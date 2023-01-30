<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@include file="../management/include/header.jsp"%>
<script>
$(document).ready(function() {
	//시작시 페이징 추가
	let frmStatus = $("#frmPaging").find("input[name=perPage]").clone();
	$("#frmPaging").append(frmStatus.attr("name", "pro_count_status"));
	$("#frmPaging").find("input[name=pro_count_status]").val("${pagingDto.pro_count_status}");
	//페이지 번호 이동
	$(".page-link").click(function(e) {
		e.preventDefault();
		let page = $(this).attr("href");
		$("#frmPaging").find("input[name=page]").val(page);
		$("#frmPaging").attr("action", "/manage/listproduct").submit();
	});
	//페이지 갯수 조절
	$(".perPage").click(function(e){
		e.preventDefault();
		let perPage = $(this).attr("href");
		$("#frmPaging").find("input[name=perPage]").val(perPage);
		$("#frmPaging").find("input[name=page]").val(1);
		$("#frmPaging").attr("action", "/manage/listproduct").submit();
	});
	//주문 단계별 정렬
	$(".pro_count_status").click(function(e){
		e.preventDefault();
		let pro_count_status = $(this).attr("href");
		$("#frmPaging").find("input[name=pro_count_status]").val(pro_count_status);
		$("#frmPaging").find("input[name=page]").val(1);
		$("#frmPaging").attr("action", "/manage/listproduct").submit();
	});
	// 클릭시 페이지 이동
	$(".productList").click(function() {
		let pro_no = $(this).find(".pro_no").text();
		location.href = "/product/detail?pro_no=" + pro_no;
	});
	// 테이블 색 변경
	$(".productList").mouseenter(function() {
		$(this).css("background-color", "#f3f3f3");
	});
	$(".productList").mouseleave(function() {
		$(this).css("background-color", "white");
	});
})
</script>
<div class="container-fluid">
	<div class="row">
		<div class="col-12">
		  <%@include file="../management/include/toast.jsp"%>
			<div class="card my-4">
				<!-- 제목 카드 -->
				<div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">
					<div
						class="bg-gradient-primary shadow-primary border-radius-lg pt-4 pb-3">
						<h6 class="text-white text-capitalize ps-3">상품 목록</h6>
					</div>
				</div>
				<!--// 제목 카드 -->
				<div class="card-body px-0 pb-2">
					<div class="table-responsive p-0" style="min-height: 200px">
						<!-- 상품 정보 테이블 -->
						<table class="table align-items-center mb-0">
							<thead>
								<tr>
									<th
										class="text-center text-uppercase text-secondary 
										text-s opacity-8"
										style="width: 170px;">상품 번호</th>
									<th
										class="text-center text-uppercase text-secondary 
										text-s opacity-8">상품명
									</th>
									<th
										class="text-center text-uppercase text-secondary 
										text-s opacity-8">
										<p class="text-xs text-secondary mb-0">브랜드</p>
										<p class="text-xs text-secondary mb-0">카테고리</p></th>
									<th
										class="text-center text-uppercase text-secondary 
										text-s opacity-8">
										<!-- 정렬 -->
										<div class="dropdown">
											<button type="button"
											  class="btn btn-outline-secondary dropdown-toggle mb-0
											  py-1 text-center text-uppercase text-xs"
											  data-toggle="dropdown" style="width: 80%;">
											  <c:choose>
 											    <c:when test="${pagingDto.pro_count_status eq 1}">
 											      판매중
 											    </c:when>
 											    <c:when test="${pagingDto.pro_count_status eq 2}">
 											      품절
 											    </c:when>
 											    <c:otherwise>
 											      상태
 											    </c:otherwise>
											  </c:choose>
											  </button>
											<div class="dropdown-menu">
												<a class="dropdown-item pro_count_status" href="0">모두</a> 
												<a class="dropdown-item pro_count_status" href="1">판매중</a>
												<a class="dropdown-item pro_count_status" href="2">품절</a>
											</div>
										</div>
										<!--// 정렬 -->
									</th>
									<th
										class="text-center text-uppercase text-secondary 
										text-s opacity-8">등록 날짜
									</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach items="${list}" var="productVo">
									<tr style="height: 100px;" class="productList">
									<td class="align-middle text-center text-sm pro_no">${productVo.pro_no}</td>
  									  <td>
										<div class="d-flex px-2 py-1">
											<div class="img-wrapper"
											  style="border-radius: 8px; width: 58px; height: 58px;">
											  <img src="/manage/displayImg?attach_file=${productVo.mainpic}">
											</div>
											<div class="d-flex flex-column justify-content-center ml-3">
											  ${productVo.pro_name}
											</div>
										</div>
									</td>
									<td>
										<p class="text-center text-uppercase 
										text-xs font-weight-bolder opacity-7">
											<c:choose>
												<c:when test="${productVo.pro_category eq 'ni'}">
													나이키
												</c:when>
												<c:when test="${productVo.pro_category eq 'ad'}">
													아디다스
												</c:when>
												<c:when test="${productVo.pro_category eq 'ne'}">
													뉴발란스
												</c:when>
											</c:choose>
										</p>
										<p class="text-center text-uppercase  
										text-xs font-weight-bolder opacity-7">
											<c:choose>
												<c:when test="${productVo.pro_status eq 'M'}">
													남성용
												</c:when>
												<c:when test="${productVo.pro_status eq 'F'}">
													여성용
												</c:when>
												<c:when test="${productVo.pro_status eq 'K'}">
													아동용
												</c:when>
											</c:choose>
										</p>
									</td>
									<td class="align-middle text-center text-sm">
									<h4>
									<span class="badge badge-sm
									<c:choose>
									  <c:when test="${productVo.cnt > 0}">
									     bg-gradient-success">판매중
									  </c:when>
									  <c:otherwise>
									     bg-gradient-secondary">품절
									  </c:otherwise>
									</c:choose>
									</span>
									</h4>
									</td>
									<td class="align-middle text-center"><span
										class="text-secondary text-xs font-weight-bold">${productVo.regdate}</span>
									</td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
						<!--// 상품 정보 테이블 -->
					</div>
				</div>
			</div>
		</div>
		<%@include file="../management/include/paging.jsp"%>
	</div>
</div>
<%@include file="../management/include/footer.jsp"%>