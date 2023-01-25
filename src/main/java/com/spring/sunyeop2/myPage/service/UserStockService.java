package com.spring.sunyeop2.myPage.service;


import com.spring.sunyeop2.myPage.info.UserStock;
import com.spring.sunyeop2.myPage.mapper.UserStockMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Optional;

@Service

public class UserStockService {

    @Autowired
    UserStockMapper userStockMapper;

    /**
     * 사용자의 보유 주식 리스트 조회
     * @param usrId 접속중인 사용자 고유번호
     * @return  사용자의 보유 주식 리스트
     */
    public List<UserStock> myStockList(long usrId){
        List<UserStock> myStockList = Optional.ofNullable(userStockMapper.myStockList(usrId)).orElse(new ArrayList<>());

        return myStockList;
    }

    /**
     * 사용자 보유 주식 저장
     * @param userStock
     */
    public void saveMystock(UserStock userStock){
        userStockMapper.saveMystock(userStock);
    }


    /**
     * 사용자 보유 주식 수정
     * @param userStock
     */
    public void changeMystock(UserStock userStock){
        userStockMapper.changeMystock(userStock);
    }

    /**
     * 사용자 보유 주식 삭제
     * @param param (usrId, srtnCd 사용자아이디, 주식단축코드)
     */
    public void deleteMystock(HashMap<String,Object> param){
        userStockMapper.deleteMystock(param);
    }


    /**
     *  전체 사용자 해당 주식 보유률
     * @param srtnCd
     * @return
     */
    public String stockHoldingRate(String srtnCd){
        return userStockMapper.stockHoldingRate(srtnCd);
    }


}
