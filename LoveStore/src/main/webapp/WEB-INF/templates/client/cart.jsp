<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="container">
    <table class="table">
        <thead>
        <tr>
            <th>Product</th>
            <th>Price</th>
            <th>Quantity</th>
            <th>Total</th>
            <th>Action</th>
            <th></th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="item" items="${carts}">
            <form action="/update-cart/${item.productid.id}" method="post">
                <input type="hidden" name="id" value="${item.productid.id}">
                <tr>
                    <td>${item.productid.name}</td>
                    <td>${item.price}</td>
                    <td>
                        <input type="number" class="form-control"
                               min="1"
                               name="quantity"
                               value="${item.quantity}"
                               onchange="this.form.submit()"
                               style="width:50px;">
                    </td>
                    <td>${item.price * item.quantity}</td>
                    <td>
                        <a class="btn btn-sm btn-danger" href="/remove-cart/${item.productid.id}">Delete</a>
                    </td>
                </tr>
            </form>
        </c:forEach>
        </tbody>
    </table>
</div>