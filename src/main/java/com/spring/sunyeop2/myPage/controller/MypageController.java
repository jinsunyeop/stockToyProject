package com.spring.sunyeop2.myPage.controller;


import com.spring.sunyeop2.core.config.auth.PrincipalDetails;
import com.spring.sunyeop2.core.jsoup.NaverRank;
import com.spring.sunyeop2.core.response.Message;
import com.spring.sunyeop2.core.stockApi.StockApiService;
import com.spring.sunyeop2.core.stockApi.StockResponseItem;
import com.spring.sunyeop2.core.util.Paging;
import com.spring.sunyeop2.login.service.UserService;
import com.spring.sunyeop2.myPage.info.UserStock;
import com.spring.sunyeop2.myPage.service.UserFavoritesService;
import com.spring.sunyeop2.myPage.service.UserStockService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.net.URISyntaxException;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Controller
public class MypageController {

    @Autowired
    StockApiService stockApiService;

    @Autowired
    UserStockService userStockService;

    @Autowired
    UserFavoritesService favoritesService;

    @Autowired
    UserService userService;

    @Autowired
    NaverRank scrapService;

    // 등락률이 -.xx 이런식으로 도출이 되어 정수형으로 캐스팅이 되지 않음을 해결한 메서드
    private Double fltRtConverter(String fltRt) {
        log.info("converter 사용 ======> "+ fltRt);
        int dotIdx = fltRt.indexOf(".");
        if(dotIdx > 0){
            char flag = fltRt.charAt(dotIdx - 1);
            if (String.valueOf(flag).equals("-") || String.valueOf(flag).equals("+")) {
                fltRt = flag + "0" + fltRt.substring(dotIdx);
            }
        } else if (dotIdx == 0) {
            fltRt = "0" + fltRt;
        }

        Double convert = Double.valueOf(fltRt);
        return convert;
    }

    /**
     * @param req
     * @param auth
     * @return  myPage -> myStock 화면
     */
    @RequestMapping("/main/mypage/myStockList")
    public String myStock(HttpServletRequest req, Authentication auth){
        //접속자 UsrId
        PrincipalDetails lgnUsr = (PrincipalDetails) auth.getPrincipal();
        long lgnId = lgnUsr.getUsrId();

        //로그인 유저가 보유한 주식 리스트
        List<UserStock> myStockList = userStockService.myStockList(lgnId);
        if (!myStockList.isEmpty()) {
            req.setAttribute("stockExist", true);

            //보유 주식 현재 정보 리스트
            List<StockResponseItem> stockInfoList = stockApiService.myStockInfoList(myStockList);
            req.setAttribute("referenceDt", stockInfoList.get(0).getBasDt());

            //나의 보유 자산 변수
            long myAsset = 0;

            //보유 주식 종목별 총 가격
            for (UserStock i : myStockList) {
                log.info(myStockList.toString());
                for (StockResponseItem item : stockInfoList) {
                    item.setFltRt(String.valueOf(fltRtConverter(item.getFltRt())));
                    if (i.getSrtnCd().equals(item.getSrtnCd())) {
                        i.setItmsNm(item.getItmsNm());
                        i.setTotalStockPrice(i.getUsrSrtnCnt() * item.getClpr());
                        myAsset += (i.getUsrSrtnCnt() * item.getClpr());
                        log.info("보유 주식 ========> " + i.getItmsNm());
                        log.info("총 가격 ========> " + i.getUsrSrtnCnt() * item.getClpr());
                    }
                }
            }
            req.setAttribute("myStockCnt", myStockList.size());
            req.setAttribute("myStockList", myStockList);
            req.setAttribute("myAsset", myAsset);

        }
        req.setAttribute("user", lgnUsr);
        return "/main/mypage/myStockList";
    }

    @GetMapping("/main/mypage/myStockNews")
    @ResponseBody
    public HashMap<String,Object> myStockNews(HttpServletRequest req,Authentication auth){

        int page = Integer.parseInt(req.getParameter("page"));
        int recordSize = 4;
        //접속자 UsrId
        PrincipalDetails lgnUsr = (PrincipalDetails) auth.getPrincipal();
        long lgnId = lgnUsr.getUsrId();

        //로그인 유저가 보유한 주식 리스트
        List<UserStock> myStockList = userStockService.myStockList(lgnId);
        Paging paging = new Paging(myStockList.size(), page, recordSize, 3 );


        List<HashMap<String,String>> scrapNewsList = scrapService.naverNewsScraping(myStockList,paging.getStartIndex(),recordSize);
        HashMap<String,Object> result = new HashMap<>();
        result.put("scrapNewsList",scrapNewsList);
        result.put("paging",paging);

        return result;
    }

    /**
     * @param req
     * @param stockInfo
     * @param auth
     * @return ResponseEntity (보유 주식 수정)
     */
    @ResponseBody
    @PostMapping("/main/mypage/changeMyStock")
    public ResponseEntity<Message> changeMyStock(HttpServletRequest req, UserStock stockInfo, Authentication auth){
        PrincipalDetails lgnUsr = (PrincipalDetails) auth.getPrincipal();
        stockInfo.setUsrId(lgnUsr.getUsrId());

        log.debug("변경 파라미터 stockInfo 객체 =========>" +stockInfo.toString());

        Message message = new Message();

        try {
            userStockService.changeMystock(stockInfo);
        }catch (Exception e){
            log.debug(e.getMessage());
            message.setStatus(HttpStatus.BAD_REQUEST);
            message.setMessage("요청 중 에러가 발생하였습니다. 다시 시도하시기 바랍니다.");
            return new ResponseEntity<>(message,HttpStatus.OK);
        }
        message.setStatus(HttpStatus.OK);
        message.setMessage("성공적으로 수정되었습니다.");


        return new ResponseEntity<>(message,HttpStatus.OK);
    }

    /**
     * @param req
     * @param auth
     * @return ResponseEntity (보유 주식 삭제)
     */
    @ResponseBody
    @PostMapping("/main/mypage/deleteMyStock")
    public ResponseEntity<Message> deleteMyStock(HttpServletRequest req, Authentication auth){

        PrincipalDetails lgnUsr = (PrincipalDetails) auth.getPrincipal();
        String srtnCd = req.getParameter("srtnCd");
        log.debug("삭제 파라미터 주식 단축코드 =========>" +srtnCd.toString());
        HashMap<String,Object> deleteParam = new HashMap<>();
        deleteParam.put("usrId",lgnUsr.getUsrId());
        deleteParam.put("srtnCd",srtnCd);

        Message message = new Message();

        try {
            userStockService.deleteMystock(deleteParam);
        }catch (Exception e){
            log.debug(e.getMessage());
            message.setStatus(HttpStatus.BAD_REQUEST);
            message.setMessage("요청 중 에러가 발생하였습니다. 다시 시도하시기 바랍니다.");
            return new ResponseEntity<>(message,HttpStatus.OK);
        }
        message.setStatus(HttpStatus.OK);
        message.setMessage("성공적으로 삭제되었습니다.");


        return new ResponseEntity<>(message,HttpStatus.OK);
    }


    @GetMapping("/main/mypage/myInfo")
    public String myInfo(HttpServletRequest req,Authentication auth){
        PrincipalDetails lgnUsr = (PrincipalDetails) auth.getPrincipal();
        req.setAttribute("user", lgnUsr);
        return "/main/mypage/myInfo";
    }


    @PostMapping ("/main/mypage/myInfo/changeInfo")
    public  ResponseEntity<Message> changeInfo(MultipartHttpServletRequest req, Authentication auth){
        PrincipalDetails lgnUsr = (PrincipalDetails) auth.getPrincipal();
        MultipartFile file = req.getFile("profileImg");
        String oldImg = req.getParameter("oldImg");
        String usrAs = req.getParameter("usrAs");

        HashMap<String,Object> changeInfo = new HashMap<>();
        changeInfo.put("oldImg",oldImg);
        changeInfo.put("usrAs",usrAs);
        changeInfo.put("file",file);
        changeInfo.put("usrId",lgnUsr.getUsrId());
        ResponseEntity<Message> msg = userService.changeInfo(changeInfo);

        req.setAttribute("user", lgnUsr);

        return msg;
    }




}
