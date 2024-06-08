<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    .img-thumbnail {
        max-width: 100%;
    }

    .small-thumb {
        width: 60px;
        height: 60px;
        margin-right: 5px;
    }

    .quantity-input input {
        width: 50px;
        text-align: center;
        padding: 5px;
        font-size: 0.9rem;
    }

    .quantity-input .btn {
        width: 30px;
        padding: 5px;
        font-size: 0.9rem;
    }
</style>
<c:if test="${param.add_success != null}">
    <script>
        swal("Success!", "Item has been added to your shopping cart", "success");
    </script>
</c:if>
<div class="container mt-5">
    <span class=" fw-bold h5"><i class="bi bi-shop"></i> LoveStore</span>
    <span class="h5">|</span>
    <strong class="h5">Detail</strong>
    <hr>
    <div class="row">
        <div class="col-md-6">
            <img src="/img/${product.image}" class="img-thumbnail" alt="${product.name}">
            <div class="mt-2 d-flex">
                <img src="/img/${product.image}" class="img-thumbnail small-thumb" alt="Thumbnail">
                <img src="/img/${product.image}" class="img-thumbnail small-thumb" alt="Thumbnail">
                <img src="/img/${product.image}" class="img-thumbnail small-thumb" alt="Thumbnail">
            </div>
        </div>
        <div class="col-md-6">
            <h3 class="text-secondary"><i class="bi bi-bookmark-check-fill text-primary"></i> ${product.categoryid.name}</h3>
            <hr>
            <p class="text-secondary h3">${product.name}</p>
            <div class="d-flex align-items-center mt-3">
                <h3 class="text-danger">$${product.price}</h3>
            </div>
            <div class="my-3">
                <span>Rating: </span><span class="text-warning">★★★★☆</span>
            </div>
            <div class="my-3">
                <hr>
                <h5><i class="bi bi-truck"></i> Transport</h5>
                <i>Order processing by Nong Hoang Vu <br>
                    Free shipping.</i>
            </div>
            <div class="my-3">
                <hr>
                <h5><i class="bi bi-palette"></i> Color</h5>
                <div class="d-flex">
                    <input class="border-0" type="color" value="#c1c1c1" disabled>
                    <input class="border-0" type="color" value="#f31111" disabled>
                    <input class="border-0" type="color" value="#1657cb" disabled>
                    <input class="border-0" type="color" value="#000000" disabled>
                </div>
            </div>
            <hr>
            <div class="my-3 mt-5">
                <a href="/" class="btn btn-outline-danger "><i class="bi bi-x"></i> Cancel</a>
                <a href="/add-to-cart/${product.id}" class="btn btn-outline-warning"><i class="bi bi-cart-plus"></i> Add
                    to cart</a>
            </div>
        </div>
    </div>
</div>