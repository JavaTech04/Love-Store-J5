<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<style>
    .cart-item {
        border-bottom: 1px solid #dee2e6;
        padding: 10px 0;
    }

    .cart-item img {
        max-width: 50px;
        margin-right: 10px;
    }
</style>
<div class="container mt-4">
    <span class=" fw-bold h5" onclick="window.location.href='/'"><i class="bi bi-shop"></i> LoveStore</span>
    <span class="h5">|</span>
    <strong class="h5">Shopping Cart</strong>
    <hr>
    <div class="row cart-header fw-bold">
        <div class="col-4">
            Product
        </div>
        <div class="col-2">
            Unit Price
        </div>
        <div class="col-2">
            Quantity
        </div>
        <div class="col-2">
            Total Price
        </div>
        <div class="col-2">
            Actions
        </div>
    </div>
    <c:forEach var="item" items="${carts.items}" varStatus="i">
        <form action="/update-item/${item.productid.id}" method="post">
            <div class="row cart-item d-flex align-items-center">
                <div class="col-4 d-flex align-items-center">
                    <img src="/img/${item.productid.image}" alt="${item.productid.image}">
                    <span>${item.productid.name}</span>
                </div>
                <div class="col-2 ">
                    <span class="text-muted"><del> $<fmt:formatNumber value="${item.price * 30}" type="number" maxFractionDigits="1"/></del></span>
                    <span class="fw-bold">$${item.price}</span>
                </div>
                <div class="col-2">
                    <input type="number" class="form-control" value="${item.quantity}"
                           min="1"
                           name="quantity"
                           onchange="this.form.submit()"
                    >
                </div>
                <div class="col-2 fw-bold">
                    $<fmt:formatNumber value="${item.price * item.quantity}" type="number" maxFractionDigits="1"/>
                </div>
                <div class="col-2">
                    <a class="btn btn-sm text-danger" href="/remove-item/${i.index}"><i class="bi bi-trash3-fill"></i></a>
                </div>
            </div>
        </form>
    </c:forEach>
    <div class="mb-5 row">
        <div class="col-6">
            <a class="link-offset-2 link-underline link-underline-opacity-0" onclick="window.location.href='/checkout';">
                <i class="bi bi-cart-check-fill"></i> Check Out
            </a>
        </div>
        <div class="col-6 text-end">
            <span class="fw-bold">Total (${carts.total} items): $<fmt:formatNumber value="${carts.totalMoney}" type="number" maxFractionDigits="1"/></span>
        </div>
    </div>
</div>
