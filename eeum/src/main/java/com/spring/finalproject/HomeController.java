package com.spring.finalproject;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonIOException;
import com.spring.finalproject.Approval.model.service.ApprovalService;
import com.spring.finalproject.Approval.model.vo.Approval;
import com.spring.finalproject.Board.model.service.BoardService;
import com.spring.finalproject.Board.model.vo.Board;
import com.spring.finalproject.Board.model.vo.UCalendar;
import com.spring.finalproject.Employee.model.service.EmployeeService;
import com.spring.finalproject.Employee.model.vo.Employee;
import com.spring.finalproject.Reservation.model.service.ReservationService;
import com.spring.finalproject.Reservation.model.vo.Reservation;
import com.spring.finalproject.Todo.model.service.TodoService;
import com.spring.finalproject.Todo.model.vo.Todo;

@Controller
public class HomeController {
	
	@Autowired
	BoardService bService;
	
	@Autowired
	ReservationService rService;
	
	@Autowired
	private EmployeeService eService;
	
	@Autowired
	ApprovalService aService;
	
	@Autowired
	private TodoService tService;
	
//	@RequestMapping(value = "home.do", method = RequestMethod.GET)
//	public String home(Locale locale, Model model) {
//		return "home";
//	}
	
	@RequestMapping(value = "home.do", method = RequestMethod.GET)
	public ModelAndView calView(ModelAndView mv,HttpSession session) {
		Employee loginEmp = (Employee)session.getAttribute("loginEmp");
		//내가 참여할 회의 리스트
		ArrayList<Reservation> rList =  rService.selectAllRes("%"+loginEmp.getEmpNo()+"%");
		
		//우리 부서원들!
		ArrayList<Employee> eList = eService.selectDeptEmp(loginEmp.getDeptNo());
		
		//부서원들 목록(휴가목록 추출용)
		ArrayList<String> emp = new ArrayList<>();
		for(Employee e : eList) {
			emp.add(e.getEmpNo());
		}
		//우리 부서원들 휴가list
		ArrayList<Approval>aList = aService.selectDeptVacation(emp);
		//캘린더에 등록된 일정 - 개인 일정, 공유 일정, 전체일정
		ArrayList<UCalendar> cList = bService.selectAllCaledar("%"+loginEmp.getEmpNo()+"%");
		
		
		//반환용 list
		// 1. 참여회의 반환용 - title, startDay
		ArrayList<HashMap<String,String>> r_rlist = new ArrayList<>();
		// 2. 입사기념일 반환용 - title-> 이름 , start
		ArrayList<HashMap<String,String>> r_eList = new ArrayList<>();
		// 3. 휴가 반환용-  title-> 이름 , start, finish
		ArrayList<HashMap<String,String>> r_vList = new ArrayList<>();
		// 4. 개인 일정
		ArrayList<UCalendar> r_pList = new ArrayList<>();
		// 5. 공유 일정
		ArrayList<UCalendar> r_sList = new ArrayList<>();
		// 6. 전체 일정
		ArrayList<UCalendar> r_aList = new ArrayList<>();
		
		
		//1. 참여 회의 list
		for(Reservation r : rList) {
			String str = r.getrDate();
			String[] temp = str.split(";");
			
			HashMap<String,String> map = new HashMap<>();
			map.put("start", temp[0]);
			map.put("title", r.getmTitle());
			
			r_rlist.add(map);
		}
		
		//입사일 올해로 치환 후 담기!
		GregorianCalendar today = new GregorianCalendar();
		int year = today.get(Calendar.YEAR);
		for(Employee e : eList) {
			String joinDate = e.getJoinDate()+"";
			String[] temp = joinDate.split("-");
			joinDate= year+"-"+temp[1]+"-"+temp[2];
			/* e.setJoinDate(joinDate.setYear(Year)); */
			HashMap<String,String> map = new HashMap<>();
			map.put("start", joinDate);
			map.put("title", e.getEmpName());
			
			r_eList.add(map);
		}
		
		//휴가 
		for(Approval ap : aList) {
			HashMap<String,String> map = new HashMap<>();
			//이름 찾아오기
			String empNo = ap.getEmpNo();
			String empName = "";
			for(Employee e : eList) {
				if(e.getEmpNo().equals(empNo)) {
					empName = e.getEmpName();
				}
			}
			map.put("title", empName);
			map.put("start", ap.getA_v_first()+"");
			map.put("finish", ap.getA_v_last()+"");
			
			r_vList.add(map);
		}
		
		//캘린더 나누기
		for(UCalendar c : cList) {
			Employee e = new Employee();
			e.setEmpNo(c.getEmpNo());
			Employee Emp = eService.selectEmp(e);
			c.setEmpNo("( "+Emp.getEmpNo()+" ) "+Emp.getEmpName()+" - "+Emp.getDeptName()); 
			
			if(c.getcStatus().equals("A")) {
				//전체일정
				r_aList.add(c);
			}else if(c.getEmpNo() != null) {
				//본인일정
				if(c.getEmpNo().contains(loginEmp.getEmpNo())) {
					r_pList.add(c);
				}
			}
			if(c.getsEmp()!=null){
				//남이 공유해준 일정
				if(c.getsEmp().contains(loginEmp.getEmpNo())) {
					r_sList.add(c);
				}
			}
		}
		
		mv.addObject("r_pList",r_pList);
		mv.addObject("r_sList",r_sList);
		mv.addObject("r_aList",r_aList);
		mv.addObject("rlist",r_rlist);
		mv.addObject("elist",r_eList);
		mv.addObject("vlist",r_vList);
		/**********************************캘린더 영역 끝! - 공지사항 영역 시작!**************************************/
		ArrayList<Board> bList = bService.selectNewBoard();//5개만 불러옴!
		mv.addObject("bList",bList);
		/******************************************to-do영역**********************************************/
		ArrayList<Todo> tList = tService.selectAllUndo(loginEmp.getEmpNo());
		mv.addObject("tList",tList);
		/*****************************************출퇴근 영역***************************************************/
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd kk:mm:ss");
		String strDate = dateFormat.format(Calendar.getInstance().getTime());
		String[] temp = strDate.split(" ");
		String startOfDate = temp[0]+" "+"00:00:00";
		
		HashMap<String,String> keys = new HashMap<>();
		keys.put("empNo", loginEmp.getEmpNo());
		keys.put("date", strDate);
		keys.put("start", startOfDate);
		
		
		HashMap<String,String> map = eService.selectCommute(keys);
		mv.addObject("map",map);
		mv.setViewName("home");
		return mv;
	}
	
	
	@RequestMapping(value = "chulgun.do")
	@ResponseBody
	public String chulgun(HttpSession session) {
		Employee loginEmp = (Employee) session.getAttribute("loginEmp");
		String EmpNo = loginEmp.getEmpNo();

		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd kk:mm:ss");
		String strDate = dateFormat.format(Calendar.getInstance().getTime());
		
		HashMap<String,String> map = new HashMap<>();
		map.put("empNo", EmpNo);
		map.put("Date", strDate);
		
		
		int result = eService.chulgun(map);
		if(result>0) {
			return strDate;
		}else {
			return "fail";
		}
	}
	
	@RequestMapping("goHome.do")
	public void goHome(HttpSession session,HttpServletResponse response) throws IOException {
		Employee loginEmp = (Employee) session.getAttribute("loginEmp");
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd kk:mm:ss");
		String strDate = dateFormat.format(Calendar.getInstance().getTime());
		String[] temp = strDate.split(" ");
		String startOfDate = temp[0]+" "+"00:00:00";
		
		HashMap<String,String> keys = new HashMap<>();
		keys.put("empNo", loginEmp.getEmpNo());
		keys.put("date", strDate);
		keys.put("start", startOfDate);
		int result = eService.updateCommute(keys);
		
		//내 출근 기록!
		HashMap<String,String> map = eService.selectCommute(keys);
		String onSigan = map.get("ATTEND");
		String ganSigan = map.get("GOHOME");
		
		//결과 반환용 map
		HashMap<String,String> rMap = new HashMap<>();
		
		if(result>0) {
			rMap.put("result","success");
			rMap.put("time", strDate);
		}else {
			rMap.put("result","fail");
		}
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		gson.toJson(rMap,response.getWriter());
	}
	
	@RequestMapping("getMychulgun.do")
	public void getMychulgun(HttpSession session,HttpServletResponse response) throws IOException {
		Employee loginEmp = (Employee) session.getAttribute("loginEmp");
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd kk:mm:ss");
		String strDate = dateFormat.format(Calendar.getInstance().getTime());
		String[] temp = strDate.split(" ");
		String startOfDate = temp[0]+" "+"00:00:00";
		
		HashMap<String,String> keys = new HashMap<>();
		keys.put("empNo", loginEmp.getEmpNo());
		keys.put("date", strDate);
		keys.put("start", startOfDate);
		HashMap<String,String> map = eService.selectCommute(keys);
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		gson.toJson(map,response.getWriter());
	}
	
}
