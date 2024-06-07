<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<nav class="navbar navbar-expand-lg bg-body-tertiary">
    <div class="container-fluid">
        <a class="navbar-brand fw-bold" href="/admin"><i class="bi bi-shop"></i> LoveStore</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link" aria-current="page" href="/admin"><i class="bi bi-house-door-fill"></i> Home</a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="bi bi-box-seam-fill"></i> Products
                    </a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="/admin/product"><i class="bi bi-eye"></i> Overview</a></li>
                        <li><a class="dropdown-item" href="/admin/product/add"><i class="bi bi-plus-circle"></i> Create product</a></li>
                    </ul>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="bi bi-people-fill"></i> Account
                    </a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="/admin/account"><i class="bi bi-eye"></i> Overview</a></li>
                        <li><a class="dropdown-item" href="/admin/account/add"><i class="bi bi-plus-circle"></i> Create account</a></li>
                    </ul>
                </li>
            </ul>
        </div>
        <ul class="navbar-nav ml-auto">
            <li class="nav-item no-arrow">
                <a class="nav-link p-0" data-bs-toggle="dropdown" href="#">
                    <div class="user-avatar">
                        <span class="username m-2">${sessionScope.username}</span>
                        <img alt="User Avatar" class="rounded-circle" style="width:40px; height: 40px" src="/static/images/logo.jpg"/>
                    </div>
                </a>
                <div class="dropdown-menu dropdown-menu-end">
                    <button onclick="showAdmin()" class="dropdown-item">Role: ${sessionScope.roles == 'ROLE_admin' ? 'Admin' : 'User'}</button>
                    <a><hr class="dropdown-divider"></a>
                    <a class="dropdown-item" href=" ${empty sessionScope.username ? '/login' : '/logout'}">
                        ${empty sessionScope.username ? '<i class="bi bi-box-arrow-in-right"></i> Login' : '<i class="bi bi-box-arrow-left"></i> Logout'}
                    </a>
                </div>
            </li>
        </ul>
    </div>
</nav>
<script>
    const showAdmin = () => {
        swal('Verify', 'You are admin!', 'success')
    }
</script>