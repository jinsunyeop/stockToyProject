package com.spring.sunyeop2.jsoupTest;


import lombok.extern.slf4j.Slf4j;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.junit.Test;
import org.springframework.boot.test.context.SpringBootTest;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@SpringBootTest
@Slf4j
public class naverRankTest {

    @Test
    public void naverNewsScraping() {
        String url = "https://finance.naver.com/item/news_news.naver?code=323410&page=&sm=title_entity_id.basic&clusterId=";
        try{
            Document doc = Jsoup.connect(url).get();
            Elements elements = doc.getElementsByClass("first");
            Element parentElement = elements.get(0).firstElementChild();
    //        log.info(parentElement.getElementsByTag("a").get(0).text());
     //       log.info(parentElement.getElementsByTag("a").attr("href"));
            log.info(elements.get(0).getElementsByClass("info").get(0).text()+ "");
            log.info(elements.get(0).getElementsByClass("date").get(0).text()+ "");


       //     log.info(parentElement.getElementsByClass("info").get(0).text());

        /*
            childElements.forEach(k ->{
                log.info("기사 제목 : ======> : " + k.select("a").text());
                log.info("기사 링크 : ======> : " + k.select("a").attr("href"));
                log.info("기사 회사 : ======> : " + k.select("span").get(0).text());
            });
*/


        }catch (IOException e){
            e.printStackTrace();
        }


    }
}
