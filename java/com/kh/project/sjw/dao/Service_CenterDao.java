package com.kh.project.sjw.dao;


import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.project.vo.MemberVo;
import com.kh.project.vo.SellerVo;
import com.kh.project.vo.QuestionVo;

@Repository
public class Service_CenterDao implements Serializable{
	private final String NAMESPACE = "mappers.service_center.";

	@Autowired
	private SqlSession sqlSession;
	
	public boolean send_question(QuestionVo questionVo) {
		int count=sqlSession.insert(NAMESPACE+"send_question",questionVo);
		if(count>0) {
			return true;
		}
		return false;
	}
}
