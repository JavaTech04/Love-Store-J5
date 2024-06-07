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
<div class="container mt-5">
    <span class="h4">
    <i class="bi bi-eye-fill text-danger"></i>
    <span class="fw-bold">View Product</span>
</span>
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
            <h3>${product.categoryid.name}</h3>
            <h2>${product.name}</h2>
            <div class="d-flex align-items-center">
                <h3 class="text-danger">$${product.price}</h3>
            </div>
            <div class="my-3">
                <span>Rating: </span><span class="text-warning">★★★★☆</span>
            </div>
            <div class="my-3">
                <h5>Transport</h5>
                <p>Order processing by Nong Hoang Vu <br>
                    Free shipping</p>
            </div>
            <div class="my-3">
                <h5>Color</h5>
                <div class="d-flex">
                    <input class="border-0" type="color" value="#c1c1c1" disabled>
                    <input class="border-0" type="color" value="#f31111" disabled>
                    <input class="border-0" type="color" value="#1657cb" disabled>
                    <input class="border-0" type="color" value="#000000" disabled>
                </div>
            </div>
            <div class="my-3 mt-5">
                <a href="/" class="btn btn-danger ">Cancel</a>
                <a href="/add-to-cart/${product.id}" class="btn btn-warning text-white">Add to cart</a>
            </div>
        </div>
    </div>
</div>