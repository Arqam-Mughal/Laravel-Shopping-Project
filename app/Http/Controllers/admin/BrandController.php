<?php

namespace App\Http\Controllers\admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Models\Brand;

class BrandController extends Controller
{
    public function index(Request $req){
        $brands = Brand::latest('id');
        
        if(!empty($req->get('keyword'))){
            $brands = $brands->where('name', 'like', '%'.$req->get('keyword').'%');
        }

        $brands = $brands->paginate(10);

        return view('admin.brand.list', compact('brands'));
    }

    public function create(){
        return view('admin.brand.create');
    }

    public function store(Request $req){
        $validator = Validator::make($req->all(), [
            'name' => 'required',
            'slug' => 'required|unique:brands',
            'status' => 'required'
        ]);

        if($validator->passes()){
            $brand = new Brand();
            $brand->name = $req->name;
            $brand->slug = $req->slug;
            $brand->status = $req->status;
            $brand->save();

            $req->session()->flash('success', 'Brand Has Been Inserted SuccessFully!');
            return response()->json([
                'status' => true,
                'message' => 'Brand Has Been Inserted SuccessFully!'
            ]);

        }else{
            return response()->json([
                'status' => false,
                'errors' => $validator->errors()
            ]);
        }
    }

    public function edit($id, Request $req) {
        $brand = Brand::find($id);

        if(empty($brand)){
            $req->session()->flash('error', 'Record Not Found!');
            return redirect()->route('brands.index');
        }else{

            return view('admin.brand.edit', ['brand'=>$brand]);

        }
    }

    public function update($id, Request $req){
        $brand = Brand::find($id);

        if(empty($brand)){
            $req->session()->flash('error', 'Record Not Found!!');

            return response()->json([
                'status' => false,
                'notFound' => true,
            ]);
        }

        $validator = Validator::make($req->all(), [
            'name' => 'required',
            'slug' => 'required|unique:brands,slug,'.$brand->id.',id',
            'status' => 'required'
        ]);

        if($validator->passes()){
            $brand->name = $req->name;
            $brand->slug = $req->slug;
            $brand->status = $req->status;
            $brand->save();

            $req->session()->flash('success', 'Brand Updated SuccessFully!');

            return response()->json([
                'status' => true,
                'message' => 'Brand Updated SuccessFully!',
            ]);
        }else{
            return response()->json([
                'status' => false,
                'errors' => $validator->errors()
            ]);
        }
    }

    public function destroy($id, Request $req){
        $brand = Brand::find($id);

        if(empty($brand)){
            $req->session()->flash('error', 'Record Not Found!');

            return response()->json([
                'status' => false,
                'notFound' => true,
                'message' => 'Record Not Found!',
            ]);
        }

        $brand->delete();
        $req->session()->flash('success', 'Record Deleted SuccessFully');

        return response()->json([
            'status' => true,
            'message' => 'Record Deleted SuccessFully!'
        ]);
    }
}
