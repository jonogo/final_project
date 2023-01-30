<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="../management/include/header.jsp"%>
<script>
$(document).ready(function() {
	//페이지 번호 이동
	$(".page-link").click(function(e) {
		e.preventDefault();
		let page = $(this).attr("href");
		$("#frmPaging").find("input[name=page]").val(page);
		$("#frmPaging").attr("action", "/manage/listcomment").submit();
	});
	//페이지 갯수 조절
	$(".perPage").click(function(e){
		e.preventDefault();
		let perPage = $(this).attr("href");
		$("#frmPaging").find("input[name=perPage]").val(perPage);
		$("#frmPaging").attr("action", "/manage/listcomment").submit();
	});
	// 테이블 색 변경
	$(".commentcard").mouseenter(function() {
		$(this).css("background-color", "#f3f3f3");
	});
	$(".commentcard").mouseleave(function() {
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
						<h6 class="text-white text-capitalize ps-3">상품평</h6>
					</div>
				</div>
			  <!--// 제목 카드 -->
				<div class="card-body px-2 pb-1 d-flex justify-content-center">
			    <!-- 댓글 카드 --> 
				<c:forEach items="${commentList}" var="commentVo" varStatus="status">
				  <div class="card w-20 m-2 commentcard">
  					<div class="card-body">
  					<!-- 별 생성 -->
    				  <c:forEach begin="0" end="4" varStatus="starStatus">
    				    <c:choose>
    				      <c:when test="${commentVo.commentstar gt starStatus.index}">
    				      <i class="bi bi-star-fill text-warning"></i>
    				      </c:when>
    				  	  <c:otherwise>
    				      <i class="bi bi-star text-warning"></i>
    				      </c:otherwise>
      				    </c:choose>
    				  </c:forEach>
    				<!--// 별 생성 -->
    				  <p class="card-title my-3">${commentVo.content}
    				  <br>
    				  <sub><fmt:formatDate value="${commentVo.regdate}" pattern="yyyy년 MM월 DD일"/></sub></p>
    				  <!-- 댓글 내용 -->
    				  <div style="background-color: #eeeeee; border-radius: 10px; 
    				    padding: 10px; border: 10px; margin-bottom: 5px;">
    				    <div class="d-flex px-2 py-1" style="vertical-align: bottom; height: 80px;">
    				      <div class="img-wrapper" style="width: 36px; height: 36px; border-radius: 7px">
    				        <img src="/manage/displayImg?attach_file=${commentVo.pro_pic}">
    				      </div>
    				      <p class="mt-2">상품: ${commentVo.pro_name}</p>
    				    </div>
    				    <hr>
    				    <div class="d-flex px-2 py-1" style="vertical-align: top;">
    				      <div class="img-wrapper" style="width: 36px; height: 36px; border-radius: 7px"> 
    				        <img src="/manage/displayImg?attach_file=${commentVo.userpic}">
    				      </div>
    				      <p class="mt-2">작성자: ${commentVo.username}
    				      <span style="font-size: 12px">(${commentVo.userid})</span><p>
    				    </div>
    				  </div>
    				  <!--// 댓글 내용 -->
    				  <a href="/product/detail?pro_no=${commentVo.pro_no}"
    				    class="btn btn-outline-primary">상품으로</a>
  					</div>
				  </div>
				  <c:if test="${(status.count % 5) eq 0}">
				  <!-- 5번째마다 띄우기 -->
				  </div>
				  <div class="card-body px-2 pb-1 d-flex justify-content-center">
				  <!--// 5번째마다 띄우기 -->
				  </c:if>
				</c:forEach>
				<!--// 댓글 카드 -->
				</div>
			</div>
		</div>
		<%@include file="../management/include/paging.jsp"%>
	</div>
</div>
<%@include file="../management/include/footer.jsp"%>