package com.spring.finalproject.Board.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.finalproject.Board.model.vo.Board;
import com.spring.finalproject.Board.model.vo.PageInfo;

@Repository("bDAO")
public class BoardDAO {
	@Autowired
	private SqlSessionTemplate sqlSession;

	public ArrayList<Board> iSelectList() {
		return (ArrayList) sqlSession.selectList("bMapper.iSelectList");
	}

	public int boardInsert(Board b) {
		return sqlSession.insert("bMapper.boardInsert",b);
	}

	public int getBListCount() {
		return sqlSession.selectOne("bMapper.getBListCount");
	}

	public ArrayList<Board> bSelectList(PageInfo pi) {
		// RowBounds로 페이징 계산하기
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		// offset : 뛰어 넘을 값
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("bMapper.bSelectList", null, rowBounds);
	}

	public Board selectBoard(int bNo) {
		return sqlSession.selectOne("bMapper.selectBoard",bNo);
	}

	public int addBoardCount(int bNo) {
		return sqlSession.update("bMapper.addBoardCount",bNo);
	}

	public int changebType(Board b) {
		return sqlSession.update("bMapper.changebType",b);
	}

	public int boardUpdat(Board b) {
		return sqlSession.update("bMapper.boardUpdat",b);
	}

	public int deleteBoard(int bNo) {
		return sqlSession.update("bMapper.deleteBoard",bNo);
	}

	public int SearchListCount(HashMap<String, String> map) {
		return sqlSession.selectOne("bMapper.SearchListCount",map);
	}

	public ArrayList<Board> selectSearchList(PageInfo pi,HashMap<String, String> map) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("bMapper.selectSearchList",map,rowBounds);
	}

}
