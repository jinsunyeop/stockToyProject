package com.spring.sunyeop2.core.config.handler.oauth;


import com.spring.sunyeop2.core.config.handler.auth.PrincipalDetails;
import com.spring.sunyeop2.login.info.User;
import com.spring.sunyeop2.login.mapper.LoginMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;



//Oauth 로그인 후 후 처리
@Service
@Slf4j
public class PrincipalOauth2UserService extends DefaultOAuth2UserService {
    @Autowired
    LoginMapper loginMapper;

    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException{
        // 구글 로그인 버튼 클릭 -> 구글 로그인 완료 -> code를 리턴(OAuth-Client 라이브러리) -> AccessToken 요청
        // userRequest 정보 -> loadUser 함수 호출 -> 구글로부터 회원 프로필을 받아준다.
        System.out.println("userRequest ClientRegistration Oauth2 ============> {}"+userRequest.getClientRegistration());
        log.info("userRequest ClientRegistration Oauth2 ============> {}",userRequest.getClientRegistration());
        log.info("userRequest AccessToken Oauth2 ============> {}",userRequest.getAccessToken());
        log.info("userRequest Oauth2 ============> {}",super.loadUser(userRequest).getAttributes());

        OAuth2User oAuth2User = super.loadUser(userRequest);

        String provide = "google";  //google
        String providerId = oAuth2User.getAttribute("sub");
        String username = oAuth2User.getAttribute("name");
        String lgnId = provide + "_" + providerId;
        String email = oAuth2User.getAttribute("email");

        User userEntity = loginMapper.findLoginUsr(lgnId);

        if(userEntity == null){
            userEntity = User.builder().provide(provide).providerId(providerId).usrNm(username).lgnId(lgnId).emlAddr(email).lgnPwd("google").build();
            loginMapper.joinUsr(userEntity);
        }

        return new PrincipalDetails(userEntity,oAuth2User.getAttributes());
    }

}
