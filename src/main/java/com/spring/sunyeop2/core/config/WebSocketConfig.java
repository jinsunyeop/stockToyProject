package com.spring.sunyeop2.core.config;


import com.spring.sunyeop2.core.config.handler.ReplyEchoHandler;
import com.spring.sunyeop2.core.config.handler.WebSocketInterceptor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

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
