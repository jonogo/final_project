<%@ page language="java" contentType="text/html; charset=utf-8"
pageEncoding="utf-8"%>
<%@include file="../management/include/header.jsp"%>
<%@taglib  prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
.card-top{
  font-size: 20px;
  font-weight: bold;
  color: #f2f2f2;
}
.list-group-item{
	height: 75px;
	font-size: 20px;
	font-weight: bold;
}
</style>
<script>
$(document).ready(function() {
	//토스트
	if("${stepResult}" == "true") {
		$(".toast-header > strong").text("주문 상태 갱신");
		$(".toast-body").text("주문 상태가 갱신되었습니다.");
		$(".toast").toast("show");
	}
	//상품 단계 이동
	$("#btnNextStep").click(function() {
		let step = "${map.orderVo.order_step}";
		switch(step){
			case "1":
				if(confirm("상품 준비중 단계로 넘어가시겠습니까?")){
					submitFrmStep("/ordersell/modifystep");
				}
				break;
			case "2":
				let tracking = prompt("운송장 번호를 입력해주세요");
				if(tracking.trim() == null || tracking.trim() == ""){
					alert("운송장 번호를 입력해주세요!");
					return false;
				}
				let inputTrack = $("#inputNo").clone();
				inputTrack.attr("name", "tracking_no")
				          .attr("id", "inputTrack")
				          .val(tracking);
				$("#inputNo").after(inputTrack);
				submitFrmStep("/ordersell/setTracking");		
				break;
			case "3":
				if(confirm("배송 완료단계로 넘어가시겠습니까?")){
					submitFrmStep("/ordersell/modifystep");					
				}
				break;
		}
	});
	function submitFrmStep(path) {
		let frmStep =  $("#frmStep");
		frmStep.attr("action", path);
		$("#inputNo").val("${map.orderVo.order_no}");
		$("#inputStep").val("${map.orderVo.order_step}");
		frmStep.submit();	
	}
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
						<h6 class="text-white text-capitalize ps-3">주문 상세 정보</h6>
					</div>
				</div>
			  <!--// 제목 카드 -->
				<div class="card-body px-0 pb-2 " style="margin: 30px;">
			   		<!-- 배경색 및 버튼 경로 설정 -->
					<c:set var="color_0" value="bg-secondary"/>
					<c:set var="color_1" value="bg-secondary"/>
					<c:set var="color_2" value="bg-secondary"/>
					<c:set var="color_3" value="bg-secondary"/>
					<c:choose>
						<c:when test="${map.orderVo.order_step eq 1}">
							<c:set var="color_0" value="bg-warning"/>
							<c:set var="btn_step" value="주문 확정"/>
						</c:when>
						<c:when test="${map.orderVo.order_step eq 2}">
							<c:set var="color_1" value="bg-warning"/>
							<c:set var="btn_step" value="운송장입력"/>
						</c:when>
						<c:when test="${map.orderVo.order_step eq 3}">
							<c:set var="color_2" value="bg-primary"/>
							<c:set var="btn_step" value="배송 완료"/>
						</c:when>
						<c:when test="${map.orderVo.order_step eq 4}">
							<c:set var="color_3" value="bg-success"/>
						</c:when>
					</c:choose>
					<!--// 배경색 및 버튼 경로 설정 -->
					<div class="col-md-12">
					  <div class="d-flex justify-content-between" style="display: flex; margin-left: 15px; margin-top: 15px;">
					    <!-- 메인 이미지 -->
					    <div class="img-wrapper"
              		   	  style="border-radius: 10px; width: 500px; height: 500px;">
						  <img src="/manage/displayImg?attach_file=${map.productVo.mainpic}"
						    class="img-thumbnail"/>
						</div>
						<!--// 메인 이미지 -->
						<!-- 상품 정보 -->
						<ul class="list-group" style="width: 500px;
							margin-top: 50px; margin-bottom: 20px;">
							<li class="list-group-item">주문 번호: ${map.orderVo.order_no}</li>
							<li class="list-group-item">상품명: ${map.productVo.pro_name}
							  <a type="button" class="btn btn-sm btn-outline-primary"
							  	style="margin-bottom: 0px;" 
							  	href="/product/detail?pro_no=${map.productVo.pro_no}">
							    상품 정보로</a>
							</li>
							<li class="list-group-item">구매자(ID): ${map.orderVo.userid}</li>
							<li class="list-group-item">사이즈: ${map.orderVo.order_size}</li>
							<li class="list-group-item">수량: ${map.orderVo.order_count}</li>
							<li class="list-group-item">배송 주소: ${map.orderVo.order_addr}</li>
							<c:if test="${!empty map.orderVo.tracking_no}">
							  <li class="list-group-item">운송장번호:
							  	${map.orderVo.tracking_no}</li>
							</c:if>
						</ul>
						<!--// 상품 정보 -->
  					    </div>
						  <!-- 주문 상태 카드 -->
						  <div style="width: 780px; float: right;">
							<h3 class="text-center">
							  주문 상태
							</h3>
							<div class="card-group"
								id="divCardGroup">
							<div class="card ${color_0}">
								<div class="card-body text-center">
									<p class="card-text card-top">결제 완료</p>
									<p class="card-text">처리 시간:<br>
									<fmt:formatDate value="${map.list[0].regdate}"
									pattern="yyyy년 MM월 DD일 a hh시 mm분 ss초"></fmt:formatDate></p>
								</div>
							</div>
							<div class="card ${color_1}">
								<div class="card-body text-center">
								    <p class="card-text card-top">상품준비중</p>
									<c:if test="${!empty map.list[1]}">
									  <p class="card-text">처리 시간:<br>									
									  <fmt:formatDate value="${map.list[1].regdate}"
									  pattern="yyyy년 MM월 DD일 a hh시 mm분 ss초"></fmt:formatDate></p>
									</c:if>
								</div>
							</div>
							<div class="card ${color_2}">
								<div class="card-body text-center">
									<p class="card-text card-top">배송중</p>
									<c:if test="${!empty map.list[2]}">
									  <p class="card-text">처리 시간:<br>									
									  <fmt:formatDate value="${map.list[2].regdate}"
									  pattern="yyyy년 MM월 DD일 a hh시 mm분 ss초"></fmt:formatDate></p>
									</c:if>
								</div>
							</div>
							<div class="card ${color_3}">
								<div class="card-body text-center">
									<p class="card-text card-top">배송 완료</p>
									<c:if test="${!empty map.list[3]}">
									  <p class="card-text">처리 시간:<br>									
									  <fmt:formatDate value="${map.list[2].regdate}"
									  pattern="yyyy년 MM월 DD일 a hh시 mm분 ss초"></fmt:formatDate></p>
									</c:if>
								</div>
						    </div>
						</div>
						<form id="frmStep" action="" method="post">
						  <input type="hidden" id="inputNo" name="order_no">
						  <input type="hidden" id="inputStep" name="order_step">
						  <button type="button" class="btn btn-outline-success"
						    style="margin-left: 350px; margin-top: 10px;
						    <c:if test="${map.orderVo.order_step eq 4}">
						      display: none;
						    </c:if>"
						    id="btnNextStep">
							${btn_step}</button>
						</form>
						</div>
						<!-- 주문 상태 카드 -->
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<%@include file="../management/include/footer.jsp"%>
</body>
</html>