package com.spring.sunyeop2.loginTest;


import com.spring.sunyeop2.login.info.User;
import com.spring.sunyeop2.login.mapper.LoginMapper;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.HashMap;
import java.util.Map;

@SpringBootTest
@Slf4j
public class loginTest {

    @Autowired
    LoginMapper mapper;

    @Test
    public void findLoginUsr(){
        User lgnInfo = mapper.findLoginUsr("test");

        log.info("logInfo===>"+lgnInfo.toString());

      //  System.out.println("lgnInfo Id " + lgnInfo.get("LGN_ID"));



    }





}
