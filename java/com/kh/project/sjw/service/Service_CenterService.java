package com.kh.project.sjw.service;

import java.io.Serializable;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.project.sjw.dao.Service_CenterDao;
import com.kh.project.vo.QuestionVo;

@Service
public class Service_CenterService implements Serializable{
	
	@Autowired
	Service_CenterDao service_centerDao;
	
	public boolean send_question(QuestionVo questionVo) {
		return service_centerDao.send_question(questionVo);
	}
}
