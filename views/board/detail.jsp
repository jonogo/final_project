<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header_main.jsp"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script>
	$(document).ready(
			function() {
				// 카트(장바구니) 버튼 클릭시 해당정보 저장표현 ->콘솔로   [장바구니 클릭인식, 유저아이디,상품번호,수량]
				$("#cartbutton").on("click", function() {
					if("${sessionScope.loginInfo}" == "") {
						location.href = "/member/login_form";
						return;
					}
					var pro_no = "${productVo.pro_no}";
					var pro_size = $("#size").val().split("/");
					var pro_quantity = $("#quantity").val();
					if (pro_size[1] == "재고 없음") {
						alert("이미 품절된 사이즈입니다.");
						return;
					}
					
					pro_size = pro_size[0];
					
					var sData = {
						"userid" : "${loginInfo.userid}",
						"pro_no" : pro_no,
						"pro_size" : pro_size,
						"pro_quantity" : pro_quantity
					};
					console.log(sData);
					var url = "/comment/insertBasket";
					var size=$("#size").val();
					var sizeLength=size.substring(4).length;
					if(sizeLength==3){
						size=size.substring(5,6);
						console.log(size);
					}else if(sizeLength==4){
						size=size.substring(5,7);
						console.log(size);
					}
					if(parseInt(size)<pro_quantity){
						alert("갯수를 확인해 주세요");
						return false;
					}
					$.post(url, sData, function(rData) {
						console.log(rData);
						alert("장바구니 등록 완료");
					});
				});

				// 댓글 완료 버튼
				$("#btnCommentInsert").click(function() {
					var c_content = $("#c_content").val();
					var pro_no = "${productVo.pro_no}";
					var userpic = "${loginInfo.userpic}";
					var commentstar = $("#commentstar").val();
					if (commentstar == null || commentstar == "") {
						alert("점수를 입력해주세요");
						$("#commentstar").focus();
						return;
					}
					var sData = {
						"content" : c_content,
						"pro_no" : pro_no,
						"userpic" : userpic,
						"commentstar" : commentstar
					};
					console.log("sData:" + sData);
					var url = "/comment/insertComment";
					$.post(url, sData, function(rData) {
						console.log("rData", rData);
						if (rData != "true") {
							alert("댓글 등록 실패");
							return;
						}
						alert("댓글 등록 성공");
						history.go(0);
					});

				});

				$(".btnCommentModify").click(
						function() {
							console.log("댓글 수정 버튼");
							var cno = $(this).attr("data-cno"); //  getXxx
							$("#btnModalSave").attr("data-cno", cno); // setXxx
							var content = $(".btnCommentModify").parent().find(
									".description").text().trim();
							console.log("content:" + content);
							$("#modal-389461").trigger("click");

						});

				$(".btnCommentDelete").click(function() {
					console.log("댓글 삭제 버튼");
					var cno = $(this).attr("data-cno");
					var pro_no = "${productVo.pro_no}";
					console.log("cno:" + cno);
					var url = "/comment/deleteComment";
					var sData = {
						"cno" : cno,
						"pro_no" : pro_no
					};
					$.post(url, sData, function(rData) {
						console.log("rData:", rData);
						if (rData == "true") {
							alert("댓글 삭제 성공");
							history.go(0);
						} else {
							alert("댓글 삭제 실패");
							history.go(0);
						}
					});
				});

				// 댓글 수정 모달창 저장 버튼
				$("#btnModalSave").click(function() {
					var content = $("#modalContent").val();
					var cno = $(this).attr("data-cno");
					console.log("content:" + content);
					console.log("cno:" + cno);
					var url = "/comment/modifyComment";
					var sData = {
						"content" : content,
						"cno" : cno
					};
					$.post(url, sData, function(rData) {
						console.log("rData:", rData);
						if (rData == "true") {
							alert("댓글 수정 성공");
							history.go(0);
						} else {
							alert("댓글 수정 실패");
						}
					});
				});
				$(".status").click(
						function(e) {
							e.preventDefault();
							$("#frmPaging").find("input[name=pro_status]").val(
									$(this).attr("data-stat"));
							$("#frmPaging").find("input[name=page]").val(1);
							$("#frmPaging").find("input[name=pro_category]")
									.val("");
							$("#frmPaging").attr("action", "/board/main")
									.submit();
						});
				    
			}); // $(document).ready()
</script>
<!-- #masthead -->
<div class="container">
	<div id="primary" class="content-area column full">
		<main id="main" class="site-main" role="main">
			<div id="container">
				<div id="content" role="main"></div>

				<div class="container-fluid">
					<div class="row">
						<div class="col-md-6" style="width: 250px; height: 500px;">
							<div class="carousel slide" id="carousel-2948">
								<ol class="carousel-indicators">
									<c:forEach items="${propics}" var="propic" varStatus="status">
										<li data-slide-to="${status.index}"
											data-target="#carousel-2948"
											class="
											<c:if test="${propic eq propics[0]}">
											active
											</c:if>
										"></li>
									</c:forEach>
								</ol>
								<div class="carousel-inner">
									<c:forEach items="${propics}" var="propic">
										<div
											class="carousel-item
										<c:if test="${propic eq propics[0]}">
										  active
										</c:if>
										">
											<div class="img-wrapper"
												style="width: 500px; height: 500px; position: relative; overflow: hidden;">
												<img src="/board/displayImg?attach_file=${propic.pro_pic}"
													style="position: absolute; top: 0; left: 0; transform: translate(50, 50); width: 100%; height: 100%; object-fit: cover; margin: auto;">
											</div>
										</div>
									</c:forEach>
								</div>
								<a class="carousel-control-prev" href="#carousel-2948"
									data-slide="prev"><span class="carousel-control-prev-icon"></span>
									<span class="sr-only">Previous</span></a> <a
									class="carousel-control-next" href="#carousel-2948"
									data-slide="next"><span class="carousel-control-next-icon"></span>
									<span class="sr-only">Next</span></a>
							</div>
						</div>
						<div class="col-md-6">
							<div class="summary entry-summary">
								<h1 itemprop="name" class="product_title entry-title">
									상품명: ${productVo.pro_name}
									<c:if test="${loginInfo ne null}">
										<a class="button"
											href="/service_center/service_question?pro_no=${productVo.pro_no}">문의하기</a>
									</c:if>
								</h1>
								<h2>
									리뷰점수:
									<fmt:formatNumber value="${avgStar}" pattern=".0" />
									점
								</h2>
								<div itemprop="offers" itemscope
									itemtype="http://schema.org/Offer">
									<p class="price">
										<span class="amount">상품 가격: <fmt:formatNumber value="${productVo.pro_price}" pattern="#,###"/>원</span>
									</p>
									<meta itemprop="price" content="35" />
									<meta itemprop="priceCurrency" content="USD" />
									<link itemprop="availability" href="http://schema.org/InStock" />
								</div>

								<!-- 쇼핑 바스켓 전달공간 -->
								<h2>상품 옵션</h2>
								<div>
									<c:choose>
										<c:when test="${productVo.pro_status eq 'M'}">
											<c:set var="pro_stat" value="남성용"></c:set>
											<c:set var="start" value="240"></c:set>
											<c:set var="finish" value="290"></c:set>
										</c:when>
										<c:when test="${productVo.pro_status eq 'F'}">
											<c:set var="pro_stat" value="여성용"></c:set>
											<c:set var="start" value="220"></c:set>
											<c:set var="finish" value="270"></c:set>
										</c:when>
										<c:when test="${productVo.pro_status eq 'K'}">
											<c:set var="pro_stat" value="아동용"></c:set>
											<c:set var="start" value="215"></c:set>
											<c:set var="finish" value="250"></c:set>
										</c:when>
									</c:choose>
									<c:choose>
										<c:when test="${productVo.pro_category eq 'ni'}">
											<c:set var="pro_cate" value="나이키"></c:set>
										</c:when>
										<c:when test="${productVo.pro_category eq 'ad'}">
											<c:set var="pro_cate" value="아디다스"></c:set>
										</c:when>
										<c:when test="${productVo.pro_category eq 'ne'}">
											<c:set var="pro_cate" value="뉴발란스"></c:set>
										</c:when>
									</c:choose>
									${pro_stat} / ${pro_cate} <br> 사이즈 : <select id="size"
										name="size"
										style="width: 100px; height: 30px; margin-bottom: 50px;">
										<c:set var="index" value="0"/>
										<c:forEach begin="${start}" end="${finish}" step="5" varStatus="status">
											<c:choose>
												<c:when
													test="${status.begin + status.count * 5 - 5 ne productCountList[index].pro_size}">
													<option>${status.begin + status.count * 5 - 5}/재고 없음</option>
												</c:when>
												<c:otherwise>
													<option>
													${status.begin + status.count * 5 - 5}/
													<c:choose>
													  <c:when test="${productCountList[index].pro_count eq 0}">
													  재고 없음
													  </c:when>
													  <c:otherwise>
													  ${productCountList[index].pro_count}개
													  </c:otherwise>
													</c:choose>
													</option>
													<c:set var="index" value="${index + 1}"/>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</select>
									<div class="quantity" style="margin-top: 50px">
										<label>수량 :</label> <input type="number" step="1" min="1"
											max="${productCountList[index].pro_count}" name="quantity" id="quantity" value="1" title="Qty"
											class="input-text qty text" size="4" />
									</div>
									<button type="button" id="cartbutton"
										class="single_add_to_cart_button button alt"
										style="margin-top: 20px">장바구니에 담기</button>
								</div>
							</div>
						</div>
					</div>
					<!-- .summary -->
					<div class="woocommerce-tabs wc-tabs-wrapper">
						<div class="panel entry-content wc-tab" id="tab-description">

						</div>
						<div class="panel entry-content wc-tab" id="tab-reviews">
							<div id="reviews">
								<div id="comments">
									<h2>상품 리뷰</h2>

									<!-- #comment-## -->
									<c:forEach items="${commentlist}" var="commentVo">
										<ol class="commentlist" id="commentlist">

											<li itemprop="review" itemscope
												itemtype="http://schema.org/Review" class="commentli" id="">

												<div id="comment-3" class="comment_container">
													<img
														src="/board/displayImg?attach_file=${commentVo.userpic}"
														class='avatar avatar-60 photo' height='60' width='60' />
													<div class="comment-text">
														<p class="meta">
															<strong itemprop="author">${commentVo.userid}</strong>
															&ndash;
															<time itemprop="datePublished">
																${commentVo.regdate}</time>
															:
															<c:set var="commentstar" value="${commentVo.commentstar}" />
															<c:if test="${commentstar == 1}">
																				★
																			</c:if>
															<c:if test="${commentstar == 2}">
																				★★
																			</c:if>
															<c:if test="${commentstar == 3}">
																				★★★
																			</c:if>
															<c:if test="${commentstar == 4}">
																				★★★★
																			</c:if>
															<c:if test="${commentstar == 5}">
																				★★★★★
																			</c:if>
														</p>
														<div itemprop="description" class="description">
															<p>${commentVo.content}</p>
														</div>
													</div>
													<c:if test="${commentVo.userid == loginInfo.userid}">
														<button type="button" class="btnCommentModify"
															data-cno="${commentVo.cno}">수정</button>
														<button type="button" class="btnCommentDelete"
															data-cno="${commentVo.cno}">삭제</button>
													</c:if>
												</div>
											</li>
										</ol>
									</c:forEach>
									<!-- #comment-## -->

								</div>
								<c:if test="${!empty sessionScope.loginInfo}">
									<div id="review_form_wrapper">
										<div id="review_form">
											<div id="respond" class="comment-respond">
												<h3 style="margin-bottom: 10px;" id="reply-title"
													class="comment-reply-title">
													Add a review <small><a rel="nofollow"
														id="cancel-comment-reply-link"
														href="/demo-moschino/product/woo-logo-2/#respond"
														style="display: none;">Cancel reply</a></small>
												</h3>
												<!-- <form action="#" method="post" id="commentstarform"
																class="comment-form" novalidate> -->
												<p class="comment-form-rating">
													<label for="rating">리뷰 점수</label> <select
														name="commentstar" id="commentstar">
														<option value="">점수</option>
														<option value="5">★★★★★</option>
														<option value="4">★★★★</option>
														<option value="3">★★★</option>
														<option value="2">★★</option>
														<option value="1">★</option>
													</select>
												</p>
												<!-- </form> -->

												<!-- 댓글 입력 -->
												<p class="comment-form-comment">
													<label for="comment">리뷰 작성</label>
													<textarea id="c_content" name="c_content" cols="45"
														rows="8" aria-required="true"></textarea>
												</p>



												<p class="form-submit">
													<button type="button" class="submit" id="btnCommentInsert">등록
														하기</button>
												</p>


											</div>
											<!--// 댓글 입력 -->
										</div>
										<!-- #respond -->
									</div>
								</c:if>
							</div>
							<div class="clear"></div>
						</div>
					</div>
				</div>

				<!-- 댓글 수정 모달창 -->
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-12">
							<button id="modal-389461" href="#modal-container-389461"
								role="button" class="btn" data-toggle="modal"
								style="display: none">댓글 수정 화면</button>

							<div class="modal fade" id="modal-container-389461" role="dialog"
								aria-labelledby="myModalLabel" aria-hidden="true">
								<div class="modal-dialog" role="document">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title" id="myModalLabel">댓글 수정</h5>
											<button type="button" class="close" data-dismiss="modal">
												<span aria-hidden="true">×</span>
											</button>
										</div>
										<div class="modal-body">
											<input type="text" id="modalContent" class="form-control">
										</div>
										<div class="modal-footer">

											<button type="button" class="btn btn-primary"
												data-dismiss="modal" id="btnModalSave">저장</button>
											<button type="button" class="btn btn-secondary"
												data-dismiss="modal">닫기</button>
										</div>
									</div>

								</div>

							</div>

						</div>
					</div>
				</div>

				<!-- 댓글 수정 모달창 -->
			</div>
	</div>
</div>
</main>
<!-- #main -->
</div>
<!-- #primary -->
</div>
<!-- #content -->
</div>
<!-- .container -->
<footer id="colophon" class="site-footer">
	<div class="container">
		<div class="site-info">
			<h1
				style="font-family: 'Herr Von Muellerhoff'; color: #ccc; font-weight: 300; text-align: center; margin-bottom: 0; margin-top: 0; line-height: 1.4; font-size: 46px;">Moschino</h1>
			<a target="blank" href="https://www.wowthemes.net/">&copy;
				Moschino - Free HTML Template by WowThemes.net</a>
		</div>
	</div>
</footer>
</body>
</html>
<a href="#top" class="smoothup" title="Back to top"><span
	class="genericon genericon-collapse"></span></a>
</div>
<!-- #page -->
<script src='/js/jquery.js'></script>
<script src='/js/plugins.js'></script>
<script src='/js/scripts.js'></script>
<script src='/js/masonry.pkgd.min.js'></script>
</body>
</html>