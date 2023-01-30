<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<style>
#divBoardImg{
  background-repeat: no-repeat;
  background-size: cover;
}
</style>
<!-- 처리 대기중 모듈 -->
            <div class="col-12 mt-4">
	<div class="mb-5 ps-3">
		<h3 class="mb-1">처리 대기중 주문</h3>
		<p class="text-sm">현재 처리를 기다리고 있는 주문입니다.</p>
	</div>
	<div class="row">
		<c:forEach items="${boardList}" var="orderVo">
			<div class="col-xl-3 col-md-6 mb-xl-0 mb-4">
				<div class="card card-blog card-plain" style="height: 450px;">
					<div class="card-header p-0 mt-n4 mx-3">
						<div class="d-block shadow-xl img-wrapper"
							style="width: 330px; height: 230px; border-radius: 5px;"
							id="divBoardImg">
							<img src="displayImg?attach_file=${orderVo.mainpic}">
						</div>
					</div>
					<div class="card-body p-3">
						<p class="mb-0 text-sm">
							<c:choose>
								<c:when test="${orderVo.order_step eq 1}">
                  		  결제 완료
                  		</c:when>
								<c:when test="${orderVo.order_step eq 2}">
                  		  상품 준비중
                  		</c:when>
							</c:choose>
						</p>
						<h5 style="height: 50px;">
							<a href="/product/detail?pro_no=${orderVo.pro_no}">
								${orderVo.pro_name} </a>
						</h5>
						<p class="mb-4 text-sm" style="height: 70px;">
							${orderVo.pro_name}[${orderVo.pro_no}]의 상품 정보로 가시려면 상품 이름을, 주문
							정보[${orderVo.order_no}]로 이동하시려면 주문으로 버튼을 눌러주세요</p>
						<div class="d-flex align-items-center justify-content-between">
							<a href="/ordersell/detail?order_no=${orderVo.order_no}"
								class="btn btn-outline-success btn-sm mb-0"> 주문으로 </a>
						</div>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
</div>
<!--// 처리 대기중 모듈 -->