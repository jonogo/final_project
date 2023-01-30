package com.kh.project.kwon.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.project.vo.OrderDateVo;
import com.kh.project.vo.OrderVo;
import com.kh.project.vo.PagingDto;

@Repository
public class OrderSellDao {
	private final String NAMESPACE = "mappers.order.";
	
	@Autowired
	SqlSession sqlSession;

	public List<OrderVo> getOrderListBySellerId(String seller_id, PagingDto pagingDto) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("seller_id", seller_id);
		map.put("startRow", pagingDto.getStartRow());
		map.put("endRow", pagingDto.getEndRow());
		map.put("order_step", pagingDto.getOrder_step());
		System.out.println(pagingDto);
		return sqlSession.selectList(
				NAMESPACE + "getOrderListBySellerId", map);
	}

	public OrderVo getOrderInfoByNo(int order_no) {
		return sqlSession.selectOne(
				NAMESPACE + "getOrderInfoByNo", order_no);
	}

	public List<OrderDateVo> getOrderDateByNo(int order_no) {
		return sqlSession.selectList(
				NAMESPACE + "getOrderDateByNo", order_no);
	}

	public boolean ModifyStep(int order_no, int order_step) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("order_no", order_no);
		map.put("order_step", order_step);
		int count = sqlSession.insert(NAMESPACE + "ModifyStep", map);
		if(count > 0) {
			return true;
		}
		return false;
	}

	public boolean UpdateStep(int order_no, int order_step) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("order_no", order_no);
		map.put("order_step", order_step);
		int count = sqlSession.update(NAMESPACE + "UpdateStep", map);
		if(count > 0) {
			return true;
		}
		return false;
	}

	public boolean SetTracking(int order_no, String tracking_no) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("order_no", order_no);
		map.put("tracking_no", tracking_no);
		int count = sqlSession.update(NAMESPACE + "SetTracking", map);
		if(count > 0) {
			return true;
		}
		return false;
	}
	
	public List<OrderVo> getOrderListforBoard(String seller_id) {
		return sqlSession.selectList(
				NAMESPACE + "getOrderListforBoard", seller_id);
	}

	public boolean getIsCorrectId(String seller_id, int order_no) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("seller_id", seller_id);
		map.put("order_no", order_no);
		int count = sqlSession.selectOne(NAMESPACE + "getIsCorrectId", map);
		if(count > 0) {
			return true;
		}
		return false;
	}

	public int getOrderCount(String seller_id, int order_step) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("seller_id", seller_id);
		map.put("order_step", order_step);
		return sqlSession.selectOne(NAMESPACE + "getOrderCount", map);
	}

	public int getLeftOrder(String seller_id) {
		return sqlSession.selectOne(NAMESPACE + "getLeftOrder", seller_id);
	}

	public int getWeekOrder(String seller_id) {
		return sqlSession.selectOne(NAMESPACE + "getWeekOrder", seller_id);
	}

	public int getWeekPrice(String seller_id) {
		return sqlSession.selectOne(NAMESPACE + "getWeekPrice", seller_id);
	}

	public List<Integer> getOrderCountInMain(String seller_id) {
		return sqlSession.selectList(
				NAMESPACE + "getOrderCountInMain", seller_id);
	}

	public int getWeekOrderComplited(String seller_id) {
		return sqlSession.selectOne(
				NAMESPACE + "weekOrderComplited", seller_id);
	}
	
	
	
	
}
