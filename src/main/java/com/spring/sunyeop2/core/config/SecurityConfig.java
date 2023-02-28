package com.spring.sunyeop2.core.config;


import com.spring.sunyeop2.core.config.handler.auth.UserLoginFailureHandler;
import com.spring.sunyeop2.core.config.handler.auth.UserLoginSuccessHandler;
import com.spring.sunyeop2.core.config.handler.oauth.PrincipalOauth2UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

@Configuration //이 어노테이션을 활성화 시 이 클래스가 설정파일이라는 것을 명시한다. (Bean으로 둥록)
@EnableWebSecurity //이 어노테이션을 활성화 시 이 클래스가 기본 스프링 필터체인에 등록이 된다.
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Bean //이 어노테이션을 활성화 시 해당 메서드의 리턴되는 오브젝트를 IoC로 등록해준다.
    public BCryptPasswordEncoder encondePwd(){
        return new BCryptPasswordEncoder();
    }

    @Bean
    public UserLoginSuccessHandler userLoginSuccessHandler(){
        return new UserLoginSuccessHandler();
    }

    @Bean
    public UserLoginFailureHandler userLoginFailureHandler(){
        return new UserLoginFailureHandler();
    }

    @Autowired
    private PrincipalOauth2UserService principalOauth2UserService;

    @Override
    public void configure(WebSecurity web){
        web.ignoring().antMatchers("/assets/**","/common/**");
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception{
        http.csrf().disable();
        http.authorizeRequests()
                .antMatchers("/login/**").permitAll()
                .antMatchers("/freeBoard").authenticated()
                .antMatchers("/main/**").authenticated()
                .antMatchers("/admin/**").access("hasRole('admin')")
                .anyRequest().permitAll()
                //denyAll()을 하려했지만 common 폴더에 있는 header/footer와 같이 공통적 css,script가 막혀서 안함.
                .and()
                .formLogin() // 이와 같이 login 화면의 주소를 명시하면 권한이 없는 유저가 authenticated와 access 같이 접근 권한이 필요한 주소로 접근하면 login 화면으로 이동시킨다.
                .loginPage("/login")
                .loginProcessingUrl("/login/login")
                .usernameParameter("lgnId")  //login.jsp 에 id/password parmeter name 을 설정하는 것
                .passwordParameter("lgnPwd")
                .successHandler(userLoginSuccessHandler())
                .failureHandler(userLoginFailureHandler())
                .and()
                .oauth2Login()
                .loginPage("/login") //구글 로그인이 완료된 뒤 후 처리가 필요함(1.엑세스 토큰 (권한) + 사용자 프로필 정보를 가져옴 2. 그 정보를 토대로 회원가일을 자동으로 진행시키거나, 추가 정보 기입창으로 감
                .userInfoEndpoint()
                .userService(principalOauth2UserService);

                ;
    }
}
