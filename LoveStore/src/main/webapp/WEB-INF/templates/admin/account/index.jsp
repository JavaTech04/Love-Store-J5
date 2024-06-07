<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<div class="row">
    <div class="col-6 d-flex align-items-center justify-content-start">
        <span class="h5 text-dark-emphasis">
            <i class="bi bi-people-fill text-dark-emphasis"></i>
            <span class="fw-bold">User overview</span>
        </span>
    </div>
    <div class="col-6 d-flex align-items-center justify-content-end">
        <a href="/admin/account/add" class="btn border"><i class="bi bi-plus"></i> Create new</a>
    </div>
</div>
<hr>
<c:if test="${param.update_successfully != null}">
    <script>
        swal("Good job!", "Successfully updated a user", "success");
    </script>
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <strong>Success!</strong> Successfully updated a user.
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
</c:if>
<c:if test="${param.new_success != null}">
    <script>
        swal("Good job!", "Successfully added a user", "success");
    </script>
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <strong>Success!</strong> Successfully added a user.
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
</c:if>
<c:if test="${param.deleteSuccessfully}">
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <strong>Success!</strong> Successfully deleted a user.
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <script>
        swal("Success!", "Successfully deleted a user.", "success");
    </script>
</c:if>
<c:if test="${param.deleteFailed}">
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <strong>Warning!</strong> This account cannot be deleted.
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <script>
        swal("Warning!", "This account cannot be deleted", "error")
    </script>
</c:if>
<form id="searchForm" action="/admin/account" method="get">
    <div class="mb-3 d-flex justify-content-end">
        <input
                type="search" class="form-control w-25"
                placeholder="Search for username, name, and email..." name="q"
                value="${q}">
    </div>
</form>
<c:if test="${empty users}">
    <div class="alert alert-warning  alert-dismissible fade show" role="alert">
        <strong>Warning!</strong> Data is empty!
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
</c:if>
<c:if test="${not empty users}">
    <table class="table">
        <thead>
        <tr>
            <th scope="col">Avatar</th>
            <th scope="col">Username</th>
            <th scope="col">Name</th>
            <th scope="col">Password</th>
            <th scope="col">Email</th>
            <th class="text-center" scope="col">Activity</th>
            <th class="text-center" scope="col">Admin</th>
            <th class="text-center" scope="col">Action</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${users.content}" var="user" varStatus="i">
            <tr class="align-middle">
                <td>
                    <img src="/img/${not empty user.photo ? user.photo : 'not_found.jpg'}" class="rounded-circle" alt="..." width="50px" height="50px" style="object-fit: cover">
                </td>
                <td>${user.username}</td>
                <td>${user.fullName}</td>
                <td class="fw-bold">••••••••</td>
                <td class="text-primary">${user.email}</td>
                <td class="text-center">${user.activated == 1 ? '<i class="bi bi-check2 text-success"></i>' : '<i class="bi bi-x-lg text-danger"></i>'}</td>
                <td class="text-success text-center">${user.admin == 1 ? '<i class="bi bi-check2"></i>' : ""}</td>
                <td class="text-center">
                    <a href="/admin/account/edit/${user.username}" class="text-secondary h5 m-2"><i
                            class="bi bi-gear-fill"></i></a>
                    <a onclick="handleDelete('${user.username}')" class="text-danger h5"><i
                            class="bi bi-x-circle-fill"></i></a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <div class="d-flex justify-content-center align-items-center">
        <nav aria-label="Page navigation example">
            <ul class="pagination">
                <li class="page-item">
                    <a class="page-link" href="/admin/account?page=0${url}">First</a>
                </li>
                <c:if test="${users.hasPrevious()}">
                    <li class="page-item">
                        <a class="page-link" href="/admin/account?page=${users.number - 1}${url}">Previous</a>
                    </li>
                </c:if>
                <li class="page-item"><span class="page-link">${users.number + 1}</span></li>
                <c:if test="${users.hasNext()}">
                    <li class="page-item">
                        <a class="page-link" href="/admin/account?page=${users.number + 1}${url}">Next</a>
                    </li>
                </c:if>
                <li class="page-item">
                    <a class="page-link" href="/admin/account?page=${users.totalPages - 1}${url}">Last</a>
                </li>
            </ul>
        </nav>
    </div>
</c:if>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
    document.getElementById('searchForm').addEventListener('submit', function (event) {
        var input = document.querySelector('input[name="q"]');
        if (!input.value.trim()) {
            input.parentNode.removeChild(input);
        }
    });
    const handleDelete = (username) => {
        swal({
            title: "Are you sure?",
            text: "Do you want to delete this user??",
            icon: "warning",
            buttons: true,
            dangerMode: true,
        })
            .then((confirm) => {
                if (confirm) {
                    this.window.location.href = "/admin/account/" + username
                }
            });
    }
</script>
