package com.kh.project.vo;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class BasketVo {
	private String userid;
	private int pro_no;
	private int pro_size;
	private int pro_quantity;
}
