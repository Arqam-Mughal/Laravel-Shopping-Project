<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Product;

class FrontController extends Controller
{
    public function index(){

        $products = Product::orderBy('id','DESC')->where('is_featured','Yes')->take(8)->where('status',1)->get();

        $data['featuredProducts'] = $products;

        $latestProducts = Product::orderBy('id','DESC')->where('status',1)->take(8)->get();
        $data['latestProducts'] = $latestProducts;

        return view('front.home', $data);
    }
}