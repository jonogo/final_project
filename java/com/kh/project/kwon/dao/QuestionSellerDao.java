package com.kh.project.kwon.dao;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.project.vo.PagingDto;
import com.kh.project.vo.QuestionVo;

@Repository
public class QuestionSellerDao {
	private final String NAMESPACE = "mappers.qusetionseller.";
	
	@Autowired
	SqlSession sqlSession;

	public int getQuestionCount(String seller_id) {
		return sqlSession.selectOne(NAMESPACE + "getQuestionCount", seller_id);
	}

	public List<QuestionVo> getQuestionListById(String seller_id, PagingDto pagingDto) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("seller_id", seller_id);
		map.put("startRow", pagingDto.getStartRow());
		map.put("endRow", pagingDto.getEndRow());
		return sqlSession.selectList(NAMESPACE + "getQuestionListById", map);
	}

	public boolean updateAnswer(QuestionVo questionVo) {
		int count = sqlSession.update(NAMESPACE + "updateAnswer", questionVo);
		if(count > 0) {
			return true;
		}
		return false;
	}

	public Timestamp selectAnswerRegdate(int q_no) {
		return sqlSession.selectOne(NAMESPACE + "selectAnswerRegdate", q_no);
	}

	public int getNewQuestionCount(String seller_id) {
		return sqlSession.selectOne(NAMESPACE + "getNewQuestionCount", seller_id);
	}

}
