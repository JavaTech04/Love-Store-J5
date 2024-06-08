<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>LoveStore</title>
    <link rel="icon"
          href="/static/images/logo.jpg"
          type="image/x-icon">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script defer src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <link rel="stylesheet" href="static/css/navbar.css">
    <link rel="stylesheet" href="static/css/video.css">
    <link rel="stylesheet" href="static/css/product.css">
</head>
<body>
<jsp:include page="${sessionScope.roles == 'ROLE_admin' ? 'layout/_navbar_admin.jsp' : 'layout/_navbar.jsp'}"/>
<jsp:include page="${sessionScope.roles == 'ROLE_admin' ?  'admin/index.jsp' : 'client/index.jsp'}"/>
<jsp:include page="layout/_footer.jsp"/>
</body>
</html>
