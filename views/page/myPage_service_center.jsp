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
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">	

</head>
<style>
	th,td{
		height:50px,
	}
	div{
		font-size:15px
	}
</style>
<script>
	

</script>
<body>
<%@ include file="../includes/header_myPage.jsp"%>
<div class="container-fluid">
	<div class="row">
	<div class="col-md-2"></div>
		
		<div class="col-md-8">
		<form>
		<table>
			<tr text-align="center">
				<th>문의 내용</th>
			</tr>
			<c:forEach items="${serviceList}" var="serviceList" varStatus="status">
			<tr>
				<td>
					<div id="card-123769${status.count}">
					<div class="card">
						<div class="card-header">
							 <a class="card-link collapsed" data-toggle="collapse" data-parent="card-123769${status.count}" href="#card-element-650069${status.count}">${serviceList.q_title}</a>
						</div>
						<div id="card-element-650069${status.count}" class="collapse">
							<div class="card-body">
								${serviceList.q_content}
								<c:if test="${serviceList.q_step eq 1}">
									<div>
										<hr>
										${serviceList.a_content}
									</div>
								</c:if>
							</div>
						</div>
					</div>
					</div>
				</td>
				<td>
				<c:if test="${serviceList.q_step eq 1}">
					o
				</c:if>
				</td>
			</tr>
			</c:forEach>
		</table>
		</form>
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

