package com.spring.finalproject.Employee.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Random;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonIOException;
import com.spring.finalproject.Board.model.vo.PageInfo;
import com.spring.finalproject.Employee.model.exception.EmpException;
import com.spring.finalproject.Employee.model.service.EmployeeService;
import com.spring.finalproject.Employee.model.vo.Employee;
import com.spring.finalproject.common.Pagination;
import com.spring.finalproject.common.mail.MailUtils;

@SessionAttributes("loginEmp")
@Controller
public class EmployeeController {

	@Autowired
	private EmployeeService eService;

	// 암호화
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;

	// 로그
	private Logger logger = LoggerFactory.getLogger(EmployeeController.class);

	@Autowired
	private JavaMailSender mailSender;

	@RequestMapping("eeum.do")
	public String eeum() {
		return "common/login";
	}

	// 암호화 로그인
	@RequestMapping(value = "login.do", method = RequestMethod.POST,produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String empLogin(@RequestParam("empNo")String empNo,@RequestParam("password")String password, Model model) {
		Employee e = new Employee();
		empNo = empNo.trim();
		e.setEmpNo(empNo);
		e.setPassword(password);
		Employee loginEmp = eService.selectEmp(e);

		if (bcryptPasswordEncoder.matches(e.getPassword(), loginEmp.getPassword())) {
			model.addAttribute("loginEmp", loginEmp);
			if(empNo.equals(password)) {
				return "changePwd";
			}
			return loginEmp.getEmpName();
		} else {
			return "fail";
		}
	}

	// 로그아웃
	@RequestMapping("logout.do")
	public String logout(SessionStatus status) {
		status.setComplete();

		return "common/login";
	}

	// 인사관리 페이지 이동 -department 조회(신규사원 등록)
	@RequestMapping("newEmp.do")
	public ModelAndView newEmp(ModelAndView mv, @RequestParam(value = "empNo", required = false) String empNo)
			throws UnsupportedEncodingException {
		ArrayList<Employee> list = eService.oSelectO();
		ArrayList<Employee> deptlist = new ArrayList<Employee>();
		ArrayList<Employee> teamlist = new ArrayList<Employee>();

		for (Employee e : list) {

			String deptNo = e.getDeptNo();

			if (deptNo.length() == 2) {
				deptlist.add(e);
			} else if (deptNo.length() == 5 && !deptNo.equals("MMMMM")) {
				teamlist.add(e);
			}
		}
		mv.addObject("deptlist", deptlist);
		mv.addObject("teamlist", teamlist);
		mv.addObject("empNo", empNo);
		mv.setViewName("employee/newEmp");

		return mv;
	}

	// 신규 사원 등록 - 기본비밀번호 사원번호와 같음
	@RequestMapping(value = "insertNewEmp.do", method = RequestMethod.POST)
	public String insertNewEmp(@ModelAttribute Employee e, @RequestParam("address1") String address1,
			@RequestParam("address2") String address2, @RequestParam("address3") String address3,
			@RequestParam("address4") String address4) {

		String address = e.getAddress() + "|" + address1 + "|" + address2 + "|" + address3 + "|" + address4;
		e.setDeptNo(e.getDeptNo().replaceAll(" ", ""));
		e.setAddress(address);
		e.setPhone(e.getPhone().replace(',', '-'));
		e.setEmpphone(e.getEmpphone().replace(',', '-'));
		e.setEmail(e.getEmail().replace(',', '@'));

		String empNo = eService.insertEmp(e);

		e.setEmpNo(empNo);
		e.setPassword(bcryptPasswordEncoder.encode(empNo));
		// 암호화 비밀번호로 업데이트!
		int result = eService.updateEmpPwd(e);
		if (result > 0) {
			return "redirect:newEmp.do?empNo=" + empNo;
		} else {
			throw new EmpException("신규사원 등록에 실패하였습니다.");
		}
	}

	// 사원 관리
	@RequestMapping("manageEmp.do")
	public ModelAndView empManage(@RequestParam(value = "cate", required = false) String cate,
			@RequestParam(value = "page", required = false) Integer page,
			@RequestParam(value = "search", required = false) String search, ModelAndView mv) {
		// requried false -> 필수가 아니라는 뜻, required flase 가 없다면 기본값은 true.

		// 부서목록
		ArrayList<Employee> list = eService.oSelectO();
		ArrayList<Employee> deptlist = new ArrayList<Employee>();
		ArrayList<Employee> teamlist = new ArrayList<Employee>();

		for (Employee e : list) {

			String deptNo = e.getDeptNo();

			if (deptNo.length() == 2) {
				deptlist.add(e);
			} else if (deptNo.length() == 5 && !deptNo.equals("MMMMM")) {
				teamlist.add(e);
			}
		}

		// 사원목록 - 페이징 부분 포함
		int currentPage = 1;
		if (page != null) {
			currentPage = page;
		}

		int listCount = 0;
		// 선택 cate 에 따른 사원수 반환 - 없을 경우 동적쿼리로 조건없음, 전체조회!

		String searchKey = "%" + search + "%";
		if (search == null) {
			listCount = eService.selectListCount(cate);
		} else {
			listCount = eService.SearchListCount(searchKey);
		}

		ArrayList<Employee> empList = null;

		// pi로 선택 사원 리스트 가져오기
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);

		if (search == null) {
			empList = eService.selectEmpList(pi, cate);
		} else {
			empList = eService.selectSearchList(pi, searchKey);
		}

		mv.addObject("deptlist", deptlist);
		mv.addObject("teamlist", teamlist);
		mv.addObject("empList", empList);
		mv.addObject("pi", pi);
		mv.addObject("search", search);
		mv.setViewName("employee/manageEmp");

		return mv;
	}

	// 사원관리 - 수정페이지
	@RequestMapping("modifyEmp.do")
	public ModelAndView modifyEmp(ModelAndView mv, Employee emp) {
		ArrayList<Employee> list = eService.oSelectO();
		ArrayList<Employee> deptlist = new ArrayList<Employee>();
		ArrayList<Employee> teamlist = new ArrayList<Employee>();

		for (Employee e : list) {

			String deptNo = e.getDeptNo();

			if (deptNo.length() == 2) {
				deptlist.add(e);
			} else if (deptNo.length() == 5 && !deptNo.equals("MMMMM")) {
				teamlist.add(e);
			}
		}

		emp = eService.selectEmp(emp);
		mv.addObject("deptlist", deptlist);
		mv.addObject("teamlist", teamlist);
		mv.addObject("emp", emp);
		mv.setViewName("employee/modifyEmp");

		return mv;
	}

	// 사원관리 - 수정하기
	@RequestMapping("updateEmp.do")
	public String updateEmp(Employee e, @RequestParam("address1") String address1,
			@RequestParam("address2") String address2, @RequestParam("address3") String address3,
			@RequestParam("address4") String address4) {

		String address = e.getAddress() + "|" + address1 + "|" + address2 + "|" + address3 + "|" + address4;
		e.setDeptNo(e.getDeptNo().replaceAll(" ", ""));
		e.setAddress(address);
		e.setPhone(e.getPhone().replace(',', '-'));
		e.setEmpphone(e.getEmpphone().replace(',', '-'));
		e.setEmail(e.getEmail().replace(',', '@'));
		int result = eService.updateEmp(e);

		return "redirect:manageEmp.do?empNo=" + e.getEmpNo();
	}

	// 부서 추가
	@RequestMapping("addDept.do")
	@ResponseBody
	public String insertDept(@RequestParam("deptNo") String deptNo, @RequestParam("deptName") String deptName) {
		HashMap<String, String> map = new HashMap<String, String>();

		map.put("deptNo", deptNo);
		map.put("deptName", deptName);

		int result = eService.insertDept(map);

		if (result > 0) {
			return "success";
		} else {
			throw new EmpException("부서 추가에 실패하였습니다.");
		}

	}

	// 부서 조회
	@RequestMapping("selectDeptName.do")
	public void selectDeptName(@RequestParam("deptNo") String deptNo, HttpServletResponse response)
			throws JsonIOException, IOException {
		String deptName = eService.selectDeptName(deptNo);

		deptName = (URLEncoder.encode(deptName, "utf-8"));

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		gson.toJson(deptName, response.getWriter());
	}

	// 퇴사처리
	@RequestMapping(value = "deleteEmp.do", method = RequestMethod.GET)
	@ResponseBody
	public int deleteEmp(@RequestParam("empNo") String empNo) {
		return eService.deleteEmp(empNo);
	}

	@RequestMapping("organization.do")
	public ModelAndView organization(@RequestParam(value = "cate", required = false) String cate,
			@RequestParam(value = "page", required = false) Integer page,
			@RequestParam(value = "search", required = false) String search, ModelAndView mv) {

		// 부서목록
		ArrayList<Employee> list = eService.oSelectO();
		ArrayList<Employee> deptlist = new ArrayList<Employee>();
		ArrayList<Employee> teamlist = new ArrayList<Employee>();

		for (Employee e : list) {

			String deptNo = e.getDeptNo();

			if (deptNo.length() == 2) {
				deptlist.add(e);
			} else if (deptNo.length() == 5 && !deptNo.equals("MMMMM")) {
				teamlist.add(e);
			}
		}

		// 사원목록 - 페이징 부분 포함
		int currentPage = 1;
		if (page != null) {
			currentPage = page;
		}

		int listCount = 0;

		String searchKey = "%" + search + "%";
		if (search == null) {
			listCount = eService.selectListCount(cate);
		} else {
			listCount = eService.SearchListCount(searchKey);
		}

		ArrayList<Employee> empList = null;

		// pi로 선택 사원 리스트 가져오기
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);

		if (search == null) {
			empList = eService.selectEmpList(pi, cate);
		} else {
			empList = eService.selectSearchList(pi, searchKey);
		}

		mv.addObject("deptlist", deptlist);
		mv.addObject("teamlist", teamlist);
		mv.addObject("empList", empList);
		mv.addObject("pi", pi);
		mv.addObject("search", search);
		mv.setViewName("board/organization");

		return mv;
	}

	// 프로필관리화면
	@RequestMapping("profile.do")
	public String profile() {
		return "employee/profile";
	}

	// 비밀번호 등록
	@RequestMapping(value = "changePwd.do", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	@ResponseBody
	public String changePwd(@RequestParam("pwd") String pwd, @RequestParam("new_pwd1") String new_pwd1,
			HttpSession session) {
		Employee loginEmp = (Employee) session.getAttribute("loginEmp");

		if (bcryptPasswordEncoder.matches(pwd, loginEmp.getPassword())) {
			pwd = bcryptPasswordEncoder.encode(pwd);

			HashMap<String, String> map = new HashMap<String, String>();
			map.put("empNo", loginEmp.getEmpNo());
			map.put("pwd", pwd);

			int result = eService.changePwd(map);
			if (result > 0) {
				return "비밀번호가 성공적으로 변경되었습니다.";
			} else {
				throw new EmpException("비밀번호 변경에 실패하였습니다.");
			}
		} else {
			return "비밀번호가 틀렸습니다.";
		}

	}

	//부서로 사원 데려오기
	@RequestMapping(value = "getEmployee.do")
	public void getEmployee(HttpServletResponse response, @RequestParam("deptNo") String deptNo) throws IOException {
		ArrayList<Employee> eList = eService.getEmployee(deptNo);
		for (Employee e : eList) {
			e.setEmpName(URLEncoder.encode(e.getEmpName(), "utf-8"));
			e.setDeptName(URLEncoder.encode(e.getDeptName(), "utf-8"));
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		gson.toJson(eList, response.getWriter());
	}

	
	//메일 전송 전 사번 및 이메일 확인
	@RequestMapping("email.do")
	@ResponseBody
	public String email(@RequestParam("empNo")String empNo,@RequestParam("email")String email) {
		Employee e = new Employee();
		e.setEmpNo(empNo);
		e = eService.selectEmp(e);
		if(e==null) {
			return "empNo";
		}
		if(!e.getEmail().equals(email)) {
			return "email";
		}
		
		return e.getEmpName();
	}
	
	
	//stmp메일전송
	@RequestMapping(value = "sendrealEmail.do", method = RequestMethod.POST)
	@ResponseBody
	public String sendEmail(@RequestParam("email") String email, HttpServletRequest request) throws MessagingException, UnsupportedEncodingException {
		//임의의 키 생성
		String authkey = new TempKey().getKey(50, false);
		MailUtils sendMail = new MailUtils(mailSender);

		sendMail.setSubject("[eeum_groupWare] 비밀번호 초기화");
		sendMail.setText(new StringBuffer().append("<h1>[이메일 인증]</h1>")
				.append("<p>아래 인증번호를 입력하시면 이메일 인증이 완료됩니다.</p>")
				.append(authkey)
				.toString());
		sendMail.setFrom("eeum ", "admin");
		sendMail.setTo(email);
		sendMail.send();
		
		return authkey;
	}
	
	
	
	public class TempKey {
		private int size;	
		private boolean lowerCheck;
	    
	    public String getKey(int size, boolean lowerCheck) {
	        this.size = size;
	        this.lowerCheck = lowerCheck;
	        return init();
	    }
	    private String init() {
	        Random ran = new Random();
	        StringBuffer sb = new StringBuffer();
	        int num = 0;
	        do {
	            num = ran.nextInt(75) + 48;
	            
	            if((num >= 48 && num <= 57) || (num >= 65 && num <= 90) || (num >= 97 && num <= 122)) {
	                sb.append((char)num);
	            }else {
	                continue;
	            }
	        } while (sb.length() < size);
	        if(lowerCheck) {
	            return sb.toString().toLowerCase();
	        }
	        return sb.toString();
	    }
	}
	
	//비밀번호 초기화
	@RequestMapping(value="pwdReset.do", method = RequestMethod.POST)
	@ResponseBody
	public String pwdReset(@RequestParam("emp") String empNo) {
		
		HashMap<String, String> map = new HashMap<String, String>();
		String pwd = bcryptPasswordEncoder.encode(empNo);
		map.put("empNo", empNo);
		map.put("pwd", pwd);
		int result = eService.changePwd(map);
		if(result >0) {
			return "success";
		}else {
			return "fail";
		}
	}
	
	//사원 조회(search)
	@RequestMapping("searchEmpList.do")
	public void searchEmpList(HttpServletResponse response,
							 @RequestParam("search")String search) throws IOException {
		ArrayList<Employee>list = eService.searchEmpList("%"+search.trim()+"%");
		ArrayList<String> resultList = new ArrayList<>();
		for(Employee emp :list) {
			String str = URLEncoder.encode("( "+emp.getEmpNo()+" ) "+ emp.getEmpName() +" - "+emp.getDeptName() ,"utf-8");
			resultList.add(str);
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		gson.toJson(resultList,response.getWriter());
	}
}
