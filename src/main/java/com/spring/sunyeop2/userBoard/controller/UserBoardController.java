package com.spring.sunyeop2.userBoard.controller;

import com.spring.sunyeop2.core.config.handler.auth.PrincipalDetails;
import com.spring.sunyeop2.core.response.Message;
import com.spring.sunyeop2.userBoard.info.Board;
import com.spring.sunyeop2.userBoard.service.UserBoardService;
import lombok.extern.slf4j.Slf4j;
import org.apache.tomcat.util.http.fileupload.FileUtils;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.*;

@Controller
@Slf4j
public class UserBoardController {

    @Autowired
    UserBoardService boardService;

    @Value("${sunyeop2.profile.rootPath}")
    String rootPath;

    String middlePath = "/assets/summerNoteDir/";

    String middleCopyPath = "/assets/summerNoteCopyDir/";


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
     * @return 게시판 수정
     */
    @RequestMapping(value = "/userBoard/update",method = RequestMethod.POST)
    public ResponseEntity<Message> updateUserBoard(HttpServletRequest req, @RequestParam(value="file[]")List<String> fileList, Board board, Authentication auth) throws Exception {
        log.info("게시판 수정 게시판 객체 =======> {}",board.toString());

        summerCopy(fileList);
        board.setBoardContent(board.getBoardContent().replaceAll("getImg","getImgCopy"));

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
     * @return 게시판 삭제
     */
    @RequestMapping(value = "/userBoard/delete",method = RequestMethod.POST)
    public ResponseEntity<Message> deleteUserBoard(HttpServletRequest req, Authentication auth){
        String strBoardNo = req.getParameter("boardNo");
        log.info("게시판 삭제 게시판 번호 =======> {}",strBoardNo);
        long boardNo = Long.valueOf(strBoardNo);

        Message msg = new Message();

        try{
            boardService.deleteBoard(boardNo);
            msg.setStatus(HttpStatus.OK);
            msg.setMessage("게시판 삭제 완료!");
        }catch (Exception e){
            e.printStackTrace();
            msg.setStatus(HttpStatus.BAD_REQUEST);
            msg.setMessage("게시판 삭제 실패! \n  다시 시도하시기 바랍니다.");
        }
        return new ResponseEntity<>(msg, HttpStatus.OK);
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
    public ResponseEntity<Message> writeUserBoard(HttpServletRequest req,@RequestParam(value="file[]")List<String> fileList, Board board, Authentication auth) throws Exception {
        log.info("게시판 작성 게시판 객체 =======> {}",board.toString());

        fileList.forEach( k ->{
            log.info("게시판 파일 리스트 =========>{}",k);
        });

        summerCopy(fileList);
        board.setBoardContent(board.getBoardContent().replaceAll("getImg","getImgCopy"));

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

    @RequestMapping(value="/userBoard/image.do", produces = "application/json; charset=utf8")
    @ResponseBody
    public ResponseEntity<Message> uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile, HttpServletRequest request ) throws IOException {
        Message msg = new Message();

        String filePath = rootPath + middlePath;
        String originalFileName = multipartFile.getOriginalFilename();	//오리지날 파일명
        String extension = originalFileName.substring(originalFileName.lastIndexOf(".")); //파일 확장자

        String savedFileName = UUID.randomUUID() + extension;	//저장될 파일 명
        File targetFile = new File(filePath + savedFileName);

        if(!new File(filePath).exists()){
            new File(filePath).mkdirs();
        }
        try {
            // 파일 저장

            multipartFile.transferTo(targetFile);
            // 파일을 열기위하여 userBoard/getImg.do 호출 / 파라미터로 savedFileName 보냄.
            msg.setData("/userBoard/getImg.do?savedFileName="+savedFileName);
            msg.setStatus(HttpStatus.OK);
        } catch (IOException e) {
            targetFile.delete();
            msg.setStatus(HttpStatus.BAD_REQUEST);
            e.printStackTrace();
        }

        return new ResponseEntity<>(msg,HttpStatus.OK);
    }

    @GetMapping("/userBoard/getImg.do")
    @ResponseBody
    public void getImg(@RequestParam(value = "savedFileName")String savedFileName, HttpServletResponse resp) throws Exception{
        String filePath = rootPath + middlePath+savedFileName;
        log.info("filePath =======>{}",filePath);
        boardService.getImage(filePath,resp);
    }

    @RequestMapping(value="/userBoard/getImgCopy.do" , method=RequestMethod.GET)
    public void getImgCopy(@RequestParam(value="savedFileName") String savedFileName, HttpServletResponse resp) throws Exception{
        String copyFilePath = rootPath + middleCopyPath + savedFileName;

        log.info("filePath =======>{}",copyFilePath);
        boardService.getImage(copyFilePath,resp);
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


    /**
     * 이미지 미리보기 폴더에 파일을 삭제하고 copy 디렉토리에 실제 업로드된 사진만을 저장하는 로직 (현재 파일 삭제가 안됌)
     * @param fileList
     * @throws Exception
     */
    public void summerCopy(List<String> fileList) throws Exception {
        File parentFile = new File(rootPath+middlePath);

        for(int i=0;i<fileList.size();i++){
            String oriFilePath = rootPath+middlePath+fileList.get(i);
            log.info("oriFilePath: {}", oriFilePath);

            //복사될 파일경로
            String copyFilePath = rootPath+middleCopyPath+fileList.get(i);
            log.info("copyFilePath: {}", copyFilePath);

            try {
                FileInputStream fis = new FileInputStream(oriFilePath); //읽을파일
                FileOutputStream fos = new FileOutputStream(copyFilePath); //복사할파일
                int data = 0;
                while((data=fis.read())!=-1) {
                    fos.write(data);
                }
                fis.close();
                fos.close();
            } catch (IOException e) {
                e.printStackTrace();
            }

            try {
                File childFile = new File(parentFile,fileList.get(i));
                log.info(childFile.toString() +"====> 파일 삭제 : " + childFile.delete());
            }catch (Exception e){
                e.printStackTrace();
            }


        }
    }

}
