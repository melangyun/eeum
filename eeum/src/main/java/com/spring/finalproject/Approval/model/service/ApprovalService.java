package com.spring.finalproject.Approval.model.service;

import java.util.ArrayList;

import com.spring.finalproject.Approval.model.vo.Approval;

public interface ApprovalService {

	int insertApproval(Approval ap);

	ArrayList<Approval> selectApprovalList(String empNo);

	Approval selectApprovalDetail(String apNo);

	int updateAp(Approval ap);

	ArrayList<Approval> selectApListByAr(String[] array);

	int deleteAp(String apNo);


}
