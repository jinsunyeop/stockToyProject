package com.spring.sunyeop2.login.controller;


import com.spring.sunyeop2.core.response.Message;
import com.spring.sunyeop2.login.info.User;
import com.spring.sunyeop2.login.service.LoginService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.lang.Nullable;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

//ResponseEntity
//    1. Spring에서 제공하는 클래스 중 HttpEntity라는 클래스가 존재하는데 이것은 HttpHeader와 HttpBody를 포함하는 클래스이다. 이를 상속받아 구현한 클래스이다.
//    2. 사용자의 HttpRequest에 대한 응답 데이터를 포함하는 클래스로서 HttpStatus,HttpHeaders,HttpBody를 포함한다.
//    3. 생성자
//    public ResponseEntity(@Nullable T body, HttpStatus status) {
//        this(body, null, status);  body는 @Nullable
//    }

@Controller
@Slf4j
public class LoginController {

    @Autowired
    private LoginService loginService;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    @RequestMapping("/login")
    public String login(HttpServletRequest req){

        return "/login/login";
    }

    /*
    * 회원가입 창 화면
    * */
    @GetMapping("/join")
    public String userJoinPage(HttpServletRequest req){
        return "/login/userJoin";
    }

    /*
    * 회원가입 로직
    * message code ==> ( 0 : 중복 , 1 : 에러 )
    * */
    @PostMapping("/join")
    @ResponseBody
    public ResponseEntity<Message> join(HttpServletRequest req, User user){
        log.info("회원가입 정보 ==> {}" , user.toString());
        Message message = new Message();

        /* 아이디 중복체크 */
        if(!loginService.duplicateIdCheck(user)){
            message.setStatus(HttpStatus.valueOf(400));
            message.setCode(0);
            message.setMessage("이미 가입된 아이디입니다.");
            return new ResponseEntity<>(message,HttpStatus.OK);
        }

        /* Security를 위한 패스워드 암호화 */
        user.setRoleCd("01");
        String rawPwd = user.getLgnPwd(); //암호화가 되지 않은 패스워드
        String encPwd = passwordEncoder.encode(rawPwd);
        user.setLgnPwd(encPwd);

        /* 회원가입 완료 */
        try{
            loginService.joinUsr(user);
            message.setStatus(HttpStatus.valueOf(200));
            message.setMessage("회원가입이 완료되었습니다.");
            return new ResponseEntity<>(message,HttpStatus.OK);
        }catch (Exception e){
            message.setStatus(HttpStatus.valueOf(400));
            message.setCode(1);
            message.setMessage("예상치 못한 오류로 회원가입에 실패하였습니다. 다시 시도하시기 바랍니다.");
            log.debug("회원가입 실패 ===>{}",e.getMessage());
            return new ResponseEntity<>(message,HttpStatus.OK);
        }
    }



}
