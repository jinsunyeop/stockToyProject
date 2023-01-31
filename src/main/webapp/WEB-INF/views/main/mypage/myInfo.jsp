<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/include.jsp" %>
<html>
<head>
    <%@ include file="/WEB-INF/views/common/head.jsp" %>

    <title>Title</title>
</head>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<div class="d-flex flex-column flex-shrink-0 p-3 text-bg-dark" style="width: 9.15%; height: 1000px; float: left;">
    <img src="<c:url value="${user.filePath}"/>" style="display: block; margin :0 auto ;" alt="" onerror='this.src="<c:url value="/assets/img/errorProfile.png"/>";' width="100" height="100" class="rounded-circle ">

    <br>
    <span class="fs-6" style="display: block; margin-left : 47px ;">${user.usrAs}</span>
    <hr>
    <ul class="nav nav-pills flex-column mb-auto">
        <li>
            <a href="<c:url value="/main/dashboard" />" class="nav-link text-white" id="sideDashBoard">
                <svg class="bi pe-none me-2" width="16" height="16"><use xlink:href="#speedometer2"/></svg>
                Dashboard
            </a>
        </li>
        <li>
            <a href="<c:url value="/main/mypage/myStockList" />" class="nav-link text-white" id="sideMyPage">
                <svg class="bi pe-none me-2" width="16" height="16"><use xlink:href="#table"/></svg>
                MyPage
            </a>
            <ul style="font-size:14px;padding-left: 80px;">
                <li><a style="text-decoration: none; color: white; " href="<c:url value="/main/mypage/myStockList" />" > myStock </a></li>
                <li><a style="font-weight: bold; color: white; "href="<c:url value="/main/mypage/main" />"  class="active">myInfo</a></li>
            </ul>
        </li>
        <li>
            <a href="#" class="nav-link text-white" id="sideStocks">
                <svg class="bi pe-none me-2" width="16" height="16"><use xlink:href="#grid"/></svg>
                Stocks
            </a>
        </li>
        <li>
            <a href="<c:url value="/userBoard/list" />" class="nav-link text-white" id="sideUserBoard">
                <svg class="bi pe-none me-2" width="16" height="16"><use xlink:href="#grid"/></svg>
                UserBoard
            </a>
        </li>
    </ul>
    <hr>
    <div class="">
            <img src="<c:url value="${user.filePath}"/>" alt="" width="32" height="32" class="rounded-circle me-2">
            <strong>${user.usrAs}</strong>
    </div>

</div>
<div style="width : 90.85%;height:1000px; float:left; background-color: rgb(62 65 68);">
    <div id="box1" style="height: 10%;"></div>
    <div class="container-md" style="width:70%; height:85%;  margin : 0 auto; background: #515151; ">
        <div id="box2" style="height: 5%;"></div>
        <div style="margin: 0 auto; text-align:center;">
            <img src="<c:url value="${user.filePath}"/>" id="previewImg" onerror='this.src="<c:url value="/assets/img/errorProfile.png"/>";'  style="margin-left: 350px;" alt="" width="200" height="200" class="rounded-circle ">
            <button type="button" class="btn btn-secondary" id="imgButton" onclick="imgButton();" style="margin-top: 160px;" >
                <input type="file" id="usrImg" onchange="readURL(this);">
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-fill" viewBox="0 0 16 16">
                    <path d="M12.854.146a.5.5 0 0 0-.707 0L10.5 1.793 14.207 5.5l1.647-1.646a.5.5 0 0 0 0-.708l-3-3zm.646 6.061L9.793 2.5 3.293 9H3.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.207l6.5-6.5zm-7.468 7.468A.5.5 0 0 1 6 13.5V13h-.5a.5.5 0 0 1-.5-.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.5-.5V10h-.5a.499.499 0 0 1-.175-.032l-.179.178a.5.5 0 0 0-.11.168l-2 5a.5.5 0 0 0 .65.65l5-2a.5.5 0 0 0 .168-.11l.178-.178z"/>
                </svg>
            </button>
        </div>
        <br>
        <div style="margin: 0 auto; width: 90%; background-color: #e5e5e5;">
            <br>
            <span class="fs-6" style="font-weight: bold;  display: block; padding-top: 10px;padding-left: 10px;">사용자 아이디</span>
            <input type="text" class="form-control" id="lgnId" value="${user.lgnId}"  readonly>
            <br>
            <span class="fs-6" style="font-weight: bold;  display: block; padding-top: 10px;padding-left: 10px;">사용자 비밀번호</span>
            <input type="text" class="form-control" id="lgnPwd" value="******" readonly>
            <br>
            <span class="fs-6" style="font-weight: bold;  display: block; padding-top: 10px;padding-left: 10px;">사용자 이메일</span>
            <input type="text" class="form-control" id="emlAddr"  value="${user.emlAddr}" readonly>
            <br>
            <span class="fs-6" style="font-weight: bold; padding-top: 10px;padding-left: 10px;">사용자 닉네임</span>
            <button type="button" class="btn btn-secondary"  onclick="change_NickName();" style="display: inline-block; margin-left: 10px;">
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-fill" viewBox="0 0 16 16">
                 <path d="M12.854.146a.5.5 0 0 0-.707 0L10.5 1.793 14.207 5.5l1.647-1.646a.5.5 0 0 0 0-.708l-3-3zm.646 6.061L9.793 2.5 3.293 9H3.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.207l6.5-6.5zm-7.468 7.468A.5.5 0 0 1 6 13.5V13h-.5a.5.5 0 0 1-.5-.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.5-.5V10h-.5a.499.499 0 0 1-.175-.032l-.179.178a.5.5 0 0 0-.11.168l-2 5a.5.5 0 0 0 .65.65l5-2a.5.5 0 0 0 .168-.11l.178-.178z"/>
                </svg>
            </button>
            <input type="text" class="form-control" maxlength="8" id="usrAs"  placeholder="닉네임을 입력하시기 바랍니다."  value="${user.usrAs}" readonly>
            <br>
            <span class="fs-6" style="font-weight: bold;  display: block; padding-top: 10px;padding-left: 10px;">가입 날짜</span>
            <input type="text" class="form-control" id="joinDt" value="<fmt:formatDate value="${user.joinDt}" pattern="yyyy-MM-dd"/>"  readonly>
            <div style="margin: 0 auto; text-align:center;">
                <button type="button" class="btn btn-secondary" onclick="change_Info();"  style="margin: 30px;" > 수정하기</button>
            </div>

        </div>
    </div>

</div>


</div>

<script>
    $(document).ready(function(){

        $("#headerMyPage").addClass("active");
        $("#sideMyPage").addClass("active");
        document.getElementById('previewImg').src =  currentFileInfo;
    });
    var newFileInfo;
    var currentFileInfo ="${user.filePath}";

    // function imgButton(){
    //     $("#imgButton").html('<input type="file" id="usrImg" onchange="readURL(this);">');
    //     $("#previewImg").css("margin-left","350px");
    // }

    function change_Info(){
        var form = new FormData();
        form.append("oldImg",currentFileInfo);
        form.append( "profileImg",$("#usrImg")[0].files[0]);
        form.append( "usrAs", $("#usrAs").val().trim());
        $.ajax({
            url : "/main/mypage/myInfo/changeInfo",
            enctype: 'multipart/form-data',
            type : "POST",
            processData : false,
            contentType : false,
            data : form,
            success:function(result) {
                alert(result.message);
                location.reload();
            },
            error: function (jqXHR){
                alert(jqXHR.responseText);
            }
        });
    }

    function readURL(input) {
        var typeArr= ["image/png","image/jpg","image/jpeg"];
        if (typeArr.indexOf(input.files[0].type) > -1) {
            var reader = new FileReader();
            reader.onload = function(e) {
                document.getElementById('previewImg').src = e.target.result;
            };
            reader.readAsDataURL(input.files[0]);
        } else {
            alert("확장자는 jpg,jpeg,png만 가능합니다.");
            $("#usrImg").val("");
        }
        console.log($("#usrImg")[0].files[0] );
    }

    function change_NickName(){
        $("#usrAs").attr("readonly",false);
        $("#usrAs").focus();
    }

    function calculateMA(dayCount, data) {
        var result = [];
        for (var i = 0, len = data.length; i < len; i++) {
            if (i < dayCount) {
                result.push('-');
                continue;
            }
            var sum = 0;
            for (var j = 0; j < dayCount; j++) {
                sum += +data[i - j][1];
            }
            result.push(sum / dayCount);
        }
        return result;
    }


    function numberWithCommas(x) {
        return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }


</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>

