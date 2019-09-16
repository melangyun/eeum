package com.spring.finalproject.Reservation.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("rDAO")
public class ReservationDAO {
	@Autowired
	private SqlSessionTemplate sqlSession;

	public ArrayList<HashMap<Integer, String>> selectRoom() {
		return (ArrayList)sqlSession.selectList("rMapper.selectRoom");
	}
}
