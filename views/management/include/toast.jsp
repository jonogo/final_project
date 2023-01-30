<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<script>
$(document).ready(function() {
	//토스트
	$(".close").click(function() {
		$('.toast').toast('hide');
	});
});
</script>
<!-- 토스트 -->
<div class="d-flex flex-row-reverse">
  <div class="toast" data-autohide="false" style="position: fixed; z-index: 3; right: 30px">
    <div class="toast-header">
      <strong class="mr-auto text-primary">토스트 헤더</strong>
      <button type="button" class="ml-2 mb-1 close">&times;</button>
    </div>
    <div class="toast-body">
      토스트 내용
    </div>
  </div>
</div>
<!--// 토스트 -->