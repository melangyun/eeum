package com.spring.finalproject.Reservation.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.spring.finalproject.Reservation.model.vo.Reservation;

public interface ReservationService {

	ArrayList<HashMap<Integer, String>> selectRoom();

	int rinsert(Reservation r);

	ArrayList<String> rSelectDate(HashMap<String, Object> map);

	ArrayList<Reservation> selectAllRes(String empNo);

	int Rupdate(Reservation r);



}
