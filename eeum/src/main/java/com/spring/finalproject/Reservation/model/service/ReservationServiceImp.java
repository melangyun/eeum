package com.spring.finalproject.Reservation.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.finalproject.Reservation.model.dao.ReservationDAO;

@Service("rService")
public class ReservationServiceImp implements ReservationService{
	
	@Autowired
	private ReservationDAO rDAO;

	@Override
	public ArrayList<HashMap<Integer, String>> selectRoom() {
		return rDAO.selectRoom();
	}
}
