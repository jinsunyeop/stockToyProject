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
    private long usrId;
    private String srtnCd;
    private long usrSrtnCnt;
    private Date regDt;



    private String itmsNm;
    private long totalStockPrice;

}
