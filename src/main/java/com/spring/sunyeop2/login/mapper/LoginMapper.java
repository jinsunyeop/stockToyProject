package com.spring.sunyeop2.login.mapper;


import com.spring.sunyeop2.login.info.User;
import org.apache.ibatis.annotations.Mapper;

import java.util.Map;

// Controller -> Service -> Repository -> mapper.xml
// Controller -> Service -> Repository -> Mapper -> mapper.xml
// Controller -> Service -> Mapper -> mapper.xml

@Mapper
public interface LoginMapper {
    public User findLoginUsr(String lgnId);

    public Integer duplicateIdCheck(User user);

    public String duplicateEmailCheck(User user);

    public String findLgnPwd(User user);

    public void joinUsr(User user);
}
