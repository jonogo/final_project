package com.kh.project.sjw.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.project.sjw.dao.SellerDao_sjw;
import com.kh.project.vo.SellerVo;

@Service
public class SellerService_sjw {
	
	@Autowired
	SellerDao_sjw sellerDao;
	//������ �α���, ȸ�� ����, �ߺ� ���̵� üũ
	public boolean seller_checkId(String seller_id) {
		return sellerDao.seller_checkId(seller_id);
	}
	public boolean seller_registerMember(SellerVo sellerVo) {
		return sellerDao.seller_registerMember(sellerVo);
	}
	public SellerVo seller_login(String seller_id, String seller_pw) {
		return sellerDao.seller_login(seller_id, seller_pw);
	}
	// ������ ��й�ȣ ã��
	public boolean isExistMember(String seller_id, String seller_email) {
		return sellerDao.isExistMember(seller_id, seller_email);
	}
	public boolean updatePassword_seller(String seller_id, String newPass) {
		return sellerDao.updatePassword(seller_id, newPass);
	}
	public SellerVo getSellerInfo(String seller_id) {
		return sellerDao.getSellerInfo(seller_id);
	}
}
