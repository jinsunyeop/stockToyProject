package com.spring.sunyeop2.userBoard.mapper;


import com.spring.sunyeop2.userBoard.info.Board;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface UserBoardMapper {

    public Integer userBoardtotalRecordSize(Map<String,Object> param);

    public void updateBoard(Board board);

    public List<Board> userBoardListPaging(Map<String,Object> param);

    public void writeBoard(Board board);

    public Board readBoard(long boardNo);

    public void updateReadCnt(long boardNo);


}
