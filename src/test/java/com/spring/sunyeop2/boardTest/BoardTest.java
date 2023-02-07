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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@SpringBootTest
@Slf4j
public class BoardTest {

    @Autowired
    UserBoardMapper boardMapper;


    @Value("${sunyeop2.profile.rootPath}")
    String rootPath;

    String middleCopyPath = "/assets/summerNoteCopyDir/";


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

    @Test
    @Transactional
    public void 게시판파일_문자열찾기(){
        Board board = boardMapper.readBoard(15);
        String boardContent = board.getBoardContent();
        List<String> fileNameList = new ArrayList<>();
        String separatorStr = "savedFileName=";
        while (boardContent.indexOf(separatorStr) > -1){
            int startIdx = boardContent.indexOf(separatorStr) + separatorStr.length();
            int endIdx = boardContent.indexOf("style") -2 ;

            fileNameList.add(boardContent.substring(startIdx,endIdx));
            log.info("fileName ===========>{}",boardContent.substring(startIdx,endIdx));

            boardContent = boardContent.substring(endIdx+7);
            log.info("split boardContent =======> {}",boardContent);
        }

        for(String fileName : fileNameList){
            File parentFile = new File(rootPath + middleCopyPath);
            File childFile = new File(parentFile,fileName);
            log.info(" 파일 경로 :  " +childFile.toString());
            log.info(" 파일 존재 여부 :  " + childFile.exists());
            log.info("파일 삭제 =======> {}", childFile.delete());
        }




    }



}
