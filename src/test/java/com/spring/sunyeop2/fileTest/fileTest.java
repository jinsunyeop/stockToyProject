package com.spring.sunyeop2.fileTest;


import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.context.SpringBootTest;

import java.io.File;

@SpringBootTest
@Slf4j
public class fileTest {

    @Value("${sunyeop2.profile.rootPath}")
    String rootPath;

    @Test
    public void filePath(){
        String filePath = "/123.jpg";
        File file = new File(rootPath+filePath);
        log.info(file.exists() + " 존재해라   " + file.getPath());
    }
}
