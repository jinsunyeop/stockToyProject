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
                    <a href="#" onclick="" style="color:black;" data-bs-toggle="modal" data-bs-target="#findIdPwdModal">아이디/비밀번호 찾기</a>
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


<div class="modal fade" id="findIdPwdModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title fw-bolder" id="staticBackdropLabel">아이디 / 비밀번호 찾기</h3>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <br>
            <div class="modal-body">
                <h4 class="fw-bolder">아이디 찾기</h4>
                <hr>
                <p class="fw-bolder"style="margin-bottom: 5px;">이메일 주소</p>
                <div class="input-group" style="margin-bottom: 10px;">
                    <input type="text" id="emailForId" class="form-control" placeholder="이메일을 입력하세요." aria-label="Input group example" aria-describedby="basic-addon1">
                </div>

                <div style="height: 25px;"></div>
                <button type="button" class="btn btn-primary" onclick="findId();" style="display: block; margin: 0 auto;">아이디 찾기</button>

                <br><br><hr>

                <h4 class="fw-bolder">비밀번호 찾기</h4>
                <hr>
                <p class="fw-bolder"style="margin-bottom: 5px;">아이디</p>
                <div class="input-group" style="margin-bottom: 10px;">
                    <input type="text" id="idForPwd" class="form-control"  placeholder="아이디를 입력하세요." aria-label="Input group example" aria-describedby="basic-addon1">
                </div>

                <p class="fw-bolder"style="margin-bottom: 5px;">이메일 주소</p>
                <div class="input-group" style="margin-bottom: 10px;">
                    <input type="text" id="emailForPwd" class="form-control" placeholder="이메일을 입력하세요." aria-label="Input group example" aria-describedby="basic-addon1">
                </div>

                <div style="height: 25px;"></div>
                <button type="button" class="btn btn-primary" onclick="findPwd();" style="display: block; margin: 0 auto;">비밀번호 찾기</button>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>

    <script>
        function findId(){
            var $emlAddr =  $("#emailForId");

            if(!$emlAddr.val().trim()){
                alert("이메일을 입력하시기 바랍니다.");
                $emlAddr.focus();
                return false ;
            }

            $.ajax ({
                url	: CONTEXT_PATH + "/findId",
                method	: "GET",
                data : {
                    emlAddr : $emlAddr.val().trim()
                },
                async : true,
                processData : true,
                dataType    : "text",
                success : function(msg) {
                    alert(msg);
                },
                error	: function(xhr, status, error) {
                }
            });
        }

        function findPwd(){
            var $lgnId =  $("#idForPwd");
            var $emlAddr =  $("#emailForPwd");

            if(!$lgnId.val().trim()){
                alert("아이디를 입력하시기 바랍니다.");
                $lgnId.focus();
                return false ;
            }

            if(!$emlAddr.val().trim()){
                alert("이메일을 입력하시기 바랍니다.");
                $emlAddr.focus();
                return false ;
            }

            $.ajax ({
                url	: CONTEXT_PATH + "/findPwd",
                method	: "GET",
                data : {
                    lgnId : $lgnId.val().trim(),
                    emlAddr : $emlAddr.val().trim()
                },
                async : true,
                processData : true,
                dataType    : "text",
                success : function(msg) {
                    alert(msg);
                },
                error	: function(xhr, status, error) {
                }
            });
        }



    </script>

</div>




