package com.spring.sunyeop2.userBoard.service;


import com.spring.sunyeop2.core.util.Paging;
import com.spring.sunyeop2.userBoard.info.Board;
import com.spring.sunyeop2.userBoard.mapper.UserBoardMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;


@Service
@Slf4j
public class UserBoardService {

    @Autowired
    UserBoardMapper boardMapper;

    /**
     * @param param 
     * @return 페이징 게시판 리스트
     */
    @Transactional
    public Map<String,Object> boardListPaging(Map<String,Object> param){
        //페이지 시작 index 계산
        int page = Integer.parseInt((String)param.get("pageNum"));  //페이지 번호
        int totalRecordSize = boardMapper.userBoardtotalRecordSize(param);  //전체 게시물 수
        int recordSize = 5;  //페이지 당 게시물 수
        Paging paging = new Paging(totalRecordSize,page,recordSize,5);
        param.put("startIndex",paging.getStartIndex());
        param.put("recordSize",recordSize);

        List<Board> boardList = boardMapper.userBoardListPaging(param);

        //Map 초기화
        param.clear();
        param.put("boardList",boardList);
        param.put("paging",paging);

        return param;
    }

    /** 게시물 작성
     * @param board 게시판 제목,내용, 작성 아이디
     * @return 0 실패 , 0 이상 성공
     */
    public long writeBoard(Board board){
        try{
            boardMapper.writeBoard(board);
            return board.getBoardNo(); 
        }catch (Exception e){
            e.printStackTrace();
            return 0;
        }
    }

    /** 게시물 수정
     * @param board 
     */
    public void updateBoard(Board board){
        boardMapper.updateBoard(board);
    }



    /**
     * @param boardNo 게시판번호
     * @return 번호에 따른 게시판 객체
     */
    @Transactional
    public Board readBoard(long boardNo){
        boardMapper.updateReadCnt(boardNo);
        Board boardDetail = boardMapper.readBoard(boardNo);
        log.info("board 객체 ===> {}",boardDetail.toString());
        return boardDetail;
    }

    
    
}
