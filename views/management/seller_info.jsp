<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@include file="../management/include/header.jsp"%>
<script>
$(document).ready(function() {
	//정보 교체 토스트 확인
	if("${infoResult}" == "true") {
		$(".toast-header > strong").text("정보 교체 성공");
		$(".toast-body").text("나의 정보가 교체되었습니다.");
		$(".toast").toast("show");
	}
	if("${infoResult}" == "false") {
		$(".toast-header > strong").text("정보 교체 실패");
		$(".toast-body").text("정보 교체에 실패하였습니다. 다시 확인해주세요");
		$(".toast").toast("show");
	}
	//비동기 이미지 교체
	$("#changeImg").click(function(e){
		e.preventDefault();
		let input = $("#inputChangeImg");
		input.click();
	});
	$("#inputChangeImg").change(function() {
		let file = this.files[0];
		if(file == null) return;
		let reader = new FileReader();
		let imgTag = $("#profileImage");
		let formData = new FormData();
		formData.append("file", file);
		if(imgTag.attr("data-img").trim() != null && imgTag.attr("data-img").trim() != ""){
			formData.append("deleteImg", imgTag.attr("data-img"));
		}
		formData.append("file", file);
		let url = "/seller/updatesellerimg";
		$.ajax({
			"processData" : false,
			"contentType" : false,
			"url" 		  : url,
			"method" 	  : "post",
			"data"		  : formData,
			"success" 	  : function(rData) {
				if(rData != "" && rData != null){
					reader.onload = function(e) {
						$(".toast-header > strong").text("프로필 사진 교체");
						$(".toast-body").text("프로필 사진이 교체되었습니다.");
						$(".toast").toast("show");
						imgTag.attr("data-img", rData);
						imgTag.attr("src", e.target.result);
						$("#imgHeader").attr("src", e.target.result);
					}
				} else {
					$(".toast-header > strong").text("프로필 사진 교체 실패");
					$(".toast-body").text("프로필 사진 교체가 실패했습니다.");
					$(".toast").toast("show");
				}
				reader.readAsDataURL(file);
			}
		});
	});
})
</script>
    <div class="container-fluid px-2 px-md-4">
      <%@include file="../management/include/toast.jsp"%>
      <div class="page-header min-height-300 border-radius-xl mt-4" 
        style="background-image: url(/manager/assets/img/background.png);">
        <span class="mask bg-gradient-light opacity-2"></span>
      </div>
      <div class="card card-body mx-3 mx-md-4 mt-n6">
        <div class="row gx-4 mb-2">
          <div class="col-auto d-flex flex-row">
          <!-- 프로필 이미지 비동기 수정 -->
            <div class="img-wrapper"
              style="border-radius: 10px; width: 75px; height: 75px;">
              <c:choose>
              	<c:when test="${empty sellerVo.seller_pic}">
              	  <c:set var="imgSrc" value="/manager/assets/img/user.png"></c:set>
              	</c:when>
              	<c:otherwise>
              	  <c:set var="imgSrc" value="/manage/displayImg?attach_file=${sellerVo.seller_pic}"></c:set>
              	</c:otherwise>
              </c:choose>
             <img src="${imgSrc}" id="profileImage" data-img="${sellerVo.seller_pic}" >
            </div>
            <!--// 프로필 이미지 비동기 수정 -->
            <div style="margin-top: 55px">
              <a href="#" id="changeImg"><i class="bi bi-pencil-square"></i></a>
              <input type="file" id="inputChangeImg" name="file" style="display: none;">
            </div>
          </div>
          <div class="col-auto my-auto">
            <div class="h-100">
              <h5 class="mb-1">
                ${sellerVo.seller_name}
              </h5>
            </div>
          </div>
          <div class="col-lg-4 col-md-6 my-sm-auto ms-sm-auto me-sm-0 mx-auto mt-3">
            <div class="nav-wrapper position-relative end-0">
            </div>
          </div>
        </div>
        <div class="row">
          <div class="row">
            <div class="col-12 col-xl-12">
              <!-- 판매자 정보 -->
              <div class="card card-plain h-100">
                <div class="card-header pb-0 p-3">
                  <div class="row">
                    <div class="col-md-8 d-flex align-items-center">
                      <h6 class="mb-0">프로필 정보</h6>
                    </div>
                    <div class="col-md-4 text-end">
                      <a href="/seller/profilechangeform">
                        <i class="bi bi-pencil-square text-secondary text-lg"
                          data-bs-toggle="tooltip" data-bs-placement="top" title="프로필 변경"></i>
                      </a>
                    </div>
                  </div>
                </div>
	                <div class="card-body p-3">
	                  <ul class="list-group">
	                    <li class="list-group-item border-0 ps-0 pt-0 text-sm">
	                      <strong class="text-dark">대표자:</strong> &nbsp;
	                        ${sellerVo.seller_person}</li>
	                    <li class="list-group-item border-0 ps-0 text-sm">
	                      <strong class="text-dark">전화번호:</strong> &nbsp;
	                        ${sellerVo.seller_phone}</li>
	                    <li class="list-group-item border-0 ps-0 text-sm">
	                      <strong class="text-dark">이메일:</strong> &nbsp; 
	                        ${sellerVo.seller_email}</li>
	                    <li class="list-group-item border-0 ps-0 text-sm">
	                      <strong class="text-dark">주소:</strong> &nbsp; 
	                        ${sellerVo.seller_addr}</li>
	                    <li class="list-group-item border-0 ps-0 text-sm">
	                      <strong class="text-dark">가입일:</strong> &nbsp; 
	                        ${sellerVo.regdate}</li>
	                  </ul>
	                </div>
              </div>
              <!-- 판매자 정보 -->
            </div>
		    <%@include file="../management/include/waitingOrder.jsp"%>
          </div>
        </div>
      </div>
    </div>
<%@include file="../management/include/footer.jsp"%>
</body>

</html>