package com.spring.sunyeop2.login.service;

import com.spring.sunyeop2.core.response.Message;
import com.spring.sunyeop2.login.info.User;
import com.spring.sunyeop2.login.mapper.LoginMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Optional;
import java.util.Random;

@Service
@Slf4j
public class LoginService {

    @Autowired
    LoginMapper mapper;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;
    @Autowired
    private JavaMailSender mailSender;

    private String newPwd(){
        int leftLimit = 48; // numeral '0'
        int rightLimit = 122; // letter 'z'
        int targetStringLength = 10;
        Random random = new Random();

        String newPwd = random.ints(leftLimit,rightLimit + 1)
                .filter(i -> (i <= 57 || i >= 65) && (i <= 90 || i >= 97))
                .limit(targetStringLength)
                .collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append)
                .toString();
        return newPwd;
    }

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
        Integer existFlag = mapper.findUserWithIdAndAddr(user);
        String msg;
        if(existFlag > 0){
            String newPwd = newPwd();
            user.setNewPwd(passwordEncoder.encode(newPwd));
            mapper.changePwd(user);
            SimpleMailMessage mailMsg = new SimpleMailMessage();
            mailMsg.setTo(user.getEmlAddr());
            mailMsg.setSubject("StockProject 비밀번호 확인");
            mailMsg.setText("당신의 비밀번호는 '" + newPwd +"' 입니다.");
            mailSender.send(mailMsg);
            msg = "귀하의 이메일 주소로 비밀번호를 전송하였습니다.";
        }else{
            msg = "존재하지 않는 아이디와 이메일입니다.";
        }
        return msg;
    }


    /*
    *  회원 가입
    * */
    public void joinUsr(User user){
        mapper.joinUsr(user);
    }




}
