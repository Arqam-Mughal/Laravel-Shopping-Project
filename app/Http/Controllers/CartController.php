<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Product;
use Gloudemans\Shoppingcart\Facades\Cart;

class CartController extends Controller
{
    public function addToCart(Request $req){
        $product = Product::with('product_images')->find($req->id);

        if(empty($product)){
            return response()->json([
                'status' => false,
                'message' => 'Product Not Found!'
            ]);            
        }

        // Cart::add('id', 'name', 'qty', 'price', [option])

        if(Cart::count() > 0){
            // Not empty
            $cart = Cart::content();
            $productAlreadyExist = false;

            foreach ($cart as $item){
                if($item->id == $product->id){
                    $productAlreadyExist = true;      
                }
            }

            if($productAlreadyExist == true){
                    // already exists

                    $status = false;
                    $message = $product->title . " already exists!";
                    
            }else{

                Cart::add($product->id, $product->title, 1, $product->price, ['productImage' => (!empty($product->product_images) ? $product->product_images->first() : '')]);

                $status = true;
                $message = $product->title . ' added to cart!';
            }                
            
        }else{
            Cart::add($product->id, $product->title, 1, $product->price, ['productImage' => (!empty($product->image) ? $product->image->first() : '')]);

            $status = true;
            $message = $product->title . ' added to cart!';
        }

        return response()->json([
            'status' => $status,
            'message' => $message
        ]);
    }

    public function cart(){
// dd(Cart::content());
// die;
        $cartContent = Cart::content();

        return view('front.cart', ['cartContent' => $cartContent]);

    }

    public function updateCart(Request $req){
        $rowId = $req->rowId;
        $qty = $req->qty;

        // stock check
        $cartGet = Cart::get($rowId);
        $product = Product::find($cartGet->id);

        if($product != ''){
            if($product->track_qty == 'Yes'){
                if($qty <= $product->qty){
                    Cart::update($rowId, $qty);

                    $status = true;
                    $message = "Cart Updated SuccessFully!";
                    session()->flash('success', $message);
                }else{
                    $status = false;
                    $message = "Request qty($qty) does not exists!";
                    session()->flash('error', $message);
                }
            }else{
                Cart::update($rowId, $qty);
                $status = true;
                $message = "Cart Updated SuccessFully!";
                session()->flash('success', $message);
            }

            return response()->json([
                'status' => $status,
                'message' => $message
            ]);
        }
    }

    public function deleteCart(Request $req){
        $cartProduct = Cart::get($req->rowId);

        if(empty($cartProduct)){
            $req->session()->flash('error', 'Record Not Found!');
            return response([
                'status' => false,
                'message' => 'Record Not Found!'
            ]);

        }
        
            Cart::remove($req->rowId);

            session()->flash('success', 'Record deleted SuccessFully');
            return response()->json([
                'status' => true,
                'message' => 'Record deleted SuccessFully'
            ]);
    }
}
