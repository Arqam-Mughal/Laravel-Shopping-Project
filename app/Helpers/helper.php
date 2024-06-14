<?php
//  Go to compooser.json and After run composer dump-autoload 

// echo "hello";
use App\Models\Category;



function getCategories(){
  return Category::orderBy('id', 'DESC')
        //  ->with('sub_category')
         ->where('status',1)
         ->where('showHome','Yes')
         ->take(7)
         ->get();
}
?>