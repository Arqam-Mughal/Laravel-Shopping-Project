@extends('front.layouts.app')

@section('content')

<section class="section-5 pt-3 pb-3 mb-3 bg-white">
  <div class="container">
      <div class="light-font">
          <ol class="breadcrumb primary-color mb-0">
              <li class="breadcrumb-item"><a class="white-text" href="{{ route('front.home') }}">Home</a></li>
              <li class="breadcrumb-item"><a class="white-text" href="{{ route('front.shop') }}">Shop</a></li>
              <li class="breadcrumb-item">Cart</li>
          </ol>
      </div>
  </div>
</section>

<section class=" section-9 pt-4">
  <div class="container">
      <div class="row">
        <div class="col-md-12">
            @if(Session::has('success'))
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                {{ Session::get('success') }}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
              </div>
            @endif

            @if(Session::has('error'))
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                {{ Session::get('error') }}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
              </div>
            @endif
        </div>
          <div class="col-md-8">
              <div class="table-responsive">
                  <table class="table" id="cart">
                      <thead>
                          <tr>
                              <th>Item</th>
                              <th>Price</th>
                              <th>Quantity</th>
                              <th>Total</th>
                              <th>Remove</th>
                          </tr>
                      </thead>
                      <tbody>
                        @if(!empty($cartContent))
                       
                        @foreach ($cartContent as $cart)
                        
                           <tr>
                              <td>
                                  <div class="d-flex align-items-center justify-content-start">

                                    @if(!empty($cart->options->productImage->image))

                                      <img src="{{ asset('uploads/product/small/' . $cart->options->productImage->image) }}" width="" height="">
                                      
                                    @else

                                    <img src="{{ asset('admin-assets/img/default-150x150.png') }}" width="" height="">

                                    @endif

                                      <h2>{{ $cart->name }}</h2>
                                  </div>
                              </td>
                              <td>${{ $cart->price }}</td>
                              <td>
                                  <div class="input-group quantity mx-auto" style="width: 100px;">
                                      <div class="input-group-btn">
                                          <button class="btn btn-sm btn-dark btn-minus p-2 pt-1 pb-1 sub" data-id="{{ $cart->rowId }}">
                                              <i class="fa fa-minus"></i>
                                          </button>
                                      </div>
                                      <input type="text" class="form-control form-control-sm  border-0 text-center qtyInput" value="{{ $cart->qty }}" data-id="({{ $cart->rowId }})" readonly>
                                      <div class="input-group-btn">
                                          <button class="btn btn-sm btn-dark btn-plus p-2 pt-1 pb-1 add" data-id="{{ $cart->rowId }}">
                                              <i class="fa fa-plus"></i>
                                          </button>
                                      </div>
                                  </div>
                              </td>
                              <td>
                                  ${{ $cart->price*$cart->qty }}
                              </td>
                              <td>
                                  <button onclick="deleteCart('{{ $cart->rowId }}')" class="btn btn-sm btn-danger"><i class="fa fa-times"></i></button>
                              </td>
                          </tr>
                        @endforeach
                        @endif
                                    
                      </tbody>
                  </table>
              </div>
          </div>
          <div class="col-md-4">            
              <div class="card cart-summery">
                  <div class="sub-title">
                      <h2 class="bg-white">Cart Summery</h3>
                  </div> 
                  <div class="card-body">
                      <div class="d-flex justify-content-between pb-2">
                          <div>Subtotal</div>
                          <div>${{ Cart::subtotal() }}</div>
                      </div>
                      <div class="d-flex justify-content-between pb-2">
                          <div>Shipping</div>
                          <div>$0</div>
                      </div>
                      <div class="d-flex justify-content-between summery-end">
                          <div>Total</div>
                          <div>${{ Cart::subtotal() }}</div>
                      </div>
                      <div class="pt-5">
                          <a href="login.php" class="btn-dark btn btn-block w-100">Proceed to Checkout</a>
                      </div>
                  </div>
              </div>     
              {{-- <div class="input-group apply-coupan mt-4">
                  <input type="text" placeholder="Coupon Code" class="form-control">
                  <button class="btn btn-dark" type="button" id="button-addon2">Apply Coupon</button>
              </div>  --}}
          </div>
      </div>
  </div>
</section>

@endsection

@section('customJs')
<script>

$('.add').click(function(){
    var qtyElement = $(this).parent().prev();
    var qtyValue = parseInt(qtyElement.val());
    if(qtyValue < 10){
        qtyElement.val(qtyValue+1);

        var newQty = qtyElement.val();
        var rowId = $(this).data('id');
        updateCart(rowId, newQty);

    }
});

$('.sub').click(function(){
    var qtyElement = $(this).parent().next();
    var qtyValue = parseInt(qtyElement.val());
    if(qtyValue > 1){
        qtyElement.val(qtyValue - 1);

        var newQty = qtyElement.val();
        var rowId = $(this).data('id');
        updateCart(rowId, newQty);

    }
});

function updateCart(rowId, qty){
    $.ajax({
        url: '{{ route("front.updateCart") }}',
        type:'POST',
        data: {rowId:rowId, qty:qty},
        dataType: 'json',
        success:function(res){
            // if(res['status'] == true){
                window.location.href = "{{ route('front.cart') }}";
            // }
        }
    });
}

function deleteCart(rowId){
    // alert(rowId);
    Swal.fire({
    title: 'Are you sure?',
    text: "You won't be able to revert this!",
    icon: 'warning',
    showCancelButton: true,
    confirmButtonColor: '#3085d6',
    cancelButtonColor: '#d33',
    confirmButtonText: 'Yes, Delete it!'
    }).then((result) => {
    if (result.isConfirmed) {

    $.ajax({
        url: '{{ route("front.deleteCart") }}',
        type: 'post',
        data: {rowId:rowId},
        dataType: 'json',
        success:function(res){
            Swal.fire(
               'Deleted!',
               'Record Deleted Successfully!',
               'success'
                )			
                setTimeout(()=>{

					location.reload(true);
            window.location.href = "{{ route('front.cart') }}";


				},1000);
        }
    });
}
});

}

</script>
@endsection