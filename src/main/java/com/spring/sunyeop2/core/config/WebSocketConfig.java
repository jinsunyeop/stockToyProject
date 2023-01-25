package com.spring.sunyeop2.core.config;


import com.spring.sunyeop2.core.config.auth.UserLoginSuccessHandler;
import com.spring.sunyeop2.core.config.handler.ReplyEchoHandler;
import com.spring.sunyeop2.core.config.handler.WebSocketInterceptor;
import com.spring.sunyeop2.login.info.User;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

import java.util.Map;

@Configuration
@EnableWebSocket
public class WebSocketConfig implements WebSocketConfigurer {

    @Bean
    public WebSocketInterceptor webSocketInterceptor(){
        return new WebSocketInterceptor();
    }


    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry webSocketHandlerRegistry) {
        webSocketHandlerRegistry.addHandler(new ReplyEchoHandler(),"/replyEcho").setAllowedOrigins("*").addInterceptors(webSocketInterceptor());
    }


}
