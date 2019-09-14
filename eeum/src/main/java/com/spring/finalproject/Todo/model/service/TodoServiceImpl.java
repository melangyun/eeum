package com.spring.finalproject.Todo.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.finalproject.Todo.model.dao.TodoDAO;
import com.spring.finalproject.Todo.model.vo.Todo;

@Service("tService")
public class TodoServiceImpl implements TodoService{
	@Autowired TodoDAO tDAO;

	@Override
	public int insertTodo(Todo td) {
		return tDAO.insertTodo(td);
	}

	@Override
	public ArrayList<Todo> selectTodo(HashMap<String,String> map) {
		return tDAO.selectTodo(map);
	}

	@Override
	public ArrayList<Todo> selectCountTotal(String empNo) {
		return tDAO.selectCountTotal(empNo);
	}

	@Override
	public int selectWeek(String empNo) {
		return tDAO.selectWeek(empNo);
	}

	@Override
	public int updateTodo(Todo td) {
		return tDAO.updateTodo(td);
	}
}
