<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/include.jsp" %>
<html>
<head>
    <%@ include file="/WEB-INF/views/common/head.jsp" %>
    <style type="text/css">
        body {
            margin: 0px;
            background-color: rgb(62 65 68);
        }

    </style>
    <title>Title</title>
</head>
<body>
<div class="container col-xl-10 col-xxl-8 px-4 py-5 mt-4">
    <div class="row align-items-center g-lg-5 py-5 p-4">
            <form class="p-4 p-md-5 border rounded-3 bg-secondary" style="text-align: center; height: 700px;">

                <h1>${error}</h1>
                <br>
                <h2>${code}</h2>
                <img src="<c:url value="/assets/img/error.png"/>"  style="border-radius: 100px; display: block;margin: 0 auto;padding-top: 50px;width: 300px;height: 350px;" >

            </form>
        <button style="width: 300px; margin: 0 auto; height: 50px;" onclick="history.back();">뒤로가기</button>

    </div>
</div>
<script>

</script>




