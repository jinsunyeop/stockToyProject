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
            <a href="#" class="nav-link text-white" id="sideStocks">
                <svg class="bi pe-none me-2" width="16" height="16"><use xlink:href="#grid"/></svg>
                Stocks
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
    <div id="box1" style="text-align: center; margin: 30 auto;"> <h2 style="color: #e5e5e5; font-weight: bold;">국내 주식 리스트</h2></div>
    <div class="container-md" style="width:90%; height:85%;  margin : 0 auto; background: #515151; ">
        <div id="box2" style="height: 5%;"></div>
        <div style="margin: 0 auto; text-align:center;">
            <h4 style="color: #e5e5e5; font-weight: bold; margin-bottom: 30px;" id="today"></h4>
            <button type="button" onclick="searchStockList();" class="btn btn-secondary" style="display: block; margin-left:4px;float: right;">
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="26" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
                    <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
                </svg>
            </button>
            <input type="text" id ="keyword" style="display: block; float: right; margin-bottom: 10px; width: 276px;"  class="form-control" maxlength="20">
            <table  class="table-S1 cell-border hover" style="width:100%; margin: 0; text-align: center; ">
                <colgroup>
                    <col><!-- No -->
                    <col><!-- 지원사업명 -->
                    <col ><!-- 지원분야 -->
                    <col><!-- 지원기관 -->
                    <col ><!-- 지역 -->
                    <col ><!-- 신청기간시작일 -->
                    <col ><!-- 신청기간종료일 -->
                </colgroup>
                <thead>
                <tr>
                    <th style="color: #e5e5e5;">종목명</th>
                    <th style="color: #e5e5e5;">시장구분</th>
                    <th style="color: #e5e5e5;">종가</th>
                    <th style="color: #e5e5e5;">즐겨찾기</th>
                </tr>
                </thead>
                <tbody id="stockList" style="color: #e5e5e5;">

                </tbody>
            </table>
            <br><br><br>
            <nav aria-label="Page navigation example">
                <ul class="pagination justify-content-center" id="paging">

                </ul>
            </nav>

        </div>
    </div>

</div>


</div>

<script>
    $(document).ready(function(){
        pagingStockList();
        $("#headerStocks").addClass("active");
        $("#sideStocks").addClass("active");

        $("#keyword").keyup(function(e) {
            if (e.keyCode == 13) {
                searchStockList();
            }
        });

    });

    var page = 1;
    function pagingStockList(){

        $.ajax({
            url: CONTEXT_PATH + "/main/stocks/allStock/pagingStockList",
            method: "GET",
            async: true,
            data :{
                pageNum : page
            },
            processData: true,
            dataType: "json",
            success: function (result) {
                console.log(result.paging);
                console.log(result.list);
                var today = result.list[0].basDt;
                var list = result.list;
                var paging = result.paging;

                $("#today").empty();
                var str = today.substring(0,4) + "년 " + today.substring(4,6) + "월 " + today.substring(6,8)+"일 기준";
                $("#today").append(str);


                $("#stockList").empty();
                for(var i = 0; i < list.length; i++){
                    var str = '<tr>';
                    str += '<td>'+'<a href="<c:url value="/main/stocks/detail/"/>'+list[i].srtnCd +'" style="color : pink; text-decoration: none;">' + list[i].itmsNm + '<a>'+'</td>';
                    str += '<td>'+ list[i].mrktCtg +'</td>';
                    str += '<td>'+ numberWithCommas(list[i].clpr) +'</td>';
                    str += '<td>'+'<input type="checkbox" onclick="favorite(this);" value="'+list[i].srtnCd+'"  class="favorite" id="'+list[i].srtnCd+'" >'+'</td>';
                    $("#stockList").append(str);
                    if(list[i].usrFavorite){$('#'+list[i].srtnCd).attr('checked',true)};
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
        pagingStockList();
    }

    function favorite(e){

        var action;

        if($(e).prop('checked')){
            action = "regist";
        }else{
            action = "delete";
        }

        $.ajax({
            url: CONTEXT_PATH + "/main/stocks/allStock/" + action,
            method: "GET",
            async: true,
            data :{
                srtnCd : $(e).val()
            },
            processData: true,
            dataType: "json",
            success: function (result) {
                alert(result.message);
                if(!(result.status == "OK") && (action == "regist") ){
                    $(e).prop('checked', false);
                }
                if(!(result.status == "OK") && (action == "delete") ){
                    $(e).prop('checked', true);
                }
            },
            error: function (xhr, status, error) {
            }
        });
    }

    function numberWithCommas(x) {
        return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }


    function searchStockList(){

        if(!$("#keyword").val().trim()){
            alert("키워드를 입력하시기 바랍니다.");
        }
        $.ajax({
            url: CONTEXT_PATH + "/main/stocks/allStock/searchStockList",
            method: "GET",
            async: true,
            data :{
                keyword : $("#keyword").val().trim()
            },
            processData: true,
            dataType: "json",
            success: function (result) {
                var today = result[0].basDt;
                var list = result;

                $("#today").empty();
                var str = today.substring(0,4) + "년 " + today.substring(4,6) + "월 " + today.substring(6,8)+"일 기준";
                $("#today").append(str);

                $("#stockList").empty();
                for(var i = 0; i < list.length; i++){
                    var str = '<tr>';
                    str += '<td>'+'<a href="javascript:callFunction( list[i].srtnCd );" style="color : pink; text-decoration: none;">' + list[i].itmsNm + '<a>'+'</td>';
                    str += '<td>'+ list[i].mrktCtg +'</td>';
                    str += '<td>'+ numberWithCommas(list[i].clpr) +'</td>';
                    str += '<td>'+'<input type="checkbox" onclick="favorite(this);" value="'+list[i].srtnCd+'"  class="favorite" id="'+list[i].srtnCd+'" >'+'</td>';
                    $("#stockList").append(str);
                    if(list[i].usrFavorite){$('#'+list[i].srtnCd).attr('checked',true)};
                }
                $("#paging").empty();

            },
            error: function (xhr, status, error) {
            }
        });
    }


</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>

