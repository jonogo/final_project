<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@include file="../management/include/header.jsp"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script>
$(document).ready(function() {
	//시작시 페이징 추가
	let frmStep = $("#frmPaging").find("input[name=perPage]").clone();
	$("#frmPaging").append(frmStep.attr("name", "order_step"));
	$("#frmPaging").find("input[name=order_step]").val("${pagingDto.order_step}");
	//페이지 번호 이동
	$(".page-link").click(function(e) {
		e.preventDefault();
		let page = $(this).attr("href");
		$("#frmPaging").find("input[name=page]").val(page);
		$("#frmPaging").attr("action", "/manage/listsellorder").submit();
	});
	//페이지 갯수 조절
	$(".perPage").click(function(e){
		e.preventDefault();
		let perPage = $(this).attr("href");
		$("#frmPaging").find("input[name=perPage]").val(perPage);
		$("#frmPaging").find("input[name=page]").val(1);
		$("#frmPaging").attr("action", "/manage/listsellorder").submit();
	});
	//주문 단계별 정렬
	$(".order_step_sort").click(function(e){
		e.preventDefault();
		let order_step = $(this).attr("href");
		$("#frmPaging").find("input[name=order_step]").val(order_step);
		$("#frmPaging").find("input[name=page]").val(1);
		$("#frmPaging").attr("action", "/manage/listsellorder").submit();
	});
	// 클릭시 페이지 이동
	$(".orderDetail").click(function() {
		let order_no = $(this).find(".order_no").text();
		location.href = "/ordersell/detail?order_no=" + order_no;
	});
	// 테이블 색 변경
	$(".orderDetail").mouseenter(function() {
		$(this).css("background-color", "#f3f3f3");
	});
	$(".orderDetail").mouseleave(function() {
		$(this).css("background-color", "white");
	});
})
</script>
<div class="container-fluid">
	<div class="row">
		<div class="col-12">
			<div class="card my-4">
			    <!-- 제목 카드 -->
				<div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">
					<div
						class="bg-gradient-primary shadow-primary border-radius-lg pt-4 pb-3">
						<h6 class="text-white text-capitalize ps-3">주문 목록</h6>
					</div>
				</div>
				<!--// 제목 카드 -->
				<div class="card-body px-0 pb-2">
					<div class="table-responsive p-0" style="min-height: 220px">
					    <!-- 주문 정보 테이블 -->
						<table class="table mb-0">
							<thead>
								<tr>
									<th
										class="text-center text-uppercase text-secondary 
										text-s opacity-8"
										style="width: 170px;">주문 번호</th>
									<th
										class="text-center text-uppercase text-secondary 
										text-s opacity-8"
										style="width: 300px;">상품명
									</th>
									<th
										class="text-center text-uppercase text-secondary 
										 text-s opacity-8 ps-2" style="width: 170px;">
										사이즈 / 수량
									</th>
									<!-- 정렬 dropdown -->
									<th
										class="text-center text-uppercase text-secondary 
										text-s"
										style="width: 170px;">
										<div class="dropdown">
											<button type="button"
												class="btn btn-outline-secondary dropdown-toggle mb-0
												py-1 text-center text-uppercase text-xs"
												data-toggle="dropdown"
												style="width: 80%;">
												<c:choose>
												<c:when test="${pagingDto.order_step eq 1}">
												  결제 완료
												</c:when>
												<c:when test="${pagingDto.order_step eq 2}">
												  상품 준비중
												</c:when>
												<c:when test="${pagingDto.order_step eq 3}">
												  배송중
												</c:when>
												<c:when test="${pagingDto.order_step eq 4}">
												  배송완료
												</c:when>
												<c:otherwise>
												  주문 단계별 정렬
												</c:otherwise>
												</c:choose>
												</button>
											<div class="dropdown-menu">
												<a class="dropdown-item order_step_sort" href="1">결제 완료</a> 
												<a class="dropdown-item order_step_sort" href="2">상품 준비중</a>
												<a class="dropdown-item order_step_sort" href="3">배송중</a>
												<a class="dropdown-item order_step_sort" href="4">배송완료</a>
											</div>
										</div>
									</th>
									<!--// 정렬 dropdown -->
									<th
										class="text-center text-uppercase text-secondary 
										text-s opacity-8"
										style="width: 170px;">구매자(id)</th>
									<th
										class="text-center text-uppercase text-secondary 
										text-s opacity-8"
										style="width: 170px;">등록 날짜</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach items="${list}" var="orderVo">
								<tr class="orderDetail">
									<td class="align-middle text-center text-sm order_no">${orderVo.order_no}</td>
									<td><div class="d-flex px-2 py-1">
											<div class="img-wrapper"
              								  style="border-radius: 6px; width: 36px; height: 36px;">
											  <img src="/manage/displayImg?attach_file=${orderVo.mainpic}">
											</div>
											<div class="d-flex flex-column justify-content-center ml-3">
												${orderVo.pro_name}
											</div>
										</div></td>
									<td
										class="text-center text-uppercase text-s
										 opacity-7 ps-2" style="vertical-align: middle;"
										 >${orderVo.order_size} / ${orderVo.order_count}</td>
									<td class="align-middle text-center text-sm">
									<h4>
									<span
										style="padding: 7px;"
										class="badge badge-sm
										
										<c:choose>
										  <c:when test="${orderVo.order_step eq 1}">
										    bg-gradient-secondary">
											결제 완료
										  </c:when>
										  <c:when test="${orderVo.order_step eq 2}">
										    bg-gradient-warning">
											상품 준비중
										  </c:when>
										  <c:when test="${orderVo.order_step eq 3}">
										    bg-gradient-info">
											배송중
										  </c:when>
										  <c:when test="${orderVo.order_step eq 4}">
										    bg-gradient-success">
											배송 완료
										  </c:when>
										  <c:otherwise>
											bg-gradient-secondary">
											${orderVo.order_step}
										  </c:otherwise>
										</c:choose>
										</span>
										</h4></td>
									<td class="align-middle text-center">${orderVo.userid}</td>
									<td class="align-middle text-center">
									  <fmt:formatDate value="${orderVo.regdate}"
									    type="date"></fmt:formatDate>
									</td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
						<!--// 주문 정보 테이블 -->
					</div>
				</div>
			</div>
		</div>
	  <%@include file="../management/include/paging.jsp"%>
	</div>
</div>
<%@include file="../management/include/footer.jsp"%>