package com.spring.sunyeop2.boardTest;


import com.spring.sunyeop2.core.util.Paging;
import com.spring.sunyeop2.userBoard.info.Board;
import com.spring.sunyeop2.userBoard.mapper.UserBoardMapper;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@SpringBootTest
@Slf4j
public class BoardTest {

    @Autowired
    UserBoardMapper boardMapper;

    @Test
    @Transactional
    public void useGeneratedKey_Test(){
        Board board = new Board();
        board.setBoardContent("테스트");
        board.setBoardTitle("제목");
        board.setUsrId(3);
        boardMapper.writeBoard(board);
        log.info("board Id ===> {}",board.getBoardNo());
    }


    @Test
    @Transactional
    public void readBoard_Test(){
        long boardNo = 2;
        boardMapper.updateReadCnt(boardNo);
        Board boardDetail = boardMapper.readBoard(2);
        log.info("board 객체 ===> {}",boardDetail.toString());
    }

    @Test
    @Transactional
    public void 게시판페이징리스트(){
        Map<String,Object> param = new HashMap<>();
        int recordSize = 5;
        Paging page = new Paging(recordSize,1,recordSize,5);
        param.put("sortName","readCnt");
        param.put("startIndex",page.getStartIndex());
        param.put("recordSize",recordSize);
        param.put("BOARD_TITLE","");
        List<Board> boardList= boardMapper.userBoardListPaging(param);

        for (Board board : boardList) {
            log.info("boardList ====>{}",board.getBoardNo() + "번쨰 : " + board.toString());
        }

    }
}
