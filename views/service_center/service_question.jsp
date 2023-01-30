<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<link rel='stylesheet' href='css/easy-responsive-shortcodes.css' type='text/css' media='all'/>
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
$(document).write(function(){
	
});
	
</script>
<body>
<%@ include file="../includes/header_myPage.jsp"%>
	<div class="container-fluid">
	<div class="row">
		<div class="col-md-2">
		</div>
		<div class="col-md-8">
			<form role="form" action="/service_center/send_question" method="post">
				<input type="hidden" name="userid" value="${loginInfo.userid}"/>
				<input type="hidden" name="pro_no" value="${pro_no}"/>
				<div class="form-group" style="font-size:20px">
					<label for="q_title">
						제목
					</label>
					<input type="text" class="form-control" name="q_title" id="q_title" style="font-size:20px"/>
					<div>
					<select style="font-size:20px" name="q_kind">
						<option value="0">상품</option>
						<option value="1">배송</option>
						<option value="2">주문/결제</option>
						<option value="3">서비스</option>
					</select>
					</div>
				</div>
				<div class="form-group" style="font-size:20px">
					 
					<label for="q_content">
						내용
					</label>
					<textarea rows="15" cols="5" style="font-size:20px" name="q_content" id="q_content"></textarea>
				</div>
				<button type="submit">
					작성 완료
				</button>
			</form>
		</div>
		<div class="col-md-2">
		</div>
	</div>
</div>
<%@ include file="../includes/footer.jsp"%>
<!-- #page -->
<script src='js/jquery.js'></script>
<script src='js/plugins.js'></script>
<script src='js/scripts.js'></script>
<script src='js/masonry.pkgd.min.js'></script>


</body>

</html>

