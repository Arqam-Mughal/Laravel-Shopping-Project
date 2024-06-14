<?php

namespace App\Http\Controllers\admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Models\Category;
use App\Models\TempImage;
use Illuminate\Support\Facades\File;
use Intervention\Image\ImageManager;
use Intervention\Image\Drivers\Gd\Driver;

class CategoryController extends Controller
{
    public function index(Request $req){
        $categories = Category::latest();

        if(!empty($req->get('keyword'))){
            $categories = $categories->where('name', 'like', '%'. $req->get('keyword').'%');
        }
        $categories = $categories->paginate(10);               // latest replaces orderBy
        // dd($categories);

        return view('admin.category.list', ['categories' => $categories]);
        // return view('admin.category.list', compact('categories'));
    }

    public function create(){
     return view('admin.category.create');
    }

    public function store(Request $req){
        $validator = Validator::make($req->all(), [               // $input,$rules,$msgs
            'name' => 'required',
            'slug' => 'required|unique:categories',
        ],
        [
            'name.required' => 'The :attribute must needed',
            'slug.required' => 'The :attribute must needed',
            'slug.unique' => 'The :attribute must be different',
        ]);    
        
        if($validator->passes()){

            $category = new Category();
            $category->name = $req->name;
            $category->slug = $req->slug;
            $category->status = $req->status;
            $category->showhome = $req->showhome;
            $category->save();

            // Save Image Here

            if(!empty($req->image_id)){
                $tempImage = TempImage::find($req->image_id);
                $extArray = explode('.' , $tempImage->name);
                $ext = last($extArray);

                $newImageName = $category->id . '.' . $ext;

                $sPath = public_path().'/temp/'.$tempImage->name;
                $dPath = public_path().'/uploads/category/'.$newImageName;
                File::copy($sPath,$dPath);

                // Generate Image ThumbNail

                // $dPath = public_path().'/uploads/category/thumb'.$newImageName;
                // $img = Image::make($sPath)->resize(450, 600);
                // $img->save(dPath);

                // create image manager with desired driver
                $dPath = public_path().'/uploads/category/thumb/'.$newImageName;
                $manager = new ImageManager(new Driver());
                $image = $manager->read($sPath);
                $image->scale(width:450, height:600);
                $image->save($dPath);

                $category->image = $newImageName;
                $category->save();
            }


            $req->session()->flash('success', 'Category added Successfully!');

            return response()->json([
                'status' => true,
                'message' => 'Category added Successfully!'
            ]);

        }else{
            return response()->json([
                'status' => false,
                'errors' => $validator->errors()
            ]);
        }
    }

    public function edit($categortId, Request $req){
        // echo $categortId;
        $category = Category::find($categortId);
        if(empty($category)){
            $req->session()->flash('error', 'Record Not Found!');
            return redirect()->route('categories.index');
        }

        return view('admin.category.edit', ['category' => $category]);                
    }

    public function update($categoryId, Request $req){

        $category = Category::find($categoryId);

        if(empty($category)){
            $req->session()->flash('error', 'Category Not Found!');

            return response()->json([
                'status' => false,
                'notFound' => true,
                'message' => 'Category Not Found!'
            ]);
        }

        $validator = Validator::make($req->all(), [
            'name' => 'required',
            'slug' => 'required|unique:categories,slug,'.$category->id.',id',
        ]);    
        
        if($validator->passes()){

            // $category = new Category();
            $category->name = $req->name;
            $category->slug = $req->slug;
            $category->status = $req->status;
            $category->showhome = $req->showhome;
            $category->save();

            $oldImage = $category->image;

            // Save Image Here

            if(!empty($req->image_id)){
                $tempImage = TempImage::find($req->image_id);
                $extArray = explode('.' , $tempImage->name);
                $ext = last($extArray);

                $newImageName = $category->id . '-' .time().'.' .$ext;

                $sPath = public_path().'/temp/'.$tempImage->name;
                $dPath = public_path().'/uploads/category/'.$newImageName;
                File::copy($sPath,$dPath);

                // Generate Image ThumbNail

                // create image manager with desired driver
                $dPath = public_path().'/uploads/category/thumb/'.$newImageName;
                $manager = new ImageManager(new Driver());
                $image = $manager->read($sPath);
                $image->scale(width:450);
                $image->save($dPath);

                $category->image = $newImageName;
                $category->save();

               // Delete Old Images
               File::delete(public_path().'/uploads/category/thumb/'. $oldImage);
               File::delete(public_path().'/uploads/category/'. $oldImage);
            }


            $req->session()->flash('success', 'Category updated Successfully!');

            return response()->json([
                'status' => true,
                'message' => 'Category updated Successfully!'
            ]);

        }else{
            return response()->json([
                'status' => false,
                'errors' => $validator->errors()
            ]);
        }                        
    }

    public function destroy($categoryId, Request $req){
        $category = Category::find($categoryId);

        if(empty($category)){
            // return redirect()->route('categories.index');

            $req->session()->flash('error', 'Category Not Found!');
            return response()->json([
                'status' => true,
                'message' => 'Category Not Found!'
            ]);
        }   
              

        File::delete(public_path().'/uploads/category/thumb/'. $category->image);
        File::delete(public_path().'/uploads/category/'. $category->image);

        $category->delete();

        $req->session()->flash('success', 'Category Deleted SuccessFully!');

        return response()->json([
            'status' => true,
            'message' => 'Category deleted Successfully!'
        ]);
    }
}
