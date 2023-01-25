package com.spring.sunyeop2.core.stockApi;


import lombok.*;

import java.security.Timestamp;
import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class StockResponseItem {
    private String basDt;  //기준일자
    private String srtnCd;  //주식 단축코드
    private String isinCd;  //증권의 국제인증 고유번호
    private String itmsNm;  //종목명
    private String mrktCtg; //시장구분
    private long clpr; //최종가격 (종가)
    private String vs;  //전일 대비 등락
    private String fltRt;  //전일 대비 등락에 따른 비율
    private String mkp;  //하루 최초가격 시가
    private String hipr;  //하루 최고가
    private String lopr;  //하루 최저가
    private String trqu;  //거래량
    private String trPrc;  //거래대금
    private long lstgStCnt;  //상장주식수
    private long mrktTotAmt;  //시가총액

    private boolean usrFavorite;




}
