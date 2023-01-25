package com.spring.sunyeop2.dashboard;


import com.spring.sunyeop2.core.config.auth.PrincipalDetails;
import com.spring.sunyeop2.core.response.Message;
import com.spring.sunyeop2.core.stockApi.StockApiService;
import com.spring.sunyeop2.core.stockApi.StockResponseItem;
import com.spring.sunyeop2.myPage.info.UserStock;
import com.spring.sunyeop2.myPage.service.UserFavoritesService;
import com.spring.sunyeop2.myPage.service.UserStockService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.net.URISyntaxException;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;

@Slf4j
@Controller
public class DashboardController {

    @Autowired
    StockApiService stockApiService;

    @Autowired
    UserStockService userStockService;

    @Autowired
    UserFavoritesService favoritesService;

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



    @RequestMapping("/main/dashboard")
    public String main(HttpServletRequest req, Authentication auth) throws URISyntaxException, IOException {
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
                for (StockResponseItem item : stockInfoList) {
                    if (i.getSrtnCd().equals(item.getSrtnCd())) {
                        myAsset += (i.getUsrSrtnCnt() * item.getClpr());
                        log.info("총 가격 ========> " + i.getUsrSrtnCnt() * item.getClpr());
                    }
                }
            }
            req.setAttribute("myStockList", stockInfoList);
            req.setAttribute("myStockListCnt", stockInfoList.size());

            req.setAttribute("myAsset", myAsset);

            //가장 전날 대비 떨어진 주식의 자세한 정보
            StockResponseItem warnStock = stockInfoList.stream().min(Comparator.comparingDouble(x -> fltRtConverter(x.getFltRt()))).get();

            List<StockResponseItem> warnStockList = stockApiService.detailStockInfo(warnStock.getSrtnCd());
            log.info("가장 떨어진 주식 =======> " + warnStock.toString());

            req.setAttribute("warnItmsNm", warnStock.getItmsNm());
            req.setAttribute("warnFltRt", fltRtConverter(warnStock.getFltRt()));
            req.setAttribute("warnStockList", warnStockList);

        }




        //로그인 유저가 즐겨찾기한 주식 리스트
        List<UserStock> favoriteStockList = favoritesService.myFavoriteStockList(lgnId);
        if(!favoriteStockList.isEmpty()){
            List<StockResponseItem> favoriteStockInfoList = stockApiService.myStockInfoList(favoriteStockList);
            favoriteStockInfoList.forEach(k -> k.setFltRt(String.valueOf(fltRtConverter(k.getFltRt()))));
            req.setAttribute("favoriteStockList",favoriteStockInfoList);
        }
        req.setAttribute("favoriteStockCnt",favoriteStockList.size());

        req.setAttribute("user", lgnUsr);


        return "/main/dashboard";
    }

    /*

    @ResponseBody
    @PostMapping("/main/dashboard/getMyStockList")
    public ResponseEntity<Message> getMyStockList(HttpServletRequest req, Authentication auth){
        //접속자 UsrId
        PrincipalDetails lgnUsr = (PrincipalDetails) auth.getPrincipal();
        long lgnId = lgnUsr.getUsrId();
        Boolean stockExist =Boolean.parseBoolean(req.getParameter("stockExist"));
        Message message = new Message();

        if (stockExist){
            HashMap<String,Object> getMyStockList = new HashMap<>();
            List<UserStock> myStockList = userStockService.myStockList(lgnId);
            List<StockResponseItem> stockInfoList = stockApiService.myStockInfoList(myStockList);

            //나의 보유 자산 변수
            long myAsset = 0;
            //보유 주식 종목별 총 가격
            for (UserStock i : myStockList) {
                for (StockResponseItem item : stockInfoList) {
                    if (i.getSrtnCd().equals(item.getSrtnCd())) {
                        myAsset += (i.getUsrSrtnCnt() * item.getClpr());
                        log.info("총 가격 ========> " + i.getUsrSrtnCnt() * item.getClpr());
                    }
                }
            }

            getMyStockList.put("referenceDt",stockInfoList.get(0).getBasDt());
            getMyStockList.put("myStockList",stockInfoList);
            getMyStockList.put("myStockListCnt",stockInfoList.size());
            getMyStockList.put("myAsset",myAsset);

            //가장 전날 대비 떨어진 주식의 자세한 정보
            StockResponseItem warnStock = stockInfoList.stream().min(Comparator.comparingDouble(x -> fltRtConverter(x.getFltRt()))).get();

            List<StockResponseItem> warnStockList = stockApiService.warnStockInfoList(warnStock.getSrtnCd());
            log.info("가장 떨어진 주식 =======> " + warnStock.toString());

            getMyStockList.put("warnItmsNm",warnStock.getItmsNm());
            getMyStockList.put("warnFltRt",fltRtConverter(warnStock.getFltRt()));
            getMyStockList.put("warnStockList",warnStockList);

            message.setStatus(HttpStatus.OK);
            message.setData(getMyStockList);
        }else {
            message.setStatus(HttpStatus.BAD_REQUEST);
        }




        return new ResponseEntity<>(message,HttpStatus.OK);
    }
    */



    @ResponseBody
    @PostMapping("/main/dashboard/search")
    public ResponseEntity<Message> searchStockList(HttpServletRequest req){
        String keyword = req.getParameter("keyword");
        Message message = new Message();
        List<StockResponseItem>  searchStockList =  stockApiService.searchStockList(keyword);

        if (searchStockList.isEmpty()){
            message.setStatus(HttpStatus.BAD_REQUEST);
            message.setMessage("검색 결과가 없습니다.");
        }else{
            message.setStatus(HttpStatus.OK);
            message.setData(searchStockList);
        }

        return new ResponseEntity<>(message, HttpStatus.OK);
    }

    @ResponseBody
    @PostMapping("/main/dashboard/saveStock")
    public ResponseEntity<Message> saveStock(HttpServletRequest req, UserStock stockInfo, Authentication auth){
        PrincipalDetails lgnUsr = (PrincipalDetails) auth.getPrincipal();
        stockInfo.setUsrId(lgnUsr.getUsrId());

        log.debug("저장 파라미터 stockInfo 객체 =========>" +stockInfo.toString());

        Message message = new Message();

        try {
            userStockService.saveMystock(stockInfo);
        }catch (Exception e){
            log.debug(e.getMessage());
            message.setStatus(HttpStatus.BAD_REQUEST);
            message.setMessage("요청 중 에러가 발생하였습니다.");
            return new ResponseEntity<>(message,HttpStatus.OK);
        }
        message.setStatus(HttpStatus.OK);
        message.setMessage("성공적으로 저장되었습니다.");


        return new ResponseEntity<>(message,HttpStatus.OK);
    }




}
