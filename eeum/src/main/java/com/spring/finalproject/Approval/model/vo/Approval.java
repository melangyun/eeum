package com.spring.finalproject.Approval.model.vo;

import java.sql.Date;

public class Approval {
	private String apNo;// 결제번호
	private String empNo;// 기안자 - 사번
	private String apTitle;// 제목
	private String apContent;// 내용
	private String approvalEmp;// 결재자
	private String approvalEmpstatus;// 결재여부 들어있는 String
	private String runEmp;// 시행자
	private String refEmp;// 참조자 - 수신자
	private String hEmp;// 합의자
	private String hEmpstatus;// 합의여부여부 들어있는 String
	private Date apDate;// 상신일
	private Date fiDate;// 결재일
	private Date dDate;// 마감일
	private String apStatus;//진행상태 --합의 거부일 때 R로 변경 N은 삭제, Y는 정상노출, D - 종결문서, R-중단문서
	private Date a_v_first;// 휴가 시작일
	private Date a_v_last;// 휴가 종료작일
	private String originalFile;// 첨부파일 원래이름
	private String renameFile;// 첨부파일변경이름

	public String getApNo() {
		return apNo;
	}

	public void setApNo(String apNo) {
		this.apNo = apNo;
	}

	public String getEmpNo() {
		return empNo;
	}

	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}

	public String getApTitle() {
		return apTitle;
	}

	public void setApTitle(String apTitle) {
		this.apTitle = apTitle;
	}

	public String getApContent() {
		return apContent;
	}

	public void setApContent(String apContent) {
		this.apContent = apContent;
	}

	public String getApprovalEmp() {
		return approvalEmp;
	}

	public void setApprovalEmp(String approvalEmp) {
		this.approvalEmp = approvalEmp;
	}

	public String getApprovalEmpstatus() {
		return approvalEmpstatus;
	}

	public void setApprovalEmpstatus(String approvalEmpstatus) {
		this.approvalEmpstatus = approvalEmpstatus;
	}

	public String getRunEmp() {
		return runEmp;
	}

	public void setRunEmp(String runEmp) {
		this.runEmp = runEmp;
	}

	public String getRefEmp() {
		return refEmp;
	}

	public void setRefEmp(String refEmp) {
		this.refEmp = refEmp;
	}

	public String gethEmp() {
		return hEmp;
	}

	public void sethEmp(String hEmp) {
		this.hEmp = hEmp;
	}

	public String gethEmpstatus() {
		return hEmpstatus;
	}

	public void sethEmpstatus(String hEmpstatus) {
		this.hEmpstatus = hEmpstatus;
	}

	public Date getApDate() {
		return apDate;
	}

	public void setApDate(Date apDate) {
		this.apDate = apDate;
	}

	public Date getFiDate() {
		return fiDate;
	}

	public void setFiDate(Date fiDate) {
		this.fiDate = fiDate;
	}

	public Date getdDate() {
		return dDate;
	}

	public void setdDate(Date dDate) {
		this.dDate = dDate;
	}

	public String getApStatus() {
		return apStatus;
	}

	public void setApStatus(String apStatus) {
		this.apStatus = apStatus;
	}

	public Date getA_v_first() {
		return a_v_first;
	}

	public void setA_v_first(Date a_v_first) {
		this.a_v_first = a_v_first;
	}

	public Date getA_v_last() {
		return a_v_last;
	}

	public void setA_v_last(Date a_v_last) {
		this.a_v_last = a_v_last;
	}

	public String getOriginalFile() {
		return originalFile;
	}

	public void setOriginalFile(String originalFile) {
		this.originalFile = originalFile;
	}

	public String getRenameFile() {
		return renameFile;
	}

	public void setRenameFile(String renameFile) {
		this.renameFile = renameFile;
	}

	public Approval() {
		super();
	}

	public Approval(String apNo, String empNo, String apTitle, String apContent, String approvalEmp,
			String approvalEmpstatus, String runEmp, String refEmp, String hEmp, String hEmpstatus, Date apDate,
			Date fiDate, Date dDate, String apStatus, Date a_v_first, Date a_v_last, String originalFile,
			String renameFile) {
		super();
		this.apNo = apNo;
		this.empNo = empNo;
		this.apTitle = apTitle;
		this.apContent = apContent;
		this.approvalEmp = approvalEmp;
		this.approvalEmpstatus = approvalEmpstatus;
		this.runEmp = runEmp;
		this.refEmp = refEmp;
		this.hEmp = hEmp;
		this.hEmpstatus = hEmpstatus;
		this.apDate = apDate;
		this.fiDate = fiDate;
		this.dDate = dDate;
		this.apStatus = apStatus;
		this.a_v_first = a_v_first;
		this.a_v_last = a_v_last;
		this.originalFile = originalFile;
		this.renameFile = renameFile;
	}

	@Override
	public String toString() {
		return "Approval [apNo=" + apNo + ", empNo=" + empNo + ", apTitle=" + apTitle + ", apContent=" + apContent
				+ ", approvalEmp=" + approvalEmp + ", approvalEmpstatus=" + approvalEmpstatus + ", runEmp=" + runEmp
				+ ", refEmp=" + refEmp + ", hEmp=" + hEmp + ", hEmpstatus=" + hEmpstatus + ", apDate=" + apDate
				+ ", fiDate=" + fiDate + ", dDate=" + dDate + ", apStatus=" + apStatus + ", a_v_first=" + a_v_first
				+ ", a_v_last=" + a_v_last + ", originalFile=" + originalFile + ", renameFile=" + renameFile + "]";
	}

}
