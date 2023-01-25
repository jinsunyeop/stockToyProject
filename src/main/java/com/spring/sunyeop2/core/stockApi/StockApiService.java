package com.spring.sunyeop2.core.stockApi;


import ch.qos.logback.core.joran.util.beans.BeanUtil;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.sunyeop2.core.exception.commonException;
import com.spring.sunyeop2.core.response.Message;
import com.spring.sunyeop2.myPage.info.UserStock;
import lombok.Builder;
import lombok.extern.slf4j.Slf4j;
import okhttp3.HttpUrl;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

@Service
@Slf4j
public class StockApiService {

    //임포트시 스프링 빈 어노테이션을 임포트, lombok 임포트 안하게 주의
    @Value("${sunyeop2.key.stockKey}")
    private String stockKey;

    private final static String serviceUrl = "http://apis.data.go.kr/1160100/service/GetStockSecuritiesInfoService/getStockPriceInfo";


    private StockResponseInfo callStockApi(Map<String, Object> sendParam) {
        try {
//            OkHttpClient client = new OkHttpClient();
//
            OkHttpClient client = new OkHttpClient.Builder()
                    .connectTimeout(100, TimeUnit.SECONDS)
                    .build();
            //Http URL 생성
            HttpUrl.Builder httpBuilder = HttpUrl.get(new URI(serviceUrl)).newBuilder();
            log.info("httpBuilder.toString()====>" + httpBuilder.toString());

            //인증키,resultType(xml or json) 요청 키값
            sendParam.put("serviceKey", stockKey);
            sendParam.put("resultType", "json");

            //요청 파라미터
            sendParam.forEach((k, v) -> {
                httpBuilder.addEncodedQueryParameter(k, (String) v);
                log.info("httpBuilder.parameter====>" + "  키 : " + k + "     값 : " + v);
            });

            //요청 url
            String callApiUrl = httpBuilder.build().toString();
            log.info("callApiUrl=====>" + callApiUrl);

            //요청
            Request req = new Request.Builder().url(callApiUrl).build();
            //응답
            Response resp = client.newCall(req).execute();
            //json 형식의 결과값을 String으로 받는다.
            String jsonData = resp.body().string();

            //json -> 객체
            ObjectMapper objectMapper = new ObjectMapper();
            Map<String, Object> respData = (Map<String, Object>) objectMapper.readValue(jsonData, Map.class).get("response");
            StockResponseInfo items = objectMapper.convertValue(respData.get("body"), StockResponseInfo.class);

            return items;
        } catch (URISyntaxException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    //최신 날짜 1개
    public List<StockResponseItem> myStockInfoList(List<UserStock> myStockList) {
        List<StockResponseItem> myStockInfoList = new ArrayList<>();

        for (int i = 0; i < myStockList.size(); i++) {
            Map<String, Object> param = new HashMap<>();
            param.put("likeSrtnCd",myStockList.get(i).getSrtnCd());
            param.put("numOfRows", "1");
            StockResponseItem item = callStockApi(param).getItems().get("item").get(0);
            myStockInfoList.add(item);
        }

        return myStockInfoList;
    }

    //종목 코드를 변수로 가져와서 그 종목을 자세히 보여준다.
    public List<StockResponseItem> detailStockInfo(String strnCd){
        Map<String, Object> param = new HashMap<>();
        param.put("likeSrtnCd", strnCd);
        param.put("numOfRows", "100000");
        List<StockResponseItem> detailStockInfo = Optional.ofNullable(callStockApi(param).getItems().get("item")).orElse(new ArrayList<>());
        return detailStockInfo;
    }

    //오늘 날짜 기준 7일 내외 키워드를 포함하는 데이터 10개 검색
    public List<StockResponseItem> searchStockList(String keyword){

        Map<String, Object> param = new HashMap<>();
        Calendar week = Calendar.getInstance();
        week.add(Calendar.DATE , -7);
        String beforeWeek = new java.text.SimpleDateFormat("yyyyMMdd").format(week.getTime());
        log.info("일주일 전 날짜 ===========>" + beforeWeek);
        param.put("numOfRows", "10");
        param.put("likeItmsNm",keyword);
        param.put("beginBasDt",beforeWeek);

        List<StockResponseItem> searchStockList = Optional.ofNullable(callStockApi(param).getItems().get("item")).orElse(new ArrayList<>());

        if(!searchStockList.isEmpty()){
            String referDt = searchStockList.get(0).getBasDt();
            searchStockList = searchStockList.stream().filter(k->k.getBasDt().equals(referDt)).collect(Collectors.toList());
            searchStockList.forEach(k -> log.info("searchStockList ==========> "+ k.toString()));
        }
        return searchStockList;
    }

    //페이지 당 10개 페이징 검색
    public StockResponseInfo pagingStockInfo(String pageNum){
        Map<String, Object> param = new HashMap<>();
        param.put("numOfRows", "10");
        param.put("pageNo", pageNum);

        StockResponseInfo pagingStockInfo = callStockApi(param);

        return pagingStockInfo;

    }





}
