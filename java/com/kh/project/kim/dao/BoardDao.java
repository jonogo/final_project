package com.kh.project.kim.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.project.vo.BoardPagingDto;
import com.kh.project.vo.ProductCountVo;
import com.kh.project.vo.ProductPicVo;
import com.kh.project.vo.ProductVo;

@Repository
public class BoardDao {
	private final String NAMESPACE = "mappers.board.";

	@Autowired
	private SqlSession sqlSession;

	public List<ProductVo> listArticle(BoardPagingDto boardPagingDto) {
		return sqlSession.selectList(NAMESPACE + "listArticle", boardPagingDto);
	}

	public List<ProductPicVo> list(int pro_no) {
		return sqlSession.selectList(NAMESPACE + "Propics", pro_no);
	}

	public ProductVo selectByPro_no(int pro_no) {
		ProductVo productVo = sqlSession.selectOne(NAMESPACE + "selectByPro_no", pro_no);
		return productVo;
	}

	public int getCount(BoardPagingDto boardPagingDto) {
		return sqlSession.selectOne(NAMESPACE + "getCount", boardPagingDto); 
	}
	public List<ProductCountVo> pro_size_count(int pro_no) {
		List<ProductCountVo> productCountVo = sqlSession.selectList(NAMESPACE + "pro_size_count",pro_no);
		return productCountVo;
	}

}