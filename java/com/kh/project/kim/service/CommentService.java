package com.kh.project.kim.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.project.kim.dao.CommentDao;
import com.kh.project.vo.BasketVo;
import com.kh.project.vo.CommentVo;

@Service
public class CommentService {

	@Autowired
	private CommentDao commentDao;

	@Transactional
	public boolean insertComment(CommentVo commentVo) {
		/*
		 * boardDao.updateCommentCnt(commentVo.getPro_no(), 1); // �뙎湲� 移댁슫�듃 利앷�
		 */// commentVo.setUserid(null);
		return commentDao.insertComment(commentVo); // �뙎湲� 異붽�
	}
	
	@Transactional
	public String insertBasket(BasketVo basketVo) {
		BasketVo checkBasket=commentDao.checkBasket(basketVo);
		System.out.println("체크:"+checkBasket);
		if(checkBasket==null) {
			System.out.println("인서트");
			commentDao.insertBasket(basketVo);
			return "insert";
		}
		System.out.println("업데이트");
		commentDao.updateBasket(basketVo);
		return "check";
	}

	public List<CommentVo> list(int pro_no) {
		return commentDao.list(pro_no);
	}

	// �뙎湲� �궘�젣
	@Transactional
	public boolean deleteComment(int cno, int pro_no) {
//		boardDao.updateCommentCnt(pro_no, -1);
		return commentDao.deleteComment(cno);
	}

	// �뙎湲� �닔�젙
	public boolean modifyComment(CommentVo commentVo) {
		return commentDao.modifyComment(commentVo);
	}
	public double getStarRatingByPro_no(int pro_no) {
		return commentDao.getStarRatingByPro_no(pro_no);
	}

}
