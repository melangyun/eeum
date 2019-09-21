package com.spring.finalproject.Board.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.spring.finalproject.Approval.model.service.ApprovalService;
import com.spring.finalproject.Approval.model.vo.Approval;
import com.spring.finalproject.Board.model.exception.BoardException;
import com.spring.finalproject.Board.model.service.BoardService;
import com.spring.finalproject.Board.model.vo.Board;
import com.spring.finalproject.Board.model.vo.PageInfo;
import com.spring.finalproject.Board.model.vo.UCalendar;
import com.spring.finalproject.Employee.model.service.EmployeeService;
import com.spring.finalproject.Employee.model.vo.Employee;
import com.spring.finalproject.Reservation.model.service.ReservationService;
import com.spring.finalproject.Reservation.model.vo.Reservation;
import com.spring.finalproject.common.Pagination;

@Controller
@SessionAttributes("loginEmp")
public class BoardController {

	@Autowired
	BoardService bService;
	
	@Autowired
	ReservationService rService;
	
	@Autowired
	private EmployeeService eService;
	
	@Autowired
	ApprovalService aService;

	@RequestMapping("notice.do")
	public ModelAndView noticeView(
									@RequestParam(value="search", required=false)String search,
									@RequestParam(value = "page", required = false) Integer page,
									@RequestParam(value="cate", required =false)String cate,
									ModelAndView mv) {
		int currentPage = 1; // 임의로 지정
		if (page != null) {
			// 페이징 버튼을 눌러서 페이지값이 바뀔 경우
			currentPage = page;
		}
		//전체 공지사항
		ArrayList<Board> important = bService.iSelectList();
		
		//페이징 공지사항
		int listCount = 0;
		
		
		//검색 영역
		String searchKey = "%" + search + "%";
		if(search == null){searchKey = "%%";}

		//검색 및 카테고리 넘기는 HashMap
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("searchKey", searchKey);
		map.put("cate",cate);
		
		if (search == null && cate ==null) {
			listCount = bService.getBListCount();
		} else {
			listCount = bService.SearchListCount(map);
		}
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);

		// pi로 유효한 페이지 가져오기
		ArrayList<Board> normal = new ArrayList<Board>();
		
		if (search == null) {
			normal = bService.bSelectList(pi);
		} else {
			normal = bService.selectSearchList(pi, map);
		}
		mv.addObject("cate",cate );
		mv.addObject("search",search);
		mv.addObject("important",important);
		mv.addObject("normal",normal);
		mv.addObject("pi", pi);
		mv.setViewName("board/board");
		return mv;
	}
	
	//글쓰기페이지로 이동
	@RequestMapping("bInsert.do")
	public String bInsertView() {
		return "board/boardInsert";
	}

	
	//사진 경로 변경 및 이름 가져오기
	@RequestMapping("getchagePhoto.do")
	@ResponseBody
	public String savePhoto(MultipartFile file, HttpServletRequest request) {
		String root = request.getSession().getServletContext().getRealPath("resources");
		String savePath = root + "\\buploadFiles";

		File folder = new File(savePath);
		if (!folder.exists()) {
			folder.mkdirs();
		}
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String originalFileName = file.getOriginalFilename();
		String renameFileName = sdf.format(new java.sql.Date(System.currentTimeMillis())) + "."
				+ originalFileName.substring(originalFileName.lastIndexOf(".") + 1);
		// 확장자 빼고

		String renamePath = folder + "\\" + renameFileName;
		try {
			file.transferTo(new File(renamePath));// 전달받은 file이 rename명으로 저장
		} catch (IOException e) {
			e.printStackTrace();
		}

		return renameFileName;
	}
	
	//글삽입
	@RequestMapping("boardinsert.do")
	public String boardInsert(Board b, HttpSession session) {
		Employee loginEmp = (Employee)session.getAttribute("loginEmp");
		b.setEmpNo(loginEmp.getEmpNo());
		int result = bService.boardInsert(b);
		if(result>0) {
			return "redirect:notice.do";
		}else {
			throw new BoardException("게시글 등록에 실패하였습니다.");
		}
	}
	
	//글보기
	@RequestMapping("bdetail.do")
	public ModelAndView boardDetail(@RequestParam("bNo") int bNo, @RequestParam("page") int page, ModelAndView mv) {
		int result = bService.addBoardCount(bNo);
		Board board = bService.selectBoard(bNo);
		if(board!=null && result>0) {
		mv.addObject("board",board).addObject("page",page).setViewName("board/boardDetail");
		}else {
			throw new BoardException("게시글 조회에 실패하였습니다.");
		}
		return mv;
	}
	
	//강조공지로 바꾸기(update)
	@RequestMapping("changeType.do")
	@ResponseBody
	public String changebType(Board b) {
		if(b.getbType().equals("I")) {
			b.setbType("B");
		}else {
			b.setbType("I");
		}
		int result = bService.changebType(b);
		if(result>0) {
		return b.getbType();
		}else {
			throw new BoardException("공지 상태 변경에 실패하였습니다.");
		}
	}
	
	//글수정 페이지로 이동
	@RequestMapping("bUpdateView.do")
	public ModelAndView bUpdateView(@RequestParam("bNo")String bNo, @RequestParam("page")int page,ModelAndView mv) {
		int no = Integer.parseInt(bNo);
		Board board = bService.selectBoard(no);
		if(board!=null) {
			mv.addObject("board",board).addObject("page",page).setViewName("board/boardUpdate");
		}else {
			throw new BoardException("게시글 수 정 페이지 이동에 실패하였습니다.");
		}
		
		return mv;
	}
	
	//글수정
	@RequestMapping("bUpdate.do")
	public String boardUpdat(Board b,@RequestParam("page")int page ) {
		int result = bService.boardUpdat(b);
		if(result>0) {
			return "redirect:notice.do?page="+page;
		}else {
			throw new BoardException("게시글 수정에 실패하였습니다.");
		}
	}
	
	//글 삭제
	@RequestMapping("bDelete.do")
	@ResponseBody
	public String deleteBoard(@RequestParam("bNo")String bNo) {
		int no = Integer.parseInt(bNo);
		int result = bService.deleteBoard(no);
		if(result>0) {
		return "success";
		}else {
			throw new BoardException("게시글 삭제에 실패하였습니다.");
		}
	}
	
	@RequestMapping("calPage.do")
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
		
		mv.setViewName("board/calender");
		return mv;
	}
	
	@RequestMapping("cinsert.do")
	@ResponseBody
	public String cinsert(HttpSession session,
						  @RequestParam("empNo")String empNo,
						  @RequestParam("cDate")String cDate,
						  @RequestParam("cStatus")String cStatus,
						  @RequestParam("cTitle")String cTitle,
						  @RequestParam("sEmp")String sEmp,
						  @RequestParam("cFDate")String cFDate) {
		UCalendar c = new UCalendar();
		c.setEmpNo(empNo);
		c.setcDate(cDate);
		c.setcStatus(cStatus);
		c.setcTitle(cTitle);
		c.setsEmp(sEmp);
		c.setcFDate(cFDate);
		
		
		/************************알람 insert*******************************/
		if(!sEmp.equals("")) {
			Employee loginEmp = (Employee) session.getAttribute("loginEmp");
			HashMap<String,Object> map = new HashMap<>();
			String[] temp = cDate.split("-");
			map.put("aContents", loginEmp.getEmpName()+"님이 "+temp[1]+"/"+temp[2]+" 일새로운 일정을 공유했습니다.");
			map.put("aCate", "cal");

			
			ArrayList<String> emp = new ArrayList<>();
			String cutSEmp = sEmp.substring(0, sEmp.length()-1);
			if(cutSEmp.contains(";")) {
				String[] tempEmp = cutSEmp.split(";");
				for(int i = 0 ; i < tempEmp.length ; i++) {
					emp.add(tempEmp[i].substring(tempEmp[i].indexOf("(")+2, tempEmp[i].indexOf(")")-1));
				}
			}else {
				emp.add(cutSEmp.substring(cutSEmp.indexOf("(")+1,cutSEmp.indexOf(")")));
			}
			map.put("emp", emp);
			
			
			eService.insertAlert(map);
		}
		
		int result = bService.cinsert(c);
		if(result>0) {
			return "success";
		}else {
			return "fail";
		}
	}
	
	@RequestMapping("cUpdate.do")
	@ResponseBody
	public String cUpdate(@RequestParam("cate")String cate,@RequestParam("id")String id,HttpSession session) {
		//id로 db에서 전체 켈린더 일정을 가져옴!
		UCalendar c = bService.selectOneC(Integer.parseInt(id));
		
		//개인일정이거나, 전체 공유일정일 때 삭제함
		if(cate.equals("m")||cate.equals("a")) {
			c.setcStatus("N");
		}else {
		//공유된 일정일 경우 내 이름을 지움
			Employee loginEmp = (Employee)session.getAttribute("loginEmp");
			String myEmp = loginEmp.getEmpNo();
			
			String sEmp = c.getsEmp().substring(0, c.getsEmp().length()-1);
			if(sEmp.contains(";")) {
				String[] temp = sEmp.split(";");
				sEmp="";
				for(int i = 0 ; i < temp.length ; i++) {
					if(!temp[i].contains(myEmp)) {
						sEmp+=temp[i]+";";
					}
				}
			}else {
				sEmp="";
			}
			c.setsEmp(sEmp);
		}
		
		int result = bService.cUpdate(c);
		if(result>0) {
			return "success";
		}else {
			return "fail";
		}
		
	}
	
}
