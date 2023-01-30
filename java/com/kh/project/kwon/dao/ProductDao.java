package com.kh.project.kwon.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.project.vo.OrderVo;
import com.kh.project.vo.PagingDto;
import com.kh.project.vo.ProductCountVo;
import com.kh.project.vo.ProductPicVo;
import com.kh.project.vo.ProductVo;

@Repository
public class ProductDao {
	private final String NAMESPACE = "mappers.product.";
	
	@Autowired
	SqlSession sqlSession;
	
	public int getPro_no() {
		return sqlSession.selectOne(NAMESPACE + "getPro_no");
	}
	
	public boolean registProduct(ProductVo productVo) {
		int count = sqlSession.insert(NAMESPACE + "registProduct", productVo);
		if(count > 0) {
			return true;
		}
		return false;
	}

	public boolean registProductCount(ProductCountVo productCountVo) {
		int count = 
				sqlSession.insert(NAMESPACE + "registerProductCount", productCountVo);
		if(count > 0) {
			return true;
		}
		return false;
	}

	public boolean registProductPic(ProductPicVo productPicVo) {
		int count = 
				sqlSession.insert(NAMESPACE + "registProductPic", productPicVo);
		if(count > 0) {
			return true;
		}
		return false;
	}

	public List<ProductVo> getProductList(PagingDto pagingDto, String seller_id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("seller_id", seller_id);
		map.put("startRow", pagingDto.getStartRow());
		map.put("endRow", pagingDto.getEndRow());
		System.out.println("nowdto:" + pagingDto.getPro_count_status());
		map.put("pro_count_status", pagingDto.getPro_count_status());
		return sqlSession.selectList(
				NAMESPACE + "getProductList", map);
	}
	
	public boolean getIsCorrectId(String seller_id, int pro_no) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("seller_id", seller_id);
		map.put("pro_no", pro_no);
		int count = sqlSession.selectOne(NAMESPACE + "isCorrectId", map);
		System.out.println(count);
		if(count > 0) {
			return true;
		}
		return false;
	}

	public ProductVo getProductInfo(int pro_no) {
		return sqlSession.selectOne(NAMESPACE + "getProductInfo", pro_no);
	}

	public List<ProductCountVo > getProductCountInfo(int pro_no) {
		return sqlSession.selectList(NAMESPACE + "getProductCountInfo", pro_no);
	}

	public List<ProductPicVo> getProductPicInfo(int pro_no) {
		return sqlSession.selectList(NAMESPACE + "getProductPicInfo", pro_no);
	}

	public boolean modifySize(ProductCountVo productCountVo) {
		int count = 
				sqlSession.update(NAMESPACE + "updateSize", productCountVo);
		if(count > 0) {
			return true;
		}
		return false;
	}

	public boolean modifyName(int pro_no, String pro_name) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pro_no", pro_no);
		map.put("pro_name", pro_name);
		int count = sqlSession.update(NAMESPACE + "updatePro_name", map);
		if(count > 0) {
			return true;
		}
		return false;
	}
	
	public boolean modifyPrice(int pro_no, String pro_price) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pro_no", pro_no);
		map.put("pro_price", pro_price);
		int count = sqlSession.update(NAMESPACE + "updatePro_price", map);
		if(count > 0) {
			return true;
		}
		return false;
	}
	
	public boolean modifyImageData(String old_pro_pic, String new_pro_pic) {
		Map<String, String> map = new HashMap<>();
		map.put("old_pro_pic", old_pro_pic);
		map.put("new_pro_pic", new_pro_pic);
		int count = sqlSession.update(NAMESPACE + "modifyImageData", map);
		if(count > 0) {
			return true;
		}
		return false;
	}

	public boolean deleteImageData(String pro_pic) {
		int count = sqlSession.delete(NAMESPACE + "deleteImageData", pro_pic);
		if(count > 0) {
			return true;
		}
		return false;
	}

	public int getProductCount(String seller_id, int pro_count_status) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("seller_id", seller_id);
		map.put("pro_count_status", pro_count_status);
		return sqlSession.selectOne(NAMESPACE + "getProductCount", map);
	}

	public ProductVo getProductInfoByOrder(int order_no) {
		return sqlSession.selectOne(
				NAMESPACE + "getProductInfoByOrder", order_no);
	}

	public List<OrderVo> getProductRevenueBySellerId(String seller_id) {
		return sqlSession.selectList(
				NAMESPACE + "getProductRevenueBySellerId", seller_id);
	}

	public boolean getSizeExist(ProductCountVo productCountVo) {
		int count = 
				sqlSession.selectOne(NAMESPACE + "getSizeExist", productCountVo);
		if(count > 0) {
			return true;
		}
		return false;
	}

	public boolean insertSize(ProductCountVo productCountVo) {
		int count = 
				sqlSession.insert(NAMESPACE + "insertSize", productCountVo);
		if(count > 0) {
			return true;
		}
		return false;
				
	}


}
