package com.spring.sunyeop2.stocks;


import com.spring.sunyeop2.core.config.auth.PrincipalDetails;
import com.spring.sunyeop2.core.response.Message;
import com.spring.sunyeop2.core.stockApi.StockApiService;
import com.spring.sunyeop2.core.stockApi.StockResponseInfo;
import com.spring.sunyeop2.core.stockApi.StockResponseItem;
import com.spring.sunyeop2.core.util.Paging;
import com.spring.sunyeop2.myPage.info.UserStock;
import com.spring.sunyeop2.myPage.service.UserFavoritesService;
import com.spring.sunyeop2.myPage.service.UserStockService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Controller
@Slf4j
public class stocksController {

    @Autowired
    StockApiService stockApiService;

    @Autowired
    UserFavoritesService favoritesService;

    @Autowired
    UserStockService stockService;

    private Double fltRtConverter(String fltRt) {
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



    @GetMapping("/main/stocks/allStock")
    public String allStock(HttpServletRequest req, Authentication auth){
        PrincipalDetails lgnUsr = (PrincipalDetails) auth.getPrincipal();

        req.setAttribute("user", lgnUsr);
        return "/main/stocks/allStock";
    }

    @GetMapping("/main/stocks/allStock/pagingStockList")
    @ResponseBody
    public HashMap<String,Object> pagingStockList(HttpServletRequest req, Authentication auth){
        PrincipalDetails lgnUsr = (PrincipalDetails) auth.getPrincipal();
        List<UserStock> myFavoriteStocks = favoritesService.myFavoriteStockList(lgnUsr.getUsrId());
        List<String> myFavoriteSrtnArr =  myFavoriteStocks.stream().map(k -> k.getSrtnCd()).collect(Collectors.toList());
        String pageNum =  Optional.ofNullable(req.getParameter("pageNum")).orElse("1");

        StockResponseInfo pagingStockInfo = stockApiService.pagingStockInfo(pageNum);

        List<StockResponseItem> pagingStockList = Optional.ofNullable(pagingStockInfo.getItems().get("item")).orElse(new ArrayList<>());

        for(StockResponseItem item : pagingStockList){
            if(myFavoriteSrtnArr.contains(item.getSrtnCd())){
                item.setUsrFavorite(true);
            }
        }


        long longStockSize = pagingStockInfo.getTotalCount();
        int stockSize = Long.valueOf(longStockSize).intValue();

        Paging paging = new Paging(stockSize, Integer.parseInt(pageNum), 10, 5);

        HashMap<String,Object> result = new HashMap<>();

        result.put("list", pagingStockList);
        result.put("paging", paging);

        return result;
    }

    @GetMapping("/main/stocks/allStock/searchStockList")
    @ResponseBody
    public List<StockResponseItem>  searchStockList(HttpServletRequest req, Authentication auth){
        String keyword =  req.getParameter("keyword");

        PrincipalDetails lgnUsr = (PrincipalDetails) auth.getPrincipal();
        List<UserStock> myFavoriteStocks = favoritesService.myFavoriteStockList(lgnUsr.getUsrId());
        List<String> myFavoriteSrtnArr =  myFavoriteStocks.stream().map(k -> k.getSrtnCd()).collect(Collectors.toList());
        List<StockResponseItem> searchStockList =  stockApiService.searchStockList(keyword);

        for(StockResponseItem item : searchStockList){
            if(myFavoriteSrtnArr.contains(item.getSrtnCd())){
                item.setUsrFavorite(true);
            }
        }

        return searchStockList;
    }

    @GetMapping("/main/stocks/allStock/delete")
    @ResponseBody
    public ResponseEntity<Message> deleteMyFavorite(HttpServletRequest req,Authentication auth){
        PrincipalDetails lgnUsr = (PrincipalDetails) auth.getPrincipal();
        long usrId = lgnUsr.getUsrId();
        String srtnCd = req.getParameter("srtnCd");
        HashMap<String,Object> param = new HashMap<>();
        Message msg = new Message();
        param.put("usrId",usrId);
        param.put("srtnCd",srtnCd);

        try {
            favoritesService.deleteMyFavorite(param);
            msg.setMessage("정상적으로 해제되었습니다.");
            msg.setStatus(HttpStatus.OK);
        }catch (Exception e){
            e.printStackTrace();
            msg.setMessage("정상적으로 해제되지 않았습니다. 다시 시도해주시기 바랍니다.");
            msg.setStatus(HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(msg,HttpStatus.OK);
    }

    @GetMapping("/main/stocks/allStock/regist")
    @ResponseBody
    public ResponseEntity<Message> registMyFavorite(HttpServletRequest req,Authentication auth){
        PrincipalDetails lgnUsr = (PrincipalDetails) auth.getPrincipal();
        long usrId = lgnUsr.getUsrId();
        String srtnCd = req.getParameter("srtnCd");
        HashMap<String,Object> param = new HashMap<>();
        Message msg = new Message();
        param.put("usrId",usrId);
        param.put("srtnCd",srtnCd);

        try {
            favoritesService.registMyFavorite(param);
            msg.setMessage("정상적으로 등록되었습니다.");
            msg.setStatus(HttpStatus.OK);
        }catch (Exception e){
            e.printStackTrace();
            msg.setMessage("정상적으로 등록되지 않았습니다. 다시 시도해주시기 바랍니다.");
            msg.setStatus(HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(msg,HttpStatus.OK);
    }

    @GetMapping("/main/stocks/detail/{srtnCd}")
    public ModelAndView stockDetail(HttpServletRequest req, Authentication auth, @PathVariable("srtnCd") String srtnCd){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/main/stocks/stockDetail");
        PrincipalDetails lgnUsr = (PrincipalDetails) auth.getPrincipal();
        mv.addObject ("user", lgnUsr);

        String rate = stockService.stockHoldingRate(srtnCd);
        List<StockResponseItem> detailStock =  stockApiService.detailStockInfo(srtnCd);
        mv.addObject("title",detailStock.get(0).getItmsNm());
        mv.addObject("stockHoldingRate",rate);
        mv.addObject("detailStock",detailStock);
        mv.addObject("recentDetailStock",detailStock.get(0));
        return mv;
    }






}
