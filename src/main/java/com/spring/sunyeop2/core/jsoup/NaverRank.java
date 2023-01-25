package com.spring.sunyeop2.core.jsoup;


import com.spring.sunyeop2.myPage.info.UserStock;
import lombok.extern.slf4j.Slf4j;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Slf4j
@Service
public class NaverRank {

    public List<HashMap<String,String>> naverNewsScraping(List<UserStock> myStockList,int startIndex, int recordSize) {

        List<HashMap<String,String>> scrapList = new ArrayList<>();
        if (!myStockList.isEmpty()){
            for(int i = startIndex; i < (recordSize+startIndex); i++){
                if(myStockList.size() == i) break;
                HashMap<String,String> m = new HashMap<>();
                m.put("srtnCd", myStockList.get(i).getSrtnCd());
                m.put("itmsNm", myStockList.get(i).getItmsNm());

                //스크래핑 시작
                try{
                    String url = "https://finance.naver.com/item/news_news.naver?code="+myStockList.get(i).getSrtnCd()+"&page=&sm=title_entity_id.basic&clusterId=";
                    Document doc = Jsoup.connect(url).get();
                    Elements elements = doc.getElementsByClass("first");
                    Element parentElement = elements.get(0).firstElementChild();
                    log.info("네이버 뉴스 스크래핑 기사 제목 ========>{}",parentElement.getElementsByTag("a").get(0).text());

                    m.put("text",parentElement.getElementsByTag("a").get(0).text());
                    m.put("href",parentElement.getElementsByTag("a").attr("href"));
                    m.put("provider",elements.get(0).getElementsByClass("info").get(0).text());
                    m.put("date",elements.get(0).getElementsByClass("date").get(0).text());
                    m.put("flag","true");
                }catch (IOException e){
                    m.put("flag","false");
                    m.put("text","해당 종목에 뉴스가 없습니다.");
                }finally {
                    scrapList.add(m);
                }
            }
        }
        return scrapList;
    }

}
