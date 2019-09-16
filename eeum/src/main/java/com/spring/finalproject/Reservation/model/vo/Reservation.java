package com.spring.finalproject.Reservation.model.vo;

public class Reservation {
	private String rDate;
	private int mNo;
	private String mName;
	private String empNo;
	private String joinEmp;
	private String mTitle;
	private String mContnet;
	
	public String getrDate() {
		return rDate;
	}
	public void setrDate(String rDate) {
		this.rDate = rDate;
	}
	public int getmNo() {
		return mNo;
	}
	public void setmNo(int mNo) {
		this.mNo = mNo;
	}
	public String getmName() {
		return mName;
	}
	public void setmName(String mName) {
		this.mName = mName;
	}
	public String getEmpNo() {
		return empNo;
	}
	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}
	public String getJoinEmp() {
		return joinEmp;
	}
	public void setJoinEmp(String joinEmp) {
		this.joinEmp = joinEmp;
	}
	public String getmTitle() {
		return mTitle;
	}
	public void setmTitle(String mTitle) {
		this.mTitle = mTitle;
	}
	public String getmContnet() {
		return mContnet;
	}
	public void setmContnet(String mContnet) {
		this.mContnet = mContnet;
	}
	public Reservation(String rDate, int mNo, String mName, String empNo, String joinEmp, String mTitle,
			String mContnet) {
		super();
		this.rDate = rDate;
		this.mNo = mNo;
		this.mName = mName;
		this.empNo = empNo;
		this.joinEmp = joinEmp;
		this.mTitle = mTitle;
		this.mContnet = mContnet;
	}
	
	public Reservation() {
		super();
	}
	
	@Override
	public String toString() {
		return "Reservation [rDate=" + rDate + ", mNo=" + mNo + ", mName=" + mName + ", empNo=" + empNo + ", joinEmp="
				+ joinEmp + ", mTitle=" + mTitle + ", mContnet=" + mContnet + "]";
	}
	
	
	
}
