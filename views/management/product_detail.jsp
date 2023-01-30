<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="../management/include/header.jsp"%>
<script>
$(document).ready(function() {
	// 상품명 변경
	$("#changeName").click(function(e) {
		e.preventDefault;
		changeAjax($(this), "/product/modifyName", "name");
	});
	// 상품가격 변경
	$("#changePrice").click(function(e) {
		e.preventDefault();
		changeAjax($(this), "/product/modifyPrice", "price");
	});
	//상품 사이즈 남은 수 변경
	$(".changeSize").click(function(e) {
		e.preventDefault();
		let inputSize = $(this).prev();
		let iconTag = $(this).find("i");
		let label = $(this).find("label");		
		if(iconTag.attr("class") == "bi bi-pencil-square"){
			inputSize.show();
			let text = label.text();
			inputSize.val(text.trim());
			label.text("");
	 		$(this).find("i").attr("class", "bi bi-check-square");
	 		label.attr("data-size", )
	 		label.focus();
		} else if (iconTag.attr("class") == "bi bi-check-square") {
			let size = $(this).parent().prev().text();
			let count = inputSize.val();
			let url = "/product/modifysize";
			let sData = {"pro_no"    : "${productVo.pro_no}",
						 "pro_size"  : size,
					     "pro_count" : count};
			$.post(url, sData, function(rData) {
				if(rData == "true"){
					label.text(count);
					inputSize.val("");
					inputSize.hide();
					iconTag.attr("class", "bi bi-pencil-square");
					
					$(".toast-header > strong").text("상품 재고 갱신");
					$(".toast-body").text("상품 재고가 갱신되었습니다.");
					$(".toast").toast("show");
				} else {
					$(".toast-header > strong").text("상품 재고 갱신 실패");
					$(".toast-body").text("상품 재고 갱신을 실패했습니다.");
					$(".toast").toast("show");
				}
							
			});	
		}
	});
	//상품 이미지 등록
	$("#btnImgInsert").click(function() {
		if($(".carousel-item").length >= 5){
			alert("이미지를 5개 이상 등록할수 없습니다");
			return;
		}
		$("#inputFileInsert").click();
	});
	$("#inputFileInsert").change(function() {
		let file = this.files[0];
		if(file == null) return;
		let reader = new FileReader();
		let btnInsert = $("#btnImgInsert");
		let newIndex = btnInsert.prev().find("img").attr("data-index");
		
		let formData = new FormData();
		formData.append("file", file);
		formData.append("pro_no", "${productVo.pro_no}");
		let url = "/product/insertImgData";
		$.ajax({
			"processData" : false,
			"contentType" : false,
			"url" 		  : url,
			"method" 	  : "post",
			"data"		  : formData,
			"success" 	  : function(rData) {
				console.log(rData);
				let clone = btnInsert.prev().clone().attr("class", "carousel-item");
				let imgTag = clone.find("img");
				imgTag.attr("data-index", parseInt(newIndex) + 1);
				imgTag.attr("data-img", rData);
				btnInsert.before(clone);
				
				let lastLi = $(".carousel-indicators").find("li").last();
				let liIndex = lastLi.attr("data-slide-to");
				let cloneLi = lastLi.clone();
				cloneLi.attr("data-slide-to", parseInt(liIndex) + 1);
				lastLi.after(cloneLi);
				reader.onload = function(e) {
					imgTag.attr("src", e.target.result);
				};
				$(".toast-header > strong").text("이미지 등록");
				$(".toast-body").text("상품 이미지가 등록되었습니다.");
				$(".toast").toast("show");
				reader.readAsDataURL(file);
			}
		});
	})
	//상품 이미지 변경
	$(".carousel-inner").on("click", ".btnImgModify", function(e) {
		e.preventDefault();
		let input = $("#inputFileChange");
		input.attr("data-index", $(this).prev().attr("data-index"));
		input.click();
	});
	$("#inputFileChange").change(function() {
		let file = this.files[0];
		if(file == null) return;
		let reader = new FileReader();
		let imgIndex = $(this).attr("data-index");
		let imgTag = $(".displayImg[data-index="+imgIndex+"]");
		let deleteImg = imgTag.attr("data-img");
		let formData = new FormData();
		formData.append("file", file);
		formData.append("deleteImg", deleteImg);
		let url = "/product/modifyImgData";
		$.ajax({
			"processData" : false,
			"contentType" : false,
			"url" 		  : url,
			"method" 	  : "post",
			"data"		  : formData,
			"success" 	  : function(rData) {
// 				console.log(rData);
				imgTag.attr("data-img", rData);
				reader.onload = function(e) {
					imgTag.attr("src", e.target.result);
				};
				$(".toast-header > strong").text("이미지 변경");
				$(".toast-body").text("상품 이미지가 변경되었습니다.");
				$(".toast").toast("show");
				reader.readAsDataURL(file);
			}
		});
	})
	//상품 이미지 삭제
	$(".carousel-inner").on("click", ".btnImgDelete", function(e) {
		e.preventDefault();
		let deleteImg = $(this).prev().prev().attr("data-img");
		let deleteIndex = $(this).prev().prev().attr("data-index");
		if($(".displayImg").length < 2){
			alert("이미지를 모두 삭제할수 없습니다.");
			return;
		}
		if(deleteIndex == 0){
			alert("첫 이미지는 삭제할수 없습니다.");
			return;
		}
		let deleteDiv = $(this).parent();
		let activeDiv = $(".carousel-inner").find(".div-first");
		let findli = $(".carousel-indicators").find("li").last();
		let url = "/product/deleteImgData";
		let sData = {"deleteImg" : deleteImg};
		$.post(url, sData, function(rData) {
			console.log(rData);
			if(rData == "true"){
				activeDiv.attr("class", "carousel-item active div-first");
				deleteDiv.remove();
				findli.remove();
				$(".toast-header > strong").text("이미지 삭제");
				$(".toast-body").text("상품 이미지가 삭제되었습니다.");
				$(".toast").toast("show");
			}
		});
	});
	//상품 이름/가격 변경 함수
	function changeAjax(that, url, type) {
		let icon = that.find("i");
		let inputBox = that.parent().next();
		if(icon.attr("class") == "bi bi-pencil-square"){
			that.find("i").attr("class", "bi bi-check-square");			
			inputBox.attr("readonly", false).focus();
		} else {
			let sData;
			if(type == "name"){
				sData = {"pro_name" : inputBox.val(),
						 "pro_no"   : "${productVo.pro_no}"}				
			} else if (type == "price"){
				sData = {"pro_price" : inputBox.val(),
						 "pro_no"   : "${productVo.pro_no}"}
			}
			$.post(url, sData, function(rData) {
				if(rData == "true"){
					$(".toast-header > strong").text("상품 정보 갱신");
					$(".toast-body").text("상품 정보가 갱신되었습니다.");
					$(".toast").toast("show");
				} else {
					$(".toast-header > strong").text("상품 정보 갱신 실패");
					$(".toast-body").text("상품 정보 갱신을 실패했습니다.");
					$(".toast").toast("show");
				}
			});
			inputBox.attr("readonly", true);
			that.find("i").attr("class", "bi bi-pencil-square");
		}
	}
})
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
						<h6 class="text-white text-capitalize ps-3">상품 상세 정보</h6>
					</div>
				</div>
				<!--/ 제목 카드 -->
				<div class="card-body px-0 pb-2" style="margin: 30px;">
					<div class="card mt-4">
						<div class="row">
							<div class="col-md-5">
							    <!-- 상품 정보 수정 폼 -->
								<div class="container" style="margin: 25px;">
									<h2>상품 정보</h2>
									<h3 class="my-3">
									  <!-- 별점 -->
									  <c:if test="${starRating gt 0}">									  
									    <i class="bi bi-star-fill text-warning"></i>&nbsp;
									    <fmt:formatNumber value="${starRating}" pattern=".0"/>
									  </c:if>
									  <!--// 별점 -->
									</h3>
									<p>상품번호 [${productVo.pro_no}]의 정보입니다.<br>아래 양식을 통해 수정해주세요</p>
									<a href="/board/detail?pro_no=${productVo.pro_no}" type="button"
									  target="_blank" class="btn btn-outline-primary">
									  <span style="font-family: SaenggeoJincheon !important; font-size: 23px;">
                      					신발팜
                    				  </span>
									   판매 페이지로...</a>
									<!-- 상품명 수정 -->
									<div class="form-group" style="margin-top: 55px">
										<label for="pro_name" style="float: left; padding-top: 8px;"
										  >상품명:<a href="#" id="changeName" class="btn-light" >
										  <i class="bi bi-pencil-square"></i></a></label>
										<input type="text" class="form-control" id="pro_name"
											name="pro_name" value="${productVo.pro_name}"
											style="width: 175px; margin-left: 150px;"
											readonly>
									</div>
									<!--// 상품명 수정 -->
									<!-- 상품 가격 수정 -->
									<div class="form-group">
										<label for="pro_price" style="float: left; padding-top: 8px;"
										>상품 가격:<a href="#" id="changePrice" class="btn-light">
											<i class="bi bi-pencil-square"></i></a></label>
											<input type="number" class="form-control"
											 id="pro_price" name="pro_price" value="${productVo.pro_price}"
											style="width: 175px; margin-left: 150px;"
											readonly> 
									</div>
									<!-- 상품 가격 수정 -->
									<label style="margin-top: 8px; margin-bottom: 8px;"
										class="form-check-label"> 
										<c:choose>
											<c:when test="${productVo.pro_category eq 'ad'}">
											아디다스
											</c:when>
											<c:when test="${productVo.pro_category eq 'ni'}">
											나이키
											</c:when>
											<c:when test="${productVo.pro_category eq 'ne'}">
											뉴발란스
											</c:when>
										</c:choose> / 
										<c:choose>
											<c:when test="${productVo.pro_status eq 'M'}">
											남성용
											</c:when>
											<c:when test="${productVo.pro_status eq 'F'}">
											여성용
											</c:when>
											<c:when test="${productVo.pro_status eq 'K'}">
											아동용
											</c:when>
										</c:choose>
									</label>
									<!-- 사이즈 비동기 개수 수정 폼 -->
									<table id="td1" class="table table-hove" style="width:300px;">
										<tr>
											<th>사이즈</th>
											<th style="width:200px; text-align: center;">남은 수량</th>
										</tr>
											<c:set var="index" value="0"/>
											<c:choose>
												<c:when test="${productVo.pro_status eq 'M'}">
													<c:set var="start" value="240"></c:set>
													<c:set var="finish" value="290"></c:set>
												</c:when>
												<c:when test="${productVo.pro_status eq 'F'}">
													<c:set var="start" value="220"></c:set>
													<c:set var="finish" value="270"></c:set>
												</c:when>
												<c:when test="${productVo.pro_status eq 'K'}">
													<c:set var="start" value="215"></c:set>
													<c:set var="finish" value="250"></c:set>
												</c:when>
											</c:choose>
											<c:forEach begin="${start}" end="${finish}" step="5"
											    var="productCountVo"
												varStatus="status">
											<tr>
											 	<td>${status.begin + status.count * 5 - 5}</td>
												<td style="text-align: right;">
												<input type="number" style="display: none; width: 100px">
												<a href="#" class="changeSize btn-light">
												<label>
												<c:choose>
													<c:when test="${status.begin + status.count * 5 - 5 eq listCount[index].pro_size}">
														${listCount[index].pro_count}
														<c:set var="index" value="${index + 1}"/>
													</c:when>
													<c:otherwise>
														0
													</c:otherwise>
												</c:choose>
												</label>
												<i class="bi bi-pencil-square"></i></a>
												</td>
											</tr>
											</c:forEach>
									</table>
									<!--// 사이즈 비동기 개수 수정 폼 -->
								</div>
								<!--// 상품 정보 수정 폼 -->
							</div>
							<div class="col-md-7 d-flex flex-column">
							<!-- 파일 비동기 업로드 -->
							<input type="file" id="inputFileInsert" name="file" style="display: none;"
								data-index="">
							<input type="file" id="inputFileChange" name="file" style="display: none;"
								data-index="">
							<!--// 파일 비동기 업로드 -->
							<div style="padding: 30px; margin-right: 300px;"
								class="">
								<!-- 사진 carousel -->
								<div id="demo" class="carousel" data-ride="carousel">
									<!-- Indicators -->
									<ul class="carousel-indicators">
										<c:forEach items="${listPic}" var="productPicVo" 
										  varStatus="status">
										  <li data-target="#demo" data-slide-to="${status.index}"></li>
										</c:forEach>
									</ul>

									<!-- The slideshow -->
									<div class="carousel-inner">
										<c:forEach items="${listPic}" var="productPicVo" 
										  varStatus="status">
										  <div class="carousel-item img-wrapper 
										  	<c:if test="${status.index eq 0}">
												div-first active								  	
										  	</c:if>
										  " style="width: 500px; height: 500px;">
											<img
												src="/manage/displayImg?attach_file=${productPicVo.pro_pic}"
												data-index="${status.index}"
												data-img="${productPicVo.pro_pic}"
												class="displayImg" width="500">
											<!--사진 삭제/수정 버튼 -->
											<a href="#" class="btn btn-sm btn-primary btnImgModify"
											  style="position: absolute; top: 10px; left : 370px; "><i class="bi bi-pencil-square"></i></a>
											<a href="#" class="btn btn-sm btn-danger btnImgDelete"
											  style="position: absolute; top: 10px; left : 400px;"><i class="bi bi-x-square"></i></a>
											<!--//사진 삭제/수정 버튼 -->
										</div>
										</c:forEach>
										<!-- 사진 등록 버튼 -->
										<button class="btn btn-sm btn-success" type="button" id="btnImgInsert"
											style="position: absolute; top: 10px; left : 260px;  z-index: 1;">
											새 이미지 등록</button>
										<!--// 사진 등록 버튼 -->
									</div>
									<!-- Left and right controls -->
									<a class="carousel-control-prev" href="#demo" data-slide="prev">
										<span class="carousel-control-prev-icon"></span>
									</a> <a class="carousel-control-next" href="#demo"
										data-slide="next" style="left: 420px;"> <span
										class="carousel-control-next-icon"></span>
									</a>
								  </div>
								<!--// 사진 carousel -->
								</div>
								<div class="card w-80 m-2 commentcard">
								  <div class="card-body p-2">
								  <p class="card-title my-2" style="text-align: center; font-weight: bold; 
								    font-size: 22px" >이 상품에 대한 최근 상품평(최대 3개)</p>
								  </div>
							    </div>
							    <!-- 상품평 카드 -->
								<c:forEach items="${listComment}" var="commentVo">
								<div class="card w-80 m-2 commentcard">
								  <div class="card-body p-2">
									<p class="card-title my-3">
									<c:forEach begin="0" end="4" varStatus="starStatus">
    				    			  <c:choose>
    				      				<c:when test="${commentVo.commentstar gt starStatus.index}">
    				      				  <i class="bi bi-star-fill text-warning"></i>
    				      			    </c:when>
    				  	  				<c:otherwise>
    				      				  <i class="bi bi-star text-warning"></i>
    				      				</c:otherwise>
      						    	  </c:choose>
    				  				</c:forEach>
									&nbsp;${commentVo.content}</p>
									<div class="d-flex justify-content-between"
									  style="background-color: #eeeeee; border-radius: 10px; padding: 5px; border: 10px; margin-bottom: 5px;">
									  <p class="card-text my-1 align-self-center">작성자: ${commentVo.username}
									    <span style="font-size: 12px">(${commentVo.userid})</span>
										<img src="/manage/displayImg?attach_file=${commentVo.userpic}"
										  class="avatar avatar-sm me-3 border-radius-lg">
									  </p>
									  <p class="card-text my-1 align-self-center"
									    ><fmt:formatDate value="${commentVo.regdate}" pattern="yyyy년 MM월 DD일"/></p>
									</div>
								  </div>
							    </div>
							    </c:forEach>
							    <!--// 상품평 카드 -->
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<%@include file="../management/include/footer.jsp"%>
</body>

</html>