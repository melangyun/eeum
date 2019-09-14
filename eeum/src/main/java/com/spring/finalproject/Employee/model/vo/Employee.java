package com.spring.finalproject.Employee.model.vo;

import java.sql.Date;

public class Employee {
	private String empNo;//사번
	private String empName;//성명
	private String deptNo;//부서코드
	private String deptName;//부서명 - emp테이블에 없음 데려오려면 조인 잊지말자
	private String empPosition;//직급
	private Date joinDate;//입사일
	private String phone;//개인번호
	private String empphone;//내선번호
	private String email;//이메일
	private String address;//주소
	private String password;//비밀번호
	//권한 및 상태 필드 없음
	
	
	@Override
	public String toString() {
		return "Employee [empNo=" + empNo + ", empName=" + empName + ", deptNo=" + deptNo + ", deptName=" + deptName
				+ ", empPosition=" + empPosition + ", joinDate=" + joinDate + ", phone=" + phone + ", empphone="
				+ empphone + ", email=" + email + ", address=" + address + ", password=" + password + "]";
	}


	public Employee() {
		super();
	}


	public Employee(String empNo, String empName, String deptNo, String deptName, String empPosition, Date joinDate,
			String phone, String empphone, String email, String address, String password) {
		super();
		this.empNo = empNo;
		this.empName = empName;
		this.deptNo = deptNo;
		this.deptName = deptName;
		this.empPosition = empPosition;
		this.joinDate = joinDate;
		this.phone = phone;
		this.empphone = empphone;
		this.email = email;
		this.address = address;
		this.password = password;
	}


	public String getEmpNo() {
		return empNo;
	}


	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}


	public String getEmpName() {
		return empName;
	}


	public void setEmpName(String empName) {
		this.empName = empName;
	}


	public String getDeptNo() {
		return deptNo;
	}


	public void setDeptNo(String deptNo) {
		this.deptNo = deptNo;
	}


	public String getDeptName() {
		return deptName;
	}


	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}


	public String getEmpPosition() {
		return empPosition;
	}


	public void setEmpPosition(String empPosition) {
		this.empPosition = empPosition;
	}


	public Date getJoinDate() {
		return joinDate;
	}


	public void setJoinDate(Date joinDate) {
		this.joinDate = joinDate;
	}


	public String getPhone() {
		return phone;
	}


	public void setPhone(String phone) {
		this.phone = phone;
	}


	public String getEmpphone() {
		return empphone;
	}


	public void setEmpphone(String empphone) {
		this.empphone = empphone;
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public String getAddress() {
		return address;
	}


	public void setAddress(String address) {
		this.address = address;
	}


	public String getPassword() {
		return password;
	}


	public void setPassword(String password) {
		this.password = password;
	}
	
}
