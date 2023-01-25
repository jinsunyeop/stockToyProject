package com.spring.sunyeop2.core.stockApi;

import lombok.Getter;
import lombok.ToString;

import java.util.List;
import java.util.Map;


//공공데이터 주식 API 응답메시지 클래스
@Getter
@ToString
public class StockResponseInfo {
    private Integer pageNo;
    private long numOfRows;
    private long totalCount;
    private Map<String,List<StockResponseItem>> items;

}
