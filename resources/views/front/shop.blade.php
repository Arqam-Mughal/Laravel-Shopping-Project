@extends('front.layouts.app')

@section('content')

<section class="section-5 pt-3 pb-3 mb-3 bg-white">
  <div class="container">
      <div class="light-font">
          <ol class="breadcrumb primary-color mb-0">
              <li class="breadcrumb-item"><a class="white-text" href="{{ route('front.home') }}">Home</a></li>
              <li class="breadcrumb-item active">Shop</li>
          </ol>
      </div>
  </div>
</section>

<section class="section-6 pt-5">
  <div class="container">
      <div class="row">            
          <div class="col-md-3 sidebar">
              <div class="sub-title">
                  <h2>Categories</h3>
                   
                    
              </div>
              
              <div class="card">
                  <div class="card-body">
                
                <div class="accordion accordion-flush" id="accordionExample">

                  @if($categories->isNotEmpty())
                  @foreach ($categories as $key => $category)

                  <div class="accordion-item">
                    @if($category->sub_category->isNotEmpty())
                    
                      <h2 class="accordion-header" id="headingOne">
                          <button class="accordion-button collapsed {{  ($categorySelected == $category->id) ? 'text-info' : '' }}" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne-{{ $key }}" aria-expanded="false" aria-controls="collapseOne-{{ $key }}">
                              {{ $category->name }}
                          </button>
                      </h2>
                      @else

                      <a href="{{ route('front.shop', $category->slug) }}" class="nav-item nav-link {{  ($categorySelected == $category->id) ? 'text-info' : '' }}">{{ $category->name }}</a>   
                      
                      @endif

                      

                      <div id="collapseOne-{{ $key }}" class="accordion-collapse collapse {{ ($categorySelected == $category->id) ? 'show' : '' }}" aria-labelledby="headingOne" data-bs-parent="#accordionExample" style="">
                          <div class="accordion-body">
                              <div class="navbar-nav">

                                @if($category->sub_category->isNotEmpty())
                                @foreach ($category->sub_category as $subcategory)

                          <a href="{{ route('front.shop', [$category->slug,$subcategory->slug]) }}" class="nav-item nav-link {{  ($subCategorySelected == $subcategory->id) ? 'text-primary' : '' }}">{{ $subcategory->name }}</a>   

                              @endforeach
                              @endif 

                              </div>
                          </div>
                      </div>
                      
                  </div>  

                  @endforeach
                  @endif
                           
                      </div>
                  </div>
              </div>

              <div class="sub-title mt-5">
                  <h2>Brand</h3>
              </div>
              
              <div class="card">
                  <div class="card-body">

                    @if($brands->isNotEmpty())
                    @foreach($brands as $brand)

                    <div class="form-check mb-2">
                      <input {{ (in_array($brand->id, $brandsArray)) ? 'checked' : '' }} class="form-check-input brand-label" type="checkbox" name="brand[]" value="{{ $brand->id }}" id="brand-{{ $brand->id }}">
                      <label class="form-check-label" for="brand-{{ $brand->id }}">
                          {{ $brand->name }}
                      </label>
                  </div>

                    @endforeach
                    @endif
                                
                  </div>
              </div>

              <div class="sub-title mt-5">
                  <h2>Price</h3>
              </div>
              
              <div class="card">
                  <div class="card-body">
                    <input type="text" class="js-range-slider" name="my_range" value="" />
          
                  </div>
              </div>
          </div>
          <div class="col-md-9">
              <div class="row pb-3">
                  <div class="col-12 pb-1">
                      <div class="d-flex align-items-center justify-content-end mb-4">
                          <div class="ml-2">
                              {{-- <div class="btn-group">
                                  <button type="button" class="btn btn-sm btn-light dropdown-toggle" data-bs-toggle="dropdown">Sorting</button>
                                  <div class="dropdown-menu dropdown-menu-right">
                                      <a class="dropdown-item" href="#">Latest</a>
                                      <a class="dropdown-item" href="#">Price High</a>
                                      <a class="dropdown-item" href="#">Price Low</a>
                                  </div>
                              </div>                                     --}}

                              <select name="sort" id="sort" class="form-control">
                                <option {{ ($sort == 'latest') ? 'selected' : '' }} value="latest">Latest</option>
                                <option {{ ($sort == 'price_desc') ? 'selected' : '' }} value="price_desc">Price High</option>
                                <option {{ ($sort == 'price_asc') ? 'selected' : '' }} value="price_asc">Price Low</option>
                              </select>
                          </div>
                      </div>
                  </div>

                  @if($products->isNotEmpty())
                  @foreach($products as $product)
                  @php
                    $productImage = $product->product_images->first();
                  @endphp 


                  <div class="col-md-4">
                    <div class="card product-card">
                        <div class="product-image position-relative">
                            <a href="" class="product-img">

                              @if(!empty($productImage->image))

                              <img class="card-img-top" src="{{ asset('/uploads/product/small/' . $productImage->image) }}" alt="">
                              
                              @else

                              <img src="{{ asset('admin-assets/img/default-150x150.png') }}" class="card-img-top">

                              @endif
                              
                            </a>

                            <a class="whishlist" href="222"><i class="far fa-heart"></i></a>                            

                            <div class="product-action">
                                <a class="btn btn-dark" href="#">
                                    <i class="fa fa-shopping-cart"></i> Add To Cart
                                </a>                            
                            </div>
                        </div>                        
                        <div class="card-body text-center mt-3">
                            <a class="h6 link" href="product.php">{{ $product->title }}</a>
                            <div class="price mt-2">
                                <span class="h5"><strong>${{ $product->price }}</strong></span>
                                @if($product->compare_price > 0)
                                
                                <span class="h6 text-underline"><del>${{ $product->compare_price }}</del></span>

                                @endif
                            </div>
                        </div>                        
                    </div>                                               
                </div>

                  @endforeach
                  @endif
                     

                  <div class="col-md-12 pt-5">
                      {{-- <nav aria-label="Page navigation example">
                          <ul class="pagination justify-content-end">
                              <li class="page-item disabled">
                              <a class="page-link" href="#" tabindex="-1" aria-disabled="true">Previous</a>
                              </li>
                              <li class="page-item"><a class="page-link" href="#">1</a></li>
                              <li class="page-item"><a class="page-link" href="#">2</a></li>
                              <li class="page-item"><a class="page-link" href="#">3</a></li>
                              <li class="page-item">
                              <a class="page-link" href="#">Next</a>
                              </li>
                          </ul>
                      </nav> --}}

                      {{-- {{ $products->links() }} --}}

                      {{ $products->withQueryString()->links() }}  

                      {{-- This will maintain your url after selecting price --}}
                      
                  </div>
              </div>
          </div>
      </div>
  </div>
</section>
  
@endsection

@section('customJs')
<script>

rangeSlider = $(".js-range-slider").ionRangeSlider({
    type: "double",
    min: 0,
    max: 1000,
    from: {{ $priceMin }},
    step: 10,
    to: {{ $priceMax }},
    skin: "round",
    max_postfix: "+",
    prefix: "$",
    onFinish: function(){
        apply_filters()
    }

});

var slider = $(".js-range-slider").data("ionRangeSlider");

    $(".brand-label").change(function(){
        apply_filters();
    });

    $("#sort").change(function(){
        apply_filters();
    });

    function apply_filters(){
        var brands = [];

        $(".brand-label").each(function(){
            if($(this).is(":checked") == true) {
                brands.push($(this).val());      // brand->id will be pushed
            }
        });

        // console.log(brands.toString());

        var url = '{{ url()->current() }}?';

        // Brand Filter
        if(brands.length > 0){
            url += '&brand=' +brands.toString();
        }

        // Price Range Filter
        url += "&price_min=" + slider.result.from + '&price_max=' + slider.result.to;


        // Sorting Filter
        url += "&sort=" + $('#sort').val();


        window.location.href = url;
    }
</script>
@endsection