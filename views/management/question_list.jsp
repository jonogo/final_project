<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib  prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="../management/include/header.jsp"%>
<style>
label{
  font-size: 16px;
  color: black;
  word-wrap: break-word;
}
</style>
<script>
$(document).ready(function() {
	//문의 답변 비동기 등록
	$(".card").on("click", ".btnAjax", function(e) {
		e.stopPropagation();
		let btnAjax = $(this);
		let q_no = $(this).attr("data-qno");
		let a_content = $(this).parent().find("textarea").val();
		let url = "/questionseller/submitansewer";
		if(a_content.trim() == null || a_content.trim() == ""){
			$(".toast-header > strong").text("답변 내용 입력");
			$(".toast-body").text("답변 내용을 입력해주세요.");
			$(".toast").toast("show");
			$(this).parent().find("textarea").val("").focus();
			return;
		}
		let sData = {
			"q_no"      : q_no,
			"a_content" : a_content
		};
		$.post(url, sData, function(rData) {
			if(rData != "" && rData != null){
				btnAjax.parent().parent().parent().find(".lblFine").show();
				
				let taAnswer = btnAjax.parent().find(".taAnswer");
				let lblAnswer = $("#lblAnswer").clone();
				let val = taAnswer.val();
				taAnswer.remove();
				btnAjax.before(lblAnswer.show().text(val));
				btnAjax.before("<br>");
				btnAjax.addClass("btnUpdate").removeClass("btnAjax").text("수정하기");
				btnAjax.parent().find(".a_regdate").text(rData);
				
				$(".toast-header > strong").text("답변 등록 완료");
				$(".toast-body").text("답변을 등록했습니다.");
				$(".toast").toast("show");
			}
		});
	});
	//문의 답변 수정 버튼
 	$(".card").on("click", ".btnUpdate", function(e) {		
		e.stopPropagation();
		let taAnswer = $("#taAnswer").clone();
		let lblAnswer = $(this).parent().find(".lblAnswer");
		let text = lblAnswer.text()
		lblAnswer.remove();
		$(this).prev().remove();
		$(this).before(taAnswer.show().val(text));
		$(this).addClass("btnAjax").removeClass("btnUpdate").text("답글 달기");
	});
	//페이지 갯수 조절
	$(".perPage").click(function(e){
		e.preventDefault();
		let perPage = $(this).attr("href");
		$("#frmPaging").find("input[name=perPage]").val(perPage);
		$("#frmPaging").find("input[name=page]").val(1);
		$("#frmPaging").attr("action", "/manage/listquestion").submit();
	});
});
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
						<h6 class="text-white text-capitalize ps-3">상품문의 목록</h6>
					</div>
				</div>
				<!--// 제목 카드 -->
				<div class="card-body px-0 pb-2">
					<div id="card-808994">
					<!-- 복사용 textarea, label -->
					<textarea id="taAnswer" class="form-control taAnswer" placeholder="답글 내용을 입력해주세요"
					  style="width: 700px; height:200px; margin-left: 50px; display: none;"
					></textarea>
					<label id="lblAnswer" class="lblAnswer" style="width: 700px; padding: 6px;
 					 height:200px; padding-left:12px; display: none;"></label>
 					<!--// 복사용 textarea, label -->
					<c:forEach items="${list}" var="questionVo">
						<div class="card" style="margin:10px; margin-bottom: 20px;">
							<div class="card-header d-flex">
								<div>
								</div>
								<div>
								<!-- 문의 열람 버튼 -->
								<a class="card-link collapsed" data-toggle="collapse" 
								 data-parent="#card-808994" href="#card-element-${questionVo.q_no}"
								 style="font-size: 22px;"
								><i class="bi bi-question-square"></i> ${questionVo.q_title}</a>
								<!--// 문의 열람 버튼 -->
								</div>
								  <div>
								    <label style="font-size: 16px; margin-left: 30px;
									 margin-top: 6px;">
									 <c:choose>
									   <c:when test="${questionVo.q_kind eq 0}">
									     상품
									   </c:when>
									   <c:when test="${questionVo.q_kind eq 1}">
									     배송
									   </c:when>
									   <c:when test="${questionVo.q_kind eq 2}">
									     주문/결제
									   </c:when>
									   <c:when test="${questionVo.q_kind eq 3}">
									     서비스
									   </c:when>
									 </c:choose>
									 </label>
									<!-- 답변 완료 표시 -->					
									<label class="lblFine" style="font-size: 16px; margin-left: 30px;
									 margin-top: 6px; opacity: 0.5;
 							  	    <c:if test="${questionVo.q_step eq 0}">
 							  	       display:none;
									</c:if>
									 ">답변이 완료된 문의입니다.
									 </label>
									 <!-- 문의 열람 버튼 -->
								  </div>
								<div class="ml-auto" style="margin-top: 6px;"> 
								  <fmt:formatDate value="${questionVo.q_regdate}"
									  pattern="yyyy년 MM월 DD일 a hh시 mm분"></fmt:formatDate>
								</div>
							</div>
							<div id="card-element-${questionVo.q_no}" class="collapse">
								<div class="card-body">
								    <label>상품 정보: ${questionVo.pro_name}</label>
								    <a type="button" class="btn btn-sm btn-outline-primary"
								     href="/product/detail?pro_no=${questionVo.pro_no}"
								     style="margin-bottom: 0px; margin-left: 20px;">
								      상품 정보로</a>
								      <br>
									<label>내용: </label>
									<label style="width: 700px; padding: 8px; padding-left:12px;
 								      	  height:200px;">${questionVo.q_content}</label>
 								    <hr style="border-top: 2px solid gray;">
 								    <c:choose>
 								      <c:when test="${questionVo.q_step < 1}">
 								      <!-- 답글 등록 -->
										<label style="float: left; padding-top: 8px;">답글:</label>
										<textarea class="form-control taAnswer" placeholder="답글 내용을 입력해주세요"
										 style="width: 700px; height:200px; margin-left: 50px;"
										 ></textarea>
										<button type="button" class="btn btn-sm btn-outline-primary btnAjax"
								     	 style="margin-bottom: 0px; margin: 20px; margin-left: 50px;"
								     	 data-qno="${questionVo.q_no}">
  								          답글 달기</button>
  								       <!--// 답글 등록 -->
 								      </c:when>
 								      <c:otherwise>
 								      <!-- 답글 표시 -->
 								        <label style="float: left; padding-top: 8px;"
 								          >답글:</label>
 								      	<label class="lblAnswer" style="width: 700px; padding: 8px; padding-left:12px;
 								      	  height:200px;">${questionVo.a_content}</label>
									  <br>
 								      <button type="button" class="btn btn-sm btn-outline-primary btnUpdate"
								     	style="margin-bottom: 0px; margin: 20px; margin-left: 50px;"
								     	data-qno="${questionVo.q_no}">
  								        수정하기</button>
  								      <!--// 답글 표시 -->
 								      </c:otherwise>
 								    </c:choose>
 								    <label class="a_regdate" style="float: right; margin-right: 30px;">
 								     <c:if test="${!empty questionVo.a_regdate}">
								      <fmt:formatDate value="${questionVo.a_regdate}"
									    pattern="yyyy년 MM월 DD일 a hh시 mm분"></fmt:formatDate>
									 </c:if>
								  </label>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
				</div>
			</div>
		</div>
		<%@include file="../management/include/paging.jsp"%>
	</div>
</div>
<%@include file="../management/include/footer.jsp"%>