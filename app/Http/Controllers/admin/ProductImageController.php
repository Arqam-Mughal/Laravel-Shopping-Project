<?php

namespace App\Http\Controllers\admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Intervention\Image\ImageManager;
use Intervention\Image\Drivers\Gd\Driver;
use App\Models\ProductImage;
use Illuminate\Support\Facades\File;

class ProductImageController extends Controller
{

   


    public function update(Request $req){
        
    $image = $req->image;
    $ext = $image->getClientOriginalExtension();
    $sourcePath = $image->getPathName();      // to get source path

        $productImage = new ProductImage();
        $productImage->product_id = $req->product_id;
        $productImage->image = 'NULL';
        $productImage->save();

        $imageName = $req->product_id. '-' . $productImage->id. '-'. time().'.' .$ext;
        // like 6-2-5645457.jpg
        $productImage->image = $imageName;
        $productImage->save();

        
        $destPath = public_path(). '/uploads/product/large/'. $imageName;

                $manager = new ImageManager(new Driver());
                $image = $manager->read($sourcePath);
                $image->resize(1400, null);    
                $image->save($destPath);

                    // Small Image
                $destPath = public_path(). '/uploads/product/small/'. $imageName;
                $manager = new ImageManager(new Driver());
                $image = $manager->read($sourcePath);
                $image->resizeDown(300, 300);    
                $image->save($destPath);

                return response()->json([
                    'status' => true,
                    'image_id' => $productImage->id,
                    'imagePath' => asset('uploads/product/small/'. $productImage->image),
                    'message' => 'Image Saved SuccessFully!'
                ]);
    }

    public function destroy(Request $req){
        $productImage = ProductImage::find($req->id);

        if(empty($productImage)){
            return response()->json([
                'status' => false,
                'message' => 'Image Not Found!'
            ]);
        }

        // Delete Image From Folder
        File::delete(public_path('uploads/product/large/'. $productImage->image));
        File::delete(public_path('uploads/product/small/'. $productImage->image));

        $productImage->delete();

        return response()->json([
            'status' => true,
            'message' => 'Image Deleted SuccessFully!'
        ]);
    }
}
