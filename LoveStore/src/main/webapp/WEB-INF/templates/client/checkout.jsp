<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="container shadow p-3 mb-5 bg-body-tertiary rounded border mt-5">
    <span class=" fw-bold h5"><i class="bi bi-shop"></i> LoveStore</span>
    <span class="h5"> | </span>
    <strong class="h5">Checkout</strong>
    <hr>
    <table class="table text-center">
        <thead>
        <tr class="text-start">
            <th class="text-center">Image</th>
            <th>Product</th>
            <th>Unit Price</th>
            <th>Quantity</th>
            <th>Total Price</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="item" items="${carts.items}" varStatus="i">
            <input type="hidden" name="id" value="${item.productid.id}">
            <tr class="align-middle text-start">
                <td>
                    <img src="/img/${item.productid.image}" class="rounded mx-auto d-block image-table-product" alt="" width="50px">
                </td>
                <td class="text-start">${item.productid.name}</td>
                <td>
                    <del> $<fmt:formatNumber value="${item.price * 30}" type="number" maxFractionDigits="1"/></del>
                    <span class="fw-bold">$${item.price}</span></td>
                <td>${item.quantity}</td>
                <td>
                    $<fmt:formatNumber value="${item.price * item.quantity}" type="number" maxFractionDigits="1"/></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <div>
        <strong>Total Payment:
            $<fmt:formatNumber value="${carts.totalMoney}" type="number" maxFractionDigits="1"/> </strong>
    </div>
    <form action="/checkout" method="post" class="mt-3" id="submit">
        <div class="form-floating">
            <textarea class="form-control" required name="address" placeholder="Address" id="address" style="height: 100px"></textarea>
            <label for="address">Address</label>
        </div>
        <div class="mt-3">
            <button class="btn btn-outline-primary" type="button" onclick="onSubmit()">
                <i class="bi bi-credit-card-fill"></i> Place Order
            </button>
        </div>
    </form>
    <div class="m-2 text-center">
        <a class="link-offset-2 link-underline link-underline-opacity-0" href="/cart">
            <i class="bi bi-cart4 fw-bold"></i> Back to cart
        </a>
    </div>
</div>
<script>
    const onSubmit = () => {
        const address = document.getElementById('address').value;
        swal({
            title: "Are you sure?",
            text: "Do you want to order?",
            icon: "warning",
            buttons: true,
            dangerMode: true,
        })
            .then((confirm) => {
                if (confirm) {
                    if (address === '' || address === null) {
                        swal('Error', 'Please enter your address!', 'error')
                        return false;
                    } else {
                        document.getElementById('submit').submit();
                    }
                }
            });
    }
</script>
