package com.spring.sunyeop2.login.service;

import com.spring.sunyeop2.login.info.User;
import com.spring.sunyeop2.login.mapper.LoginMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class LoginService {

    @Autowired
    LoginMapper mapper;

    /*
    *  아이디 중복체크
    *  return boolean ( true 중복 x, false 중복 )
    * */
    public boolean duplicateIdCheck (User user){
        Integer duplicateCnt = Optional.ofNullable(mapper.duplicateIdCheck(user)).orElse(0);
        boolean flag = duplicateCnt == 0 ? true : false;
        return flag;
    };

    /*
    *  회원 가입
    * */
    public void joinUsr(User user){
        mapper.joinUsr(user);
    }




}
