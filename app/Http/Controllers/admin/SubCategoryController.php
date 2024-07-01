<?php

namespace App\Http\Controllers\admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Models\Category;
use App\Models\SubCategory;

class SubCategoryController extends Controller  
{
    public function index(Request $req){
        $subcategories = SubCategory::select('sub_categories.*', 'categories.name as categoryName')->latest('sub_categories.id')->leftJoin('categories','categories.id','sub_categories.category_id');

        if(!empty($req->get('keyword'))){

            $subcategories = $subcategories->where('sub_categories.name', 'like', '%'. $req->get('keyword').'%');

            $subcategories = $subcategories->orWhere('categories.name', 'like', '%'. $req->get('keyword').'%');
        }
        $subcategories = $subcategories->paginate(10);               // latest replaces orderBy
        // dd($subcategories);

        return view('admin.subcategory.list', ['subcategories' => $subcategories]);
    }

    public function create(){

        $categories = Category::orderBy('name','ASC')->get();

        return view('admin.subcategory.create', ['categories' => $categories]);
    }

    public function store(Request $req){
        $validator = Validator::make($req->all(), [
            'name' => 'required',
            'slug' => 'required|unique:sub_categories',
            'category' => 'required',
            'status' => 'required',
            'showhome' => 'required',
        ]);

        if($validator->passes()) {
            
            $subcategory = new SubCategory();
            $subcategory->name = $req->name;
            $subcategory->slug = $req->slug;
            $subcategory->status = $req->status;
            $subcategory->category_id = $req->category;
            $subcategory->showhome = $req->showhome;
            $subcategory->save();

            $req->session()->flash('success','Sub Category Created SuccessFully!');

            return response([
                'status' => true,
                'message' => 'Sub Category Created SuccessFully!'
            ]);

        } else{
            return response([
                'status' => false,
                'errors' => $validator->errors()
            ]);
        }

    }

    public function edit($subcategoryId, Request $req){
        // echo "<h1>$subcategoryId</h1>";

        $subcategory = SubCategory::find($subcategoryId);

        if(empty($subcategory)){
            $req->session()->flash('error', 'Record Not Found!');
            return redirect()->route('sub_categories.index');
        }

        $category = Category::orderBy('name','ASC')->get();

        $data['categories'] = $category;
        $data['subcategory'] = $subcategory;
        return view('admin.subcategory.edit', $data);
    }

    public function update($id, Request $req){
        $subcategory = SubCategory::find($id);

        if(empty($subcategory)){
            $req->session()->flash('error', 'Record Not Found!');
            return response()->json([
                'status' => false,
                'notFound' => true,
            ]);
            // return redirect()->route('sub_categories.index');
        }

        $validator = Validator::make($req->all(), [
            'name' => 'required',
            'slug' => 'required|unique:sub_categories,slug,'.$subcategory->id.' ,id',
            'category' => 'required',
            'status' => 'required',
            'showhome' => 'required'
        ]);

        if($validator->passes()) {
            
            // $subcategory = new SubCategory();
            $subcategory->name = $req->name;
            $subcategory->slug = $req->slug;
            $subcategory->status = $req->status;
            $subcategory->category_id = $req->category;
            $subcategory->showhome = $req->showhome;
            $subcategory->save();

            $req->session()->flash('success','Sub Category Updated SuccessFully!');

            return response([
                'status' => true,
                'message' => 'Sub Category Updated SuccessFully!'
            ]);

        } else{
            return response([
                'status' => false,
                'errors' => $validator->errors()
            ]);
        }
    }

    public function destroy($id, Request $req){
        $subcategory = SubCategory::find($id);

        if(empty($subcategory)){
            $req->session()->flash('error', 'Record Not Found!');
            return response()->json([
                'status' => false,
                'notFound' => true,
            ]);
    }

        
            $subcategory->delete();
            
            $req->session()->flash('success', 'SubCategory Deleted Successfully!');

            return response()->json([
                'status' => true,
                'message' => 'SubCategory Deleted Successfully!'
            ]);
}
}
