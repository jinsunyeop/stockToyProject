package com.spring.sunyeop2.core.exception;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class commonException extends RuntimeException {

    public commonException(){
        super();
    }

    public commonException(String msg){
        super(msg);
    }
}
