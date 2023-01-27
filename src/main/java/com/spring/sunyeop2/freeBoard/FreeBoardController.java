package com.spring.sunyeop2.freeBoard;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

@Controller
public class FreeBoardController {

    @RequestMapping(value = "/freeBoard/write",method = RequestMethod.GET)
    public ModelAndView freeBoard(HttpServletRequest req, Authentication auth){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/freeBoard/write");

        return mv;
    }




}
