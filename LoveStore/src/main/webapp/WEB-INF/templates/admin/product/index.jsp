<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="row">
    <div class="col-6 d-flex align-items-center justify-content-start">
        <h2 class="text-dark-emphasis m-2">Products overview</h2>
    </div>
    <div class="col-6 d-flex align-items-center justify-content-end">
        <a href="/product/add" class="btn border"><i class="bi bi-plus"></i> Create new</a>
    </div>
</div>
<hr>
<c:if test="${param.deleted != null && not empty products}">
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <strong>Success!</strong> Successfully deleted a product.
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
</c:if>
<c:if test="${param.new_success != null}">
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <strong>Success!</strong> Successfully added a product.
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <script>
        swal("Good job!", "Successfully added a product.", "success");
    </script>
</c:if>
<c:if test="${param.update_success != null}">
    <script>
        swal("Good job!", "Successfully edited a product.", "success");
    </script>
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <strong>Success!</strong> Successfully edited a product.
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
</c:if>
<form id="searchForm" action="/product" method="get">
    <div class="mb-3 d-flex justify-content-end">
        <input
                type="search" class="form-control w-25"
                placeholder="Search for name and category..." name="q"
                value="${q}">
    </div>
</form>
<c:if test="${empty products}">
    <div class="alert alert-warning  alert-dismissible fade show" role="alert">
        <strong>Warning!</strong> Data is empty!
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
</c:if>
<c:if test="${not empty products}">
    <div>
        <table class="table text-center">
            <thead>
            <tr>
                <th scope="col">Image</th>
                <th scope="col">Name</th>
                <th scope="col">Category</th>
                <th scope="col">Price</th>
                <th scope="col">Available</th>
                <th scope="col">Action</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${products}" var="prd">
                <tr class="align-middle">
                    <td><img src="/img/${prd.image}" class="rounded mx-auto d-block image-table-product" alt=""
                             width="50px"></td>
                    <td class="text-start">${prd.name}</td>
                    <td>${prd.categoryid.name}</td>
                    <td>$${prd.price}</td>
                    <td class="text-center">${prd.available == 1? '<i class="bi bi-check2 text-success"></i>' : '<i class="bi bi-x-lg text-danger"></i>'}</td>
                    <td class="text-center">
                        <a href="/product/edit/${prd.id}" class="text-secondary h5 m-2"><i class="bi bi-gear-fill"></i></a>
                        <a onclick="handleDelete(${prd.id})" class="text-danger h5"><i class="bi bi-x-circle-fill"></i></a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <c:if test="${products.size() > 3}">
            <strong class="m-2">Size: ${products.size()}</strong>
        </c:if>
    </div>
</c:if>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
    const handleDelete = (id) => {
        swal({
            title: "Are you sure?",
            text: "Do you want to delete this product??",
            icon: "warning",
            buttons: true,
            dangerMode: true,
        })
            .then((confirm) => {
                if (confirm) {
                    swal({
                        title: "Success!",
                        text: "Product successfully deleted",
                        icon: "success",
                    }).then((value) => {
                        if (value) {
                            this.window.location.href = "/product/" + id
                        }
                    });

                }
            });
    }
</script>