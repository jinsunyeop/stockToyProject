package com.spring.sunyeop2.userBoard.info;


import lombok.*;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
/*
*  회원 게시판 테이블
* */
public class Board {
    long boardNo;  //게시판 고유번호
    long usrId;  //사용자 고유번호
    String boardTitle;  //게시판 제목
    String boardContent;  //게시판 내용
    long readCnt;  //게시판 조회수
    Date regDt;  //게시판 등록날짜
    
    String usrNm;  //게시판 작성자


}
