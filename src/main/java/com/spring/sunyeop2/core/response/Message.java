package com.spring.sunyeop2.core.response;


//이 클래스는 ResponseEntity 안에 T body에 들어갈 객체이므로 null이 가능하다.
//그래서 @NoArgsConstructor도 명시할 것이다.


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.http.HttpStatus;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Message {
    private HttpStatus status;
    private Integer code; //코드상태
    private String message;
    private Object data;


}
