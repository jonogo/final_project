package com.kh.project.kwon.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.project.kwon.dao.OrderSellDao;
import com.kh.project.kwon.dao.ProductDao;
import com.kh.project.vo.OrderVo;
import com.kh.project.vo.PagingDto;

@Service
public class OrderSellService {
	
	@Autowired
	OrderSellDao orderDao;
	@Autowired
	ProductDao productDao;

	public List<OrderVo> getOrderListBySellerId(String seller_id, PagingDto pagingDto) {
		return orderDao.getOrderListBySellerId(seller_id, pagingDto);
	}

	public Map<String, Object> getOrderInfoByNo(int order_no) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orderVo", orderDao.getOrderInfoByNo(order_no));
		map.put("productVo", productDao.getProductInfoByOrder(order_no));
		map.put("list", orderDao.getOrderDateByNo(order_no));
		return map;
	}
	
	@Transactional
	public boolean ModifyStep(int order_no, int order_step) {
		boolean b1 =  orderDao.ModifyStep(order_no, order_step);
		boolean b2 =  orderDao.UpdateStep(order_no, order_step);
		return b1 && b2;
	}

	public boolean SetTracking(int order_no, String tracking_no) {
		return orderDao.SetTracking(order_no, tracking_no);
	}

	public List<OrderVo> getOrderListforBoard(String seller_id) {
		return orderDao.getOrderListforBoard(seller_id);
	}

	public boolean getIsCorrectId(String seller_id, int order_no) {
		return orderDao.getIsCorrectId(seller_id, order_no);
	}

	public int getOrderCount(String seller_id, int order_step) {
		return orderDao.getOrderCount(seller_id, order_step);
	}

	public int getLeftOrder(String seller_id) {
		return orderDao.getLeftOrder(seller_id);
	}

	public int getWeekOrder(String seller_id) {
		return orderDao.getWeekOrder(seller_id);
	}

	public int getWeekPrice(String seller_id) {
		return orderDao.getWeekPrice(seller_id);
	}

	public Map<String, Object> getMainMap(String seller_id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("boardList", orderDao.getOrderListforBoard(seller_id));
		map.put("weekPrice", orderDao.getWeekPrice(seller_id));
		map.put("weekOrder", orderDao.getWeekOrder(seller_id));
		map.put("leftOrder", orderDao.getLeftOrder(seller_id));
		map.put("orderCountList", orderDao.getOrderCountInMain(seller_id));
		map.put("weekOrderComplited", orderDao.getWeekOrderComplited(seller_id));
		return map;
	}

}
