package com.spring.sunyeop2.login.mapper;


import com.spring.sunyeop2.login.info.User;
import org.apache.ibatis.annotations.Mapper;

import java.util.HashMap;

// Controller -> Service -> Repository -> mapper.xml
// Controller -> Service -> Repository -> Mapper -> mapper.xml
// Controller -> Service -> Mapper -> mapper.xml

@Mapper
public interface UserMapper {

    public void updateProfileImg(HashMap<String,Object> param);
    public void  updateUsrAs(HashMap<String,Object> param);
}
