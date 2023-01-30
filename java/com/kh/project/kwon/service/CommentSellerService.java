package com.kh.project.kwon.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.project.kwon.dao.CommentSellerDao;
import com.kh.project.vo.CommentVo;
import com.kh.project.vo.PagingDto;

@Service
public class CommentSellerService {

	@Autowired
	CommentSellerDao commentSellerDao;

	public int getCommentCount(String seller_id) {
		return commentSellerDao.getCommentCount(seller_id);
	}
	
	public List<CommentVo> getCommentListBySellerId(String seller_id, PagingDto pagingDto) {
		return commentSellerDao.getCommentListBySellerId(seller_id, pagingDto);
	}

	
	
}
