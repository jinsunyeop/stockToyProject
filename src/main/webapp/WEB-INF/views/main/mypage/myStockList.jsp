<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/include.jsp" %>
<html>
<head>
    <%@ include file="/WEB-INF/views/common/head.jsp" %>
    <title>Title</title>
    <style type="text/css">
        table thead th { color: white; text-align: center; }
    </style>
</head>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<div class="d-flex flex-column flex-shrink-0 p-3 text-bg-dark" style="width: 9.15%; height: 1000px; float: left;">
    <img src="<c:url value="${user.filePath}"/>" style="display: block; margin :0 auto ;" alt="" width="100" height="100" class="rounded-circle ">
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
                <li><a style="font-weight: bold; color: white; " href="<c:url value="/main/mypage/myStockList" />" class="active"> myStock </a></li>
                <li><a style="text-decoration: none; color: white; " href="<c:url value="/main/mypage/myInfo" />" >myInfo</a></li>
            </ul>

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

<c:if test="${stockExist ne true}">
<div style="width : 90.85%;height:1000px; float:left; background-color: rgb(62 65 68);">
    <div style="height: 450px;"></div>
    <button type="button" style="display:block; margin : 0 auto;"" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#settingMyStock"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-fill" viewBox="0 0 16 16" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
        <path d="M12.854.146a.5.5 0 0 0-.707 0L10.5 1.793 14.207 5.5l1.647-1.646a.5.5 0 0 0 0-.708l-3-3zm.646 6.061L9.793 2.5 3.293 9H3.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.207l6.5-6.5zm-7.468 7.468A.5.5 0 0 1 6 13.5V13h-.5a.5.5 0 0 1-.5-.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.5-.5V10h-.5a.499.499 0 0 1-.175-.032l-.179.178a.5.5 0 0 0-.11.168l-2 5a.5.5 0 0 0 .65.65l5-2a.5.5 0 0 0 .168-.11l.178-.178z"/>
    </svg>  나의 보유 주식 추가하기 </button>
</div>
</c:if>

<c:if test="${stockExist eq true}">

<div style="width : 90.85%;height:1000px; float:left; background-color: rgb(62 65 68);">
        <div class="myStockStatus" style="width: 50%; height: 100%;  float: left; border-right-style : solid ;">
                <div id = "myStockChart" style="width: 100%; height: 50%; padding:10px;">

                </div>
                <h4 style="text-align: center;color: white;height:8%;padding-top: 30px; font-weight: bold; "> 총 ${myStockCnt}종목 <span id="countMyAsset" ></span> </h4>
                <div style="margin : 10px; height: 45%;">
                    <button type="button" style="display:block; float:right;" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#settingMyStock"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-fill" viewBox="0 0 16 16" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
                        <path d="M12.854.146a.5.5 0 0 0-.707 0L10.5 1.793 14.207 5.5l1.647-1.646a.5.5 0 0 0 0-.708l-3-3zm.646 6.061L9.793 2.5 3.293 9H3.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.207l6.5-6.5zm-7.468 7.468A.5.5 0 0 1 6 13.5V13h-.5a.5.5 0 0 1-.5-.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.5-.5V10h-.5a.499.499 0 0 1-.175-.032l-.179.178a.5.5 0 0 0-.11.168l-2 5a.5.5 0 0 0 .65.65l5-2a.5.5 0 0 0 .168-.11l.178-.178z"/>
                    </svg>  나의 보유 주식 추가하기 </button>
                    <table id="myStockListTable" class="table-S1 cell-border hover" style="width:100%; margin: 0;">
                        <colgroup>
                            <col><!-- No -->
                            <col><!-- 보유 주식명 -->
                            <col ><!-- 보유 주식 수 -->
                            <col><!-- 수정날짜 -->
                            <col ><!-- 수정버튼 -->
                        </colgroup>
                        <thead>
                        <tr>
                            <th>No</th>
                            <th>주식 명</th>
                            <th>주식 수</th>
                            <th>총 가격</th>
                            <th>수정 및 삭제</th>
                        </tr>
                        </thead>
                    </table>
                </div>
        </div>

    <div class="scrapNews" style="width: 50%; height: 100%;  float: left; text-align: center">
        <h3 style="color: #ffffff;font-weight: 600; margin-top: 30px; margin-bottom: 30px;"  class="font-weight-bold">나의 종목 최신 뉴스</h3>
        <div class="container-fluid border border-primary"  style="background-color: white; margin: 0 auto; padding: 10px; width: 90%;">
            <div id="scrapDiv"></div>
            <nav aria-label="Page navigation example">
                <ul class="pagination justify-content-center" id="paging">

                </ul>
            </nav>
<%--            <div class="border border-5" style="color: #e5e5e5;">
                <h5 style="color: #0c0c0c;" >카카오뱅크</h5>
                <hr>
                <a href="#">"카카오뱅크 수신 경쟁력·대출 성장성 회복될 것"</a>
            </div>--%>
        </div>

    </div>


</div>
</c:if>

<!-- 보유 주식 추가 모달창 -->

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
                <button type="button" class="btn btn-secondary" onclick="inputReset()" data-bs-dismiss="modal">Close</button>
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


            for(var i=0; i<stockTableArr.length;i++){
                if(stockTableArr[i].itmsNm == $itmsNm ){
                    alert("이미 추가된 주식명입니다.");
                    return false;
                }
            }

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


<!-- 보유 주식 수정 모달/삭제 모달창 -->
<div class="modal fade" id="resettingMyStock" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title fw-bolder" >나의 보유 주식 수정/삭제</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <input type="hidden" id="mySrtnCd">
                <p class="fw-bolder"style="margin-bottom: 5px;">종목명
                </p>
                <div class="input-group" style="margin-bottom: 10px;">
                    <input type="text" id="myItmsNm" class="form-control" onkeyup="searchKeywordStock(this);"  aria-label="Input group example" aria-describedby="basic-addon1" readonly>
                </div>

                <p class="fw-bolder"style="margin-bottom: 5px;">수량</p>
                <div class="input-group">
                    <input type="number" id="mySrtnCnt" placeholder="수량을 입력하세요. (1주 이상)" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" class="form-control" aria-label="Input group example" aria-describedby="basic-addon1" style="margin-bottom: 25px;"  >
                </div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" onclick="deleteMyStock();" data-bs-dismiss="modal">delete</button>
                <button type="button" class="btn btn-primary" onclick="changeMyStock();">change</button>
            </div>
        </div>
    </div>

    <script>

        function changeMyStock(){
            var $srtnCd =  $("#mySrtnCd").val().trim();
            var $stockCnt = $("#mySrtnCnt").val().trim();

            if(!$stockCnt || $stockCnt == "0"){
                alert("수량은 1주 이상 입력하시기 바랍니다.");
                return false;
            }

            $.ajax({
                url: CONTEXT_PATH + "/main/mypage/changeMyStock",
                method: "POST",
                data: {
                    srtnCd : $srtnCd,
                    usrSrtnCnt : $stockCnt
                },
                async: true,
                processData: true,
                dataType: "json",
                success: function (result) {
                    alert(result.message);
                    location.reload();
                },
                error: function (xhr, status, error) {

                }
            });
            return true;
        }

        function deleteMyStock(){
            var $srtnCd =  $("#mySrtnCd").val().trim();
            if(!confirm($("#myItmsNm").val() + " 을 삭제하시겠습니까?" )){
                return false;
            }

            $.ajax({
                url: CONTEXT_PATH + "/main/mypage/deleteMyStock",
                method: "POST",
                data: {
                    srtnCd : $srtnCd
                },
                async: true,
                processData: true,
                dataType: "json",
                success: function (result) {
                    alert(result.message);
                    location.reload();
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

        $("#headerMyPage").addClass("active");
        $("#sideMyPage").addClass("active");


        draw_myStockChart();
        draw_myStockListTable();
        scrapRecentNews();
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

    function draw_myStockChart(){
        var stockArr = [];  //종목명

        <c:forEach items="${myStockList}" var="item">
            var item = {};
            item.name = "${item.itmsNm}";
            item.value = "${item.totalStockPrice}";
            item.cnt = "${item.usrSrtnCnt}";
            item.srtnCd = "${item.srtnCd}";
            stockArr.push(item);
        </c:forEach>

        var chartDom = document.getElementById('myStockChart');
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
                text: '나의 주식 보유 현황',
                subtext: referYear+"년 "+referMonth+"월 " + referDay+"일 (기준)",
                left: 'center'
            },
            tooltip: {
                trigger: 'item',
                axisPointer: {
                    type: 'shadow' // 'shadow' as default; can also be 'line' or 'shadow'
                },
                formatter: function (params){
                    var txt = '<div style="width: 200px;">'+'<span style="font-weight:bold;">'+params.data.name+ '</span>'+'</div><hr>';
                    txt += '<div>' + '<p style="text-align: right; margin:0px;padding:0px; font-weight:bold;"> <span style="font-weight:bold; float:left;">' ;
                    txt += params["marker"]+'</span>' + " 보유 주식 수 : "+ numberWithCommas(params.data.cnt)+"개" + '</p>' + '</div>';
                    txt += '<div>' + '<p style="text-align: right; margin:0px;padding:0px; font-weight:bold;">';
                    txt +=  "총 금액 : " + numberWithCommas(params.data.value) +"원"+'</p>'+ '</div>';
                    return txt;
                }
            },
            legend: {
                top: '13%',
                width: "60%",
                textStyle : {
                    color : '#FFFFFF'
                }
            },
            series: [
                {
                    name: '나의 주식 보유 현황',
                    type: 'pie',
                    radius: '80%',
                    data : stockArr,
                    top:80,
                    avoidLabelOverlap: false,
                    label: {
                        color : '#FFFFFF',
                        alignTo: 'edge',
                        formatter: '{b} ( {d} % )' ,
                        edgeDistance: 50,
                        rich: {
                            time: {
                                fontSize: 10,
                                color: '#999'
                            }
                        }
                    },
                    labelLine: {
                        length: 15,
                        length2: 100,
                        maxSurfaceAngle: 80
                    },
                    labelLayout: function (params) {
                        var isLeft = params.labelRect.x < myChart.getWidth() / 2;
                        var points = params.labelLinePoints;
                        points[2][0] = isLeft ? params.labelRect.x : params.labelRect.x + params.labelRect.width;
                        return {
                            labelLinePoints: points,
                            height:'25'
                        };
                    }
                }
            ]
        };

        $(window).unbind("resize."+"myStockChart").bind("resize."+"myStockChart", function() { // window.onresize
            if (myChart) myChart.resize();
        });
        myChart.clear();

        option && myChart.setOption(option);

        //차트를 클릭하면 새로운 창으로 그 주식코드로 네이버 증권 검색
        myChart.on('click', function (params) {
            window.open('https://finance.naver.com/item/main.naver?code=' + encodeURIComponent(params.data.srtnCd));
        });
    }


    var stockTableArr = [];
    var i = 0;
    <c:forEach items="${myStockList}" var="item">
    var info = {};
    info.no= ++i;
    info.itmsNm="${item.itmsNm}";
    info.totalStockPrice="${item.totalStockPrice}";
    info.usrSrtnCnt="${item.usrSrtnCnt}";
    info.srtnCd="${item.srtnCd}";
    stockTableArr.push(info);
    </c:forEach>

    function draw_myStockListTable(){
        var columns = [
            { data: 'no',		className: 'c-pointer dt-body-center',		defaultContent: '-' }, 	// [0]
            { data: 'itmsNm',		className: 'c-pointer dt-body-center',		defaultContent: '-' }, 	// [1]
            { data: 'usrSrtnCnt',			className: 'c-pointer dt-body-right',	    defaultContent: '-' }, 	// [2]
            { data: 'totalStockPrice',			className: 'c-pointer dt-body-right',		defaultContent: '-' }, 	// [3]
            { data: 'srtnCd',		className: 'c-pointer dt-body-center',	orderable:false,	defaultContent: '-' } 	// [5]
        ];

        var columnDefs = [{
            createdCell: function(cell, cellData, rowData, rowIndex, colIndex) {
                if ([2].indexOf(colIndex) > -1) {
                    var str =  numberWithCommas(cellData) + ' 주';
                    cell.innerHTML = str;
                }
                if ([3].indexOf(colIndex) > -1) {
                    var str =  numberWithCommas(cellData) + ' ￦';
                    cell.innerHTML = str;
                }

                if([4].indexOf(colIndex) > -1){
                    var str = '<button type="button" class="btn btn-secondary" data-bs-toggle="modal" onclick="resetStockModal(\''+cellData+'\', \''+rowData.itmsNm+'\', \''+rowData.usrSrtnCnt+'\')"  data-bs-target="#resettingMyStock">수정</button>';

                    cell.innerHTML = str;
                }


            }, targets: columns.map(function(d, i) { return i }) // 모든 컬럼
        }];

        dataTable = $("#myStockListTable").DataTable({
            serverSide: false, // processing: true,
            data : stockTableArr,
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
    function resetStockModal(srtnCd,itmsNm,srtnCnt){
        $("#mySrtnCd").val(srtnCd);
        $("#myItmsNm").val(itmsNm);
        $("#mySrtnCnt").val(srtnCnt);
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

    var page = 1;
    function scrapRecentNews(){

        $.ajax({
            url: CONTEXT_PATH + "/main/mypage/myStockNews",
            method: "GET",
            async: true,
            data :{
                page : page
            },
            processData: true,
            dataType: "json",
            success: function (result) {
                console.log(result.paging);
                var scrapNewsList = result.scrapNewsList;
                var paging = result.paging;
                $("#scrapDiv").empty();
                for(var i = 0; i < scrapNewsList.length; i++){
                    $.each(stockTableArr, function(index,item){
                       if (item.srtnCd == scrapNewsList[i].srtnCd){
                           scrapNewsList[i].itmsNm = item.itmsNm;
                       }
                    });

                    var str = '<div class="container-fluid border border-primary" style="background-color: white; margin: 10 auto; padding: 20px; width: 90%;">'+
                        '<div class="border border-5" style="color: #e5e5e5;">';
                    str += ' <h5 style="color: #0c0c0c;" >'+scrapNewsList[i].itmsNm+'</h5><hr style="color: #aab7d1; margin-bottom: 5px;">';
                    if (scrapNewsList[i].flag == "true"){
                        str += '<span style="font-size: 10px;color: #0c0c0c;display: block;margin-bottom: 10px;">('+scrapNewsList[i].provider+"("+scrapNewsList[i].date+")"+')</span>';
                        str += '<a style="display:block; margin-bottom: 10px;" href="https://finance.naver.com/'+scrapNewsList[i].href+'">' + scrapNewsList[i].text + '<a>';
                        str += '</div></div>';
                    }else{
                        str += '<h3>('+scrapNewsList[i].text+')</h3>';
                        str += '</div></div>';
                    }
                    $("#scrapDiv").append(str);
                }

                //페이징 변환
                $("#paging").empty();
                var startPage = paging.startPage;  //페이지 시작번호
                var pageSize = paging.pageSize;  //페이지 사이즈
                var currentPage = paging.page;  //현재 페이지
                var pagingStr = '<li class="page-item" id="back"> <a class="page-link" onclick="movePage('+(startPage-pageSize)+');"><<</a></li>';

                for(var i = startPage; i < (startPage+pageSize); i++){
                    if(currentPage == i && i<=paging.endPage ){
                        pagingStr += '<li class="page-item active"><a class="page-link" onclick="movePage('+i+');">'+i+'</a></li>';
                    }else if(currentPage != i && i<=paging.endPage){
                        pagingStr += '<li class="page-item"><a class="page-link" onclick="movePage('+i+');">'+i+'</a></li>';
                    }
                }
                pagingStr += '<li class="page-item" id="next"><a class="page-link" onclick="movePage('+(startPage+pageSize)+');">>></a></li>';

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
        scrapRecentNews();
    }




</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>

