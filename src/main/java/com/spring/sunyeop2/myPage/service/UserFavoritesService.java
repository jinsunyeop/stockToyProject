package com.spring.sunyeop2.myPage.service;


import com.spring.sunyeop2.myPage.info.UserStock;
import com.spring.sunyeop2.myPage.mapper.UserFavoritesMapper;
import com.spring.sunyeop2.myPage.mapper.UserStockMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service

public class UserFavoritesService {

    @Autowired
    UserFavoritesMapper favoritesMapper;

    /**
     * @param usrId
     * @return 로그인 유저 즐겨찾기 주식 리스트 조회
     */
    public List<UserStock> myFavoriteStockList(long usrId){
        return Optional.ofNullable(favoritesMapper.myFavoriteStockList(usrId)).orElse(new ArrayList<>());
    }

    public void deleteMyFavorite(HashMap<String,Object> param){
        favoritesMapper.deleteMyFavorite(param);
    }

    public void registMyFavorite(HashMap<String,Object> param){
        favoritesMapper.registMyFavorite(param);
    }


}
