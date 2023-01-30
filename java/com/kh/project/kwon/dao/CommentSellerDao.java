package com.kh.project.kwon.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.project.vo.CommentVo;
import com.kh.project.vo.PagingDto;

@Repository
public class CommentSellerDao {
	private final String NAMESPACE = "mappers.comment.";
	
	@Autowired
	SqlSession sqlSession;

	public List<CommentVo> getCommentListBySellerId(String seller_id, PagingDto pagingDto) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("seller_id", seller_id);
		map.put("startRow", pagingDto.getStartRow());
		map.put("endRow", pagingDto.getEndRow());
		return sqlSession.selectList(
				NAMESPACE + "getCommentListBySellerId", map);
	}

	public int getCommentCount(String seller_id) {
		return sqlSession.selectOne(NAMESPACE + "getCommentCount", seller_id);
	}

	public List<CommentVo> getCommentListByPro_no(int pro_no) {
		return sqlSession.selectList(NAMESPACE + "getCommentListByPro_no", pro_no);
	}

	public double getStarRatingByPro_no(int pro_no) {
		return sqlSession.selectOne(NAMESPACE + "getStarRatingByPro_no", pro_no);
	}

}
