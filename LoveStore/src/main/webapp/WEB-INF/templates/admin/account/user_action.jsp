<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${error}">
    <script>
        swal("Error!", "Please check the data again!", "error");
    </script>
</c:if>
<span class="h5 text-dark-emphasis text-uppercase mb-3">
            <i class="bi bi-people-fill text-dark-emphasis"></i>
            <span class="fw-bold">${title} user account</span>
        </span>
<hr>
<form:form modelAttribute="user" action="${action}" enctype="multipart/form-data">
    <div class="row">
        <div class="col-5">
            <img src="/static/images/banner.svg" alt="banner" style="width: 30em">
        </div>
        <div class="col-5">
            <div ${type ? "style='display: none'" : ""} class="mb-3">
                <div class="form-floating">
                    <form:input path="username" type="text" class="form-control" id="username" placeholder="username"/>
                    <label for="username">Username</label>
                </div>
                <form:errors path="username" cssClass="text-danger" element="label"/>
            </div>
            <div class="mb-3">
                <div class="form-floating">
                    <form:input path="fullName" type="text" class="form-control" id="fullName" placeholder="fullName"/>
                    <label for="fullName">Name</label>
                </div>
                <form:errors path="fullName" cssClass="text-danger" element="label"/>

            </div>
            <div class="mb-3">
                <div class="form-floating">
                    <form:input path="password" type="password" class="form-control" id="password"
                                placeholder="password"/>
                    <label for="password">Password</label>
                </div>
                <form:errors path="password" cssClass="text-danger" element="label"/>
            </div>
            <div class="mb-3">
                <div class="form-floating">
                    <form:input path="email" type="email" class="form-control" id="email" placeholder="email"/>
                    <label for="email">Email</label>
                </div>
                <form:errors path="email" cssClass="text-danger" element="label"/>
            </div>
            <div class="col-6 mb-5">
                <div class="form-check form-check-inline">
                    <form:checkbox path="activated" class="form-check-input" id="activity" value="1"/>
                    <label class="form-check-label" for="activity">Activity</label>
                </div>
                <div class="form-check form-check-inline">
                    <form:checkbox path="admin" class="form-check-input" id="admin" value="1"/>
                    <label class="form-check-label" for="admin">Admin</label>
                </div>
            </div>
            <div class="d-flex justify-content-start align-items-center w-25">
                <button class="btn btn-primary fw-semibold m-2">Save</button>
                <a href="/admin/account" class="btn btn-danger fw-semibold">Cancel</a>
            </div>
        </div>
        <div class="col-2 shadow-none p-3 mb-5 bg-body-tertiary rounded">
            <div class="row">
                <div class="col-12 mb-2">
                    <img src="/img/${user.photo == null ? 'not_found.jpg' : user.photo}" class="rounded-circle" alt="..." id="imagePreview" width="150px" height="150px" style="object-fit: cover">
                </div>
                <div class="col-12">
                    <div class="mb-3">
                        <input name="__" type="file" class="form-control form-control-sm" id="imageInput"/>
                        <form:errors path="photo" cssClass="text-danger" element="label"/>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form:form>
<script>
    const imageInput = document.getElementById('imageInput');
    imageInput.addEventListener('change', function (event) {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function (e) {
                imagePreview.src = e.target.result;
            };
            reader.readAsDataURL(file);
        }
    });
</script>