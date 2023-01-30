package com.kh.project.kim.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.project.vo.BasketVo;
import com.kh.project.vo.CommentVo;

@Repository
public class CommentDao {
	private final String NAMESPACE = "mappers.comment.";

	@Autowired
	private SqlSession sqlSession;

	public boolean insertComment(CommentVo commentVo) {
		int count = sqlSession.insert(NAMESPACE + "insertComment", commentVo);
		if (count > 0) {
			return true;
		}
		return false;
	}

	public boolean insertBasket(BasketVo basketVo) {
		int count = sqlSession.insert(NAMESPACE + "insertBasket", basketVo);
		if (count > 0) {
			return true;
		}
		return false;
	}
	public boolean updateBasket(BasketVo basketVo) {
		int count = sqlSession.update(NAMESPACE+"updateBasket",basketVo);
		if(count>0) {
			return true;
		}
		return false;
	}
	public BasketVo checkBasket(BasketVo basketVo) {
		BasketVo count = sqlSession.selectOne(NAMESPACE+"checkBasket",basketVo);
		return count;
	}
	
	
	

	public List<CommentVo> list(int pro_no) {
		return sqlSession.selectList(NAMESPACE + "list", pro_no);
	}

	// �뙎湲� �궘�젣
	public boolean deleteComment(int cno) {
		int count = sqlSession.delete(NAMESPACE + "deleteComment", cno);
		if (count > 0) {
			return true;
		}
		return false;
	}

	// �뙎湲� �닔�젙
	public boolean modifyComment(CommentVo commentVo) {
		int count = sqlSession.update(NAMESPACE + "modifyComment", commentVo);
		if (count > 0) {
			return true;
		}
		return false;
	}
	public double getStarRatingByPro_no(int pro_no) {
		return sqlSession.selectOne(NAMESPACE + "getStarRatingByPro_no",pro_no);
	}

}
