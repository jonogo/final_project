package com.kh.project.sjw.dao;


import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.project.vo.SellerVo;

@Repository
public class SellerDao_sjw {
	private final String NAMESPACE = "mappers.seller.";

	@Autowired
	private SqlSession sqlSession;
	//�Ǹ��� ���� dao
	public boolean seller_checkId(String seller_id) {
		SellerVo sellerVo=sqlSession.selectOne(NAMESPACE+"seller_checkId",seller_id);
		System.out.println(sellerVo);
		if(sellerVo==null) {
			return true;
		}
		return false;
	}
	
	public boolean seller_registerMember(SellerVo sellerVo) {
		int count=sqlSession.insert(NAMESPACE+"seller_registerMember",sellerVo);
		System.out.println("count:"+count);
		if(count>0) {
			return true;
		}
		return false;
	}
	
	public SellerVo seller_login(String seller_id, String seller_pw) {
		Map<String, String> map= new HashMap<>();
		map.put("seller_id", seller_id);
		map.put("seller_pw", seller_pw);
		SellerVo sellerVo=sqlSession.selectOne(NAMESPACE+"seller_login",map);
		return sellerVo;
	}
	
	// seller �̸��� ��� dao
	public boolean isExistMember(String seller_id, String seller_email) {
		Map<String, String> map=new HashMap<>();
		map.put("seller_id", seller_id);
		map.put("seller_email", seller_email);
		int count=sqlSession.selectOne(NAMESPACE+"isExistMember_seller",map);
		if(count>0) {
			return true;
		}
		return false;
	}
	
	public boolean updatePassword(String seller_id, String newPass) {
		Map<String, String> map= new HashMap<>();
		map.put("seller_id", seller_id);
		map.put("seller_pw", newPass);
		int count=sqlSession.update(NAMESPACE+"updatePassword_seller",map);
		if(count>0) {
			return true;
		}
		return false;
	}

	public SellerVo getSellerInfo(String seller_id) {
		return sqlSession.selectOne(NAMESPACE + "getSellerInfo", seller_id);
	}
}
