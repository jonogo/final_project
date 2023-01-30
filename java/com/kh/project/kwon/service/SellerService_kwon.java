package com.kh.project.kwon.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.project.kwon.dao.SellerDao_kwon;
import com.kh.project.vo.SellerVo;

@Service
public class SellerService_kwon {
	
	@Autowired
	SellerDao_kwon sellerDao;
	
	public SellerVo getChangeInfoById(String seller_id) {
		return sellerDao.getChangeInfoById(seller_id);
	}

	public boolean nowPwCheck(String seller_id, String nowPw) {
		return sellerDao.nowPwCheck(seller_id, nowPw);
	}

	public boolean updateSellerInfo(SellerVo sellerVo) {
		return sellerDao.updateSellerInfo(sellerVo);
	}

	public SellerVo getInfoById(String seller_id) {
		return sellerDao.getInfoById(seller_id);
	}

	public boolean updateSellerImg(String seller_pic, String seller_id) {
		return sellerDao.updateSellerImg(seller_pic, seller_id);
	}

}
