package com.spring.sunyeop2.userBoard.controller;

import com.spring.sunyeop2.core.config.handler.auth.PrincipalDetails;
import com.spring.sunyeop2.core.response.Message;
import com.spring.sunyeop2.userBoard.info.Board;
import com.spring.sunyeop2.userBoard.service.UserBoardService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Controller
@Slf4j
public class UserBoardController {

    @Autowired
    UserBoardService boardService;

    /**
     * @param req
     * @param auth
     * @return 게시판 리스트 페이징 화면
     */
    @RequestMapping(value="/userBoard/list")
    public ModelAndView userBoardList(HttpServletRequest req,Authentication auth){

        ModelAndView mv = new ModelAndView();
        PrincipalDetails lgnUsr = (PrincipalDetails) auth.getPrincipal();
        mv.addObject("user", lgnUsr);
        mv.setViewName("/userBoard/list");
        return mv;
    }

    @RequestMapping(value="/userBoard/list.do")
    @ResponseBody
    public Map<String,Object> boardListPagingInfo(HttpServletRequest req){
        Map<String,Object> param = new HashMap<>();
        String sortName = Optional.ofNullable(req.getParameter("sortName")).orElse("BOARD_NO");  //정렬 기준
        String boardTitle = Optional.ofNullable(req.getParameter("boardTitle").trim()).orElse("");  //검색
        String pageNum = Optional.ofNullable(req.getParameter("pageNum")).orElse("1");  //페이지 번호
        log.info("boardTitle =====>{}",boardTitle);
        param.put("sortName",sortName);
        param.put("BOARD_TITLE",boardTitle);
        param.put("pageNum",pageNum);

        Map<String,Object> boardListPagingInfo = boardService.boardListPaging(param);

        return boardListPagingInfo;
    }


    /**
     * @param req
     * @param auth
     * @return 게시판 작성 화면
     */
    @RequestMapping(value = "/userBoard/write",method = RequestMethod.GET)
    public ModelAndView userBoard(HttpServletRequest req, Authentication auth){
        ModelAndView mv = new ModelAndView();
        PrincipalDetails lgnUsr = (PrincipalDetails) auth.getPrincipal();
        mv.addObject("user", lgnUsr);
        mv.setViewName("/userBoard/write");

        return mv;
    }

    /**
     * @param req
     * @param auth
     * @return 게시판 작성
     */
    @RequestMapping(value = "/userBoard/write",method = RequestMethod.POST)
    public ResponseEntity<Message> writeUserBoard(HttpServletRequest req, Board board, Authentication auth){
        log.info("게시판 작성 게시판 객체 =======> {}",board.toString());

        long boardNo = boardService.writeBoard(board);
        Message msg = new Message();

        if(boardNo > 0){
            msg.setStatus(HttpStatus.OK);
            msg.setData(boardNo);
            msg.setMessage("게시판 작성 완료!");
        }else {
            msg.setStatus(HttpStatus.BAD_REQUEST);
            msg.setMessage("게시판 작성 실패! \n  다시 시도하시기 바랍니다.");
        }
        return new ResponseEntity<>(msg, HttpStatus.OK);
    }

    /**
     * @param req
     * @param auth
     * @return 게시판 작성
     */
    @RequestMapping(value = "/userBoard/update",method = RequestMethod.POST)
    public ResponseEntity<Message> updateUserBoard(HttpServletRequest req, Board board, Authentication auth){
        log.info("게시판 작성 게시판 객체 =======> {}",board.toString());

        Message msg = new Message();

        try{
            boardService.updateBoard(board);
            msg.setStatus(HttpStatus.OK);
            msg.setMessage("게시판 수정 완료!");
        }catch (Exception e){
            e.printStackTrace();
            msg.setStatus(HttpStatus.BAD_REQUEST);
            msg.setMessage("게시판 수정 실패! \n  다시 시도하시기 바랍니다.");
        }
        return new ResponseEntity<>(msg, HttpStatus.OK);
    }

    /**
     * @param req
     * @param auth
     * @param boardNo 게시판 번호
     * @return 게시물 상세 화면
     */
    @RequestMapping(value = "/userBoard/read/{boardNo}")
    public ModelAndView readUserBoard(HttpServletRequest req, Authentication auth, @PathVariable long boardNo){
        ModelAndView mv = new ModelAndView();
        PrincipalDetails lgnUsr = (PrincipalDetails) auth.getPrincipal();
        mv.addObject("user", lgnUsr);
        Board boardDetail = boardService.readBoard(boardNo);
        mv.addObject("board", boardDetail);

        mv.setViewName("/userBoard/read");
        return mv;
    }





}
