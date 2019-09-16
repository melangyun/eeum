package com.spring.finalproject.Reservation.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.finalproject.Reservation.model.service.ReservationService;

@Controller
public class ReservationController {
	@Autowired
	ReservationService rService;
	
	@RequestMapping("rInsertView.do")
	public ModelAndView rInsertView(ModelAndView mv) {
		ArrayList<HashMap<Integer,String>> roomList = rService.selectRoom();
		mv.addObject("roomList",roomList);
		mv.setViewName("board/rInsert");
		return mv;
	}
	
	@RequestMapping("rListView.do")
	public ModelAndView rListView(ModelAndView mv) {
		
		mv.setViewName("board/rList");
		return mv;
	}
}
