package com.spring.sunyeop2.core.config.handler;


import lombok.extern.slf4j.Slf4j;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.util.*;
import java.util.stream.Collectors;

@Slf4j
public class ReplyEchoHandler extends TextWebSocketHandler {

    private final static String splitStr = "==&==";

    private final static String infoBoxStr = "==&infos&==";

    //접속 중인 전체 webSocketSession
    List<Map<String,WebSocketSession>> allsessions = new ArrayList<>();

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        log.info("연결 확인 : " + session);

        //키 : 종목 URI 값 : WebSocketSession
        Map<String,WebSocketSession> userSession = new HashMap<>();
        userSession.put(session.getUri().toString(),session);
        allsessions.add(userSession);
        allsessions.stream().filter(k->k.containsKey(session.getUri().toString())).forEach(k-> log.info("같은 URI를 사용하는 세션 사용자 : " +  k.get(session.getUri().toString()).getId()));

    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage handleTextMessage) throws Exception {
        log.info("메시지 확인 : " + session + " : " + handleTextMessage);

        //응답 메시지
        String resultStr = handleTextMessage.getPayload();

        //WebSocketInterceptor에서 WebSocketSession에 부여한 login 사용자 lgnId, UsrId, ImgPath
        Map<String,Object> attributes = session.getAttributes();
        String userUsrAs = (String)attributes.get("userUsrAs");
        long userUsrId = (long)attributes.get("userUsrId");
        String userImgPath =(String)attributes.get("userImgPath");

        //입장 문구와 답 문구를 구분
        //만약 "==&==" 가 붙어서 온 문구라면 일반적인 대화
        String msg;
        if(resultStr.indexOf(splitStr) > -1) {
            String[] resultArr = resultStr.split(splitStr);
            log.info("사용자 로그인 아이디 --> "+userUsrAs+ " 의 대화 내용 : "  + resultArr[0]);
            msg = userUsrId + "&:&"+userUsrAs + "&:&" +userImgPath+"&:&"+resultArr[0];
           
        //만약 "==&==" 가 붙어서 오지않은 문구라면 사용자 입장
        }else{
            log.info("사용자 로그인 아이디 --> "+userUsrAs+ " 의 대화 내용 : "  + resultStr);
            msg = infoBoxStr+ resultStr;
        }

        //같은 URI에 있는 세션에게만 전송
        String sessionKey = session.getUri().toString();
        List<Map<String,WebSocketSession>>  sameUriSessions = allsessions.stream().filter(k->k.containsKey(sessionKey)).collect(Collectors.toList());
        for(Map<String,WebSocketSession> ss : sameUriSessions){
        		ss.get(sessionKey).sendMessage(new TextMessage(msg));
            
        }

    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        log.info("연결 끊김 확인 : " + session + " : " + status );

//        Map<String,Object> attributes = session.getAttributes();
//        String userUsrAs = (String)attributes.get("userUsrAs");
//
//        String sessionKey = session.getUri().toString();

        for(int i = 0; i < allsessions.size(); i++){
            WebSocketSession compare  = Optional.ofNullable(allsessions.get(i).get(session.getUri().toString().trim())).orElse(null);
            if(compare != null){
                log.info("접속 중인 전체 webSocketSession List에서 현재 종료 Session 삭제 : " + allsessions.remove(i));
            }
        }

//        List<Map<String,WebSocketSession>>  sameUriSessions = allsessions.stream().filter(k->k.containsKey(sessionKey)).collect(Collectors.toList());
//        for(Map<String,WebSocketSession> ss : sameUriSessions){
//            ss.get(sessionKey).sendMessage(new TextMessage(infoBoxStr+userUsrAs+"님이 퇴장하였습니다."));
//        }

        session.close();
    }

}
