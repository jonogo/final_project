package com.kh.project.sjw.dao;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.project.vo.MemberVo;
import com.kh.project.vo.OrderVo;
import com.kh.project.vo.QuestionVo;
import com.kh.project.vo.ShoppingBasketVo;

@Repository
public class PageDao {
	private final String NAMESPACE = "mappers.page.";

	@Autowired
	private SqlSession sqlSession;
	
	public boolean modifyMember(MemberVo memberVo) {
		int count=sqlSession.update(NAMESPACE+"modifyMember",memberVo);
		if(count>0) {
			return true;
		}
		return false;
	}
	
	public List<ShoppingBasketVo> shopping_basket_list(String userid) {
		List<ShoppingBasketVo>list=sqlSession.selectList(NAMESPACE+"shopping_basket_list",userid);
		return list;
	}
	public int delete_shopping_basket_list(String userid, String pro_no) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("userid", userid);
		map.put("pro_no", pro_no);
		int count=sqlSession.delete(NAMESPACE+"delete_shopping_basket_list",map);
		return count;
	}
	public List<QuestionVo> serviceList(String userid) {
		List<QuestionVo>list=sqlSession.selectList(NAMESPACE+"serviceList",userid);
		return list;
	}
	public List<OrderVo> orderList(String userid) {
		List<OrderVo>list=sqlSession.selectList(NAMESPACE+"orderList",userid);
		return list;
	}
	public OrderVo preOrder( String userid, String pro_no, String pro_size) {
		Map<String, String>map=new HashMap<>();
		map.put("pro_no", pro_no);
		map.put("userid", userid);
		map.put("pro_size", pro_size);
		OrderVo preOrder=sqlSession.selectOne(NAMESPACE+"preOrder",map);
		System.out.println("preOrder:"+preOrder);
		return preOrder;
	}
	
	public boolean insertOrder(OrderVo orderVo) {
		int count=sqlSession.insert(NAMESPACE+"insertOrder",orderVo);
		if(count>0) {
			return true;
		}
		return false;
	}
	public boolean insertOrder_date(OrderVo orderVo) {
		int count= sqlSession.insert(NAMESPACE+"insertOrder_date",orderVo);
		if(count>0) {
			return true;
		}
		return false;
	}
	public boolean order_delete_basket(OrderVo orderVo) {
		int count= sqlSession.insert(NAMESPACE+"order_delete_Basket",orderVo);
		if(count>0) {
			return true;
		}
		return false;
	}
	public int orderSeq() {
		return sqlSession.selectOne(NAMESPACE+"orderSeq");
	}
	public boolean order_product_count_down(OrderVo orderVo) {
		int count=sqlSession.update(NAMESPACE+"order_product_count_down",orderVo);
		if(count>0) {
			return true;
		}
		return false;
	}

}
