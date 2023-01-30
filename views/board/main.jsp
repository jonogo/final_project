<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header_main.jsp"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script>
	$(document).ready(function() {
		var order="${success}"
		if(order=="success"){
			alert("상품 주문 완료");
		}
		
		// 페이지 번호
		$(".page-numbers").click(function(e) {
			e.preventDefault();
			var page = $(this).attr("href");
			if(page == "" || page == null) return;
			$("#frmPaging").find("input[name=page]").val(page);
			$("#frmPaging").attr("action", "/board/main").submit();
		});
		
		// n줄씩 보기
		$(".perPage").click(function(e) {
			e.preventDefault();
			var perPage = $(this).attr("href");
			$("#frmPaging").find("input[name=perPage]").val(perPage);
			$("#frmPaging").attr("action", "/board/main").submit();
		});

		// 제목 클릭
		$(".a_title").click(function(e) {
			e.preventDefault();
			var pro_no = $(this).attr("data-pro_no");
			location.href = "/board/detail?pro_no=" + pro_no; 
		});
		var select = $('#brand > option:selected').val()
		$("#brand").click(function(e) {
			var brand_name = "";
			var brandval = $("#brand").val();
			if(brandval == select){
				return;
			}
			console.log("브랜드 고유번호:" + brandval);
			if (brandval == 1) {
				console.log("나이키 선택");
				brand_name = "ni";
			} else if (brandval == 2) {
				console.log("뉴발란스 선택");
				brand_name = "ne";
			} else if (brandval == 3) {
				console.log("아디다스 선택");
				brand_name = "ad";
			} else {
				return;
			}
			var page = $(this).attr("href");
			$("#frmPaging").find("input[name=pro_category]").val(brand_name);
			$("#frmPaging").find("input[name=page]").val(1);
			$("#frmPaging").attr("action", "/board/main").submit();
		});
		$(".status").click(function(e){
			e.preventDefault();
			$("#frmPaging").find("input[name=pro_status]").val($(this).attr("data-stat"));
			$("#frmPaging").find("input[name=page]").val(1);
			$("#frmPaging").find("input[name=pro_category]").val("");
			$("#frmPaging").attr("action", "/board/main").submit();
		});
	});
</script>
		<div class="container">
			<!-- #masthead -->
			<div id="content" class="site-content">
				<div id="primary" class="content-area column full">
					<main id="main" class="site-main" role="main">
						<form class="woocommerce-ordering" method="get">
							<select name="brand" id="brand">
							  <option 
							  <c:if test="${empty boardPagingDto.pro_category}">
							    selected="selected" 
							  </c:if>
								value="0">브랜드별 항목</option>
							  <option 
							  <c:if test="${boardPagingDto.pro_category eq 'ni'}">
							    selected="selected" 
							  </c:if>
								value="1">나이키</option>
							  <option 
							  <c:if test="${boardPagingDto.pro_category eq 'ne'}">
							    selected="selected" 
							  </c:if>
								value="2">뉴발란스</option>
							  <option 
							  <c:if test="${boardPagingDto.pro_category eq 'ad'}">
							    selected="selected" 
							  </c:if>
								value="3">아디다스</option>
							</select>
						</form>
						<!-- main productlist-->
						<ul class="products">
							<c:forEach items="${list}" var="productVo" varStatus="status">
								<li
									class="
								<c:choose>
									<c:when test="${status.count mod 4 eq 1}">
									  first 
									</c:when>
									<c:when test="${status.count mod 4 eq 0}">
									  last 
									</c:when>
								</c:choose>
									product"><a
									class="a_title" data-pro_no="${productVo.pro_no}" href="#">
										<div>
											<div class="img-wrapper" style="width: 150px; height: 150px; 
											position: relative; overflow:hidden;">
												<img
													src="/board/displayImg?attach_file=${productVo.mainpic}"
													class="img-thumbnail"
													style="position: absolute;
													 top: 0; left: 0; transform: translate(50, 50); 
													 width: 100%; height: 100%; object-fit: cover; margin: auto;">
											</div>
										</div>
										<h3>${productVo.pro_name}</h3> <span class="price">
										<span class="amount"><fmt:formatNumber value="${productVo.pro_price}" pattern="#,###"/>	</span></span>
								</a></li>
							</c:forEach>
						</ul>
						<!-- //main productlist-->
						<!-- 페이징 perpage -->
						<div class="d-flex justify-content-between">
							<div class="btn-group dropup">
								<!-- //페이징 번호넘기기 -->
								<button type="button" class="btn btn-outline-dark dropdown-toggle"
									data-toggle="dropdown" aria-haspopup="true"
									aria-expanded="false" style="position: relative;
									 top:30px; left: 50px; height: 30px">
									${boardPagingDto.perPage}개씩보기</button>
								<div class="dropdown-menu">
									<c:forEach var="v" begin="4" end="20" step="4">
										<a class="dropdown-item perPage" href="${v}">${v}개씩 보기</a>
									</c:forEach>
								</div>
							</div>
							<!-- 페이징 Pagination -->
							<div class="row d-flex justify-content-center">
								<nav class="pagination">
									<c:if test="${boardPagingDto.startPage ne 1}">
										<a class="prev page-numbers"
											href="${boardPagingDto.startPage - 1}">« prev</a>
									</c:if>
									<c:forEach var="v" begin="${boardPagingDto.startPage}"
										end="${boardPagingDto.endPage}">
										<c:choose>
											<c:when test="${boardPagingDto.page eq v}">
												<span class="page-numbers current">${v}</span>
											</c:when>
											<c:otherwise>
												<a class="page-numbers" href="${v}">${v}</a>
											</c:otherwise>
										</c:choose>
									</c:forEach>
									<c:if
										test="${boardPagingDto.endPage lt boardPagingDto.totalPage}">
										<a class="next page-numbers"
											href="${boardPagingDto.endPage + 1}">Next »</a>
									</c:if>
								</nav>
							</div>
							<!-- //페이징 Pagination -->

							<div></div>
						</div>
					</main>
					<!-- #main -->
				</div>
				<!-- #primary -->
			</div>
			<!-- #content -->
		</div>
		<!-- .container -->
		<%@ include file="../includes/footer.jsp"%>
	</div>
</body>
</html>