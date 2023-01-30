<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="../management/include/header.jsp"%>
    <div class="container-fluid py-4">
      <div class="row">
        <!-- 주간 매출 카드 -->
        <div class="col-xl-3 col-sm-6 mb-xl-0 mb-4">
          <div class="card">
            <div class="card-header p-3 pt-2">
              <div class="icon icon-lg icon-shape bg-gradient-dark shadow-dark text-center border-radius-xl mt-n4 position-absolute">
                <div class="text-center p-3">
                  <i class="bi bi-bag-fill opacity-10 fs-5"></i>
                </div>
              </div>
              <div class="text-end pt-1">
                <p class="mb-0 text-capitalize">1주일간 매출</p>
                <h4 class="mb-0">
                  <fmt:formatNumber value="${weekPrice}" type="currency" 
                    currencySymbol="￦"></fmt:formatNumber>
                </h4>
              </div>
            </div>
          </div>
        </div>
         <!--// 주간 판매량 카드 --> 
         <!-- 주간 주문 수 카드 --> 
        <div class="col-xl-3 col-sm-6 mb-xl-0 mb-4">
          <div class="card">
            <div class="card-header p-3 pt-2">
              <div class="icon icon-lg icon-shape bg-gradient-primary shadow-primary text-center border-radius-xl mt-n4 position-absolute">
              <div class="text-center p-3">
                  <i class="bi bi-person-fill opacity-10 fs-5"></i>
              </div>
              </div>
              <div class="text-end pt-1">
                <p class="mb-0 text-capitalize">1주일간 주문 수</p>
                <h4 class="mb-0">${weekOrder}</h4>
              </div>
            </div>
          </div>
        </div>
        <!--// 주간 주문 수 카드 -->
        <!-- 처리 대기중 주문 카드 -->
        <div class="col-xl-3 col-sm-6 mb-xl-0 mb-4">
          <div class="card">
            <div class="card-header p-3 pt-2">
              <div class="icon icon-lg icon-shape bg-gradient-success shadow-success text-center border-radius-xl mt-n4 position-absolute">
              <div class="text-center p-3">
                <i class="bi bi-card-list opacity-10 fs-5"></i>
              </div>
              </div>
              <div class="text-end pt-1">
                <p class="mb-0 text-capitalize">처리 대기중 주문</p>
                <h4 class="mb-0">${leftOrder}건</h4>
              </div>
            </div>
          </div>
        </div>
        <!--// 처리 대기중 주문 카드 -->
        <!-- 새로운 문의 카드 -->
        <div class="col-xl-3 col-sm-6">
          <div class="card">
            <div class="card-header p-3 pt-2">
              <div class="icon icon-lg icon-shape bg-gradient-info shadow-info text-center border-radius-xl mt-n4 position-absolute">
              <div class="text-center p-3">
                <i class="bi bi-envelope-exclamation-fill opacity-10 fs-5"></i>
              </div>
              </div>
              <div class="text-end pt-1">
                <p class="mb-0 text-capitalize">새로운 문의</p>
                <h4 class="mb-0">${newQuestion}건</h4>
              </div>
            </div>
          </div>
        </div>
        <!-- 새로운 문의 카드 -->
      </div>
      <div class="row mt-4 mb-4">
        <!-- 최고 판매량 및 매출 테이블 -->
        <div class="col-lg-8 col-md-6 mb-md-0 mb-4">
          <div class="card">
            <div class="card-header">
              <div class="row">
                <div class="col-lg-6 col-7">
                  <h6>최고 판매량 및 매출</h6>
                </div>
              </div>
            </div>
            <div class="card-body px-0 pt-0 pb-2">
              <div class="table-responsive">
                <table class="table align-items-center mb-0">
                  <thead>
                    <tr>
                      <th class="text-uppercase text-secondary text-xs
                        font-weight-bolder opacity-7">상품명</th>
                      <th class="text-uppercase text-secondary text-xs
                        font-weight-bolder opacity-7 ps-2">판매량</th>
                      <th class="text-center text-uppercase text-secondary
                        text-xs font-weight-bolder opacity-7">상품별 매출</th>
                      <th class="text-center text-uppercase text-secondary 
                        text-xs font-weight-bolder opacity-7">상품 상세 페이지</th>
                    </tr>
                  </thead>
                  <tbody>
                  <c:forEach items="${tableList}" var="productVo">
                    <tr>
                      <td>
                        <div class="d-flex px-2 py-1">
                          <div class="img-wrapper" style="width: 36px; height: 36px; border-radius: 7px;">
                            <img src="/manage/displayImg?attach_file=${productVo.mainpic}">
                          </div>
                          <div class="d-flex flex-column justify-content-center">
                            <h6 class="mb-0 text-sm">${productVo.pro_name}</h6>
                          </div>
                        </div>
                      </td>
                      <td>
                        <div class="avatar-group mt-2">
                          <span class="text-xs font-weight-bold">${productVo.pro_count}</span>
                        </div>
                      </td>
                      <td class="align-middle text-center text-sm">
                        <span class="text-xs font-weight-bold">
                          <fmt:formatNumber value="${productVo.pro_revenue}" type="currency" 
                            currencySymbol="￦"></fmt:formatNumber>
                        </span>
                      </td>
                      <td class="align-middle text-center">
                        <div class="progress-wrapper w-75 mx-auto" >
                        <a class="btn btn-outline-primary btn-sm mb-0"
                          href="/product/detail?pro_no=${productVo.pro_no}">상품 상세 페이지</a>
                        </div>
                      </td>
                    </tr>
                  </c:forEach>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
        <!--// 최고 판매량 및 매출 테이블 -->
        <!-- 현재 주문 상태 카드 -->
        <div class="col-lg-4 col-md-6">
          <div class="card h-100">
            <div class="card-header">
              <h6>현재 주문 상태</h6>
            </div>
            <div class="card-body px-3 pb-0" >
            <c:forEach items="${orderCountList}" var="orderCountVo">
              <c:if test="${orderCountVo.order_Step eq 1}">
                <c:set var="firstStatus" value="${orderCountVo.order_count}"/>
              </c:if>
              <c:if test="${orderCountVo.order_Step eq 2}">
                <c:set var="secondStatus" value="${orderCountVo.order_count}"/>
              </c:if>
              <c:if test="${orderCountVo.order_Step eq 3}">
                <c:set var="thirdStatus" value="${orderCountVo.order_count}"/>
              </c:if>
            </c:forEach>

              <div class="timeline timeline-one-side">
                <div class="timeline-block mb-3">
                  <span class="timeline-step">
                    <i class="bi bi-basket3 fs-4 text-primary text-gradient"></i>
                  </span>
                  <div class="timeline-content">
                    <h6 class="text-dark text-sm font-weight-bold mb-0">결제 완료</h6>
                    <p class="text-secondary font-weight-bold text-xs mt-1 mb-0"
                      ><c:if test="${!empty firstStatus}">${firstStatus}건</c:if></p>
                  </div>
                </div>
                <div class="timeline-block mb-3">
                  <span class="timeline-step">
                    <i class="bi bi-card-list fs-4 text-warning text-gradient"></i>
                  </span>
                  <div class="timeline-content">
                    <h6 class="text-dark text-sm font-weight-bold mb-0">상품 준비중</h6>
                    <p class="text-secondary font-weight-bold text-xs mt-1 mb-0"
                      ><c:if test="${!empty secondStatus}">${secondStatus}건</c:if></p>
                  </div>
                </div>
                <div class="timeline-block mb-3">
                  <span class="timeline-step">
                    <i class="bi bi-cart fs-4 text-info text-gradient"></i>
                  </span>
                  <div class="timeline-content">
                    <h6 class="text-dark text-sm font-weight-bold mb-0">배송중</h6>
                    <p class="text-secondary font-weight-bold text-xs mt-1 mb-0"
                      ><c:if test="${!empty thirdStatus}">${thirdStatus}건</c:if></p>
                  </div>
                </div>
                <div class="timeline-block mb-3">
                  <span class="timeline-step">
                    <i class="bi bi-cart-check fs-4 text-success text-gradient"></i>
                  </span>
                  <div class="timeline-content">
                    <h6 class="text-dark text-sm font-weight-bold mb-0">배송 완료(1주일 이내)</h6>
                    <p class="text-secondary font-weight-bold text-xs mt-1 mb-0"
                    ><c:if test="${weekOrderComplited gt 0}">${weekOrderComplited}건</c:if></p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <!--// 현재 주문 상태 카드 -->
      </div>
      <div class="mx-auto p-3 pb-5 pt-2" style="background-color: white">
        <!-- 처리 대기중 모듈 -->
        <%@include file="../management/include/waitingOrder.jsp"%>
      </div>
	<%@include file="../management/include/footer.jsp"%>
</body>

</html>