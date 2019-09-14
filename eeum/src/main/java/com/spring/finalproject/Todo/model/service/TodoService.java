package com.spring.finalproject.Todo.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.spring.finalproject.Todo.model.vo.Todo;

public interface TodoService {

	int insertTodo(Todo td);

	ArrayList<Todo> selectTodo(HashMap<String,String> map);

	 ArrayList<Todo> selectCountTotal(String empNo);

	 int selectWeek(String empNo);

	int updateTodo(Todo td);

}
