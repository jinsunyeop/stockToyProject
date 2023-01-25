package com.spring.sunyeop2.myPage.mapper;

import com.spring.sunyeop2.myPage.info.UserStock;
import org.apache.ibatis.annotations.Mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Mapper
public interface UserFavoritesMapper {
    public List<UserStock> myFavoriteStockList(long usrId);

    public void deleteMyFavorite(HashMap<String,Object> param);

    public void  registMyFavorite(HashMap<String,Object> param);


}
