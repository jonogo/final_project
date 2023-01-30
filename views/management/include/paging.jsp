<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!-- 페이징 -->
<div class="row">
		 <form method="get" id="frmPaging">
			<input type="hidden" name="page" value="${pagingDto.page}"/>
			<input type="hidden" name="perPage" value="${pagingDto.perPage}"/>
		</form>
			<div class="col-md-12">
			  <nav>
			  <div class="d-flex justify-content-between">
			    <div class="btn-group dropup">
				  <button type="button" class="btn btn-primary dropdown-toggle"
					data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"
					style="position: relative; left: 50px;">
					${pagingDto.perPage}개씩보기</button>
				  <div class="dropdown-menu">
					<c:forEach var="v" begin="5" end="25" step="5">
					<a class="dropdown-item perPage" href="${v}">${v}개씩 보기</a>
				    </c:forEach>
				  </div>
			   </div>
			<ul class="pagination justify-content-center"
			  style="position: relative; right: 75px;">
					<c:if test="${pagingDto.startPage ne 1}">
						<li class="page-item"><a class="page-link"
							href="${pagingDto.startPage - 1}">이전</a></li>
					</c:if>
					<c:forEach var="v" begin="${pagingDto.startPage}"
						end="${pagingDto.endPage}">
						<li
							<c:choose>
								<c:when test="${pagingDto.page eq v}">
										class="page-item active"
									</c:when>
									<c:otherwise>
										class="page-item"
									</c:otherwise>
							</c:choose>>
							<a class="page-link" href="${v}">${v}</a>
						</li>
					</c:forEach>
					<c:if test="${pagingDto.endPage lt pagingDto.totalPage}">
						<li class="page-item"><a class="page-link"
							href="${pagingDto.endPage + 1}">다음</a></li>
					</c:if>
				</ul>
				<div></div>
			  </div>
				</nav>
			</div>
		</div>
<!-- //페이징 -->