<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Category;
use App\Models\brand;
use App\Models\SubCategory;
use App\Models\Product;

class ShopController extends Controller
{
    public function index(Request $req, $categorySlug = null, $subCategorySlug = null) {
        $categorySelected = '';
        $subCategorySelected = '';
        $brandsArray = [];

        

        $categories = Category::where('status',1)->orderBy('name','ASC')->with('sub_category')->get();

        $brands = Brand::orderBy('name','ASC')->where('status',1)->get();

        // $products = Product::orderBy('id','DESC')->where('status',1)->where('is_featured','Yes')->get();
        $products = Product::where('status',1);

        //  Apply Filters
        if(!empty($categorySlug)){
            $category = Category::where('slug',$categorySlug)->first();
            $products = $products->where('category_id', $category->id);
            $categorySelected = $category->id;
        }

        if(!empty($subCategorySlug)){
            $subcategory = SubCategory::where('slug',$subCategorySlug)->first();
            $products = $products->where('sub_category_id', $subcategory->id);
            $subCategorySelected = $subcategory->id;
        }

        if(!empty($req->get('brand'))){
            $brandsArray = explode(',', $req->get('brand'));
            $products = $products->whereIn('brand_id', $brandsArray);
        }

        if($req->get('price_max') != '' && $req->get('price_min') != ''){
            if($req->get('price_max') == 1000){

                $products = $products->whereBetween('price', [intval($req->get('price_min')), 1000000]);

            }else{
                $products = $products->whereBetween('price', [intval($req->get('price_min')), intval($req->get('price_max')) ]);
            }
        }
       

        

        if($req->get('sort')){
            if($req->get('sort') == 'latest'){
                $products = $products->orderBy('id', 'DESC'); 
            }else if($req->get('sort') == 'price_desc'){
                $products = $products->orderBy('price','DESC');
            }else if($req->get('sort') == 'price_asc'){
                $products = $products->orderBy('price','ASC');
            }
        }else{
            $products = $products->orderBy('id', 'DESC');
        }

        $products = $products->where('is_featured','Yes');
        $products = $products->paginate(6);


        return view('front.shop', [
            'categories'=>$categories,
            'brands'=>$brands,
            'products'=>$products,
            'categorySelected'=>$categorySelected,
            'subCategorySelected'=>$subCategorySelected,
            'brandsArray'=>$brandsArray,
            'priceMax'=> (intval($req->get('price_max')) == 0 ? 1000 : intval($req->get('price_max'))),
            'priceMin'=>intval($req->get('price_min')),
            'sort'=>$req->get('sort'),
        ]);
    }
}
