package com.kh.project.sjw.dao;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.project.vo.MemberVo;

@Repository
public class MemberDao {
	private final String NAMESPACE = "mappers.member.";

	@Autowired
	private SqlSession sqlSession;
	//占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙 dao
	public boolean checkId(String userid) {
		MemberVo memberVo=sqlSession.selectOne(NAMESPACE+"checkId",userid);
		System.out.println(memberVo);
		if(memberVo==null) {
			return true;
		}
		return false;
	}
	
	public boolean registerMember(MemberVo memberVo) {
		int count=sqlSession.insert(NAMESPACE+"registerMember",memberVo);
		if(count>0) {
			return true;
		}
		return false;
	}
	
	public MemberVo login(String userid, String userpw) {
		Map<String, String> map= new HashMap<>();
		map.put("userid", userid);
		map.put("userpw", userpw);
		MemberVo memberVo=sqlSession.selectOne(NAMESPACE+"login",map);
		return memberVo;
	}
	//占실몌옙占쏙옙 占쏙옙占쏙옙 dao
	public boolean seller_checkId(String userid) {
		MemberVo memberVo=sqlSession.selectOne(NAMESPACE+"checkId",userid);
		System.out.println(memberVo);
		if(memberVo==null) {
			return true;
		}
		return false;
	}
	
	public boolean seller_registerMember(MemberVo memberVo) {
		int count=sqlSession.insert(NAMESPACE+"registerMember",memberVo);
		if(count>0) {
			return true;
		}
		return false;
	}
	
	public MemberVo seller_login(String userid, String userpw) {
		Map<String, String> map= new HashMap<>();
		map.put("userid", userid);
		map.put("userpw", userpw);
		MemberVo memberVo=sqlSession.selectOne(NAMESPACE+"login",map);
		return memberVo;
	}
	
	// seller 占싱몌옙占쏙옙 占쏙옙占� dao
	public boolean isExistMember_customer(String userid, String email) {
		Map<String, String> map=new HashMap<>();
		map.put("userid", userid);
		map.put("email", email);
		int count=sqlSession.selectOne(NAMESPACE+"isExistMember_customer",map);
		if(count>0) {
			return true;
		}
		return false;
	}
	
	public boolean updatePassword_customer(String userid, String newPass) {
		Map<String, String> map= new HashMap<>();
		map.put("userid", userid);
		map.put("userpw", newPass);
		int count=sqlSession.update(NAMESPACE+"updatePassword_customer",map);
		if(count>0) {
			return true;
		}
		return false;
	}
	
	// customer 占싱몌옙占쏙옙 占쏙옙占� dao
	public boolean isExistMember_seller(String seller_id, String seller_email) {
		Map<String, String> map=new HashMap<>();
		map.put("seller_id", seller_id);
		map.put("seller_email", seller_email);
		int count=sqlSession.selectOne(NAMESPACE+"isExistMember_seller",map);
		if(count>0) {
			return true;
		}
		return false;
	}
	
	public boolean updatePassword_seller(String userid, String newPass) {
		Map<String, String> map= new HashMap<>();
		map.put("userid", userid);
		map.put("userpw", newPass);
		int count=sqlSession.update(NAMESPACE+"updatePassword",map);
		if(count>0) {
			return true;
		}
		return false;
	}
	
	public List<MemberVo> getMemberList(String userid) {
		List<MemberVo> list =  sqlSession.selectList(
				NAMESPACE + "getMemberList");
		return list;
	}
}
