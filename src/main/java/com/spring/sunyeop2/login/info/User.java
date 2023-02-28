package com.spring.sunyeop2.login.info;


import lombok.*;

import java.security.Timestamp;
import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
@Builder
public class User {
    private long usrId;  //사용자 번호
    private String lgnId;  //로그인 아이디
    private String newPwd;  //비밀번호 찾기 시 지정할 새로운 비밀번호
    private String lgnPwd;  //로그인 비밀번호
    private String usrNm;  //사용자 성명
    private String usrAs;  //사용자 별칭
    private String emlAddr;  //사용자 이메일
    private Integer lgnFailCnt;  //로그인 틀린 횟수
    private Date joinDt;  //회원가입일
    private String roleCd;  //역할 구분 코드 ( '01' 사용자 , '00' 운영자)
    private String provide;  //제공자
    private String providerId;  //제공자ID
    //사용자 프로필 이미지
    private String filePath;
    private String fileNm;
    private Date regDt;

}
