package com.spring.finalproject.Approval.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.spring.finalproject.Approval.model.service.ApprovalService;
import com.spring.finalproject.Approval.model.vo.Approval;
import com.spring.finalproject.Employee.model.service.EmployeeService;
import com.spring.finalproject.Employee.model.vo.Employee;

@Controller
public class ApprovalController {
	
	@Autowired
	ApprovalService aService;
	
	@Autowired
	private EmployeeService eService;
	
	@RequestMapping("approvalView.do")
	public ModelAndView approvalView(HttpSession session,ModelAndView mv) {
		Employee loginEmp = (Employee) session.getAttribute("loginEmp");
		//로그인유저 사번
		String loginempNo = loginEmp.getEmpNo();
		ArrayList<Approval> list = aService.selectApprovalList("%"+loginempNo+"%");
		
		//기안문서-내가 올린문서 중 진행중 혹은 상신중인 문서
		ArrayList<Approval> mlist = new ArrayList<Approval>();
		//기안문서인데 결제완료됨
		ArrayList<Approval> mflist = new ArrayList<Approval>();
		//기안문서인데 중지
		ArrayList<Approval> mrlist = new ArrayList<Approval>();
		
		//결재할문서 
		ArrayList<Approval> glist = new ArrayList<Approval>();
		//결재한문서 
		ArrayList<Approval> flist = new ArrayList<Approval>();
		//(중지)반려문서(결재거절)
		ArrayList<Approval> rlist = new ArrayList<Approval>();
		// 종결문서
		ArrayList<Approval> endlist = new ArrayList<Approval>();
		//시행문서
		ArrayList<Approval> slist = new ArrayList<Approval>();
		//참조문서
		ArrayList<Approval> clist = new ArrayList<Approval>();
		
		//각 list 기안번호(apNo)를 담을 map
		HashMap<String,ArrayList<String>> map = new HashMap<String,ArrayList<String>>();
		
		for(Approval ap : list) {
			ap.sethEmpstatus(ap.gethEmp());
			ap.setApprovalEmpstatus(ap.getApprovalEmp());
			if(ap.gethEmp()!=null) {
				ap.sethEmp(deleteStatus(ap.gethEmp()));
			}
			ap.setApprovalEmp(deleteStatus(ap.getApprovalEmp()));
			
			//출력용 기안자 만들기- 이름붙이기
			Employee e = new Employee();
			e.setEmpNo(ap.getEmpNo());
			e =eService.selectEmp(e);
			ap.setEmpNo("("+e.getEmpNo()+") "+e.getEmpName());
			if(ap.gethEmp()==null) {
				ap.sethEmp("");
			}
			if(ap.getRefEmp()==null) {
				ap.setRefEmp("");
			}
			if(ap.getRunEmp()==null) {
				ap.setRunEmp("");
			}
			
			
			
			//기안문서 - 로그인 empno와 기안자와 사번이 일치한다면 기안문서로
			if(ap.getEmpNo().contains(loginempNo)) {
				if(ap.getApStatus().contentEquals("R")) {
					//기안문서중 반려됨
					mrlist.add(ap);
					
				}else if(ap.getApStatus().contentEquals("D")) {
					//기안문서중 종결됨
					mflist.add(ap);
				}else {
					//진행중임
					mlist.add(ap);
				}
			//결재문서&& 합의문서
			}else if(ap.getApprovalEmp().contains(loginempNo)||(ap.gethEmp().contains(loginempNo))) {
				//1. 중지문서인가?
				if(ap.getApStatus().equals("R")) {
				//중지문서라면 중지문서에 넣음
					rlist.add(ap);
				}else if(ap.getApStatus().equals("D")){
				//2. 종결문서인가?
					endlist.add(ap);
				}else{
				//3. 진행 혹은 상신문서 일 때 내가 결재를 했는가?
					boolean check = false;
					check = checkFile(check,ap.getApprovalEmpstatus(),loginempNo);
					if(ap.gethEmpstatus()!=null) {
						check = checkFile(check,ap.gethEmpstatus(),loginempNo);
					}
					if(check) {
						//결재를 해줬다면 결재한 문서에 추가
						flist.add(ap);
					}else {
						//아직 안해줬다면 결재 할 문서에 추가
						glist.add(ap);
					}
				}
			//참조문서 - 참조자에 내 이름이 들어잇을때
			}else if(ap.getRefEmp().contains(loginempNo)) {
				clist.add(ap);
			//시행문서
			}else if(ap.getRunEmp().contains(loginempNo)) {
				slist.add(ap);
			}
		}
		
		//각 문서들 map에 담음
		map.put("m", putIntheMap(mlist));
		map.put("mf", putIntheMap(mflist));
		map.put("mr", putIntheMap(mrlist));
		map.put("g", putIntheMap(glist));
		map.put("f", putIntheMap(flist));
		map.put("r", putIntheMap(rlist));
		map.put("end", putIntheMap(endlist));
		map.put("s", putIntheMap(slist));
		map.put("c", putIntheMap(clist));
		
		
		mv.addObject("map",map);
		mv.addObject("mlist", mlist);//기안문서-내가 올린문서 중 진행중 혹은 상신중인 문서
		mv.addObject("mflist", mflist);//기안문서인데 결제완료됨
		mv.addObject("mrlist", mrlist);//기안문서인데 중지(반려됨)
		
		mv.addObject("glist", glist);//결재할 문서(합의, 결재 통합)
		mv.addObject("flist", flist);//결재한 문서(합의, 결재 통합)
		mv.addObject("rlist", rlist);//중지문서
		mv.addObject("endlist", endlist);//종결문서
		mv.addObject("slist", slist);//시행문서(내가 참조할 문서
		mv.addObject("clist", clist);//참조문서 (내가 시행자인 문서
		mv.setViewName("approval/approval");
		return mv;
	}
	
	//불러올때 결재, 합의의 경우 결제 상태로 따로 넘겨줌
	public String deleteStatus(String emp) {
		if(!emp.equals("") && emp.contains(";")) {
			String array1[] = emp.split(";");
			emp = "";
			for(int i = 0 ; i < array1.length ; i++) {
				String array2[] = array1[i].split(",");
				array1[i] = array2[0];
				if(i!= array1.length-1) {
					emp += array1[i]+", ";
				}else {
					emp += array1[i];
				}
			}
		}else{
			String array2[] = emp.split(",");
			emp = array2[0];
		}
		return emp;
	}
	
	//내가 결제를 해줬을까?
	public boolean checkFile(boolean check, String emp,String loginempNo) {
		//결재를 해줬다면 바로 종결
		if(!check) {
			if(emp.contains(";")) {
				String array[] = emp.split(";");
				for(int i = 0;  i < array.length ; i++) {
					String array2[] = array[i].split(",");
					if(array2[0].contains(loginempNo) && !array2[1].equals("N")) {
						//내 사번에, 승인 또는 거절을 했다면
						check = true;
					}
				}
			}else{
				String array2[] = emp.split(",");
				if(array2[0].contains(loginempNo) && !array2[1].equals("N")) {
					//내 사번에, 승인 또는 거절을 했다면
					check = true;
				}
			}
		}
		return check;
	}
	
	//맵에 담기위해 ApNo만 list로 만듬
	public ArrayList<String> putIntheMap(ArrayList<Approval> inputlist){
		ArrayList<String> outputlist = new ArrayList<String>();
		for(Approval ap : inputlist ) {
			outputlist.add(ap.getApNo());
		}
		return outputlist;
	}
	
	
	//사람고르는 페이지로 넘어감
	@RequestMapping("apporvalinsertView.do")
	public ModelAndView apporvalinsertView(ModelAndView mv, @RequestParam("tag")String tag) {
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
		mv.addObject("tag",tag);
		mv.setViewName("approval/approvalInsertView");
		return mv;
	}
	
	//기안할때 전역변수를 다음페이지로 넘겨줌
	@RequestMapping("nextPage.do")
	public ModelAndView apporvalWriteView(ModelAndView mv,
										 @RequestParam("hEmp")String hEmp,
										 @RequestParam("gEmp")String gEmp,
										 @RequestParam("cEmp")String cEmp,
										 @RequestParam("sEmp")String sEmp,
										 @RequestParam("tag")String tag) {
		hEmp =cuttingFun(hEmp);
		gEmp =cuttingFun(gEmp);
		cEmp =cuttingFun(cEmp);
		sEmp =cuttingFun(sEmp);
		
		mv.addObject("hEmp",hEmp);
		mv.addObject("gEmp",gEmp);
		mv.addObject("cEmp",cEmp);
		mv.addObject("sEmp",sEmp);
		mv.addObject("tag",tag);
		mv.setViewName("approval/approvalWrite");
		return mv;
	}
	
	//마지막 ', '구분자 없에는 메소드
	public String cuttingFun(String str) {
		if(!str.equals("")) {
			str=str.substring(0, str.length()-2);
		}
		return str;
	}
	
	// inserts
	@RequestMapping("insertApproval.do")
	@ResponseBody
	public ModelAndView insertApproval(@ModelAttribute Approval ap,ModelAndView mv,HttpSession session,
								 @RequestParam(value="uploadFile",required= false)MultipartFile uploadFile,
								HttpServletRequest request) {
		 
		ap.setApprovalEmp(insertMethod(ap.getApprovalEmp()));
		if(!ap.gethEmp().equals("")) {
			ap.sethEmp(insertMethod(ap.gethEmp()));
		}
		Employee loginEmp = (Employee) session.getAttribute("loginEmp");
		ap.setEmpNo(loginEmp.getEmpNo());
		
		if (uploadFile != null && !uploadFile.isEmpty()) {
			String renameFileName = saveFile(uploadFile, request);
			if (renameFileName != null) {
				ap.setOriginalFile(uploadFile.getOriginalFilename());
				ap.setRenameFile(renameFileName);
			}
		}
		aService.insertApproval(ap);
		
		mv.setViewName("redirect:approvalView.do");
		
		return mv;
	}
	
	//파일 rename
	public String saveFile(MultipartFile file,  HttpServletRequest request) {
		String root = request.getSession().getServletContext().getRealPath("resources");
		String savePath = root + "\\buploadFiles";

		File folder = new File(savePath);
		if (!folder.exists()) {// 지정한 경로에 파일이 없다면 만들어줭
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
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		return renameFileName;
	}
	
	//디비 보낼 때 결재 혹은 합의가 되지 않았음을 보내줌 - 기본 삽입이므로!
	public String insertMethod(String empStr) {
		String array[] = empStr.split(", ");
		empStr="";
		for(int i = 0 ; i < array.length; i++) {
			if(i != array.length-1) {
				empStr += array[i]+",N;";
			}else {
				empStr += array[i]+",N";
			}
		}
		return empStr;
	}
	
	//목록 페이지로 넘어감!
	@RequestMapping("aplist.do")
	public void apList(HttpServletResponse response,@RequestParam("map")String map) throws IOException {
		map = map.substring(1, map.length()-1);
		String array[] =map.split(", ");
		ArrayList<Approval> list = aService.selectApListByAr(array);
		
		for(Approval ap:list) {
			Employee e = new Employee();
			e.setEmpNo(ap.getEmpNo());
			e = eService.selectEmp(e);
			ap.setEmpNo("("+e.getEmpNo()+") "+e.getEmpName());
			
			ap.setEmpNo(URLEncoder.encode(ap.getEmpNo(),"utf-8"));
			ap.setApTitle(URLEncoder.encode(ap.getApTitle(),"utf-8"));
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		gson.toJson(list,response.getWriter());
	}

	
	@RequestMapping("apDetail.do")
	public ModelAndView apDetail(ModelAndView mv,
								 @RequestParam("apNo")String apNo,
								 @RequestParam("tag")String tag) {
		Approval ap = aService.selectApprovalDetail(apNo);
		//출력용 기안자 만들기- 이름붙이기
		Employee e = new Employee();
		e.setEmpNo(ap.getEmpNo());
		e = eService.selectEmp(e);
		ap.setEmpNo("("+e.getEmpNo()+") "+e.getEmpName());
		mv.addObject("ap",ap);
		mv.addObject("tag",tag);
		mv.setViewName("approval/approvalDetail");
		return mv;
	}
	@RequestMapping("updateAp.do")
	@ResponseBody
	public String updateAp(@RequestParam("apNo")String apNo,
						   @RequestParam("cate")String cate,
						   @RequestParam("agree")String agree,
						   @RequestParam("loginEmp")String loginEmp,
						   @RequestParam("status")String status,
						   @RequestParam("plusStatus")String plusStatus) {
		Approval ap = new Approval();
		ap.setApNo(apNo);
		if(agree.equals("R")) {
			ap.setApStatus("R");
		}else {
			ap.setApStatus("Y");
		}
		status = updateApMethod(loginEmp,status, agree);
		
		if(cate.equals("h")) {
			ap.sethEmp(status);
			ap.setApprovalEmp(plusStatus);
		}else if(cate.equals("g")) {
			ap.setApprovalEmp(status);
			ap.sethEmp(plusStatus);
		}
		
		if(!status.contains("N") && !plusStatus.contains("N") && !plusStatus.contains("R") && !status.contains("R")) {
			ap.setApStatus("D");
		}
		
		
		int result = aService.updateAp(ap);
		
		if(result>0) {
			return "success";
		}else {
			return "fail";
		}
		
	}
	
	public String updateApMethod(String loginEmp, String status,String agree) {
		String array[] = status.split(";");
		status="";
		for(int i = 0 ; i < array.length ; i++) {
			if(array[i].contains(loginEmp)) {
			String array2[] = array[i].split(",");
			 array[i]=array2[0]+","+agree;
			}
			status += array[i]+";";
			if(i==array.length-1) {
				status = status.substring ( 0 , status.length()-1 );
			}
		}
		return status;
	}
	
	@RequestMapping("deleteAp.do")
	@ResponseBody
	public String deleteAp(@RequestParam("apNo")String apNo) {
		int result = aService.deleteAp(apNo);
		if(result>0) {
			return "success";
		}else {
			return "fail";
		}
	}
	
	
}
