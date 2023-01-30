package com.kh.project.vo;
import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
@AllArgsConstructor
public class QuestionVo {
	private int q_no;
	private String userid;
	private int pro_no;
	private String pro_name;
	private String q_title;
	private String q_content;
	private String a_content;
	private String q_kind;
	private String q_step;
	private Timestamp q_regdate;
	private Timestamp a_regdate;
}