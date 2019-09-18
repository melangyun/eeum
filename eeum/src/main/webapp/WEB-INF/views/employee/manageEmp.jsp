<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page language="java" contentType= "text/html; charset=UTF-8" pageEncoding= "UTF-8" %>
<!DOCTYPE html>
<html lang="kor">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<title>GroupWare</title>
<!-- Custom fonts for this template-->
<link href="${contextPath}/resources/bootstrap/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
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
				<h1 class="h3 mb-0 text-gray-800">인사관리</h1>
			</div>
			<div class="row">
				<div class="col-lg-4">
					<div class="vard shadow mb-4">
						<div class="card-header py-3">
			             <!-- <a href="#" class="btn btn-primary btn-icon-split" style="display: inline-block; maring:0; text-align:right">
							<span class="icon text-white-50">
								<i class="fa fa-plus"></i>
							</span>
						</a> -->
			             <h6 class="m-0 font-weight-bold text-primary" style="display: inline-block;">조직도</h6>
			           </div>
            <div class="card-body" style="clear:both;">
              <div class="table-responsive">
                <table class="table table-bordered" id="dataTable">
                  <colgroup>
                  	<col width="40%">
                  	<col>
                  </colgroup>
                  <thead>
                    <tr>
                      <th>부서</th>
                      <th>팀</th>
                    </tr>
                  </thead>
                  <tfoot>
                    <tr>
                      <th>부서</th>
                      <th>팀</th>
                    </tr>
                  </tfoot>
                  <tbody>
					<c:forEach var="dl" items="${deptlist }">
					<c:set var="dDeptNo" value="${dl.deptNo}"/>	
					<% int i = 0; %>			
						<tr>
							<td><b>${dl.deptName}</b></td>
							
							<c:forEach var="tl" items="${teamlist}">
								<c:set var="tDeptNo" value="${tl.deptNo}"/>
								<c:if test="${fn:startsWith(tDeptNo,dDeptNo)}">
									<c:url var="deptDetail" value="manageEmp.do">
										<c:param name="cate" value="${tDeptNo}"/>
									</c:url>
									<c:choose>
										<c:when test="<%=i==0 %>">
											<td><a href="${deptDetail }">${tl.deptName}( ${tDeptNo} )</a></td>
										</c:when>
										<c:otherwise>
											</tr>
											<tr>
											<td></td>
											<td><a href="${deptDetail }" >${tl.deptName}( ${tDeptNo} )</a></td>
										</c:otherwise>
									</c:choose>
									<% i++; %>
								</c:if>
							</c:forEach>
							
						</tr>
					</c:forEach>
                  </tbody>
                </table>
              </div>
            </div>
					</div>
				</div>
				<div class="col-lg-8">
					<div class="card mb-4">
		                <div class="card-header"><b>사원 관리</b></div>
		                <div class="card-body">
			                <div class="col-sm-12 col-md-6" style="margin-bottom: 1rem">
			                	<div id="dataTable_filter" class="dataTables_filter">
			                		<form action="manageEmp.do" autocomplete="off">
			                		<input type="search" name="search" class="form-control form-control-sm" placeholder="" aria-controls="dataTable" style="display: inline-block; width: 50%">
			                		<input type="submit" class="btn" value="검색" style="border: 1px solid lightgray">
			                		<c:set var="search" value="${search}"/>
									<c:if test="${!empty search}">
										<p>"${search}"에 대한 검색결과 입니다.</p>
									</c:if>
			                		</form>
			                	</div>
			                </div>
		                <form name="newEmpForm" method="post" style="clear: both;" autocomplete="off">
		                  <table class="table table-bordered" id="dataTable">
							<%-- <colgroup>
								<col width="30%">
								<col>
							</colgroup> --%>
							<thead>
								<tr>
									<th>사번</th>
									<th>이름</th>
									<th>부서</th>
									<th>직급</th>
									<th>입사일</th>
									<th>전화번호</th>
									<th>내선번호</th>
									<th>인사관리</th>
								</tr>
							</thead>
							<tfoot>
								<tr>
									<th>사번</th>
									<th>이름</th>
									<th>부서</th>
									<th>직급</th>
									<th>입사일</th>
									<th>전화번호</th>
									<th>내선번호</th>
									<th>인사관리</th>
								</tr>
							</tfoot>
							<tbody>
								<c:forEach var="e" items="${empList}">
									<tr>
										<td>${e.empNo}</td>
										<td>${e.empName}</td>
										<td>${e.deptName}</td>
										<td>lv. ${e.empPosition}</td>
										<td>${e.joinDate}</td>
										<td>${e.phone}</td>
										<td>${e.empphone}</td>
										<c:url var="modifyEmp" value="modifyEmp.do">
											<c:param name="empNo" value="${e.empNo}"/>
										</c:url>
										<td><a  href="${modifyEmp}" class="btn" style="border : 1px solid lightgray">관리</a></td>
									</tr>
								</c:forEach>
							</tbody>
		                 </table>
						</form>
							<!-- 페이지 영역  -->
		                	<div class="row">
		                		<div class="pagination">
									<!--이전  -->
									<c:if test="${pi.currentPage <= 1}">
										<a style="color: lightgray;">&laquo;</a>
									</c:if>
									<c:if test="${pi.currentPage > 1}">
										<c:url var="before" value="manageEmp.do">
											<c:param name="page" value="${ pi.currentPage - 1 }"/>
											<c:param name="search" value="${search}"/>
										</c:url>
										<a href="${ before }">&laquo;</a>
									</c:if>
									
									<!--페이징  -->
									<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
										<c:if test="${ p eq pi.currentPage }">
											<a class="active">${ p }</a>
										</c:if>
										
										<c:if test="${ p ne pi.currentPage }">
											<c:url var="pagination" value="manageEmp.do">
												<c:param name="page" value="${ p }"/>
												<c:param name="search" value="${search}"/>
											</c:url>
											<a href="${ pagination }">${ p }</a> &nbsp;
										</c:if>
									</c:forEach>
									
									<!-- 다음 -->
									<c:if test="${ pi.currentPage >= pi.maxPage }">
										<a style="color: lightgray;">&raquo;</a>
									</c:if>
									<c:if test="${ pi.currentPage < pi.maxPage }">
										<c:url var="after" value="manageEmp.do">
											<c:param name="page" value="${ pi.currentPage + 1 }"/>
											<c:param name="search" value="${search}"/>
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
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" flush="false"></jsp:include>

</body>

</html>
