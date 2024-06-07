<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<div class="row">
    <div class="col-6 d-flex align-items-center justify-content-start">
        <span class="h5 text-dark-emphasis">
            <i class="bi bi-box2-fill text-dark-emphasis"></i>
            <span class="fw-bold">Products overview</span>
        </span>
    </div>
    <div class="col-6 d-flex align-items-center justify-content-end">
        <a href="/admin/product/add" class="btn border"><i class="bi bi-plus"></i> Create new</a>
    </div>
</div>
<hr>
<c:if test="${param.deleteSuccessfully}">
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <strong>Success!</strong> Successfully deleted a product.
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <script>
        swal("Success!", "Product successfully deleted.", "success");
    </script>
</c:if>
<c:if test="${param.deleteFailed}">
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <strong>Warning!</strong> This product cannot be deleted.
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <script>
        swal("Warning!", "This product cannot be deleted", "error")
    </script>
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
<form id="searchForm" action="/admin/product" method="get">
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
            <c:forEach items="${products.content}" var="prd">
                <tr class="align-middle">
                    <td>
                        <img src="/img/${prd.image}" class="rounded mx-auto d-block image-table-product" alt="" width="50px">
                    </td>
                    <td class="text-start">${prd.name}</td>
                    <td>${prd.categoryid.name}</td>
                    <td>$${prd.price}</td>
                    <td class="text-center">${prd.available == 1? '<i class="bi bi-check2 text-success"></i>' : '<i class="bi bi-x-lg text-danger"></i>'}</td>
                    <td class="text-center">
                        <a href="/admin/product/edit/${prd.id}" class="text-secondary h5 m-2"><i class="bi bi-gear-fill"></i></a>
                        <a onclick="handleDelete(${prd.id})" class="text-danger h5"><i class="bi bi-x-circle-fill"></i></a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <div class="d-flex justify-content-center align-items-center">
            <nav aria-label="Page navigation example">
                <ul class="pagination">
                    <li class="page-item">
                        <a class="page-link" href="/admin/product?page=0${url}">First</a>
                    </li>
                    <c:if test="${products.hasPrevious()}">
                        <li class="page-item">
                            <a class="page-link" href="/admin/product?page=${products.number - 1}${url}">Previous</a>
                        </li>
                    </c:if>
                    <li class="page-item"><span class="page-link">${products.number + 1}</span></li>
                    <c:if test="${products.hasNext()}">
                        <li class="page-item">
                            <a class="page-link" href="/admin/product?page=${products.number + 1}${url}">Next</a>
                        </li>
                    </c:if>
                    <li class="page-item">
                        <a class="page-link" href="/admin/product?page=${products.totalPages - 1}${url}">Last</a>
                    </li>
                </ul>
            </nav>
        </div>
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
                    this.window.location.href = "/admin/product/" + id
                }
            });
    }
</script>