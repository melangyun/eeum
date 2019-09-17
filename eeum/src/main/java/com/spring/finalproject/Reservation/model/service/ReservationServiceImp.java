package com.spring.finalproject.Reservation.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.finalproject.Reservation.model.dao.ReservationDAO;
import com.spring.finalproject.Reservation.model.vo.Reservation;

@Service("rService")
public class ReservationServiceImp implements ReservationService{
	
	@Autowired
	private ReservationDAO rDAO;

	@Override
	public ArrayList<HashMap<Integer, String>> selectRoom() {
		return rDAO.selectRoom();
	}

	@Override
	public int rinsert(Reservation r) {
		return rDAO.rinsert(r);
	}

	@Override
	public ArrayList<String> rSelectDate(HashMap<String, Object> map) {
		return rDAO.rSelectDate(map);
	}

	@Override
	public ArrayList<Reservation> selectAllRes(String empNo) {
		return rDAO.selectAllRes(empNo);
	}

	@Override
	public int Rupdate(Reservation r) {
		return rDAO.Rupdate(r);
	}


}
