package com.spring.sunyeop2.myPage.info;


import lombok.*;

import java.security.Timestamp;
import java.util.Date;


//사용자 보유 주식 테이블 VO
@Getter
@Setter
@NoArgsConstructor
@Data
@AllArgsConstructor
public class UserStock {
    private long usrId;  //사용자 고유번호
    private String srtnCd;  //고유 주식 단축코드
    private long usrSrtnCnt;  //사용자 보유주식 수
    private Date regDt;  //사용자 보유주식 입력날짜
 

    
    private String itmsNm;  //종목명
    private long totalStockPrice;  //종목 당 전체 금액

}
