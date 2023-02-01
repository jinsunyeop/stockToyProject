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
            <img src="<c:url value="${user.filePath}"/>" alt="" width="32" height="32" class="rounded-circle me-2">
            <strong>${user.usrAs}</strong>
    </div>

</div>
<div style="width : 90.85%;height:1000px; float:left; background-color: rgb(62 65 68);">
    <div id="box1" style="text-align: center; margin: 30 auto;"> <h2 style="color: #e5e5e5; font-weight: bold;">회원 자유게시판</h2></div>
    <div class="container-md" style="width:90%; height:85%;  margin : 0 auto; background: #515151; ">
        <div id="box2" style="height: 5%;"></div>
        <div style="margin: 0 auto; text-align:center;">
            <select class="form-select" id="sortType" aria-label="Default select example" style="margin-left: 270px; width: 200px; float: right;">
                <option value="BOARD_NO" selected>게시판 번호 순</option>
                <option value="readCnt">조회 많은 순</option>
                <option value="regDt">최신 순</option>
            </select>
            <button type="button" onclick="searchStockList();" class="btn btn-secondary" style="display: block; margin-left:4px;float: right;">
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="26" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
                    <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
                </svg>
            </button>
            <input type="text" id ="keyword" style="display: block; float: right; margin-bottom: 100px; width: 276px;" placeholder="게시판 제목을 입력해주세요." class="form-control" maxlength="20">
            <table  class="table-S1 cell-border hover" style="width:100%; margin-top: 30px; text-align: center; ">
                <colgroup>
                    <col><!-- No -->
                    <col><!-- 지원사업명 -->
                    <col ><!-- 지원분야 -->
                    <col><!-- 지원기관 -->
                    <col ><!-- 지역 -->
                </colgroup>
                <thead>
                <tr>
                    <th style="color: #e5e5e5;">NO</th>
                    <th style="color: #e5e5e5;">제목</th>
                    <th style="color: #e5e5e5;">조회 수</th>
                    <th style="color: #e5e5e5;">날짜</th>
                </tr>
                </thead>
                <tbody id="boardList" style="color: #e5e5e5;">

                </tbody>
            </table>
            <br><br><br>
            <nav aria-label="Page navigation example">
                <ul class="pagination justify-content-center" id="paging">
                </ul>
            </nav>
            <button type="button" onclick="locationWriteBoard();" class="btn btn-secondary" style="display: block; margin-top:200px;float: right;">작성하러 가기</button>

        </div>
    </div>

</div>


</div>

<script>
    $(document).ready(function(){
        pagingBoardList();
        $("#headerBoard").addClass("active");
        $("#sideUserBoard").addClass("active");
        $("#sortType").change(function(e){
            pagingBoardList();
        });
        $("#keyword").keyup(function(e) {
            if (e.keyCode == 13) {
                pagingBoardList();
            }
        });

    });

    function locationWriteBoard(){
        location.href = '<c:url value="/userBoard/write"/>';
    }

    var page = 1;
    function pagingBoardList(){

        $.ajax({
            url: CONTEXT_PATH + "/userBoard/list.do",
            method: "GET",
            async: true,
            data :{
                pageNum : page,
                boardTitle : $("#keyword").val().trim(),
                sortName :$("#sortType").val()
            },
            processData: true,
            dataType: "json",
            success: function (result) {
                console.log(result);
                var list = result.boardList;
                var paging = result.paging;

                $("#boardList").empty();
                for(var i = 0; i < list.length; i++){
                    var str = '<tr>';
                    str += '<td>'+ list[i].boardNo +'</td>';
                    str += '<td>'+'<a href="<c:url value="/userBoard/read/"/>'+list[i].boardNo +'" style="color : pink; text-decoration: none;">' + list[i].boardTitle + '<a>'+'</td>';
                    str += '<td>'+ numberWithCommas(list[i].readCnt) +'</td>';
                    str += '<td>'+ list[i].regDt.substring(0,10) +'</td>';
                    $("#boardList").append(str);
                }

                //페이징 변환
                $("#paging").empty();
                var startPage = paging.startPage;  //페이지 시작번호
                var pageSize = paging.pageSize;  //페이지 사이즈
                var currentPage = paging.page;  //현재 페이지
                var pagingStr = '<li class="page-item" id="back"> <a class="page-link" onclick="movePage('+(startPage-pageSize)+');">'+ '<<'+' </a></li>';

                for(var i = startPage; i < (startPage+pageSize); i++){
                    if(currentPage == i && i<=paging.endPage ){
                        pagingStr += '<li class="page-item active"><a class="page-link" onclick="movePage('+i+');">'+i+'</a></li>';
                    }else if(currentPage != i && i<=paging.endPage){
                        pagingStr += '<li class="page-item"><a class="page-link" onclick="movePage('+i+');">'+i+'</a></li>';
                    }
                }
                pagingStr += '<li class="page-item" id="next"><a class="page-link" onclick="movePage('+(startPage+pageSize)+');"> '+'>>'+ '</a></li>';

                $("#paging").append(pagingStr);

                if(!paging.existPrevPage){
                    $("#back").addClass("disabled");
                }
                if(!paging.existNextPage){
                    $("#next").addClass("disabled");
                }


            },
            error: function (xhr, status, error) {
            }
        });
    }

    function movePage(i){
        page = i;
        pagingBoardList();
    }

    function numberWithCommas(x) {
        return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }

</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>

