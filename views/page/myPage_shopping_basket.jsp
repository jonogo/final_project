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
		var check=$("#chkAll").is(":checked");
		console.log("check",check);
		var sum=0;
		$("#basketList").on("change", ".chkBasket", function(e) {
			var checked=$(this).is(":checked")
			var pro_price=parseInt($(this).attr("data-pro_price"));
			if(checked){
				sum+=pro_price;
				$("#sum").text("합계 : "+comma(sum)+"원");
					console.log(sum) 
			}else{
				sum-=pro_price;
				$("#sum").text("합계 : "+comma(sum)+"원");
				console.log(sum) 
			}
		});		
		
		$("#order").click(function(){
			var pro_nos=[];
			var pro_sizes=[];
			$("#basketList").find("input").each(function(){
				var checked=$(this).is(":checked");
 				console.log(checked);
				if(checked){
					var pro_no=$(this).attr("data-pro_no");
					var pro_size=$(this).attr("data-pro_size");
					console.log(pro_size);
					pro_nos.push(pro_no);
					pro_sizes.push(pro_size);
				}
			});
			var userid="${loginInfo.userid}"
			var orderSum=$("#sum").text();
			var url="/page/preOrderList";
			var sData={
					"pro_sizes[]":pro_sizes,
					"pro_nos[]":pro_nos,
					"userid":userid
			};
			console.log(sData);
			$.post(url,sData,function(rData){
				if(rData=="success"){
					console.log(rData);
					$("#frmOrder").submit();	
				}
			});
		});
		var checkAllsum=0;
		$("#chkAll").click(function() {
    		console.log("클릭하긴 함");
            if($("#chkAll").is(":checked")){
            	$("#basketList").find("input").prop("checked",true).change();
            }else {
            	$("#basketList").find("input").prop("checked",false).change();
            }
        });
    	

		$("#basketList").on("click", ".btnDelete", function(e) {
			e.preventDefault();
			var userid=$(this).attr("data-userid");
			var pro_no=$(this).attr("data-pro_no");
			var url="/page/delete_shopping_basket";
			var tr=$(this).parent().parent();
			console.log(tr);
			var sData={
					"userid":userid,
					"pro_no":pro_no
			}
			$.get(url,sData,function(rData){
				console.log("삭제")
				tr.remove();
				
			});
		});
		getShoppingBasket();
		function getShoppingBasket() {
			$.get("/page/shopping_basket_list", {"userid" : "${loginInfo.userid}"}, function(rData) {
				console.log("rData:", rData);
				let a=1;
				$("#basketList > tr:gt(0)").remove();
				$.each(rData, function() {
					var cloneTr = $("#basketList > tr:eq(0)").clone();
					var tds = cloneTr.find("td");
					tds.eq(0).text(a++);
					tds.eq(1).append("<img src='/member/displayImage?userpic="+this.pro_pic+"' style='height:100px'>")
					tds.eq(2).text(this.pro_no);
					tds.eq(3).text(this.pro_name);
					tds.eq(4).text(comma(this.pro_price*this.pro_quantity));	
					tds.eq(5).text(this.pro_quantity);	
					tds.eq(6).text(this.pro_size);
					tds.eq(7).append("<a href='#' class='btnDelete' data-userid='"+this.userid+"' data-pro_no='"+this.pro_no+"'>삭제</a>");
					tds.eq(8).append("<input type='checkbox' class='chkBasket' data-pro_no='"+this.pro_no+"' data-pro_size='"+this.pro_size+"' data-pro_quantity='"+this.pro_quantity+"' data-pro_price='"+this.pro_price*this.pro_quantity+"'data-pro_name='"+this.pro_name+"'>");
					$("#basketList").append(cloneTr);
					cloneTr.fadeIn(2000);
				});
			});
		};
		function comma(str) {
	        str = String(str);
	        return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
	    }
	});
</script>
<body>
<%@ include file="../includes/header_myPage.jsp"%>
<form action="/page/myPageOrder" method="get" id="frmOrder">
	<div class="col-md-12">
	
		<div class="row">
			<div class="col-md-2"></div>
			<div class="col-md-8">
			<h1>장바구니</h1>
				<table class="table">
					<thead>
						<tr>
							<th>#</th>
							<th>상품 이미지</th>
							<th>상품 번호</th>
							<th>상품 명</th>
							<th>가격</th>
							<th>수량</th>
							<th>사이즈</th>
							<th>삭제</th>
							<th><input type="checkbox" id="chkAll"></th>
						</tr>
					</thead>
					<tbody id="basketList">
							<tr style="display:none">
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
					</tbody>
				</table>
				<div id="sum">합계 : 0원</div>
				<div class="col-md-2"><button type="button" id="order">주문하기</button></div>
			</div>
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

