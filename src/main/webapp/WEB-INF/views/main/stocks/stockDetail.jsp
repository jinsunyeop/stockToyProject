<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/include.jsp" %>
<html>
<head>
    <%@ include file="/WEB-INF/views/common/head.jsp" %>
    <title>Title</title>
    <style type="text/css">
        table thead th { color: white; text-align: center; }

        .chat{
            margin-left: 22.5px;
            margin-top: auto;
            margin-bottom: auto;
        }
        .card{
            margin: 0 auto;
            width: 780px;
            height: 700px;
            border-radius: 15px !important;
            background-color: rgba(0,0,0,0.4) !important;
        }
        .contacts_body{
            padding:  0.75rem 0 !important;
            overflow-y: auto;
            white-space: nowrap;
        }
        .msg_card_body{
            overflow-y: auto;
        }
        .card-header{
            border-radius: 15px 15px 0 0 !important;
            border-bottom: 0 !important;
        }
        .card-footer{
            border-radius: 0 0 15px 15px !important;
            border-top: 0 !important;
        }
        .type_msg{
            background-color: rgba(0,0,0,0.3) !important;
            border:0 !important;
            color:white !important;
            height: 60px !important;
            overflow-y: auto;
        }
        .type_msg:focus{
            box-shadow:none !important;
            outline:0px !important;
        }
        .attach_btn{
            border-radius: 15px 0 0 15px !important;
            background-color: rgba(0,0,0,0.3) !important;
            border:0 !important;
            color: white !important;
            cursor: pointer;
        }
        .send_btn{
            border-radius: 0 15px 15px 0 !important;
            background-color: rgba(0,0,0,0.3) !important;
            border:0 !important;
            color: white !important;
            cursor: pointer;
        }
        .contacts li{
            width: 100% !important;
            padding: 5px 10px;
            margin-bottom: 15px !important;
        }
        .active{
            background-color: rgba(0,0,0,0.3);
        }
        .user_img{
            height: 70px;
            width: 70px;
            border:1.5px solid #f5f6fa;

        }
        .user_img_msg{
            height: 40px;
            width: 40px;
            border:1.5px solid #f5f6fa;

        }
        .img_cont{
            position: relative;
            height: 70px;
            width: 70px;
        }
        .img_cont_msg{
            height: 40px;
            width: 40px;
        }
        .online_icon{
            position: absolute;
            height: 15px;
            width:15px;
            background-color: #4cd137;
            border-radius: 50%;
            bottom: 0.2em;
            right: 0.4em;
            border:1.5px solid white;
        }
        .user_info{
            margin-top: auto;
            margin-bottom: auto;
            margin-left: 15px;
        }
        .user_info span{
            font-size: 20px;
            color: white;
        }
        .user_info p{
            font-size: 10px;
            color: rgba(255,255,255,0.6);
        }
        .video_cam{
            margin-left: 50px;
            margin-top: 5px;
        }
        .video_cam span{
            color: white;
            font-size: 20px;
            cursor: pointer;
            margin-right: 20px;
        }
        .msg_cotainer{
            margin-top: auto;
            margin-bottom: auto;
            margin-left: 10px;
            border-radius: 25px;
            background-color: #82ccdd;
            padding: 10px;
            position: relative;
        }
        .msg_cotainer_send{
            margin-top: auto;
            margin-bottom: auto;
            margin-right: 10px;
            border-radius: 25px;
            background-color: #78e08f;
            padding: 10px;
            position: relative;
        }
        .msg_time{
            position: absolute;
            left: 0;
            bottom: -15px;
            color: rgba(255,255,255,0.5);
            font-size: 10px;
        }
        .msg_time_send{
            position: absolute;
            right:0;
            bottom: -15px;
            color: rgba(255,255,255,0.5);
            font-size: 10px;
        }
        .msg_head{
            position: relative;
        }
        #recordSize_btn{
            position: absolute;
            right: 10px;
            top: 10px;
            color: white;
            cursor: pointer;
            font-size: 20px;
        }
        .action_menu{
            z-index: 1;
            position: absolute;
            padding: 15px 0;
            background-color: rgba(0,0,0,0.5);
            color: white;
            border-radius: 15px;
            top: 30px;
            right: 15px;
            display: none;
        }
        .action_menu ul{
            list-style: none;
            padding: 0;
            margin: 0;
        }
        .action_menu ul li{
            width: 100%;
            padding: 10px 15px;
            margin-bottom: 5px;
        }
        .action_menu ul li i{
            padding-right: 10px;

        }
        .action_menu ul li:hover{
            cursor: pointer;
            background-color: rgba(0,0,0,0.2);
        }
        @media(max-width: 576px){
            .contacts_card{
                margin-bottom: 15px !important;
            }
        }
    </style>
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

<div style="width : 90.85%;height:1000px; float:left; background-color: rgb(62 65 68);">
        <div class="myStockStatus" style="width: 65%; height: 100%;  float: left; border-right-style : solid ;">
                <div id = "detailStockChart" style="width: 100%; height: 70%; background: #515151;" >
                </div>
            <br>
            <c:set var="today" value ="${recentDetailStock.basDt}"/>
            <h3 class="fw-bold" style="text-align: center; color: white">${fn:substring(today,0,4)}년 ${fn:substring(today,4,6)}월 ${fn:substring(today,6,8)}일 기준</h3>
            <br>
                <table class="table table-striped" style="text-align: center;">
                    <tr class="table-primary">
                        <th>종목명</th>
                        <th>시장구분</th>
                        <th>종가</th>
                        <th>전일 대비 등락</th>
                        <th>전일 대비 등락률</th>
                        <th>시작가</th>
                        <th>최고가</th>
                        <th>최저가</th>
                        <th>거래량</th>
                        <th>상장주식수</th>
                        <th>시가총액</th>
                    </tr>
                    <tr class="table-light">
                        <td>${recentDetailStock.itmsNm}</td>
                        <td>${recentDetailStock.mrktCtg}</td>
                        <td> <fmt:formatNumber value="${recentDetailStock.clpr}" pattern="#,###"/>  원</td>
                        <td> <fmt:formatNumber value="${recentDetailStock.vs}" pattern="#,###"/>  원</td>
                        <td>${recentDetailStock.fltRt} %</td>
                        <td> <fmt:formatNumber value="${recentDetailStock.mkp}" pattern="#,###"/>  원</td>
                        <td> <fmt:formatNumber value="${recentDetailStock.hipr}" pattern="#,###"/>  원</td>
                        <td> <fmt:formatNumber value="${recentDetailStock.lopr}" pattern="#,###"/>  원</td>
                        <td> <fmt:formatNumber value="${recentDetailStock.trqu}" pattern="#,###"/>  주</td>
                        <td> <fmt:formatNumber value="${recentDetailStock.lstgStCnt}" pattern="#,###"/>  주</td>
                        <td><fmt:formatNumber value="${recentDetailStock.mrktTotAmt}" pattern="#,###"/> 원</td>
                    </tr>
                </table>
        </div>

    <div class="rate" style="width: 35%; height: 100%;  float: left; text-align: center">
        <h4 style="color: #ffffff;font-weight: 600; margin-top: 30px; "  class="font-weight-bold">MY STOCK 전체 사용자 주식 보유 비율</h4>
        <div id="rateChart"  style="width: 100%; height: 20%; margin-left: 35px;">
        </div>
        <div class="col-md-8 col-xl-6 chat">
            <div class="card" id="chatCard">
                <div class="card-header msg_head">
                    <div class="d-flex bd-highlight">
                        <div class="img_cont">
                            <img src="<c:url value="${user.filePath}"/>" onerror='this.src="<c:url value="/assets/img/errorProfile.png"/>";' class="rounded-circle user_img">
                            <span class="online_icon"></span>
                        </div>
                        <div class="user_info">
                            <span>${user.usrAs} 님</span>
                            <button onclick="closed();" id="close" style="display:none;">퇴장</button>
                        </div>
                    </div>

                </div>
                <div class="card-body msg_card_body" id="enterChat">
                        <button class="btn-secondary" onclick="connectionChatBtn();" style="margin-top: 250px;">입장하기</button>
                </div>
            </div>
        </div>

    </div>


</div>

<script>
    $(document).ready(function(){

        $("#headerStocks").addClass("active");
        $("#sideStocks").addClass("active");
        draw_rateChart();
        draw_detailStockChart();
    });

    var socket = null;
    var sendUsrAs = "${user.usrAs}";
    var usrId = "${user.usrId}";



   //웹소켓 연결
   function connect(){
        var ws = new WebSocket("ws://localhost:8088/replyEcho?srtnCd="+"${srtnCd}");
        socket = ws;

        ws.onopen = function (){
            console.log("웹소켓 연결");
            socket.send( sendUsrAs +"님이 입장하였습니다.");
        };

        ws.onmessage = function(event){
            var msg = event.data;
            var infoMsgSeparator ="==&infos&==";
            var commonMsgSeparator = "&:&";
            if(msg.indexOf(infoMsgSeparator) > -1){
                var info = msg.split(infoMsgSeparator);
                $("#chatBox").append('<span style="display: block; color: white;">'+ info[1] +'</span>');
            }else{
                var msgArr = msg.split(commonMsgSeparator);0
                console.log(msgArr);
                var sendUsrId = msgArr[0];
                var sendUsrAs = msgArr[1];
                var sendUsrImgPath = msgArr[2];
                var sendMsg = msgArr[3];
                console.log(sendUsrImgPath);
                if(sendUsrId != usrId){
                    $("#chatBox").append('<span style="color: white; display: block; float: left;">' + sendUsrAs + '</span><br>'
                        +'<div class="d-flex justify-content-start mb-4">'
                        + '<div class="img_cont_msg">'
                        + '<img src="' +sendUsrImgPath+ '" class="rounded-circle user_img_msg">'
                        +'</div>'
                        + '<div class="msg_cotainer">'
                        + sendMsg
                        + '</div></div>');
                }else{
                    $("#chatBox").append('<div class="d-flex justify-content-end mb-4">'
                        + '<div class="msg_cotainer_send">'
                        + sendMsg
                        + '</div>'
                        + '<div class="img_cont_msg">'
                        + '<img src="' +sendUsrImgPath+ '" class="rounded-circle user_img_msg">'
                        +'</div></div>');
                }
            }
        }

       ws.onclose  = function(event){
            console.log("웹소켓 연결 해제");
       };
        ws.onerror = function(event){console.log("Info: Connection error");
            setTimeout(function(){connect();} , 2000);
        };
    }

    function connectionChatBtn(){

        $("#enterChat").css("display","none");  //입장하기 버튼 숨기기
        $("#close").css("display","flex");  //입장하기 버튼 숨기기

        //보내기 박스
        $("#chatCard").append( '<div style="height: 530px; padding:10px;" id ="chatBox"></div>'
            +'<div class="card-footer" id="inputBox">'
            + '<div class="input-group">'
            + '<textarea name="" id ="inputMsg" maxlength="200" class="form-control type_msg" placeholder="Type your message..."></textarea>'
            + '<div class="input-group-append">'
            +'<button class="input-group-text send_btn" style="height: 60px;" id="send">' +"보내기" +'</button>'
            + '</div> </div> </div>');

        $("#send").on('click',function(evt){
            evt.preventDefault();
            if(socket.readyState !== 1) return;
            let msg = $("#inputMsg").val();
            socket.send(msg+"==&==");
            $("#inputMsg").val("");
        });

        connect();
    }

    function closed(){
       socket.send( sendUsrAs +"님이 퇴장하였습니다.");
       socket.close();
       socket = null;
       $("#enterChat").css("display","block");  //입장하기 버튼 숨기기
       $("#close").css("display","none");
       $("#chatBox").remove();
       $("#inputBox").remove();
       $("#enterChat").html('<button class="btn-secondary" onclick="connectionChatBtn();" style="margin-top: 250px;">입장하기</button>');
       }




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

    function draw_rateChart(){
        var rate = ${stockHoldingRate};
        var holdRate = Math.round(rate * 100) / 100;
        var unholdRate = { value : 100-holdRate , itemStyle:{color:'#a90000'}};
        var rateArr = [holdRate, unholdRate];


        var chartDom = document.getElementById('rateChart');
        var myChart = echarts.init(chartDom);
        var option;

        option = {
            xAxis: {
                min: 0,
                max: 100,
                type: 'value',
            },
            yAxis: {
                type: 'category',
                data: ['보유','보유하지 않음']
            },
            series: [
                {
                    data: rateArr,
                    type: 'bar',
                    showBackground: true,
                    backgroundStyle: {
                        color: 'rgba(180, 180, 180, 0.2)'
                    }
                }
            ]
        };
        $(window).unbind("resize."+"rateChart").bind("resize."+"rateChart", function() { // window.onresize
            if (myChart) myChart.resize();
        });
        myChart.clear();

        option && myChart.setOption(option);

    }

    function draw_detailStockChart(){
        var stockArr = [];  //종목명
        <c:forEach items="${detailStock}" var="item">
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

        var referenceDt = stockArr[0][0];
        var referYear = referenceDt.substring(0,4);
        var referMonth = referenceDt.substring(5,7);
        var referDay = referenceDt.substring(8);



        stockArr.reverse();

        const dates = stockArr.map(function (item) {
            return item[0];
        });
        const data = stockArr.map(function (item) {
            return [+item[1], +item[2], +item[5], +item[6]];
        });

        var chartDom = document.getElementById('detailStockChart');
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
                top : '2%',
                text: "${title}",
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

        $(window).unbind("resize."+"detailStockChart").bind("resize."+"detailStockChart", function() { // window.onresize
            if (myChart) myChart.resize();
        });
        myChart.clear();

        option && myChart.setOption(option);
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








</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>

