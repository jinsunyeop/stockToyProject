<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/include.jsp" %>
<html>
<head>
    <%@ include file="/WEB-INF/views/common/head.jsp" %>
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
            <img src="<c:url value="${user.filePath}"/>" onerror='this.src="<c:url value="/assets/img/errorProfile.png"/>";' alt="" width="32" height="32" class="rounded-circle me-2">
            <strong>${user.usrAs}</strong>
    </div>

</div>
<div style="width : 90.85%;height:1000px; float:left;">
    <div class="myStockStatus" style="width: 50%; height: 50%;  float: left; text-align: center; padding:10px; background-color: rgb(62 65 68); ">
        <c:if test="${stockExist ne true}">
            <div id = "myStockChart" style="width: 100%; height: 100%; padding:10px; background-color: rgb(62 65 68); ">
                <h3 style="color: #ffffff;font-weight: 600;"  class="font-weight-bold">나의 보유 주식 현황</h3>

                <button type="button" style="margin-top: 180px;" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#settingMyStock"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-fill" viewBox="0 0 16 16" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
                        <path d="M12.854.146a.5.5 0 0 0-.707 0L10.5 1.793 14.207 5.5l1.647-1.646a.5.5 0 0 0 0-.708l-3-3zm.646 6.061L9.793 2.5 3.293 9H3.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.207l6.5-6.5zm-7.468 7.468A.5.5 0 0 1 6 13.5V13h-.5a.5.5 0 0 1-.5-.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.5-.5V10h-.5a.499.499 0 0 1-.175-.032l-.179.178a.5.5 0 0 0-.11.168l-2 5a.5.5 0 0 0 .65.65l5-2a.5.5 0 0 0 .168-.11l.178-.178z"/>
                    </svg>  나의 보유 주식 추가하기 </button>
            </div>
        </c:if>
        <c:if test="${stockExist eq true}">
            <div style="width: 100%; height: 95%;">
                <h3 style="color: #ffffff;font-weight: 600;"  class="font-weight-bold">나의 보유 주식 현황</h3>
                <h5 style="color: #ffffff;font-weight: 600; margin-bottom:30px;"  class="font-weight-bold">(총 ${myStockListCnt} 건)</h5><br>

                <p style="display: block; height: 5%; background-color: rgb(62 65 68); margin : 0;">
                    <a href="#" class="text-decoration-none" style="display:block; float:right; color: #ffffff;" >
                        수정 및 추가하러 가기
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
                            <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"/>
                            <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z"/>
                        </svg>
                    </a>
                </p>
                <table id="myStock_dataTables" class="table-S1 cell-border hover" style="width:100%; margin: 0;">
                    <colgroup>
                        <col  ><!-- No -->
                        <col><!-- 지원사업명 -->
                        <col ><!-- 지원분야 -->
                        <col><!-- 지원기관 -->
                        <col ><!-- 지역 -->
                        <col ><!-- 신청기간시작일 -->
                        <col ><!-- 신청기간종료일 -->
                    </colgroup>
                    <thead>
                    <tr>
                        <th>종목명</th>
                        <th>시작가</th>
                        <th>종가</th>
                        <th>전일 대비</th>
                        <th>전일 대비 등락률</th>
                        <th>하루 최저가</th>
                        <th>하루 최고가</th>
                    </tr>
                    </thead>
                </table>
            </div>

        </c:if>
    </div>
    <div style="width: 50%; height: 50%; background: #515151;  text-align: center; float: left;">
        <c:if test="${stockExist ne true}">
            <h3 style="color: #ffffff;font-weight: 600;"  class="font-weight-bold">나의 급등 주식</h3>
        </c:if>
        <c:if test="${stockExist eq true}">
            <div id = "warnStockChart" style="width: 100%; height: 100%; padding:10px; background: #515151;">

            </div>
        </c:if>

    </div>
    <div style="width: 50%; height: 50%; background: #868686 ; float: left; padding:10px; text-align: center;">
        <h3 style="color: #ffffff;font-weight: 600;"  class="font-weight-bold">나의 관심 주식</h3>
        <h5 style="color: #ffffff;font-weight: 600;"  class="font-weight-bold">(총 ${favoriteStockCnt} 건)</h5>
        <br><br>
        <p style="display: block; height: 5%; background-color:#868686; margin : 0;">
            <a href="#" class="text-decoration-none" style="display:block; float:right; color: #ffffff;" >
                즐겨찾기 수정
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
                    <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"/>
                    <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z"/>
                </svg>
            </a>
        </p>
        <div style="margin: 0;">
            <table id="favoriteStock_dataTables" class="table-S1 cell-border hover" style="width:100%; margin: 0;">
                <colgroup>
                    <col  ><!-- No -->
                    <col><!-- 지원사업명 -->
                    <col ><!-- 지원분야 -->
                    <col><!-- 지원기관 -->
                    <col ><!-- 지역 -->
                    <col ><!-- 신청기간시작일 -->
                    <col ><!-- 신청기간종료일 -->
                </colgroup>
                <thead>
                <tr>
                    <th>종목명</th>
                    <th>시작가</th>
                    <th>종가</th>
                    <th>전일 대비</th>
                    <th>전일 대비 등락률</th>
                    <th>하루 최저가</th>
                    <th>하루 최고가</th>
                </tr>
                </thead>
            </table>
        </div>
    </div>
    <div id="myAsset" style="padding:10px; width: 50%; height: 50%; background: #696969; text-align: center; float: left;">
        <h3 style="color: #ffffff;font-weight: 600;"  class="font-weight-bold">나의 보유 자산</h3>
        <br><br><br><br><br>
        <h1 id="countMyAsset" style="color: #ffffff;font-weight: 600; font-size:100px;"  class="font-weight-bold"></h1>
    </div>
</div>

<div class="modal fade" id="settingMyStock" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title fw-bolder" id="staticBackdropLabel">나의 보유 주식 추가</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p class="fw-bolder"style="margin-bottom: 5px;">종목명
                    <button type="button" id="resetButton" onclick="inputReset();" class="btn btn-secondary" style="float:right;" >
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-clockwise" viewBox="0 0 16 16">
                            <path fill-rule="evenodd" d="M8 3a5 5 0 1 0 4.546 2.914.5.5 0 0 1 .908-.417A6 6 0 1 1 8 2v1z"/>
                            <path d="M8 4.466V.534a.25.25 0 0 1 .41-.192l2.36 1.966c.12.1.12.284 0 .384L8.41 4.658A.25.25 0 0 1 8 4.466z"/>
                        </svg>
                    </button>
                </p>
                <div class="input-group" style="margin-bottom: 10px;">
                    <span class="input-group-text" id="basic-addon1">
                     <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
                       <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
                     </svg>
                    </span>
                    <input type="text" id="itmsNm" class="form-control" onkeyup="searchKeywordStock(this);" placeholder="종목명을 입력하세요." aria-label="Input group example" aria-describedby="basic-addon1">
                </div>
                <ul id="searchList" style="display: none;  padding:0; list-style:none; ">

                </ul>

                <p class="fw-bolder"style="margin-bottom: 5px;">단축 코드</p>
                <div class="input-group">
                    <input type="text" id="srtnCd" class="form-control" placeholder="단축 코드" aria-label="Input group example" aria-describedby="basic-addon1" style="margin-bottom: 25px;" readonly>
                </div>

                <p class="fw-bolder"style="margin-bottom: 5px;">시장 구분</p>
                <div class="input-group">
                    <input type="text" id="mrktCtg" class="form-control" placeholder="KOSPI / KOSDAQ/ KONEX" aria-label="Input group example" aria-describedby="basic-addon1" readonly style="margin-bottom: 25px;" >
                </div>

                <p class="fw-bolder"style="margin-bottom: 5px;">수량</p>
                <div class="input-group">
                    <input type="number" id="stockCnt" placeholder="수량을 입력하세요. (1주 이상)" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" class="form-control" aria-label="Input group example" aria-describedby="basic-addon1" style="margin-bottom: 25px;"  >
                </div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" onclick="saveStock();">save</button>
            </div>
        </div>
    </div>

    <script>
        function searchKeywordStock(e){
            var keyword = $(e).val().trim();
            if(keyword) {
                $.ajax({
                    url: CONTEXT_PATH + "/main/dashboard/search",
                    method: "POST",
                    data: {
                        keyword: keyword
                    },
                    async: true,
                    processData: true,
                    dataType: "json",
                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                    success: function (result) {
                        $("#searchList").html('');
                        $("#searchList").css("display", "block");
                        if (result.status == "OK") {
                            for (var i = 0; i < result.data.length; i++) {
                                $("#searchList").append('<li><a class="form-control" onclick = "drawResultStock(\''+result.data[i].itmsNm+','+result.data[i].srtnCd+','+ result.data[i].mrktCtg+'\')" href="#">' + result.data[i].itmsNm + '</a></li>');
                            }
                        }else{
                            $("#searchList").append('<li><a class="form-control" href="#">' + result.message + '</a></li>');
                        }
                    },
                    error: function (xhr, status, error) {
                    }
                });
            }else {
                $("#searchList").html('');
            }
        }

        function  drawResultStock(stock){
            var stockArr = stock.split(",");
            console.log(stockArr);
            $("#searchList").html('');
            $("#itmsNm").val(stockArr[0]).attr("readonly", true);
            $("#srtnCd").val(stockArr[1]);
            $("#mrktCtg").val(stockArr[2]);
        }

        function inputReset(){
            $("#itmsNm").val('').attr("readonly", false);
            $("#srtnCd").val('');
            $("#mrktCtg").val('');
            $("#stockCnt").val('');
        }

        function saveStock(){
            var $itmsNm = $("#itmsNm").val().trim();
            var $srtnCd =  $("#srtnCd").val().trim();
            var $stockCnt = $("#stockCnt").val().trim();

            if(!$itmsNm){
                alert("종목을 선택하시기 바랍니다.");
                return false;
            }

            if(!$stockCnt || $stockCnt == "0"){
                alert("수량은 1주 이상 입력하시기 바랍니다.");
                return false;
            }

            $.ajax({
                url: CONTEXT_PATH + "/main/dashboard/saveStock",
                method: "POST",
                data: {
                    srtnCd : $srtnCd,
                    usrSrtnCnt : $stockCnt
                },
                async: true,
                processData: true,
                dataType: "json",
                success: function (result) {
                    if (result.status == "OK") {
                        alert(result.message);
                        location.reload();
                    }else{
                        alert(result.message);
                    }
                },
                error: function (xhr, status, error) {
                }
            });

            return true;

        }


    </script>

</div>

<script>
    $(document).ready(function(){

        $("#headerDashBoard").addClass("active");
        $("#sideDashBoard").addClass("active");

        draw_myStock_dataTables();
        draw_warnStockChart();
        draw_favoriteStock_dataTables();
        draw_asset("${myAsset}");
    });


    //주식 업데이트 날짜
    var referenceDt = "${referenceDt}";
    var referYear = referenceDt.substring(0,4);
    var referMonth = referenceDt.substring(4,6);
    var referDay = referenceDt.substring(6);


    function draw_asset(asset){
        $({ val : 0/*시작숫자*/ }).animate({ val : asset/*종료숫자*/ }, {
            duration: 1500,
            step: function() {
                var num = numberWithCommas(Math.floor(this.val));
                $("#countMyAsset").text(num+" ￦");
            },
            complete: function() {
                var num = numberWithCommas(Math.floor(this.val));
                $("#countMyAsset").text(num+" ￦");
            }
        });
    }

    function draw_myStock_dataTables(){
        var stockArr = [];

        <c:forEach items="${myStockList}" var="item">
        var info = {};
        info.itmsNm="${item.itmsNm}";
        info.mkp="${item.mkp}";  //시작가
        info.clpr="${item.clpr}"; //종가
        info.vs="${item.vs}";  //전일 대비
        info.fltRt="${item.fltRt}"; //전일 대비 등락률
        info.lopr="${item.lopr}"; //하루 최저가
        info.hipr="${item.hipr}"; //하루 최고가
        info.srtnCd="${item.srtnCd}";
        stockArr.push(info);
        </c:forEach>

        var columns = [
            { data: 'itmsNm',		className: 'c-pointer dt-body-center',		defaultContent: '-' }, 	// [0]
            { data: 'mkp',			className: 'c-pointer dt-body-right',	    defaultContent: '-' }, 	// [3]
            { data: 'clpr',			className: 'c-pointer dt-body-right',		defaultContent: '-' }, 	// [1]
            { data: 'vs',			className: 'c-pointer dt-body-right',		defaultContent: '-' }, 	// [2]
            { data: 'fltRt',		className: 'c-pointer dt-body-center',		defaultContent: '-' }, 	// [4]
            { data: 'lopr',			className: 'c-pointer dt-body-right',		defaultContent: '-' }, 	// [5]
            { data: 'hipr',			className: 'c-pointer dt-body-right',		defaultContent: '-' } 	// [6]
        ];

        var columnDefs = [{
            createdCell: function(cell, cellData, rowData, rowIndex, colIndex) {
                if ([0].indexOf(colIndex) > -1) {
                    var str = '<a style="color: #0c0c0c" class="text-decoration-none font-weight-bold" href ="<c:url value="/main/stocks/detail/"/>'+rowData.srtnCd +'" >' + cellData + '</a>';
                    cell.innerHTML = str;
                }
                if ([1].indexOf(colIndex) > -1) {
                    var str =  numberWithCommas(cellData) + ' ￦';
                    cell.innerHTML = str;
                }
                if ([2].indexOf(colIndex) > -1) {
                    var str =  numberWithCommas(cellData) + ' ￦';
                    cell.innerHTML = str;
                }
                if ([3].indexOf(colIndex) > -1) {
                    var str =  numberWithCommas(cellData) + ' ￦';
                    cell.innerHTML = str;
                }
                if ([4].indexOf(colIndex) > -1) {
                    var str =  cellData + ' %';
                    cell.innerHTML = str;
                }
                if ([5].indexOf(colIndex) > -1) {
                    var str =  numberWithCommas(cellData) + ' ￦';
                    cell.innerHTML = str;
                }
                if ([6].indexOf(colIndex) > -1) {
                    var str =  numberWithCommas(cellData) + ' ￦';
                    cell.innerHTML = str;
                }


            }, targets: columns.map(function(d, i) { return i }) // 모든 컬럼
        }];

        dataTable = $("#myStock_dataTables").DataTable({
            serverSide: false, // processing: true,
            data : stockArr,
            columns: columns,
            columnDefs: columnDefs,
            order: [],
            ordering: true,   // 정렬기능 여부
            searching: false, // 검색기능 여부
            info: false,      // 정보표시 여부
            paging: true,     // 페이징 여부
            pageLength: 5,       // 한 페이지에 표시할 개수
            lengthChange: true, // 한 페이지에 표시할 개수 설정 (10/25/50/100)
            scrollX: true,
            dom: 'rt<"table-footSet"pi><"clear">'

        });
    }

    function draw_warnStockChart(){
        var stockArr = [];  //종목명

        <c:forEach items="${warnStockList}" var="item">
            var info = [];
            info.push("${item.basDt}".substring(0,4) + "/"+ "${item.basDt}".substring(4,6) + "/" + "${item.basDt}".substring(6)); //날짜
            info.push("${item.mkp}");  //시작가
            info.push("${item.clpr}"); //종가
            info.push("${item.vs}");  //전일 대비
            info.push("${item.fltRt}"); //전일 대비 등락률
            info.push("${item.lopr}"); //하루 최저가
            info.push("${item.hipr}"); //하루 최고가
            info.push(""); //하루 최저가
            info.push(""); //하루 최저가
            info.push("-"); //하루 최저가
            stockArr.push(info);
        </c:forEach>

        console.log(stockArr);

        stockArr.reverse();

        const dates = stockArr.map(function (item) {
            return item[0];
        });
        const data = stockArr.map(function (item) {
            return [+item[1], +item[2], +item[5], +item[6]];
        });

        var chartDom = document.getElementById('warnStockChart');
        var myChart = echarts.init(chartDom);
        var option;

        option = {
            title: {
                textStyle :{
                    color : '#FFFFFF',
                    fontSize : 22,
                },
                subtextStyle :{
                    color : '#FFFFFF',
                    fontWeight : 'lighter',
                    fontSize : 16
                },
                text: '전날 대비 가장 떨어진 나의 주식 ('+"${warnItmsNm}"+" ("+ ${warnFltRt}+"%) )",
                subtext: referYear+"년 "+referMonth+"월 " + referDay+"일 (기준)",
                left: 'center'
            },
            legend: {
                data: ['日K', 'MA5'],
                inactiveColor: '#FFFFFF',
                top: '13%',
                textStyle : {
                    color : '#FFFFFF'
                }
            },
            tooltip: {
                trigger: 'axis',
                axisPointer: {
                    animation: false,
                    type: 'cross',
                    lineStyle: {
                        color: '#376df4',
                        width: 2,
                        opacity: 1
                    }
                }
            },
            xAxis: {
                type: 'category',
                data: dates,
                axisLine: {lineStyle: {color: '#FFFFFF'}}
            },
            yAxis: {
                scale: true,
                axisLine: {lineStyle: {color: '#FFFFFF'}},
                splitLine: {show: false}
            },
            grid: {
                bottom: 80
            },
            dataZoom: [
                {
                    textStyle: {
                        color: '#8392A5'
                    },
                    handleIcon:
                        'path://M10.7,11.9v-1.3H9.3v1.3c-4.9,0.3-8.8,4.4-8.8,9.4c0,5,3.9,9.1,8.8,9.4v1.3h1.3v-1.3c4.9-0.3,8.8-4.4,8.8-9.4C19.5,16.3,15.6,12.2,10.7,11.9z M13.3,24.4H6.7V23h6.6V24.4z M13.3,19.6H6.7v-1.4h6.6V19.6z',
                    dataBackground: {
                        areaStyle: {
                            color: '#8392A5'
                        },
                        lineStyle: {
                            opacity: 0.8,
                            color: '#8392A5'
                        }
                    },
                    brushSelect: true
                },
                {
                    type: 'inside'
                }
            ],
            series: [
                {
                    type: 'candlestick',
                    name: 'Day',
                    data: data,
                    itemStyle: {
                        color: '#0CF49B',
                        color0: '#FD1050',
                        borderColor: '#0CF49B',
                        borderColor0: '#FD1050'
                    }
                },
                {
                    name: 'MA5',
                    type: 'line',
                    color:'#FFFFFF',
                    data: calculateMA(5, data),
                    smooth: true,
                    showSymbol: false,
                    lineStyle: {
                        width: 2
                    }
                }
            ]
        };

        $(window).unbind("resize."+"warnStockChart").bind("resize."+"warnStockChart", function() { // window.onresize
            if (myChart) myChart.resize();
        });
        myChart.clear();

        option && myChart.setOption(option);
    }
    function draw_favoriteStock_dataTables(){

        var stockArr = [];

        <c:forEach items="${favoriteStockList}" var="item">
        var info = {};
        info.itmsNm="${item.itmsNm}";
        info.mkp="${item.mkp}";  //시작가
        info.clpr="${item.clpr}"; //종가
        info.vs="${item.vs}";  //전일 대비
        info.fltRt="${item.fltRt}"; //전일 대비 등락률
        info.lopr="${item.lopr}"; //하루 최저가
        info.hipr="${item.hipr}"; //하루 최고가
        info.srtnCd="${item.srtnCd}";
        stockArr.push(info);
        </c:forEach>

        var columns = [
            { data: 'itmsNm',		className: 'c-pointer dt-body-center',		defaultContent: '-' }, 	// [0]
            { data: 'mkp',			className: 'c-pointer dt-body-right',	    defaultContent: '-' }, 	// [3]
            { data: 'clpr',			className: 'c-pointer dt-body-right',		defaultContent: '-' }, 	// [1]
            { data: 'vs',			className: 'c-pointer dt-body-right',		defaultContent: '-' }, 	// [2]
            { data: 'fltRt',		className: 'c-pointer dt-body-center',		defaultContent: '-' }, 	// [4]
            { data: 'lopr',			className: 'c-pointer dt-body-right',		defaultContent: '-' }, 	// [5]
            { data: 'hipr',			className: 'c-pointer dt-body-right',		defaultContent: '-' } 	// [6]
        ];

        var columnDefs = [{
            createdCell: function(cell, cellData, rowData, rowIndex, colIndex) {
                if ([0].indexOf(colIndex) > -1) {
                    var str = '<a style="color: #0c0c0c" class="text-decoration-none font-weight-bold"  href ="<c:url value="/main/stocks/detail/"/>'+rowData.srtnCd +'" >' + cellData + '</a>';
                    cell.innerHTML = str;
                }
                if ([1].indexOf(colIndex) > -1) {
                    var str =  numberWithCommas(cellData) + ' ￦';
                    cell.innerHTML = str;
                }
                if ([2].indexOf(colIndex) > -1) {
                    var str =  numberWithCommas(cellData) + ' ￦';
                    cell.innerHTML = str;
                }
                if ([3].indexOf(colIndex) > -1) {
                    var str =  numberWithCommas(cellData) + ' ￦';
                    cell.innerHTML = str;
                }
                if ([4].indexOf(colIndex) > -1) {
                    var str =  cellData + ' %';
                    cell.innerHTML = str;
                }
                if ([5].indexOf(colIndex) > -1) {
                    var str =  numberWithCommas(cellData) + ' ￦';
                    cell.innerHTML = str;
                }
                if ([6].indexOf(colIndex) > -1) {
                    var str =  numberWithCommas(cellData) + ' ￦';
                    cell.innerHTML = str;
                }


            }, targets: columns.map(function(d, i) { return i }) // 모든 컬럼
        }];

        dataTable = $("#favoriteStock_dataTables").DataTable({
            serverSide: false, // processing: true,
            data : stockArr,
            columns: columns,
            columnDefs: columnDefs,
            order: [],
            ordering: true,   // 정렬기능 여부
            searching: false, // 검색기능 여부
            info: false,      // 정보표시 여부
            paging: true,     // 페이징 여부
            pageLength: 5,       // 한 페이지에 표시할 개수
            lengthChange: true, // 한 페이지에 표시할 개수 설정 (10/25/50/100)
            scrollX: true,
            dom: 'rt<"table-footSet"pi><"clear">'

        });

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

