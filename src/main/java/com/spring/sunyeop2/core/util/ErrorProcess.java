package com.spring.sunyeop2.core.util;


import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;


@Controller
public class ErrorProcess implements ErrorController {


    @Override
    public String getErrorPath() {
        return null;
    }

    @GetMapping("/error")
    public String handleError(HttpServletRequest req){
        Object status = req.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
        String error = "돌아가";
        String code = status.toString();
        if(status != null){
            int statusCode = Integer.valueOf(status.toString());
            if(statusCode == HttpStatus.NOT_FOUND.value()) {  //404
                code = "404";
                error = "요청하신 페이지를 찾을 수 없습니다.";
            } else if(statusCode == HttpStatus.BAD_REQUEST.value()) { //400
                code = "400";
                error = "잘못된 요청입니다.";
            } else if(statusCode == HttpStatus.FORBIDDEN.value()) { //403
                code = "403";
                error = "권한이 없습니다.";
            }
        }
        req.setAttribute("error", error);
        req.setAttribute("code", code);


        return "common/error";
    }




}
