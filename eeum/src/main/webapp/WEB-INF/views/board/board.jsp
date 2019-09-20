<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType= "text/html; charset=UTF-8" pageEncoding= "UTF-8" %>
<!DOCTYPE html>
<html lang="kor">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<title>GroupWare</title>
<!-- Custom fonts for this template-->
<link href="${contextPath}/resources/bootstrap/vendor/fontawesome-free/css/all.min.css"rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

<!-- Bootstrap core JavaScript-->
<script	src="${contextPath}/resources/bootstrap/vendor/jquery/jquery.min.js"></script>
<script	src="${contextPath}/resources/bootstrap/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin JavaScript-->
<script src="${contextPath}/resources/bootstrap/vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script src="${contextPath}/resources/bootstrap/js/sb-admin-2.min.js"></script>

<!-- Page level plugins -->
<script src="${contextPath}/resources/bootstrap/vendor/chart.js/Chart.min.js"></script>

<!-- Page level custom scripts -->
<script src="${contextPath}/resources/bootstrap/js/demo/chart-area-demo.js"></script>
<script src="${contextPath}/resources/bootstrap/js/demo/chart-pie-demo.js"></script>

<!-- Custom styles for this template-->
<link href="${contextPath}/resources/bootstrap/css/sb-admin-2.min.css" rel="stylesheet">
<script src="https://kit.fontawesome.com/fbd170e696.js"></script>
<style>
.pagination {
  display: inline-block;
  margin-left: auto;
  margin-right: auto;
}

.pagination a {
  color: black;
  float: left;
  padding: 8px 16px;
  text-decoration: none;
  transition: background-color .3s;
  border: 1px solid #ddd;
}

.pagination a.active {
  background-color: rgb(2, 1, 13);
  color: white;
  border: 1px solid rgb(2, 1, 13);
}

.pagination a:hover:not(.active) {background-color: #DCDCDC;}


 a:link { color: gray; text-decoration: none;}
 a:visited { color: gray; text-decoration: none;}
 a:hover { color: gray; text-decoration: none;}

.bContents:hover {
	background: rgb(250,250,250);
}
</style>
</head>

<body id="page-top">

	<!-- 메인레버 -->
	<div id="wrapper">
		<!-- 사이드바 -->
		<jsp:include page="/WEB-INF/views/common/sidebar.jsp" flush="false"></jsp:include>
		<!-- 상단바 -->
		<jsp:include page="/WEB-INF/views/common/topbar.jsp" flush="false"></jsp:include>

		<!-- 컨텐츠 영역 -->
		<div class="container-fluid">
			<!-- 타이틀 영역 -->
			<div class="d-sm-flex align-items-center justify-content-between mb-4">
				<h1 class="h3 mb-0 text-gray-800">
					공지사항
				</h1>
			</div>
          <div class="card shadow mb-4">
            <div class="card-header py-3">
              <h6 class="m-0 font-weight-bold text-primary">전체 공지</h6>
            </div>
            <div class="card-body">
	            <div style="margin-bottom: 1em;">
	            	<form action="notice.do" autocomplete="off" style="display: inline-block; width:50%;">
	              		<input type="search" name="search" class="form-control form-control-sm" placeholder="" aria-controls="dataTable" style="display: inline-block; width: 50%">
	              		<input type="submit" class="btn" value="검색" style="border: 1px solid lightgray">
	              		<input type="hidden" name="cate" value="${cate}">
	              		<c:set var="search" value="${search}"/>
					<c:if test="${!empty search}">
						<p>"${search}"에 대한 검색결과 입니다.</p>
					</c:if>
	           		</form>
	           		<div style="display: inline-block; width:40%; float: right;">
	           			<select id="selectbox" name="dataTable_length" name="cate" aria-controls="dataTable" class="custom-select custom-select-sm form-control form-control-sm" style="width:40%; float: right;">
		           			<option value="countDesc">조회수 높은순</option>
		           			<option value="DateDesc">최신 게시물 순</option>
		           			<option value="DateASC">오래된 게시물 순</option>
	           			</select>
	           			<script type="text/javascript">
	           				$(document).ready(function(){
	           					var cate = "${cate}";
	           					$("#selectbox").val(cate).prop("selected",true);
	           				});
	           			
	           				$("#selectbox").change(function(){
	           					var cate = $("#selectbox option:selected").val();
	           					var search = "${search}";
	           					var page = "${page}";
	           					
	           					window.location.href="notice.do?search="+search+"&page="+page+"&cate="+cate;
	           				});
	           			</script>
	           		</div>
	       	</div>
              <div class="table-responsive" style="clear: both;">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                  <thead>
                    <tr>
                      <th>게시번호</th>
                      <th>제목</th>
                      <th>조회수</th>
                      <th>게시자</th>
                      <th>게시일</th>
                    </tr>
                  </thead>
                  <tfoot>
                    <tr>
                      <th>게시번호</th>
                      <th>제목</th>
                      <th>조회수</th>
                      <th>게시자</th>
                      <th>게시일</th>
                    </tr>
                  </tfoot>
                  <tbody>
                  	<!-- 상단 노출수  -->
                  	<c:forEach var="i" items="${important}" >
                  	<c:url var="bdetail" value="bdetail.do">
                  		<c:param name="bNo" value="${i.bNo}"/>
                  		<c:param name="page" value="${ pi.currentPage }"/>
                  	</c:url>
						<tr style="background-color: rgb(220,220,220); font-weight: bold;">
							<td>${i.bNo}</td>
							<td><i class="as fa-fw fa fa-bullhorn"> </i>
								<c:set var="bContent" value="${i.bContent}"/>
								<c:if test="${fn:contains(bContent,'<img')}">
									<i class="fa fa-picture-o" aria-hidden="true"></i>
								</c:if>
								<c:if test="${fn:contains(bContent,'<iframe')}">
									<i class="fa fa-video-camera" aria-hidden="true"></i>
								</c:if>
								<a href="${bdetail}">${i.bTitle}</a></td>
							<td>${i.bCount}</td>
							<td>${i.empName}</td>
							<td>${i.bDate}</td>
						</tr>
					</c:forEach>
					<!-- 일반 노출부  -->
					<c:forEach var="n" items="${normal}" >
					<c:url var="bdetail" value="bdetail.do">
                  		<c:param name="bNo" value="${n.bNo}"/>
                  		<c:param name="page" value="${ pi.currentPage }"/>
                  	</c:url>
					<tr class="bContents">
						<td>${n.bNo}</td>
						<td>
							<c:set var="bContent" value="${n.bContent}"/>
							<c:if test="${fn:contains(bContent,'<img')}">
								<i class="fa fa-picture-o" aria-hidden="true"></i>
							</c:if>
							<c:if test="${fn:contains(bContent,'<iframe')}">
								<i class="fa fa-video-camera" aria-hidden="true"></i>
							</c:if>
							<a href="${bdetail}">
							${n.bTitle}
							</a>
						</td>
						<td>${n.bCount}</td>
						<td>${n.empName}</td>
						<td>${n.bDate}</td>
					</tr>
					</c:forEach>
                  </tbody>
                </table>
                <!--글쓰기 버튼  -->
                <c:if test="${loginEmp.empStatus eq 'A' }">
                <a href="bInsert.do" class="btn btn-primary btn-icon-split">
					<span class="icon text-white-50">
						<i class="fas fa-check"></i>
					</span>
					<span class="text" style="color: white">글쓰기</span>
				</a>
				</c:if>
								<!-- 페이지 영역  -->
               	<div class="row" style="width: 90%; margin-left: 5%;">
               		<div class="pagination">
						<!--이전  -->
						<c:if test="${pi.currentPage <= 1}">
							<a style="color: lightgray;">&laquo;</a>
						</c:if>
						<c:if test="${pi.currentPage > 1}">
							<c:url var="before" value="notice.do">
								<c:param name="page" value="${ pi.currentPage - 1 }"/>
								<c:param name="search" value="${search}"/>
								<c:param name="cate" value="${cate }"/>
							</c:url>
							<a href="${ before }">&laquo;</a>
						</c:if>
						
						<!--페이징  -->
						<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
							<c:if test="${ p eq pi.currentPage }">
								<a class="active">${ p }</a>
							</c:if>
							
							<c:if test="${ p ne pi.currentPage }">
								<c:url var="pagination" value="notice.do">
									<c:param name="page" value="${ p }"/>
									<c:param name="search" value="${search}"/>
									<c:param name="cate" value="${cate }"/>
								</c:url>
								<a href="${ pagination }">${ p }</a> &nbsp;
							</c:if>
						</c:forEach>
						
						<!-- 다음 -->
						<c:if test="${ pi.currentPage >= pi.maxPage }">
							<a style="color: lightgray;">&raquo;</a>
						</c:if>
						<c:if test="${ pi.currentPage < pi.maxPage }">
							<c:url var="after" value="notice.do">
								<c:param name="page" value="${ pi.currentPage + 1 }"/>
								<c:param name="search" value="${search}"/>
								<c:param name="cate" value="${cate }"/>
							</c:url> 
							<a href="${ after }">&raquo;</a>
						</c:if>
					</div>
               </div>
				
              </div>
            </div>
          </div>			
				

		</div>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" flush="false"></jsp:include>

</body>

</html>
