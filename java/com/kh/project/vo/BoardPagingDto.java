package com.kh.project.vo;

import lombok.Data;

@Data
public class BoardPagingDto {
	private int page = 1;
	private int startRow = 1;
	private int endRow = 10;
	private int startPage = 1;
	private int endPage = 10;
	private int totalPage;
	private int count;
	private int perPage = 8;
	private final int BLOCK_COUNT = 10;
	private String pro_category;
	private String pro_status;
	
	public void setPagingInfo(int page, int perPage, int count) {
		this.page = page;
		this.perPage = perPage;
		this.count = count;
		this.endRow = page * perPage;
		this.startRow = this.endRow - (perPage - 1);
		this.startPage = ((page - 1) / BLOCK_COUNT) * BLOCK_COUNT + 1;
		this.endPage = this.startPage + (BLOCK_COUNT - 1);
		
		this.totalPage = (count + (perPage - 1)) / perPage;
		if(this.endPage > this.totalPage) {
			this.endPage = this.totalPage;
		}
	}
}
