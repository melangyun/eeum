package com.spring.finalproject.Mail.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonIOException;
import com.spring.finalproject.Board.model.vo.PageInfo;
import com.spring.finalproject.Employee.model.service.EmployeeService;
import com.spring.finalproject.Employee.model.vo.Employee;
import com.spring.finalproject.Mail.model.exception.MailException;
import com.spring.finalproject.Mail.model.service.MailService;
import com.spring.finalproject.Mail.model.vo.Mail;
import com.spring.finalproject.common.Pagination;

@Controller
public class MailController {

	@Autowired
	MailService mService;
	
	@Autowired
	private EmployeeService eService;
	
	// 메일 삽입 보내기 페이지로 가기
	@RequestMapping("mailinsertView.do")
	public ModelAndView mailinsertView(@RequestParam(value = "empNo", required = false) String empNo, ModelAndView mv) {
		if (empNo == null) {
			empNo = "";
		}else {
			System.out.println(empNo);
			if(!empNo.contains("( ")) {
			Employee e = new Employee();
			e.setEmpNo(empNo);
			Employee emp = eService.selectEmp(e);
			empNo = "( "+emp.getEmpNo()+" ) "+ emp.getEmpName() +" - "+emp.getDeptName();
			}
		}
		
		mv.addObject("empNo", empNo);
		mv.setViewName("mail/mailWrite");
		return mv;
	}


	// 메일 전송
	@RequestMapping(value = "sendEmail.do", method = RequestMethod.POST)
	@ResponseBody
	public String sendEmail(HttpSession session,@RequestParam("empNo") String empNo, @RequestParam("recieveEmp") String recieveEmp,
			@RequestParam("eType") String eType, @RequestParam("eTitle") String eTitle,
			@RequestParam("eContent") String eContent) {
//		Employee e = new Employee();
//		e.setEmpNo(recieveEmp);
//		e = eService.selectEmp(e);
		
		Mail mail = new Mail();
		mail.setEmpNo(empNo);
		mail.setRecieveEmp(recieveEmp);
		mail.seteType(eType);
		mail.seteTitle(eTitle);
		mail.seteContent(eContent);
		mail.setRecieveEmpName(recieveEmp);
		
		/************************알람 insert*******************************/
		Employee loginEmp = (Employee) session.getAttribute("loginEmp");
		HashMap<String,Object> map = new HashMap<>();
		map.put("aContents", loginEmp.getEmpName()+"님의 새로운 메일 : "+eTitle);
		map.put("aCate", "mail");

		
		ArrayList<String> emp = new ArrayList<>();
		emp.add(recieveEmp.substring(recieveEmp.indexOf("( ")+2, recieveEmp.indexOf(" )")));
		map.put("emp", emp);
		
		eService.insertAlert(map);

		
		int result = mService.sendEmail(mail);
		if (result > 0) {
			return "success";
		} else {
			throw new MailException("메일 전송에 실패하였습니다.");
		}
	}
	
	//받은메일함
	@RequestMapping("mailReceive.do")
	public ModelAndView noticeView(@RequestParam(value = "search", required = false) String search,
			@RequestParam(value = "page", required = false) Integer page, @RequestParam("eStatus") String eStatus,
			@RequestParam(value = "cate", required = false) String cate, ModelAndView mv, HttpSession session) {
		// cate : 최신순, 오래된순
		int currentPage = 1; // 임의로 지정
		if (page != null) {
			// 페이징 버튼을 눌러서 페이지값이 바뀔 경우
			currentPage = page;
		}

		// 페이징 공지사항
		int listCount = 0;

		// 검색 영역
		String searchKey = "%" + search + "%";
		if (search == null) {
			searchKey = "%%";
		}

		// 검색 및 카테고리 넘기는 HashMap
		HashMap<String, String> map = new HashMap<String, String>();
		Employee loginEmp = (Employee) session.getAttribute("loginEmp");
		map.put("searchKey", searchKey);
		map.put("cate", cate);
		map.put("eStatus", eStatus);
		map.put("empNo", "%" + loginEmp.getEmpNo() + "%");

		listCount = mService.SearchMListCount(map);
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		ArrayList<Mail> mail = mService.selectMSearchList(pi, map);

		mv.addObject("cate", cate);
		mv.addObject("search", search);
		mv.addObject("mail", mail);
		mv.addObject("pi", pi);
		mv.addObject("eStatus", eStatus);
		mv.setViewName("mail/mailReceive");
		return mv;
	}

	// 메일 업데이트
	@RequestMapping("updateMail.do")
	public void updateMail(@RequestParam("mailNo") String mailNo, @RequestParam("eStatus") String eStatus,
			HttpServletResponse response) throws JsonIOException, IOException {
		Mail mail = new Mail();
		mail.setMailNo(Integer.parseInt(mailNo));
		mail.seteStatus(eStatus);

		int result = mService.updateMail(mail);

		if (result > 0) {
			Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
			gson.toJson(eStatus, response.getWriter());
		} else {
			throw new MailException("메일 상태 변경에 실패하였습니다.");
		}

	}

	// 메일 읽은시간 업데이트
	@RequestMapping("updateReadTime.do")
	@ResponseBody
	public String updateReadTime(@RequestParam("mailNo") String mailNo) {
		int result = mService.updateReadTime(mailNo);
		if (result > 0) {
			return "success";
		} else {
			throw new MailException("메일 읽은 시간 확인에 실패하였습니다.");
		}
	}
	
	//보낸 메일함
	@RequestMapping("mailSendView.do")
	public ModelAndView mailSendView(ModelAndView mv, HttpSession session,
									@RequestParam(value = "search", required = false) String search,
									@RequestParam(value = "page", required = false) Integer page,
									@RequestParam("eStatus") String eStatus,
									@RequestParam(value = "cate", required = false) String cate
									) {

		int currentPage = 1; // 임의로 지정
		if (page != null) {
			// 페이징 버튼을 눌러서 페이지값이 바뀔 경우
			currentPage = page;
		}

		// 페이징 공지사항
		int listCount = 0;

		// 검색 영역
		String searchKey = "%" + search + "%";
		if (search == null) {
			searchKey = "%%";
		}

		// 검색 및 카테고리 넘기는 HashMap
		HashMap<String, String> map = new HashMap<String, String>();
		Employee loginEmp = (Employee) session.getAttribute("loginEmp");
		map.put("searchKey", searchKey);
		map.put("cate", cate);
		map.put("eStatus", eStatus);
		map.put("empNo", loginEmp.getEmpNo());

		listCount = mService.SearchBListCount(map);
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		ArrayList<Mail> mail = mService.selectBSearchList(pi, map);
		for(Mail m : mail) {
			String str = m.getRecieveEmp();
			m.setRecieveEmpName(str.substring( str.indexOf(" ) ")+3,str.indexOf(" - ") ));
		}
		
		mv.addObject("cate", cate);
		mv.addObject("search", search);
		mv.addObject("mail", mail);
		mv.addObject("pi", pi);
		mv.addObject("eStatus", eStatus);
		
		
		mv.setViewName("mail/mailSendView");
		return mv;
	}
}
