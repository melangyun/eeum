package com.spring.finalproject.Reservation.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.finalproject.Reservation.model.vo.Reservation;

@Repository("rDAO")
public class ReservationDAO {
	@Autowired
	private SqlSessionTemplate sqlSession;

	public ArrayList<HashMap<Integer, String>> selectRoom() {
		return (ArrayList)sqlSession.selectList("rMapper.selectRoom");
	}

	public int rinsert(Reservation r) {
		return sqlSession.insert("rMapper.rinsert", r);
	}

	public ArrayList<String> rSelectDate(HashMap<String, Object> map) {
		return (ArrayList)sqlSession.selectList("rMapper.rSelectDate",map);
	}

	public ArrayList<Reservation> selectAllRes(String empNo) {
		return (ArrayList)sqlSession.selectList("rMapper.selectAllRes",empNo);
	}

	public int Rupdate(Reservation r) {
		return sqlSession.update("rMapper.Rupdate", r);
	}

}
