package com.kh.project.vo;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrderDateVo {
	private int order_no;
	private int order_step;
	private Timestamp regdate;
}
