package com.spring.finalproject.Board.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.finalproject.Board.model.dao.BoardDAO;
import com.spring.finalproject.Board.model.vo.Board;
import com.spring.finalproject.Board.model.vo.PageInfo;

@Service("bService")
public class BoardServiceImpl implements BoardService {

	@Autowired
	BoardDAO bDAO;

	@Override
	public ArrayList<Board> iSelectList() {
		return bDAO.iSelectList();
	}

	@Override
	public int boardInsert(Board b) {
		return bDAO.boardInsert(b);
	}

	@Override
	public int getBListCount() {
		return bDAO.getBListCount();
	}

	@Override
	public ArrayList<Board> bSelectList(PageInfo pi) {
		return bDAO.bSelectList(pi);
	}

	@Override
	public Board selectBoard(int bNo) {
		return bDAO.selectBoard(bNo);
	}

	@Override
	public int addBoardCount(int bNo) {
		return bDAO.addBoardCount(bNo);
	}

	@Override
	public int changebType(Board b) {
		return bDAO.changebType(b);
	}

	@Override
	public int boardUpdat(Board b) {
		return bDAO.boardUpdat(b);
	}

	@Override
	public int deleteBoard(int bNo) {
		return bDAO.deleteBoard(bNo);
	}

	@Override
	public int SearchListCount(HashMap<String, String> map) {
		return bDAO.SearchListCount(map);
	}

	@Override
	public ArrayList<Board> selectSearchList(PageInfo pi, HashMap<String, String> map) {
		return bDAO.selectSearchList(pi,map);
	}
	
}
