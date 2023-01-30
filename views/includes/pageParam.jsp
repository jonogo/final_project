<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<form method="get" id="frmPaging">
	<input type="hidden" name="page" value="${boardPagingDto.page}"/>
	<input type="hidden" name="perPage" value="${boardPagingDto.perPage}"/>
	<input type="hidden" name="pro_status" value="${boardPagingDto.pro_status}"/>
	<input type="hidden" name="pro_category" value="${boardPagingDto.pro_category}"/>
</form>