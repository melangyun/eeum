package com.spring.finalproject.Employee.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.spring.finalproject.Board.model.vo.PageInfo;
import com.spring.finalproject.Employee.model.vo.Employee;

public interface EmployeeService {

	Employee selectEmp(Employee e);

	ArrayList<Employee> oSelectO();

	String selectDeptName(String deptNo);

	int insertDept(HashMap<String, String> map);

	String insertEmp(Employee e);

	int updateEmpPwd(Employee e);

	int selectListCount(String deptNo);

	ArrayList<Employee> selectEmpList(PageInfo pi, String deptNo);

	int SearchListCount(String search);

	ArrayList<Employee> selectSearchList(PageInfo pi, String search);

	int updateEmp(Employee e);

	int deleteEmp(String empNo);

	int changePwd(HashMap<String, String> map);

	ArrayList<Employee> getEmployee(String deptNo);

	ArrayList<Employee> searchEmpList(String string);

	ArrayList<Employee> selectDeptEmp(String deptNo);







}
