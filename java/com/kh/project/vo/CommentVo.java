package com.kh.project.vo;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CommentVo {
	private int cno;
	private int pro_no;
	private String content;
	private String userid;
	private Timestamp regdate;
	private String commentstar;
	private String pro_pic;
	private String pro_name;
	private String userpic;
	private String username;
}
