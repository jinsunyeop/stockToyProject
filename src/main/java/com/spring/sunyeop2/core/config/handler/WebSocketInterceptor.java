package com.spring.sunyeop2.core.config.handler;

import com.spring.sunyeop2.core.config.handler.auth.PrincipalDetails;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

import java.util.Map;
import java.util.Optional;

public class WebSocketInterceptor extends HttpSessionHandshakeInterceptor {
    @Override
    public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler, Map<String, Object> attributes) throws Exception {
        PrincipalDetails user = (PrincipalDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        attributes.put("userUsrAs", Optional.ofNullable(user.getUsrAs()).orElse("익명"));
        attributes.put("userUsrId", user.getUsrId());
        attributes.put("userImgPath", (String) Optional.ofNullable(user.getFilePath()).orElse("/assets/img/errorProfile.png"));
        return super.beforeHandshake(request, response, wsHandler, attributes);
    }
}
