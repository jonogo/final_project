package com.kh.project.sjw.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.project.sjw.dao.MemberDao;
import com.kh.project.vo.MemberVo;

@Service
public class MemberService {
	
	@Autowired
	MemberDao memberDao;
	//������ �α���, ȸ�� ����, �ߺ� ���̵� üũ
	public boolean checkId(String userid) {
		return memberDao.checkId(userid);
	}
	public boolean registerMember(MemberVo memberVo) {
		return memberDao.registerMember(memberVo);
	}
	public MemberVo login(String userid, String userpw) {
		return memberDao.login(userid, userpw);
	}
	//�Ǹ��� �α���, ȸ�� ����, �ߺ� ���̵� üũ
	public boolean seller_checkId(String userid) {
		return memberDao.seller_checkId(userid);
	}
	public boolean seller_registerMember(MemberVo memberVo) {
		return memberDao.seller_registerMember(memberVo);
	}
	public MemberVo seller_login(String userid, String userpw) {
		return memberDao.seller_login(userid, userpw);
	}
	// ������ ��й�ȣ ã��
	public boolean isExistMember_customer(String userid, String email) {
		return memberDao.isExistMember_customer(userid, email);
	}
	public boolean updatePassword_customer(String userid, String newPass) {
		return memberDao.updatePassword_customer(userid, newPass);
	}
	// �Ǹ��� ��й�ȣ ã��
	public boolean isExistMember_seller(String userid, String email) {
		return memberDao.isExistMember_customer(userid, email);
	}
	public boolean updatePassword_seller(String userid, String newPass) {
		return memberDao.updatePassword_customer(userid, newPass);
	}
	public List<MemberVo> list(String userid) {
		return memberDao.getMemberList(userid);
	}
}
