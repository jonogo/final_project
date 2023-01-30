package com.kh.project.kwon.service;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.project.kwon.dao.QuestionSellerDao;
import com.kh.project.vo.PagingDto;
import com.kh.project.vo.QuestionVo;

@Service
public class QuestionSellerService {

	@Autowired
	QuestionSellerDao questionSellerDao;
	
	public int getQuestionCount(String seller_id) {
		return questionSellerDao.getQuestionCount(seller_id);
	}

	public List<QuestionVo> getQuestionListById(String seller_id, PagingDto pagingDto) {
		return questionSellerDao.getQuestionListById(seller_id, pagingDto);
	}

	public Timestamp updateAnswer(QuestionVo questionVo) {
		boolean result = questionSellerDao.updateAnswer(questionVo);
		if(result) {
			return questionSellerDao.selectAnswerRegdate(questionVo.getQ_no());
		}
		return null;
	}

	public int getNewQuestionCount(String seller_id) {
		return questionSellerDao.getNewQuestionCount(seller_id);
	}

	
	
}
