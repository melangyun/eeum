package com.spring.finalproject.Approval.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.finalproject.Approval.model.dao.ApprovalDAO;
import com.spring.finalproject.Approval.model.vo.Approval;

@Service("aService")
public class ApprovalServiceImp implements ApprovalService{
	@Autowired
	ApprovalDAO aDAO;

	@Override
	public int insertApproval(Approval ap) {
		return aDAO.insertApproval(ap);
	}

	@Override
	public ArrayList<Approval> selectApprovalList(String empNo) {
		return aDAO.selectApprovalList(empNo);
	}

	@Override
	public Approval selectApprovalDetail(String apNo) {
		return aDAO.selectApprovalDetail(apNo);
	}

	@Override
	public int updateAp(Approval ap) {
		return aDAO.updateAp(ap);
	}

	@Override
	public ArrayList<Approval> selectApListByAr(String[] array) {
		return aDAO.selectApListByAr(array);
	}

	@Override
	public int deleteAp(String apNo) {
		return aDAO.deleteAp(apNo);
	}

	@Override
	public ArrayList<Approval> selectDeptVacation(ArrayList<String> emp) {
		return aDAO.selectDeptVacation(emp);
	}
}
