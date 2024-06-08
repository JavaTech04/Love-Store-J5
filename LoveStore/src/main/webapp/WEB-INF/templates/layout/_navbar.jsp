<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    .position-relative {
        position: relative;
    }

    .position-absolute {
        position: absolute;
        top: 1px;
        right: -5px;
    }

    .badge {
        display: inline-block;
        padding: 0.25em 0.4em;
        font-size: 0.75rem;
        font-weight: 700;
        line-height: 1;
        color: #fff;
        text-align: center;
        white-space: nowrap;
        vertical-align: baseline;
        border-radius: 10rem;
    }

</style>
<nav class="navbar navbar-expand-lg bg-body-tertiary">
    <div class="container-fluid">
        <a class="navbar-brand fw-bold" href="/"><i class="bi bi-shop"></i> LoveStore</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <ul class="navbar-nav ml-auto">
            <c:if test="${not empty carts.items}">
                <li class="nav-item no-arrow">
                    <a href="/cart" class="nav-link text-primary position-relative">
                        <i class="bi bi-cart4 h3"></i>
                        <span class="badge position-absolute badge-pill bg-danger">${carts.total}</span>
                    </a>
                </li>
            </c:if>
            <li class="nav-item no-arrow">
                <a class="nav-link p-0" data-bs-toggle="dropdown" href="#">
                    <div class="user-avatar">
                        <span class="username m-2">${sessionScope.username}</span>
                        <img alt="User Avatar" class="rounded-circle" style="width:40px; height: 40px" src="/static/images/logo.jpg"/>
                    </div>
                </a>
                <div class="dropdown-menu dropdown-menu-end">
                    <a class="dropdown-item" href=" ${empty sessionScope.username ? '/login' : '/logout'}">
                        ${empty sessionScope.username ? '<i class="bi bi-box-arrow-in-right"></i> Login' : '<i class="bi bi-box-arrow-left"></i> Logout'}
                    </a>
                </div>
            </li>
        </ul>
    </div>
</nav>