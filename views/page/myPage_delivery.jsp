<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel='stylesheet' href='/css/myPage_cardInfo.css' type='text/css' media='all'/>
<link rel='stylesheet' href='/css/woocommerce-layout.css' type='text/css' media='all'/>
<link rel='stylesheet' href='/css/woocommerce-smallscreen.css' type='text/css' media='only screen and (max-width: 768px)'/>
<link rel='stylesheet' href='/css/woocommerce.css' type='text/css' media='all'/>
<link rel='stylesheet' href='/css/font-awesome.min.css' type='text/css' media='all'/>
<link rel='stylesheet' href='/style.css' type='text/css' media='all'/>
<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Oswald:400,500,700%7CRoboto:400,500,700%7CHerr+Von+Muellerhoff:400,500,700%7CQuattrocento+Sans:400,500,700' type='text/css' media='all'/>
<link rel='stylesheet' href='/css/easy-responsive-shortcodes.css' type='text/css' media='all'/>
   <meta name="viewport" content="width=device-width, initial-scale=1">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<style>
	th,td{
		height:50px
	}
</style>
<script>
	$(document).ready(function(){
		var delivery;
		$(".btnDelivery").on("click",function(){
			$("#t_invoice").text("");
			console.log("클릭");
			delivery=$(this).attr("data-tracking_no");
			console.log(delivery);
			$("#t_invoice").val(delivery);
			$("#frameDiv").attr("style","display");
			$("#closeFrame").attr("style","display");
			$("#delivery_btn").trigger("click");
		});
		$("#closeFrame").on("click",function(){
			console.log("닫기 클릭");
			$("#frameDiv").attr("style","display:none");
			$("#closeFrame").attr("style","display:none");
		});
		tracking_no=$("#tracking_no").attr("data-tracking_no");
		$("#t_invoice").val(tracking_no);

	});
</script>
<body>
<%@ include file="../includes/header_myPage.jsp"%>
<form action="http://info.sweettracker.co.kr/tracking/5" id="frmDelivery" method="post"  target="delivery" align="center" style="display:none">
                    <div class="form-group">
                      <label for="t_key">API key</label>
                      <input type="hidden" class="form-control" id="t_key" name="t_key" placeholder="제공받은 APIKEY" value="4s8WGSzbR5s3zMNXx9xUdg">
                    </div>
                    <div class="form-group">
                      <label for="t_code">택배사 코드</label>
                      <input type="text" class="form-control" name="t_code" id="t_code" placeholder="택배사 코드" value="04">
                    </div>
                    <div class="form-group">
                      <label for="t_invoice">운송장 번호</label>
                      <input type="text" class="form-control" name="t_invoice" id="t_invoice" placeholder="운송장 번호">
                    </div>
                    <button type="submit" class="btn btn-default" id="delivery_btn">조회하기</button>
</form>
		<div class="col-md-12" id="frameDiv" style="display:none">
			<div class="row">
				<div class="col-md-4">
				</div>
				<div class="col-md-4">
				
				<iframe src="" width="800" height="300" scrolling="yes" align="center" name="delivery" id="deliveryFrame">
				</iframe>
				<button type="button" id="closeFrame" style="display:none" align="right">닫기</button>
				
				</div>
				<div class="col-md-4">
				</div>
			</div>
		</div>
	
	<div class="col-md-12">
		<div class="row">
			<div class="col-md-2"></div>
			<div class="col-md-8">
			<h1>배송 조회</h1>
				<table class="table">
					<thead>
						<tr>
							<th>#</th>
							<th>상품명</th>
							<th>상품 배송</th>
							<th>배송 조회</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${orderList}" var="orderVo" varStatus="status">
							<tr>
								<td>${status.count}</td>
								<td>${orderVo.pro_name }</td>
								<td>
									<c:choose>
										<c:when test="${orderVo.order_step eq 1}">
											결제완료		
										</c:when>
										<c:when test="${orderVo.order_step eq 2}">
											상품준비중		
										</c:when>
										<c:when test="${orderVo.order_step eq 3}">
											배송중	
										</c:when>
										<c:when test="${orderVo.order_step eq 4}">
											배송완료	
										</c:when>
									</c:choose>
								</td>
								<td>
								<c:if test="${orderVo.order_step gt 2}">
									<button type="button" class="btnDelivery" id="tracking_no"
									 data-tracking_no=
									 <c:if test="${orderVo.tracking_no ne null}">
									 	"${orderVo.tracking_no}"
									 </c:if>
									 >배송 조회</button>
								 </c:if>
								 </td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="col-md-2"></div>
		</div>
	</div>
	<%@ include file="../includes/footer.jsp"%>
<!-- #page -->
<script src='/js/jquery.js'></script>
<script src='/js/plugins.js'></script>
<script src='/js/scripts.js'></script>
<script src='/js/masonry.pkgd.min.js'></script>
</body>
</html>

