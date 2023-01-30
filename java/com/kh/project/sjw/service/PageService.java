package com.kh.project.sjw.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.project.sjw.dao.PageDao;
import com.kh.project.vo.MemberVo;
import com.kh.project.vo.OrderVo;
import com.kh.project.vo.QuestionVo;
import com.kh.project.vo.ShoppingBasketVo;

@Service
public class PageService {
	@Autowired
	PageDao pageDao;
	
	public boolean modifyMember(MemberVo memberVo) {
		return pageDao.modifyMember(memberVo);
	}
	public List<ShoppingBasketVo>shopping_basket_list(String userid){
		return pageDao.shopping_basket_list(userid);
	}
	public int delete_shopping_basket_list(String userid, String pro_no) {
		return pageDao.delete_shopping_basket_list(userid, pro_no);
	}
	public List<QuestionVo> serviceList(String userid) {
		return pageDao.serviceList(userid);
	}
	public List<OrderVo> orderList(String userid) {
		return pageDao.orderList(userid);
	}
	public OrderVo preOrder( String userid,String pro_no, String pro_size) {
		return pageDao.preOrder( userid,pro_no, pro_size);
	}
	@Transactional
	public boolean order(OrderVo orderVo) {
		System.out.println(orderVo);
		boolean result1=pageDao.order_delete_basket(orderVo);
		boolean result2=pageDao.insertOrder(orderVo);
		boolean result3=pageDao.insertOrder_date(orderVo);
		boolean result4=pageDao.order_product_count_down(orderVo);
		if(result1&&result2&&result3&&result4) {
			return true;
		}
		return false;
	}
	public int orderSeq(){
		return pageDao.orderSeq();
	}
}
