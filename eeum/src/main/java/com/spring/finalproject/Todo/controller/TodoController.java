package com.spring.finalproject.Todo.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.finalproject.Employee.model.vo.Employee;
import com.spring.finalproject.Todo.model.exception.TodoException;
import com.spring.finalproject.Todo.model.service.TodoService;
import com.spring.finalproject.Todo.model.vo.Todo;

@Controller
public class TodoController {

	@Autowired
	private TodoService tService;

	// toDo Page로 이동!
	@RequestMapping("todoView.do")
	public ModelAndView todoView(ModelAndView mv, HttpSession session,
			@RequestParam(value = "search", required = false) String search) {
		Employee loginEmp = (Employee) session.getAttribute("loginEmp");
		String empNo = loginEmp.getEmpNo();
		String searchKey = "%%";

		// 상단부 띄우는 부분
		// 총갯수
		ArrayList<Todo> totalList = tService.selectCountTotal(empNo);
		int total = totalList.size();
		int undo = 0;
		int done = 0;
		for (Todo td : totalList) {
			if (td.gettDone() == null) {
				undo++;
			} else {
				done++;
			}
		}

		// 작엽률 구해야지........왜넣었을까..?
		int percent = tService.selectWeek(empNo);
		if (percent > 100) {
			percent = 100;
		}

		// list가져오는 부분
		if (search != null) {
			searchKey = "%" + search + "%";
		}
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("searchKey", searchKey);
		map.put("empNo", empNo);

		ArrayList<Todo> list = tService.selectTodo(map);
		ArrayList<Todo> undoList = new ArrayList<Todo>();
		ArrayList<Todo> doneList = new ArrayList<Todo>();

		for (Todo td : list) {
			if (td.gettStatus().equals("Y")) {
				undoList.add(td);
			} else {
				doneList.add(td);
			}
		}

		mv.addObject("total", total);
		mv.addObject("undo", undo);
		mv.addObject("done", done);
		mv.addObject("percent", percent);
		mv.addObject("doneList", doneList);
		mv.addObject("undoList", undoList);
		mv.setViewName("board/to-do");
		return mv;
	}

	@RequestMapping("insertTodo.do")
	@ResponseBody
	public int insertTodo(@RequestParam("empNo") String empNo, @RequestParam("tImport") String tImport,
			@RequestParam("tTitle") String tTitle, @RequestParam("tContent") String tContent) {
		Todo td = new Todo();
		td.setEmpNo(empNo);
		td.settImport(tImport);
		td.settTitle(tTitle);
		td.settContent(tContent);

		int tno = tService.insertTodo(td);

		return tno;

	}

	@RequestMapping("updateTodo.do")
	@ResponseBody
	public String updateTodo(@RequestParam("tNo") Integer tNo, @RequestParam("tStatus") String tStatus) {
		Todo td = new Todo();
		td.settNo(tNo);
		td.settStatus(tStatus);

		int result = tService.updateTodo(td);

		if (result > 0) {
			return "success";
		} else {
			throw new TodoException("할일 업데이트에 실패하였습니다.");
		}
	}
}
