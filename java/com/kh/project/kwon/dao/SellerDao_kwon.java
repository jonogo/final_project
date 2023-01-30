package com.kh.project.kwon.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.project.vo.SellerVo;

@Repository
public class SellerDao_kwon {
	private final String NAMESPACE = "mappers.seller.";
	
	@Autowired
	SqlSession sqlSession;

	public SellerVo getInfoById(String seller_id) {
		return sqlSession.selectOne(NAMESPACE + "getInfoById", seller_id);
	}

	public SellerVo getChangeInfoById(String seller_id) {
		return sqlSession.selectOne(NAMESPACE + "getChangeInfoById", seller_id);
	}

	public boolean nowPwCheck(String seller_id, String nowPw) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("seller_id", seller_id);
		map.put("nowPw", nowPw);
		int count = sqlSession.selectOne(NAMESPACE + "nowPwCheck", map);
		if(count > 0) {
			return true;
		}
		return false;
	}

	public boolean updateSellerInfo(SellerVo sellerVo) {
		int count = 
				sqlSession.update(NAMESPACE + "updateSellerInfo", sellerVo);
		if(count > 0) {
			return true;
		}
		return false;
	}

	public boolean updateSellerImg(String seller_pic, String seller_id) {
		Map<String, String> map = new HashMap<>();
		map.put("seller_pic", seller_pic);
		map.put("seller_id", seller_id);
		int count = sqlSession.update(NAMESPACE + "updateSellerImg", map);
		if(count > 0) {
			return true;
		}
		return false;
	}

}
