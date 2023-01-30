<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@include file="../management/include/header.jsp"%>
<script>
$(document).ready(function() {
	//비밀번호 확인
	$("#btnPwCheck").click(function() {
		let url = "/seller/nowPwCheck";
		let sData = {"nowPw" : $("#nowPw").val()};
		$.post(url, sData, function(rData) {
			if(rData == "true"){				
				$(".pw").attr("disabled", false);
				$("#nowPw").attr("disabled", true);
				$("#btnPwCheck").text("비밀번호 확인 완료");
			} else {
				alert("현재 비밀번호를 다시 입력해주세요.");
				$("#nowPw").focus();
			}
		});
	});
	// 폼 제출
	$("#frmUpdate").submit(function() {
		if($("#seller_person").val().trim() == "" ||
		   $("#seller_pw").val().trim() == "" ||
		   $("#seller_pw_re").val().trim() == "" ||
		   $("#seller_name").val().trim() == "" ||
		   $("#seller_phone").val().trim() == "" ||
		   $("#seller_email").val().trim() == "" ||
		   $("#seller_addr").val().trim() == ""){
			alert("모든 입력 항목을 입력해주세요");
			return false;
		}
		let pw = $("#seller_pw").val().trim();
		let pw_re = $("#seller_pw_re").val().trim();
		if(pw != pw_re){
			alert("새로운 비밀번호와 비밀번호를 같게 해 주세요");
			$("#seller_pw_re").focus();
			return false;
		}
	});
});
</script>
<div class="container-fluid px-2 px-md-4">
	<div class="page-header min-height-300 border-radius-xl mt-4" 
	  style="background-image: url(/manager/assets/img/background.png);">
        <span class="mask bg-gradient-light opacity-2"></span>
	</div>
	<div class="card card-body mx-3 mx-md-4 mt-n6">
		<div class="row">
			<div class="col-md-12">
				<div class="row">
					<div class="col-md-10" style="margin: 30px;">
						<h2 class="text-sm">정보 수정</h2>
						<hr class="horizontal gray-light my-4">
						<!-- 정보수정 폼 -->
						<form action="/seller/updatesellerinfo" method="post" id="frmUpdate">
							<ul class="list-group list-group-flush">
								<li class="list-group-item" style="padding: 10px; float: left"><label
									style="width: 200px" for="seller_person"> <strong
										class="text-dark">대표자:</strong> &nbsp;
								</label><input type="text" style="width: 200; margin-left: 150px;"
									id="seller_person" name="seller_person"
									value="${sellerVo.seller_person}"></li>
								<li class="list-group-item" style="padding: 10px;"><label
									style="width: 200px" for="nowPw"> <strong
										class="text-dark">현재 비밀번호:</strong> &nbsp;
								</label><input type="password" style="width: 200; margin-left: 150px;"
									id="nowPw">
									<button type="button" class="btn btn-light" id="btnPwCheck"
										style="margin: 15px; margin-left: 20px">현재 비밀번호 확인</button></li>
								<li class="list-group-item" style="padding: 10px;"><label
									style="width: 200px"> <strong class="text-dark">새로운
											비밀번호:</strong> &nbsp;
								</label><input type="password" style="width: 200; margin-left: 150px;"
									class="pw" name="seller_pw" id="seller_pw" disabled></li>
								<li class="list-group-item" style="padding: 10px;"><label
									style="width: 200px"> <strong class="text-dark">비밀번호
											확인:</strong> &nbsp;
								</label><input type="password" style="width: 200; margin-left: 150px;"
									class="pw" id="seller_pw_re" disabled></li>
								<li class="list-group-item" style="padding: 10px;"><label
									style="width: 200px"> <strong class="text-dark">회사 이름:</strong>
										&nbsp;
								</label><input type="text" style="width: 200; margin-left: 150px;"
									value="${sellerVo.seller_name}" id="seller_name"
									name="seller_name"></li>
								<li class="list-group-item" style="padding: 10px;"><label
									style="width: 200px"> <strong class="text-dark">전화번호:</strong>
										&nbsp;
								</label><input type="text" style="width: 200; margin-left: 150px;"
									value="${sellerVo.seller_phone}" id="seller_phone"
									name="seller_phone"></li>
								<li class="list-group-item" style="padding: 10px;"><label
									style="width: 200px"> <strong class="text-dark">이메일:</strong>
										&nbsp;
								</label><input type="email" style="width: 200; margin-left: 150px;"
									value="${sellerVo.seller_email}" id="seller_email"
									name="seller_email"></li>
								<li class="list-group-item" style="padding: 10px;"><label
									style="width: 200px"> <strong class="text-dark">주소:</strong>
										&nbsp;
								</label><input type="text" style="width: 200; margin-left: 150px;"
									value="${sellerVo.seller_addr}" id="seller_addr"
									name="seller_addr"></li>
							</ul>
							<button type="button" onclick="history.back(-1)"
								class="btn btn-light" style="margin: 15px">목록으로</button>
							<button type="submit" class="btn btn-light" style="margin: 15px">개인정보
								변경</button>
						</form>
						<!-- 정보수정 폼 -->
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="card-body p-3"></div>
</div>
<%@include file="../management/include/footer.jsp"%>
</body>

</html>