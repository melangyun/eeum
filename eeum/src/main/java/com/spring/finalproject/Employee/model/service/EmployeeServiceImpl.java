package com.spring.finalproject.Employee.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.spring.finalproject.Board.model.vo.PageInfo;
import com.spring.finalproject.Employee.model.dao.EmployeeDAO;
import com.spring.finalproject.Employee.model.vo.Employee;

@Service("eService")
public class EmployeeServiceImpl implements EmployeeService{
	
	@Autowired EmployeeDAO eDAO;
	
	@Autowired
	private JavaMailSender mailSender;	
	
	@Override
	public Employee selectEmp(Employee e) {
		return eDAO.selectEmp(e);
	}

	@Override
	public ArrayList<Employee> oSelectO() {
		return eDAO.oSelectO();
	}

	@Override
	public String selectDeptName(String deptNo) {
		return eDAO.selectDeptName(deptNo);
	}

	@Override
	public int insertDept(HashMap<String, String> map) {
		return eDAO.insertDept(map);
	}

	@Override
	public String insertEmp(Employee e) {
		return eDAO.insertEmp(e);
	}

	@Override
	public int updateEmpPwd(Employee e) {
		return eDAO.updateEmpPwd(e);
	}

	@Override
	public int selectListCount(String deptNo) {
		return eDAO.selectListCount(deptNo);
	}

	@Override
	public ArrayList<Employee> selectEmpList(PageInfo pi,String deptNo) {
		return eDAO.selectEmpList(pi, deptNo);
	}

	@Override
	public int SearchListCount(String search) {
		return eDAO.SearchListCount(search);
	}

	@Override
	public ArrayList<Employee> selectSearchList(PageInfo pi, String search) {
		return eDAO.selectSearchList(pi, search);
	}

	@Override
	public int updateEmp(Employee e) {
		return eDAO.updateEmp(e);
	}

	@Override
	public int deleteEmp(String empNo) {
		return eDAO.deleteEmp(empNo);
	}

	@Override
	public int changePwd(HashMap<String, String> map) {
		return eDAO.changePwd(map);
	}

	@Override
	public ArrayList<Employee> getEmployee(String deptNo) {
		return eDAO.getEmployee(deptNo);
	}

	@Override
	public ArrayList<Employee> searchEmpList(String string) {
		return eDAO.searchEmpList(string);
	}


	
}
