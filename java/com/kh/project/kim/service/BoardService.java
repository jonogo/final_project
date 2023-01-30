package com.kh.project.kim.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.project.kim.dao.BoardDao;
import com.kh.project.vo.BoardPagingDto;
import com.kh.project.vo.ProductCountVo;
import com.kh.project.vo.ProductPicVo;
import com.kh.project.vo.ProductVo;

@Service
public class BoardService {

	@Autowired
	private BoardDao boardDao;

	public List<ProductVo> listArticle(BoardPagingDto boardPagingDto) {
		return boardDao.listArticle(boardPagingDto);
	}

	public List<ProductPicVo> list(int pro_no) {
		return boardDao.list(pro_no);
	}

	public List<ProductCountVo> pro_size_count(int pro_no) {
		return boardDao.pro_size_count(pro_no);
	}
	public ProductVo selectByPro_no(int pro_no) {
		return boardDao.selectByPro_no(pro_no);
	}

	public int getCount(BoardPagingDto boardPagingDto) {
		return boardDao.getCount(boardPagingDto);
	}

}
