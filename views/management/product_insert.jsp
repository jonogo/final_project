<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@include file="../management/include/header.jsp"%>
<style>
#fileDrop{
	width : 60%;
	height: 100px;
	background-color: aqua;
	margin: 20px;
	margin-bottom: 10px;
	border: 2px dashed silver;
}
.size-val{
	width: 75px;
}
.divUploaded{
	height: 200px;
	float: left;
	margin: 12px;
	margin-left: 0px;
}
</style>
<script src="/manager/assets/js/myscript.js"></script>
<script>
$(document).ready(function() {
	//등록후 토스트 생성
	if("${registResult}" == "true"){
		$(".toast-header > strong").text("상품 등록 완료");
		$(".toast-body").text("새로운 상품이 등록되었습니다.");
		$(".toast").toast("show");
	} else if("${registResult}" == "false") {
		$(".toast-header > strong").text("상품 등록 실패");
		$(".toast-body").text("상품이 실패했습니다. 다시 확인해주세요");
		$(".toast").toast("show");
	}
	//상품 입력
	$("#frmProduct").submit(function() {
		let price = $("#pro_price").val().trim();
		let name = $("#pro_name").val().trim();
		if (name == "") {
			alert("상품명을 입력해주세요");
			$("#pro_name").focus();
			return false;
		}
		if (price == "" || price == 0) {
			alert("상품 가격을 입력해주세요");
			$("#pro_price").focus();
			return false;
		}
		let b1 = false;
		$(".size-val").each(function() {
			let val = $(this).val();
			if(val == ""|| val == null){
				val = 0;
				$(this).val(0);
			}
			let b2 = true;
			if(val <= 0) b2 = false;
			b1 = b1 || b2;
		});
		if(!b1){
			alert("수량을 입력해주세요");
			return false;
		}
		if($(".divUploaded").length < 2){
			alert("1개 이상 사진을 등록해주세요");
			return false;
		}
		let divs = $("#uploadList .divUploaded");
		divs.each(function(index) {
			let filename = $(this).find("a").attr("href");
			let inputTag = "<input type='hidden' name='files[" + index + "]";
			inputTag += "'value='" + filename + "'>";
			$("#frmProduct").prepend(inputTag);
		});
	});
	// 남성용 테이블 변화
	$("#rdoMale").change(function() {
		if ($(this).prop("checked")) {
			$(".size-val").parent().show();
			$(".size").show();
			let mSize = 240;
			let i = 0;
			$(".size-val").each(function() {
				$(this).val(0);
				$(this).parent().parent().prev()
				       .children("td:eq(" + i++ + ")").text(mSize);
				$(this).attr("name", "s_" + mSize);
				mSize += 5;
			});
		}
	});
	// 여성용 테이블 변화
	$("#rdoFemale").change(function() {
		if ($(this).prop("checked")) {
			$(".size-val").parent().show();
			$(".size").show();
			let fSize = 220;
			let i = 0;
			$(".size-val").each(function() {
				$(this).val(0);
				$(this).parent().parent().prev()
				 	   .children("td:eq(" + i++ + ")").text(fSize);
				$(this).attr("name", "s_" + fSize);
				fSize += 5;
			});
		}
	});
	// 아동용 테이블 변화
	$("#rdoKids").change(function() {
		if ($(this).prop("checked")) {
			let kSize = 215;
			let i = 0;
			$(".size-val").each(function() {
				$(this).val(0);
				let sizeTr = $(this).parent().parent().prev().children("td:eq(" + i++ + ")");
				if (kSize > 250) {
					$(this).parent().hide();
					sizeTr.hide();
				} else {
					sizeTr.text(kSize);
					$(this).attr("name", "s_" + kSize);
					kSize += 5;
				}
			});
		}
	});
	//전체 입력
	$("#btnAddAll").click(function() {
		$(".size-val").val($("#addAll").val());
		if($(".tdOver").css("display") == "none"){
			$(".tdOver > input").val(0);
		}
	});
	//파일 비동기 업로드
	$("#fileDrop").on("dragenter dragover", function(e) {
		e.preventDefault();
	});
	$("#fileDrop").on("drop", function(e) {
		e.preventDefault();
		if($(".divUploaded").length > 5){
			alert("이미지는 5개까지 입력 가능합니다");
			return;
		}
		let file = e.originalEvent.dataTransfer.files[0];
		let result = isExtImage(file);
		if(!result){
			alert("이미지 파일을 넣어주세요");
			return;
		}
		let formData = new FormData();
		formData.append("file", file);
		let url = "/product/fileupload";
		$.ajax({
			"processData" : false,
			"contentType" : false,
			"url" 		  : url,
			"method" 	  : "post",
			"data"		  : formData,
			"success" 	  : function(rData) {
				let div = $("#uploadList").prev().clone();
				$("#uploadList").append(div);
				div.find("img").attr("src", "/manage/displayImg?attach_file=" + rData);
				div.fadeIn(1000);
				div.find("a").attr("href", rData);
			}
		});
	});
	// 이미지 지우기
	$("#uploadList").on("click", ".btnDelete", function(e) {
		e.preventDefault();
		let deleteImg = $(this).attr("href");
		let url = "/product/deleteImg";
		let sData = {"deleteImg" : deleteImg};
		let deleteDiv = $(this).parent();
		$.post(url, sData, function(rData) {
			if(rData == "true"){				
				deleteDiv.remove();
			}
		});
	});
});
</script>
<div class="container-fluid px-2 px-md-4">
	<div class="col-lg-10 col-md-10 mx-auto">
	   <%@include file="../management/include/toast.jsp"%>
		<form action="/product/registproduct" method="post" id="frmProduct">
			<div class="card mt-4">
				<div class="row">
					<div class="col-md-4">
						<!-- 상품 데이터 등록 폼 -->
						<div class="container" style="margin: 25px;">
							<h2>신규 상품 등록</h2>
							<p>아래 항목을 모두 입력해주세요.</p>
							
							<div class="form-group" style="margin-top: 80px">
								<label for="pro_name" style="float: left; padding-top: 8px;">상품명:</label>
								<input type="text" class="form-control" id="pro_name"
									name="pro_name" placeholder="이름을 입력해주세요"
									style="width: 175px; margin-left: 150px;">
							</div>
							<div class="form-group">
								<label for="pro_price" style="float: left; padding-top: 8px;">상품
									가격:</label> <input type="number" class="form-control" id="pro_price"
									placeholder="가격을 입력해주세요" name="pro_price"
									style="width: 175px; margin-left: 150px;">
							</div>
							<!-- 카테고리 셀렉트 박스 -->
							<div class="form-group form-check" style="padding-left: 5px;">
								<select class="form-check-select" name="pro_category">
									<option selected value="ad">아디다스</option>
									<option value="ni">나이키</option>
									<option value="ne">뉴발란스</option>
								</select>
							</div>
							<!--// 카테고리 셀렉트 박스 -->
							<!-- 성별 라디오 버튼 -->
							<div class="form-group form-check" style="padding-left: 5px;">
								<label class="form-check-label"> <input id="rdoMale"
									class="form-check-input" type="radio" name="pro_status"
									value="M" checked> 남성용
								</label> <label class="form-check-label"> <input id="rdoFemale"
									class="form-check-input" type="radio" name="pro_status"
									value="F"> 여성용
								</label> <label class="form-check-label"> <input id="rdoKids"
									class="form-check-input" type="radio" name="pro_status"
									value="K"> 어린이용
								</label>
							</div>
							<!--// 성별 라디오 버튼 -->
							<!-- 사이즈 한번에 입력 -->
							<label for="btnAddAll"> 한꺼번에 입력: </label> <input id="addAll"
								type="number" style="width: 100px;">
							<button id="btnAddAll" class="btn btn-sm btn-success"
								type="button" style="margin-bottom: 2px;">입력</button>
							<!--// 사이즈 한번에 입력 -->
						</div>
						<!--// 상품 데이터 등록 폼 -->
					</div>
					<div class="col-md-8">
						<!-- 이미지 등록 div -->
						<div style="display: none; width: 150px; height: 150px;" class="divUploaded img-wrapper">
							<img src=""><br>
							<a href="#" class="btn btn-sm btn-danger btnDelete mt-7">
							<i class="bi bi-x-square"></i></a>
						</div>
						<!--// 이미지 등록 div -->
						<div id="uploadList" style="clear:both"></div>
						<!-- 파일 비동기 입력창 -->
						<div style="margin-top: 300px;">
							<div id="fileDrop"></div>
							<label style="margin: 15px; margin-top: 0px; margin-left: 20px;">
								첨부할 파일을 드래그 &amp; 드롭하세요
							</label>
						</div>
						<!--// 파일 비동기 입력창 -->
					</div>
					<div class="d-flex justify-content-center">
						<div class="table-responsive" style="margin-left: 30px;">
							<!-- 사이즈 입력 테이블 -->
							<table id="td1" class="table table-bordered" style="width: 20px;">
								<tr>
									<th>사이즈</th>
									<td class="size">240</td>
									<td class="size">245</td>
									<td class="size">250</td>
									<td class="size">255</td>
									<td class="size">260</td>
									<td class="size">265</td>
									<td class="size">270</td>
									<td class="size">275</td>
									<td class="size">280</td>
									<td class="size">285</td>
									<td class="size">290</td>
								</tr>
								<tr>
									<th>수량</th>
									<td><input type="number" id="size-1" class="size-val"
										name="s_240" value="0"></td>
									<td><input type="number" id="size-2" class="size-val"
										name="s_245" value="0"></td>
									<td><input type="number" id="size-3" class="size-val"
										name="s_250" value="0"></td>
									<td><input type="number" id="size-4" class="size-val"
										name="s_255" value="0"></td>
									<td><input type="number" id="size-5" class="size-val"
										name="s_260" value="0"></td>
									<td><input type="number" id="size-6" class="size-val"
										name="s_265" value="0"></td>
									<td><input type="number" id="size-7" class="size-val"
										name="s_270" value="0"></td>
									<td><input type="number" id="size-8" class="size-val"
										name="s_275" value="0"></td>
									<td class="tdOver"><input type="number" id="size-9" class="size-val"
										name="s_280" value="0"></td>
									<td class="tdOver"><input type="number" id="size-10" class="size-val"
										name="s_285" value="0"></td>
									<td class="tdOver"><input type="number" id="size-11" class="size-val"
										name="s_290" value="0"></td>
								</tr>
							</table>
							<!--// 사이즈 입력 테이블 -->
						</div>
					</div>
					<!-- 제출 버튼 -->
					<div class="d-flex justify-content-center">
						<button type="submit" class="btn btn-primary"
						    style="margin-top: 15px; width: 500px;">상품 등록</button>
					</div>
					<!--// 제출 버튼 -->
				</div>
			</div>
		</form>
	</div>
</div>
<%@include file="../management/include/footer.jsp"%>
</body>
</html>