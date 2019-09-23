package com.spring.finalproject.Reservation.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonIOException;
import com.spring.finalproject.Employee.model.service.EmployeeService;
import com.spring.finalproject.Employee.model.vo.Employee;
import com.spring.finalproject.Reservation.model.service.ReservationService;
import com.spring.finalproject.Reservation.model.vo.Reservation;

@Controller
public class ReservationController {
	@Autowired
	ReservationService rService;
	
	@Autowired
	private EmployeeService eService;
	
	@RequestMapping("rInsertView.do")
	public ModelAndView rInsertView(ModelAndView mv) {
		ArrayList<HashMap<Integer,String>> roomList = rService.selectRoom();
		mv.addObject("roomList",roomList);
		mv.setViewName("board/rInsert");
		return mv;
	}
	
	@RequestMapping("rListView.do")
	public ModelAndView rListView(ModelAndView mv,HttpSession session) {
		Employee loginEmp = (Employee)session.getAttribute("loginEmp");
		ArrayList<Reservation>list =  rService.selectAllRes("%"+loginEmp.getEmpNo()+"%");
		ArrayList<Reservation>mine = new ArrayList<>();// 내가 예약한 회의
		ArrayList<Reservation>join = new ArrayList<>();// 내가 참여할 회의 
		
		for(Reservation r : list) {
			Employee e =new Employee();
			e.setEmpNo(r.getEmpNo());
			Employee getEmp = eService.selectEmp(e);
			r.setEmpNo("("+getEmp.getEmpNo()+") " + getEmp.getEmpName()+" - "+getEmp.getDeptName());
			
			
			String[] temp = r.getrDate().split(";");
			r.setrDate(temp[0]);
			r.setrTime(temp[1]);
			
			if(r.getEmpNo().contains(loginEmp.getEmpNo())){
				mine.add(r);
			}else {
				join.add(r);
			}
		}
		
		mv.addObject("mine",mine);// 내가 예약한 회의
		mv.addObject("join",join);// 내가 참여할 회의 
		mv.setViewName("board/rList");
		return mv;
	}
	
	@RequestMapping("rinsert.do")
	@ResponseBody
	public String rinsert(HttpSession session,
						  @RequestParam("rDate")String rDate,
						  @RequestParam("mNo")int mNo,
						  @RequestParam("empNo")String empNo,
						  @RequestParam("joinEmp")String joinEmp,
						  @RequestParam("mTitle")String mTitle,
						  @RequestParam("mContnet")String mContnet) {
		Reservation r = new Reservation();
		r.setrDate(rDate);
		r.setmNo(mNo);
		r.setEmpNo(empNo);
		r.setJoinEmp(joinEmp);
		r.setmTitle(mTitle);
		r.setmContnet(mContnet);
		
		/************************알람 insert*******************************/
			Employee loginEmp = (Employee) session.getAttribute("loginEmp");
			HashMap<String,Object> map = new HashMap<>();
			map.put("aContents", loginEmp.getEmpName()+"님이 '"+mTitle+"' 미팅을 공유했습니다.");
			map.put("aCate", "room");

			
			ArrayList<String> emp = new ArrayList<>();
			String cutSEmp = joinEmp.substring(0, joinEmp.length()-1);
			if(cutSEmp.contains(";")) {
				String[] tempEmp = cutSEmp.split(";");
				for(int i = 0 ; i < tempEmp.length ; i++) {
					emp.add(tempEmp[i].substring(tempEmp[i].indexOf("(")+2, tempEmp[i].indexOf(")")-1).trim());
				}
			}else {
				emp.add(cutSEmp.substring(cutSEmp.indexOf("(")+1,cutSEmp.indexOf(")")).trim());
			}
			map.put("emp", emp);
			
			
			eService.insertAlert(map);
		
		
		int result = rService.rinsert(r);
		if(result>0) {
			return "success";
		}else {
			return "fail";
		}
	}
	
	//날짜 집어넣어서 예약 내역 받아옴!
	@RequestMapping("rSelectDate.do")
	public void rSelectDate(HttpServletResponse response, @RequestParam("date")String date,@RequestParam("mNo")int mNo) throws IOException {
		HashMap<String,Object> map= new HashMap<>();
		map.put("date", date+"%");
		map.put("mNo", mNo);
		ArrayList<String> list = rService.rSelectDate(map);
		String result = "";
		if(list!=null) {
			for(String str : list ) {
				String resultStr = str.substring(str.indexOf(";")+1, str.length());
				if(resultStr.contains(",")) {
					String[] resultArr = resultStr.split(",");
					for(int i = 0 ; i <resultArr.length; i++) {
						result += resultArr[i]+",";
					}
				}else {
					result += str+",";
				}
			}
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		gson.toJson(result,response.getWriter());
	}
	
	@RequestMapping("rUpdate.do")
	@ResponseBody
	public String rUpdate(@RequestParam("id")String id,@RequestParam("rStatus")String rStatus,@RequestParam("joinEmp")String joinEmp) {
		Reservation r = new Reservation();
		String[] array = id.split(";");
		r.setrDate(array[0]+";"+array[1]);
		r.setmNo(Integer.parseInt(array[2]));
		r.setrStatus(rStatus);
		r.setJoinEmp(joinEmp);
		
		int result = rService.Rupdate(r);
		if(result>0) {
			return "success";
		}else {
			return "fail";
		}
	}
}
