<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType= "text/html; charset=UTF-8" pageEncoding= "UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
	<style type="text/css">
	#buttons button{
		margin: 5em;
		display: inline-block;
		margin-left: auto;
		margin-right: auto;
	}
	#buttons{
		display: inline-block;
		margin-left: auto;
		margin-right: auto;
		text-align: center;
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
				<h1 class="h3 mb-0 text-gray-800">결재문서</h1>
			</div>
			 <div class="card shadow" style="margin-bottom: 5rem;">
				  <div class="card-body">
					 <h3 style="margin-bottom: 25px;">${ap.apTitle}( ${ap.apNo} )</h3>
					   <div class="form-group">
						   <strong>기안자 : </strong><input type="text" class="form-control" value="${ap.empNo}" readonly>
					   </div>
					   <div class="row">
						   <div class="form-group col-lg-6">
						   		<c:set var="str1" value="${ap.approvalEmp}"/>
								<c:set var="str2" value="${fn:replace(str1, ',N', '-미결')}" />
								<c:set var="str3" value="${fn:replace(str2, ',R', '-반려')}" />
								<c:set var="str4" value="${fn:replace(str3, ',Y', '-결재')}" />
								<c:set var="str5" value="${fn:replace(str4, ';', ', ')}" />
						    	<strong>결재자 : </strong><input type="text" class="form-control" value="${str5}" readonly>
						   </div>
						   <div class="form-group col-lg-6">
						   		<c:set var="str01" value="${ap.hEmp}"/>
								<c:set var="str02" value="${fn:replace(str01, ',N', '-미결')}" />
								<c:set var="str03" value="${fn:replace(str02, ',R', '-거부')}" />
								<c:set var="str04" value="${fn:replace(str03, ',Y', '-합의')}" />
								<c:set var="str05" value="${fn:replace(str04, ';', ', ')}" />
						    	<strong>합의자 : </strong><input type="text" class="form-control" value="${str05}" readonly>
						   </div>
						   <div class="form-group col-lg-6">
						    	<strong>시행자 : </strong><input type="text" class="form-control" value="${ap.runEmp}" readonly>
						    </div>
						    <div class="form-group col-lg-6">
						    	<strong>참조자 : </strong><input type="text" class="form-control" value="${ap.refEmp}" readonly>
					    </div>
					    </div>
				   		<c:if test="${empty ap.a_v_first}">
					   	<div class="form-group">
					   		<strong>마감일 : </strong> <input type="date" class="form-control" value="${ap.dDate}" readonly>
					   </div>
				   		</c:if>
				   		<c:if test="${!empty ap.a_v_first }">
							<div class="row">
					   			<div class="form-group col-lg-6">
					   				<strong>휴가시작일 : </strong> <input type="date" value="${ap.a_v_first }" class="form-control" name="a_v_first" readonly>
					   			</div>
					   			<div class="form-group col-lg-6">
					   				<strong>휴가종료일: </strong> <input type="date" value="${ap.a_v_last }" class="form-control" name="a_v_last" readonly>
					   			</div>
					   		</div>
				   		</c:if>
					    <div class="form-group" style="border: 1px solid lightgray; border-radius:.5rem; padding: 2rem;min-height: 20rem;">
					    	${ap.apContent}
						 </div>
						 	<c:if test="${!empty ap.originalFile }">
						 	첨부파일 : 
						 	</c:if>
						 	<a href="${ contextPath }/resources/buploadFiles/${ ap.renameFile }" download="${ ap.originalFile }">${ ap.originalFile }</a>
							<!-- a태그 안에서 다운로드 받을 것이 있을 때 쓰는 속성 download, 얘는 download="fileName" 이라고 해서 fileName을 지정해줄 수 있다. -->
						  
					  <div class="row">
						  <div id="buttons">
						  	  <c:set var="tag" value="${tag}"/>
						  	  <!--결제 할 문서일때  -->
						  	 <c:set var="empNo" value="${loginEmp.empNo}"/>
							  <c:if test="${tag eq 'g'}">
							  	 <c:set var="hEmp" value="${ap.hEmp}" />
							  	 <c:set var="approvalEmp" value="${ap.approvalEmp}"/>
							  	 <c:if test="${fn:contains(approvalEmp, empNo)}">
								 	 <button type="button" id="agreeFun" class="btn btn-success">결재</button>
								 	 <button type="button" id="disareeFun" class="btn btn-danger">반려</button>
							  	 </c:if>
							  	 <c:if test="${fn:contains(hEmp,empNo)}">
								 	 <button type="button" id="yesFun" class="btn btn-success">합의</button>
								 	 <button type="button" id="nopeFun" class="btn btn-danger">거절</button>
							  	 </c:if>
							 </c:if>
							  <c:set var="gEmp" value="${ap.empNo}"/>
							  <c:if test="${fn:contains(gEmp,empNo)}">
								 	<button id="deleteBtn" class="btn btn-danger">삭제하기</button>
							 </c:if>
							  <button type="button" onclick="javascript:location.href='approvalView.do';" class="btn btn-secondary">목록으로</button>
						  </div>
					  </div>	
					</div>
				</div>
				<script type="text/javascript">
					$(document).on('click','#agreeFun',function(){
						if(confirm("'${ap.apTitle}'를 정말로 결제 하시겠습니까?")){
							var cate = "g";
							var agree = "Y";
							updateApFun(cate,agree);
						}
					});
					
					$(document).on('click','#disareeFun',function(){
						if(confirm("'${ap.apTitle}'를 정말로 반려 하시겠습니까?")){
							var cate = "g";
							var agree = "R";
							updateApFun(cate,agree);
						}
					});
					
					$(document).on('click','#yesFun',function(){
						if(confirm("'${ap.apTitle}'를 정말로 합의 하시겠습니까?")){
							var cate = "h";
							var agree = "Y";
							updateApFun(cate,agree);
						}
					});
					
					$(document).on('click','#nopeFun',function(){
						if(confirm("'${ap.apTitle}'를 정말로 거절 하시겠습니까?")){
							var cate = "h";
							var agree = "R";
							updateApFun(cate,agree);
						}
					});
					$(document).on('click','#deleteBtn',function(){
						if(confirm("'${ap.apTitle}'를 정말로 삭제 하시겠습니까?\n 삭제 후 재조회는 불가능합니다.")){
							var apNo = "${ap.apNo}";
							$.ajax({
								url:"deleteAp.do",
								data:{apNo:apNo},
								type:"post",
								success:function(data){
									if(data=="success"){
										alert("결재서류 삭제에 성공하였습니다.\n결제 목록으로 이동합니다.");
										location.href="approvalView.do";
									}else{
										alert("삭제에 실패하였습니다.\n관라자에게 문의해주세요");
									}
								}
							});
						}
					});
					
					
					function updateApFun(cate,agree){
						var loginEmp = "${empNo}";
						var apNo = "${ap.apNo}";
						var status="";
						var plusStatus="";
						if(cate=='h'){
							status= "${ap.hEmp}";
							plusStatus= "${ap.approvalEmp}";
						}else if(cate=='g'){
							status= "${ap.approvalEmp}";
							plusStatus= "${ap.hEmp}";
						}
						$.ajax({
							url:"updateAp.do",
							data:{apNo:apNo,cate:cate,agree:agree,loginEmp:loginEmp,status:status,plusStatus:plusStatus},
							type:"POST",
							success:function(data){
								if(data=="success"){
									alert("요청하신 결제가 완료되었습니다.\n결재 목록으로 이동합니다.");
									location.href="approvalView.do";
								}else{
									alert("결재에 실패하였습니다.\n관라자에게 문의해주세요");
								}
							}
						});
					}
				</script>

		</div>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" flush="false"></jsp:include>

</body>

</html>
