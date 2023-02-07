package com.spring.sunyeop2.core.config.handler.oauth;

import lombok.extern.slf4j.Slf4j;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;



//Oauth 로그인 후 후 처리
@Service
@Slf4j
public class PrincipalOauth2UserService extends DefaultOAuth2UserService {

    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException{
        log.info("userRequest ClientRegistration Oauth2 ============> {}",userRequest.getClientRegistration());
        log.info("userRequest AccessToken Oauth2 ============> {}",userRequest.getAccessToken());
        log.info("userRequest Oauth2 ============> {}",super.loadUser(userRequest).getAttributes());
        return super.loadUser(userRequest);
    }

}
