<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
		var price=0;
		parseInt(price);
		$(".price").each(function(){
			price+=parseInt(uncomma($(this).text()));
			console.log(price);			
		});
		$("#sum").text("총합:"+comma(price)+"원");
		
		$("#btnOrder").click(function(){
			var pro_nos=[];
			var order_sizes=[];
			var order_counts=[];
			var order_addr;
			$(".pro_no").each(function(){
				pro_nos.push($(this).text());
			});
			$(".order_size").each(function(){
				order_sizes.push($(this).text());
			});
			$(".order_count").each(function(){
				order_counts.push($(this).text());
			});
			var userid="${loginInfo.userid}"
			var order_addr=$("#order_addr1").val()+" "+$("#order_addr2").val()+" "+$("#order_addr3").val();
			var sData={
					"pro_nos":pro_nos,
					"order_counts":order_counts,
					"order_sizes":order_sizes,
					"order_addr":order_addr,
					"userid":userid
			};
			var url="/page/orderList"
			console.log(sData);
			$.post(url,sData,function(rData){
				console.log(rData)
				if(rData=="success"){
					$("#frmOrder").submit();
				}
			});
		});
		function comma(str) {
	        str = String(str);
	        return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
	    }
		function uncomma(str) {
	        str = String(str);
	        return str.replace(/[^\d]+/g, '');
	    }
	});
</script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
function execPostCode() {
         new daum.Postcode({
             oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
 
                // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 도로명 조합형 주소 변수
 
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }
                // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
                if(fullRoadAddr !== ''){
                    fullRoadAddr += extraRoadAddr;
                }
 
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                console.log(data.zonecode);
                console.log(fullRoadAddr);
                
                
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                $("[name=order_addr1]").val(data.zonecode);
                $("[name=order_addr2]").val(fullRoadAddr);
//                 document.getElementById('user_addr1').value = data.zonecode; //5자리 새우편번호 사용
//                 document.getElementById('user_addr2').value = fullRoadAddr;
                
                /* document.getElementById('signUpUserPostNo').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('signUpUserCompanyAddress').value = fullRoadAddr;
                document.getElementById('signUpUserCompanyAddressDetail').value = data.jibunAddress; */
            }
         }).open();
     }
</script>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<body>
<%@ include file="../includes/header_myPage.jsp"%>	
<form id="frmOrder" action="/board/main" method="post">
<input type="hidden" name="userid" value="${loginInfo.userid}"/>
	<div class="col-md-12">
		<div class="row">
			<div class="col-md-2"></div>
			<div class="col-md-8">
			<h1>주문하기</h1>
				<table class="table">
					<thead>
						<tr>
							<th>#</th>
							<th>상품 사진</th>
							<th>상품 번호</th>
							<th>상품명</th>
							<th>사이즈</th>
							<th>갯수</th>
							<th>가격</th>
							<th>적립 포인트</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${preOrderList}" var="orderVo" varStatus="status">
							<tr>
								<td>${status.count}</td>
								<td><img src="/member/displayImage?userpic=${orderVo.mainpic}" style="height:50px"/></td>
								<td class="pro_no">${orderVo.pro_no}</td>
								<td>${orderVo.pro_name}</td>
								<td class="order_size">${orderVo.order_size}</td>
								<td class="order_count">${orderVo.order_count}</td>
								<td class="price">
								<fmt:formatNumber value="${orderVo.pro_price}" pattern="#,###" />		
								</td>								
								<td id="point" class="point">
									<fmt:parseNumber var= "price" integerOnly= "true" value= "${orderVo.order_count*orderVo.pro_price*0.08}" />
									${price}
								</td>								
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<table style="border:0px">
					<tr>
						<th>주소</th>
							<td>
								<input class="pass" style="width: 40%; display: inline;" placeholder="우편번호" name="order_addr1" id="order_addr1" type="text" readonly="readonly" >
	                			<button type="button" class="submit btn btn-default" onclick="execPostCode();"><i class="fa fa-search"></i> 우편번호 찾기</button>
	     						
							</td>
						</tr>
						<tr>
							<td></td>
							<td>
								<input class="pass" style="top: 5px; width:40%" placeholder="도로명 주소" name="order_addr2" id="order_addr2" type="text" readonly="readonly" />
								<input class="pass" placeholder="상세주소" name="order_addr3" id="order_addr3" type="text"  />  
							</td>
							<td>
								   
							</td>
						</tr>
				</table>
				
				<div id="sum">총합 : 0 원</div>
				<div><button type="button" id="btnOrder">주문하기</button></div>
			</div>
			<div class="col-md-2"></div>
		</div>
	</div>
</form>
	<%@ include file="../includes/footer.jsp"%>
<!-- #page -->
<script src='/js/jquery.js'></script>
<script src='/js/plugins.js'></script>
<script src='/js/scripts.js'></script>
<script src='/js/masonry.pkgd.min.js'></script>
</body>
</html>

<%session.removeAttribute("preOrderList");%>