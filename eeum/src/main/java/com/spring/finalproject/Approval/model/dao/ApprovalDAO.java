package com.spring.finalproject.Approval.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.finalproject.Approval.model.vo.Approval;

@Repository("aDAO")
public class ApprovalDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	public int insertApproval(Approval ap) {
		return sqlSession.update("aMapper.insertApproval", ap);
	}

	public ArrayList<Approval> selectApprovalList(String empNo) {
		return (ArrayList)sqlSession.selectList("aMapper.selectApprovalList", empNo);
	}

	public Approval selectApprovalDetail(String apNo) {
		return (Approval)sqlSession.selectOne("aMapper.selectApprovalDetail", apNo);
	}

	public int updateAp(Approval ap) {
		return sqlSession.update("aMapper.updateAp", ap);
	}

	public ArrayList<Approval> selectApListByAr(String[] array) {
		return (ArrayList)sqlSession.selectList("aMapper.selectApListByAr",array);
	}

	public int deleteAp(String apNo) {
		return sqlSession.update("aMapper.deleteAp", apNo);
	}

	public ArrayList<Approval> selectDeptVacation(ArrayList<String> list) {
		return (ArrayList)sqlSession.selectList("aMapper.selectDeptVacation",list);
	}

}
