<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/include.jsp" %>
<html>
<head>
    <%@ include file="/WEB-INF/views/common/head.jsp" %>
    <!--summernote Dependency-->
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
    <script>
        $(function (){
            $(".board-form").find("[name=content]").summernote({
                height : 500,
                minHeight : 300,
                callbacks: {
                    onImageUpload : function(files, editor, welEditable){

                        // 파일 업로드(다중업로드를 위해 반복문 사용)
                        for (var i = files.length - 1; i >= 0; i--) {
                            uploadSummernoteImageFile(files[i],this);
                        }
                    }
                }
            });
        })
    </script>
    <title>Title</title>
</head>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<div class="d-flex flex-column flex-shrink-0 p-3 text-bg-dark" style="width: 9.15%; height: 1000px; float: left;">
    <img src="<c:url value="${user.filePath}"/>" onerror='this.src="<c:url value="/assets/img/errorProfile.png"/>";' style="display: block; margin :0 auto ;" alt="" width="100" height="100" class="rounded-circle ">
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
        </li>
        <li>
            <a href="<c:url value="/main/stocks/allStock" />" class="nav-link text-white" id="sideStocks">
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
        <img src="<c:url value="${user.filePath}"/>" onerror='this.src="<c:url value="/assets/img/errorProfile.png"/>";'  alt="" width="32" height="32" class="rounded-circle me-2">
        <strong>${user.usrAs}</strong>
    </div>

</div>

<div style="width : 90.85%;height:1000px; padding: 50px; float:left; background-color: rgb(62 65 68);">
    <h1 style="text-align: center;" class="text-white">회원 게시판</h1>

    <h5 class="text-white">작성자</h5>
    <input type="text" class="form-control mb-3" id="writer" value="${user.username}" readonly>

    <h5 class="text-white"> 제목</h5>
    <div class="form-floating mb-3">
        <input type="text" class="form-control" id="title" maxlength="20">
        <label for="title">제목</label>
    </div>

    <form class="board-form" style="background-color: whitesmoke;">
        <textarea name="content" id="content"></textarea>
    </form>

    <div id="reqButton"  style="margin: 0 auto; text-align:center;" class="mt-4">
        <button type="button" class="btn btn-primary" onclick="writeBoard();" >저장</button>
        <button type="button" class="btn btn-success" onclick="moveBoardList();" style="">목록</button>
    </div>
</div>

<script>
    $(document).ready(function(){

        $("#headerBoard").addClass("active");
        $("#sideUserBoard").addClass("active");

    });


    function moveBoardList(){
        location.href = CONTEXT_PATH + "/userBoard/list";
    }

    var fileArray = [];
    function writeBoard(){

        var $title =  $("#title");
        var $content =  $("#content");
        var $usrId = "${user.usrId}";

        if(!$title.val().trim()){
            alert("제목을 입력하시기 바랍니다.");
            $title.focus();
            return false ;
        }
        if(!$content.val().length > 1000){
            alert("내용은 1000자 이하로 입력하시기 바랍니다.");
            $content.focus();
            return false ;
        }

        if(!$content.val().trim()){
            alert("내용을 입력하시기 바랍니다.");
            $content.focus();
            return false ;
        }
        var formData = new FormData();
        for(var i = 0; i<fileArray.length; i++){
            var str = fileArray[i];
            // str의 값 : common/getImg.do?savedFileName=bc395afe-2324-438d-ae68-1a0a75d0a431.png
            // '='를 기준으로 자른다.
            var result = str.toString().split('=');
            formData.append('file[]',result[1]);
            // result[1] : bc395afe-2324-438d-ae68-1a0a75d0a431.png
        }

        formData.append('boardTitle',$title.val().trim());
        formData.append('boardContent',$content.val().trim());
        formData.append('usrId',$usrId);

        $.ajax ({
            url	: CONTEXT_PATH + "/userBoard/write",
            method	: "POST",
            data : formData,
            enctype: 'multipart/form-data',
            processData : false,
            contentType : false,
            dataType    : "json",
            success : function(result) {
                alert(result.message);
                if(result.status == "OK"){
                    location.href = CONTEXT_PATH + "/userBoard/read/" + result.data;
                }else{
                    location.reload();
                }
            },
            error	: function(xhr, status, error) {
            }
        });
    }

    function uploadSummernoteImageFile(file, el) {
        var data = new FormData();
        data.append("file",file);
        $.ajax({
            url: CONTEXT_PATH + '/userBoard/image.do',
            type: "POST",
            enctype: 'multipart/form-data',
            data: data,
            cache: false,
            contentType : false,
            processData : false,
            success : function(result) {
                $(el).summernote('editor.insertImage',result.data);
                fileArray.push(result.data);
            },
            error : function(e) {
                console.log(e);
            }
        });
    }





</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>

