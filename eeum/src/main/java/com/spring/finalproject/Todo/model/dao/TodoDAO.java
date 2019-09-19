package com.spring.finalproject.Todo.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.finalproject.Todo.model.vo.Todo;

@Repository("tDAO")
public class TodoDAO {
	@Autowired
	private SqlSessionTemplate sqlSession;

	public int insertTodo(Todo td) {
		sqlSession.insert("tMapper.insertTodo", td);
		return sqlSession.selectOne("tMapper.selectTNo", td);
	}

	public ArrayList<Todo> selectTodo(HashMap<String,String> map) {
		return (ArrayList)sqlSession.selectList("tMapper.selectTodo",map);
	}

	public ArrayList<Todo> selectCountTotal(String empNo) {
		return (ArrayList)sqlSession.selectList("tMapper.selectCountTotal", empNo);
	}

	public int selectWeek(String empNo) {
		int Registration = sqlSession.selectOne("tMapper.selectRegistration", empNo);
		int doneCount = sqlSession.selectOne("tMapper.selectDone", empNo);
		
		int result =0;
		if(Registration!=0) {
			result = (int) (((double)doneCount/Registration)*100);
		}
		
		return result;
	}

	public int updateTodo(Todo td) {
		return sqlSession.update("tMapper.updateTodo", td);
	}

	public ArrayList<Todo> selectAllUndo(String empNo) {
		return (ArrayList)sqlSession.selectList("tMapper.selectAllUndo",empNo);
	}

}
