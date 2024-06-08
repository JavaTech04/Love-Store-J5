<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:if test="${param.checkout_successfully != null}">
    <script>
        swal('Success', 'Checkout Successfully', 'success')
    </script>
</c:if>
<div class="row m-2 container-fluid">
    <form:form modelAttribute="productFilter" class="col-3 border" action="/" method="get">
        <div class="m-2">
        <span class="h5 text-dark-emphasis">
            <i class="bi bi-filter text-dark-emphasis"></i>
            <span class="fw-bold">SEARCH FILTER</span>
        </span>
            <div class="mb-4 mt-3">
                <label for="product-name" class="form-label fw-bold">Product name:</label>
                <form:input path="productName" type="search" class="form-control" id="product-name" placeholder="Enter the product name to search"/>
            </div>
            <div class="mb-4">
                <label class="form-label fw-bold">By category:</label>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="product-category" id="category-all" value="" checked>
                    <label class="form-check-label" for="category-all">
                        All
                    </label>
                </div>
                <c:forEach var="c" items="${categories}">
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="product-category" id="category-${c.id}" ${productCategory eq c.name ? 'checked' : ''} value="${c.name}">
                        <label class="form-check-label" for="category-${c.id}">
                                ${c.name}
                        </label>
                    </div>
                </c:forEach>
            </div>
            <div class="mb-5">
                <label class="form-label fw-bold">Price Range:</label>
                <div class="row">
                    <div class="col">
                        <form:input path="minPrice" type="number" class="form-control" placeholder="$MIN"/>
                    </div>
                    <div class="col">
                        <form:input path="maxPrice" type="number" class="form-control" placeholder="$MAX"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="mb-3 d-grid gap-2">
            <button class="btn text-white fw-bold btn-secondary">APPLY</button>
            <a class="btn text-white fw-bold btn-danger" href="/">Clear</a>
        </div>
    </form:form>
    <div class="col">
        <div class="row">
            <c:forEach var="prd" items="${products.content}">
                <div class="col-md-3 mt-4">
                    <a href="/view/${prd.id}" class="card product-card" id="card-border">
                        <div class="card-header text-white bg-danger choice-label">${prd.categoryid.name}</div>
                        <img src="/img/${prd.image}" class="card-img-top" alt="Product Image">
                        <div class="card-body">
                            <h5 class="card-title">${prd.name}</h5>
                            <p class="price">
                                <span class="current-price">$${prd.price}</span>
                            </p>
                            <p class="card-text">
                                <span class="rating">★★★★★</span>
                            </p>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
        <div class="mt-3 mb-5">
            <nav aria-label="Page navigation example">
                <ul class="pagination">
                    <li class="page-item"><a class="page-link" href="/?p=0${url}">First</a></li>
                    <c:if test="${products.hasPrevious()}">
                        <li class="page-item"><a class="page-link" href="/?p=${products.number - 1}${url}">Previous</a>
                        </li>
                    </c:if>
                    <li class="page-item"><a class="page-link">${products.number + 1}</a></li>
                    <c:if test="${products.hasNext()}">
                        <li class="page-item"><a class="page-link" href="/?p=${products.number + 1}${url}">Next</a></li>
                    </c:if>
                    <li class="page-item"><a class="page-link" href="/?p=${products.totalPages - 1}${url}">Last</a></li>
                </ul>
            </nav>
        </div>
    </div>
</div>
