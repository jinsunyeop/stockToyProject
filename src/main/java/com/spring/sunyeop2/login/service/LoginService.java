package com.spring.sunyeop2.login.service;

import com.spring.sunyeop2.core.response.Message;
import com.spring.sunyeop2.login.info.User;
import com.spring.sunyeop2.login.mapper.LoginMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@Slf4j
public class LoginService {

    @Autowired
    LoginMapper mapper;

    /*
    *  아이디,이메일 중복체크
    *  return code (0 정상, 1 아이디 중복, 2 이메일 중복)
    * */
    public Integer duplicateCheck (User user){
        Integer duplicateIdCnt = Optional.ofNullable(mapper.duplicateIdCheck(user)).orElse(0);
        String duplicateEml = Optional.ofNullable(mapper.duplicateEmailCheck(user)).orElse("");
        Integer code;
        code = duplicateIdCnt > 0 ? 1 : 0;
        code = !duplicateEml.isEmpty() ? 2 : code;

        return code;
    };

    /**
     * @param user
     * @return lgnId or Null
     */
    public String findId(User user){
        return Optional.ofNullable( mapper.duplicateEmailCheck(user) ).orElse("");
    }

    /**
     * @param user
     * @return lgnPwd or Null
     */
    public String findPwd(User user){
        return Optional.ofNullable( mapper.findLgnPwd(user)).orElse("");
    }


    /*
    *  회원 가입
    * */
    public void joinUsr(User user){
        mapper.joinUsr(user);
    }




}
