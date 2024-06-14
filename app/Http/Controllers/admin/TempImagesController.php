<?php

namespace App\Http\Controllers\admin;

use App\Http\Controllers\Controller;
use App\Models\TempImage;
use Illuminate\Http\Request;
use Intervention\Image\ImageManager;
use Intervention\Image\Drivers\Gd\Driver;

class TempImagesController extends Controller
{
    public function create(Request $req){
        $image = $req->image;

        if(!empty($image)){
            $ext = $image->getClientOriginalExtension();
            $newName = time(). ".".$ext;

            $temImage = new TempImage();
            $temImage->name = $newName;
            $temImage->save();

            $image->move(public_path().'/temp/',$newName);

            // Generate thumbnail
            $sourcePath = public_path(). '/temp/'. $newName;
            $destPath = public_path(). '/temp/thumb/'. $newName;

                $manager = new ImageManager(new Driver());
                $image = $manager->read($sourcePath);
                // $image->scale(width:300, height:300);
                $image->resizeDown(300, 300);
                $image->save($destPath);

            return response()->json([
                'status' => true,
                'image_id' => $temImage->id,
                'imagePath' => asset('/temp/thumb/'. $newName),
                'message' => 'Image Uploaded Successfully!'
            ]);
        }
    }
}
