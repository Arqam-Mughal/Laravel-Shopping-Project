<?php

namespace App\Http\Controllers\admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\File;
use App\Models\Product;
use App\Models\Category;
use App\Models\SubCategory;
use App\Models\Brand;
use App\Models\ProductImage;
use App\Models\TempImage;
use Intervention\Image\ImageManager;
use Intervention\Image\Drivers\Gd\Driver;

class ProductController extends Controller
{
    public function create(){

        $categories = Category::orderBy('name', 'ASC')->get();
        $subcategories = SubCategory::orderBy('name', 'ASC')->get();
        $brands = Brand::orderBy('name', 'ASC')->get();

        $data['categories'] = $categories;
        $data['subcategories'] = $subcategories;
        $data['brands'] = $brands;
        return view('admin.products.create', $data);
    }

    public function store(Request $req){
        // dd($req->image_array);
        // exit();

        $rules = [
            'title' => 'required',
            'slug' => 'required|unique:products',
            'price' => 'required|numeric',
            'sku' => 'required|unique:products',
            'track_qty' => 'required|in:Yes,No',
            'category' => 'required|numeric',
            'is_featured' => 'required|in:Yes,No',
        ];

        if(!empty($req->track_qty) && $req->track_qty == 'Yes'){
            $rules['qty'] = 'required|numeric';
        }
        $validator = Validator::make($req->all(), $rules);

        if($validator->passes()){

            $product = new Product();
            $product->title = $req->title;
            $product->slug = $req->slug; 
            $product->description = $req->description; 
            $product->price = $req->price; 
            $product->compare_price = $req->compare_price; 
            $product->sku = $req->sku; 
            $product->barcode = $req->barcode; 
            $product->track_qty = $req->track_qty; 
            $product->qty = $req->qty; 
            $product->status = $req->status; 
            $product->category_id = $req->category; 
            $product->sub_category_id = $req->sub_category; 
            $product->brand_id = $req->brand; 
            $product->is_featured = $req->is_featured; 
            $product->save();

            // Save Gallery Pics
            if(!empty($req->image_array)){

                foreach ($req->image_array as $temp_image_id) {

                    $tempImageInfo = TempImage::find($temp_image_id);
                    $extArray = explode('.', $tempImageInfo->name);
                    // 1713926505.png
                    $ext = last($extArray);     // like jpg

                    $productImage = new ProductImage();
                    $productImage->product_id = $product->id;
                    $productImage->image = 'NULL';
                    $productImage->save();

                    $imageName = $product->id. '-' . $productImage->id. '-'. time().'.' .$ext;
                    // like 6-2-5645457.jpg
                    $productImage->image = $imageName;
                    $productImage->save();

                    // Generate Thumbnail

                    // large Image

                $sourcePath = public_path(). '/temp/'. $tempImageInfo->name;
                $destPath = public_path(). '/uploads/product/large/'. $imageName;

                $manager = new ImageManager(new Driver());
                $image = $manager->read($sourcePath);
                $image->resize(1400, null);    
                $image->save($destPath);

                    // Small Image
                $sourcePath = public_path(). '/temp/'. $tempImageInfo->name;
                $destPath = public_path(). '/uploads/product/small/'. $imageName;
                $manager = new ImageManager(new Driver());
                $image = $manager->read($sourcePath);
                $image->resizeDown(300, 300);    
                $image->save($destPath);
                }
            }

            $req->session()->flash('success', 'Product Added SuccessFully!');
            return response()->json([
                'status' => true,
                'message' => 'Product Added SuccessFully!'
            ]);

        }else{
            return response()->json([
                'status' => false,
                'errors' => $validator->errors()
            ]);
        }

    }

    public function index(Request $req){
        $products = Product::latest('id')->with('product_images');

        if(!empty($req->keyword)){
            $products = $products->where('title','like','%'.$req->keyword.'%');
        }
        $products = $products->paginate();
        // dd($products);
        $data['products'] = $products;
        return view('admin.products.list', $data);
    }

    public function edit($id, Request $req){

        $product = Product::find($id);

        if(empty($product)){
            // $req->session()->flash('error', 'Record Not Found!');
            return redirect()->route('products.index')->with('error', 'Record Not Found!');
        }

        // Fetch Product Images
        $productImages = ProductImage::where('product_id', $product->id)->get();

        $subcategories = SubCategory::where('category_id', $product->category_id)->get();
        
        $categories = Category::orderBy('name', 'ASC')->get();
        $brands = Brand::orderBy('name', 'ASC')->get();

        $data['categories'] = $categories;
        $data['brands'] = $brands;
        $data['subcategories'] = $subcategories;
        $data['product'] = $product;
        $data['productImages'] = $productImages;

        return view('admin.products.edit', $data);
    }

    public function update($id, Request $req){
        $product = Product::find($id);

        if(empty($product)){
            $req->session()->flash('error', 'Record Not Found!');
            return response()->json([
                'status' => false,
                'notFound' => true,
                'message' => 'Record NoT Found!'
            ]);
        }

        $rules = [
            'title' => 'required',
            'slug' => 'required|unique:products,slug,'.$product->id.',id',
            'price' => 'required|numeric',
            'sku' => 'required|unique:products,sku,'.$product->id.',id',
            'track_qty' => 'required|in:Yes,No',
            'category' => 'required|numeric',
            'is_featured' => 'required|in:Yes,No',
        ];

        if(!empty($req->track_qty) && $req->track_qty == 'Yes'){
            $rules['qty'] = 'required|numeric';
        }
        $validator = Validator::make($req->all(), $rules);

        if($validator->passes()){

            // $product = new Product();
            $product->title = $req->title;
            $product->slug = $req->slug; 
            $product->description = $req->description; 
            $product->price = $req->price; 
            $product->compare_price = $req->compare_price; 
            $product->sku = $req->sku; 
            $product->barcode = $req->barcode; 
            $product->track_qty = $req->track_qty; 
            $product->qty = $req->qty; 
            $product->status = $req->status; 
            $product->category_id = $req->category; 
            $product->sub_category_id = $req->sub_category; 
            $product->brand_id = $req->brand; 
            $product->is_featured = $req->is_featured; 
            $product->save();

            // Save Gallery Pics
            

            $req->session()->flash('success', 'Product Updated SuccessFully!');
            return response()->json([
                'status' => true,
                'message' => 'Product Updated SuccessFully!'
            ]);

        }else{
            return response()->json([
                'status' => false,
                'errors' => $validator->errors()
            ]);
        }

    }

    public function destroy($id, Request $req){     
        $product = Product::find($id);


        if(empty($product)){
            $req->session()->flash('error', 'Record Not Found');
            return response()->json([
            'status' => false,
            'notFound' => true
            ]);
        }
        
        $productImages = ProductImage::where('product_id',$id)->get();
        if(!empty($productImages)){
        foreach($productImages as $val){
     
        File::delete(public_path().'/uploads/product/large/'. $val->image);
        File::delete(public_path().'/uploads/product/small/'. $val->image);
        }
        }

        $product->delete();
        
        $req->session()->flash('success', 'Data Deleted SuccessFully!');
        return response([
            'status' => true,
            'message' => 'Data Deleted SuccessFully!'
        ]);
        
    }

}
