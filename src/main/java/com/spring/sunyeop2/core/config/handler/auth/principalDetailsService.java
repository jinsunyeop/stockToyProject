package com.spring.sunyeop2.core.config.handler.auth;

import com.spring.sunyeop2.login.info.User;
import com.spring.sunyeop2.login.mapper.LoginMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

// Security Config에서 loginProcessingUrl에 설정한 곳에 요청이 오면 자동으로 UserDetailsService 타입으로 IoC되어 있는 loadUserByUsername 메소드가 실행된다.
@Service
@Slf4j
public class principalDetailsService implements UserDetailsService {

    @Autowired
    private LoginMapper loginMapper;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = loginMapper.findLoginUsr(username);

        if(user != null){
            UserDetails userDetails = new PrincipalDetails(user);
            return userDetails;
        }

        return null;
    }
}
