package com.spring.finalproject.Board.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.spring.finalproject.Board.model.vo.Board;
import com.spring.finalproject.Board.model.vo.PageInfo;
import com.spring.finalproject.Board.model.vo.UCalendar;

public interface BoardService {

	ArrayList<Board> iSelectList();

	int boardInsert(Board b);

	int getBListCount();

	ArrayList<Board> bSelectList(PageInfo pi);

	Board selectBoard(int bNo);

	int addBoardCount(int bNo);

	int changebType(Board b);

	int boardUpdat(Board b);

	int deleteBoard(int bNo);

	int SearchListCount(HashMap<String, String> map);

	ArrayList<Board> selectSearchList(PageInfo pi, HashMap<String, String> map);

	int cinsert(UCalendar c);

	ArrayList<UCalendar> selectAllCaledar(String string);

	UCalendar selectOneC(int parseInt);

	int cUpdate(UCalendar c);

}
