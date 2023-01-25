package com.spring.sunyeop2.myPage.mapper;

import com.spring.sunyeop2.myPage.info.UserStock;
import org.apache.ibatis.annotations.Mapper;

import java.util.HashMap;
import java.util.List;

@Mapper
public interface UserStockMapper {
    public List<UserStock> myStockList(long usrId);
    public void saveMystock(UserStock userStock);
    public void changeMystock(UserStock userStock);
    public void  deleteMystock(HashMap<String,Object> param);

    public String stockHoldingRate(String srtnCd);

}
