package com.spring.finalproject.Employee.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.finalproject.Board.model.vo.PageInfo;
import com.spring.finalproject.Employee.model.vo.Employee;

@Repository("eDAO")
public class EmployeeDAO {
	@Autowired
	private SqlSessionTemplate sqlSession;

	public ArrayList<Employee> oSelectO() {
		return (ArrayList) sqlSession.selectList("empMapper.oSelectO");
	}

	public String selectDeptName(String deptNo) {
		/* return sqlSession.selectOne("empMapper.selectDeptName", deptNo); */
		String DeptName = sqlSession.selectOne("empMapper.selectDeptName", deptNo);
		if (DeptName == null) {
			DeptName = " ";
		}
		return DeptName;
	}

	public Employee selectEmp(Employee e) {
		return (Employee) sqlSession.selectOne("empMapper.selectEmp", e);
	}

	public int insertDept(HashMap<String, String> map) {
		return sqlSession.insert("empMapper.insertDept", map);
	}

	public String insertEmp(Employee e) {
		sqlSession.insert("empMapper.insertEmp", e);
		return sqlSession.selectOne("empMapper.selectNewEmp", e);
	}

	public int updateEmpPwd(Employee e) {
		return sqlSession.update("empMapper.updateEmpPwd", e);
	}

	public int selectListCount(String deptNo) {
		return sqlSession.selectOne("empMapper.selectListCount", deptNo);
	}

	public ArrayList<Employee> selectEmpList(PageInfo pi, String deptNo) {

		// RowBounds로 페이징 계산하기
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		// offset : 뛰어 넘을 값
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList) sqlSession.selectList("empMapper.selectEmpList", deptNo, rowBounds);
	}

	public int SearchListCount(String search) {
		return sqlSession.selectOne("empMapper.SearchListCount", search);
	}

	public ArrayList<Employee> selectSearchList(PageInfo pi, String search) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList) sqlSession.selectList("empMapper.selectSearchList", search, rowBounds);
	}

	public int updateEmp(Employee e) {
		return sqlSession.update("empMapper.updateEmp", e);
	}

	public int deleteEmp(String empNo) {
		return sqlSession.update("empMapper.deleteEmp", empNo);
	}

	public int changePwd(HashMap<String, String> map) {
		return sqlSession.update("empMapper.changePwd", map);
	}

	public ArrayList<Employee> getEmployee(String deptNo) {
		return (ArrayList)sqlSession.selectList("empMapper.getEmployee", deptNo);
	}

}
