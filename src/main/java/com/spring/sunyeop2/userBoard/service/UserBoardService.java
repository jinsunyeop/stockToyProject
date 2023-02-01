package com.spring.sunyeop2.userBoard.service;


import com.spring.sunyeop2.core.util.Paging;
import com.spring.sunyeop2.userBoard.info.Board;
import com.spring.sunyeop2.userBoard.mapper.UserBoardMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletResponse;
import java.io.*;
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

    public void deleteBoard(long boardNo){
        boardMapper.deleteBoard(boardNo);
    }



    /** 이미지 미리보기 로직
     * @param filePath
     * @param response
     * @throws Exception
     */
    public void getImage(String filePath, HttpServletResponse response) throws Exception{

        File file = new File(filePath);
        if(!file.isFile()){
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.write("<script type='text/javascript'>alert('조회된 정보가 없습니다.'); self.close();</script>");
            out.flush();
            return;
        }

        FileInputStream fis = null;
        new FileInputStream(file);

        BufferedInputStream in = null;
        ByteArrayOutputStream bStream = null;
        try {
            fis = new FileInputStream(file);
            in = new BufferedInputStream(fis);
            bStream = new ByteArrayOutputStream();
            int imgByte;
            while ((imgByte = in.read()) != -1) {
                bStream.write(imgByte);
            }

            String type = "";

            String ext = filePath.substring(filePath.lastIndexOf(".") + 1);

            if (ext != null && !"".equals(ext)) {
                if ("jpg".equals(ext.toLowerCase())) {
                    type = "image/jpeg";
                } else {
                    type = "image/" + ext.toLowerCase();
                }

            } else {
                log.debug("Image fileType is null.");
            }

            response.setHeader("Content-Type", type);
            response.setContentLength(bStream.size());

            bStream.writeTo(response.getOutputStream());

            response.getOutputStream().flush();
            response.getOutputStream().close();

        } catch (Exception e) {
            log.debug("{}", e);
        } finally {
            if (bStream != null) {
                try {
                    bStream.close();
                } catch (Exception est) {
                    log.debug("IGNORED: {}", est.getMessage());
                }
            }
            if (in != null) {
                try {
                    in.close();
                } catch (Exception ei) {
                    log.debug("IGNORED: {}", ei.getMessage());
                }
            }
            if (fis != null) {
                try {
                    fis.close();
                } catch (Exception efis) {
                    log.debug("IGNORED: {}", efis.getMessage());
                }
            }
        }
    }
    
    
}
