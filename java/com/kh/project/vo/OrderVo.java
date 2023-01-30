package com.kh.project.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrderVo {
	private int order_no;
	private int pro_no;
	private int order_count;
	private int order_size;
	private int order_step;
	private String userid;
	private String order_addr;
	private String pro_name;
	private String mainpic;
	private String tracking_no;
	private int pro_price;
	private java.sql.Timestamp regdate;
}
