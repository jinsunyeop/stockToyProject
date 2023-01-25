<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/include.jsp" %>
<html>
<head>
    <style type="text/css">
        body {
            margin: 0px;
            background-image: url("https://cbxnews.wpenginepowered.com/wp-content/uploads/2018/08/graph_up_blue.gif")
        }

    </style>
    <%@ include file="/WEB-INF/views/common/head.jsp" %>
    <title>Title</title>
</head>
<body>
<img src="<c:url value="/assets/img/stockLogo.png"/>"  style="border-radius: 100px; display: block;margin: 0 auto;padding-top: 50px;width: 900px;height: 350px;" >
<div class="container col-xl-10 col-xxl-8 px-4 py-5 mt-4">
    <div class="row align-items-center g-lg-5 py-5 p-4">
            <form class="p-4 p-md-5 border rounded-3 bg-secondary">
                <div class="form-floating mb-3">
                    <input type="text" class="form-control" id="lgnId" name="lgnId" placeholder="name@example.com">
                    <label for="lgnId">Email address</label>
                </div>
                <div class="form-floating mb-3">
                    <input type="password" class="form-control" id="lgnPwd" name="lgnPwd" placeholder="Password">
                    <label for="lgnPwd">Password</label>
                </div>
                <div class="checkbox mb-3">
                </div>
                <a class="w-100 btn btn-lg btn-secondary" onclick="login();">Sign up</a>
                <hr class="my-4">
                <div>
                    <a href="#" onclick="" style="color:black;">아이디/비밀번호 찾기</a>
                    <a href="<c:url value="/join" />" style="display: block; color:black; float: right;">회원가입</a>
                </div>
            </form>
    </div>
</div>
<script>
    $(document).ready(function(){
        $("#lgnId,#lgnPwd").keyup(function(e) {
            if (e.keyCode == 13) {
                login();
            }
        });
    });



    function login(){
        var $lgnId =  $("#lgnId");
        var $lgnPwd =  $("#lgnPwd");

        if(!$lgnId.val().trim()){
            alert("아이디를 입력하시기 바랍니다.");
            $lgnId.focus();
            return false ;
        }

        if(!$lgnPwd.val().trim()){
            alert("비밀번호를 입력하시기 바랍니다.");
            $lgnPwd.focus();
            return false ;
        }

        $.ajax ({
            url	: CONTEXT_PATH + "/login/login",
            method	: "POST",
            data : {
              lgnId: $lgnId.val().trim(),
              lgnPwd: $lgnPwd.val().trim()
            },
            async : true,
            processData : true,
            dataType    : "json",
            success : function(result) {
                if (result == false) {
                    alert("아이디 또는 비밀번호가 맞지 않습니다.");
                }else{
                    window.location.href = '/main/dashboard'; // goHome
                }
            },
            error	: function(xhr, status, error) {
            }
        });
    }

</script>




