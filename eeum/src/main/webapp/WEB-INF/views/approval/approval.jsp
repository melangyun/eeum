<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="kor">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<title>GroupWare</title>
<!-- Custom fonts for this template-->
<link href="${contextPath}/resources/bootstrap/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

<!-- Bootstrap core JavaScript-->
<script src="${contextPath}/resources/bootstrap/vendor/jquery/jquery.min.js"></script>
<script src="${contextPath}/resources/bootstrap/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

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
li{
list-style: none;
margin: 0;
padding: 0;
}

caption {
	caption-side: top;
}
 a:link { color: gray; text-decoration: none;}
 a:visited { color: gray; text-decoration: none;}
 a:hover { color: gray; text-decoration: none;}
 
 .aplist{
 cursor: pointer;
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
			<div class="d-sm-flex align-items-center justify-content-between mb-4 col-lg-9" style="margin-left: auto; margin-right: auto;" >
				<h1 class="h3 mb-0 text-gray-800">전자결재</h1>
			</div>
			<div class="row">
				<div class="col-lg-9" style="margin-left: auto; margin-right: auto;">
					<div class="card shadow mb-4">
						<div class="card-header py-3">
				            <div class="nav-item dropdown no-arrow">
				              <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="display: inline-block;">
				              	<i class="fa fa-plus-square-o text-gray-800 "></i>
				              </a>
				              <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
				                <a class="dropdown-item" href="apporvalinsertView.do">
				                  <i class="fas fa fa-file-text-o fa-sm fa-fw mr-2 text-gray-400 fa-fw"></i>기안하기
				                </a>
				                <div class="dropdown-divider"></div>
				                <a class="dropdown-item" href="apporvalinsertView.do?tag=T">
				                  <i class="fas fa fa-user-o fa-sm fa-fw mr-2 text-gray-400 fa-fw"></i>근태신청
				                </a>
				              </div>
							<h6 class="m-0 font-weight-bold text-primary" style="display: inline-block;">진행사항</h6>
				            </div>
						</div>
						<div class="card-body" style="clear: both;">
							<div class="row">
								<div class="col-lg-4">
									<table class="table table-bordered"  style="text-align: center;">
										<tr>
											<th colspan="2">결재 진행</th>
										</tr>
										<tr>
											<th>미결재 문서</th>
											<td class="aplist">
												<input type="hidden" class="tag" value="g">
												<input type="hidden" class="map" value="${map['g']}">
												${fn:length(glist)} 건
											</td>
										</tr>
										<tr>
											<th>결재 완료 문서</th>
											<td class="aplist">
												<input type="hidden" class="tag" value="f">
												<input type="hidden" class="map" value="${map['f']}">
												${fn:length(flist)} 건
											</td>
										</tr>
										<tr>
											<th>반려 문서</th>
											<td class="aplist">
												<input type="hidden" class="tag" value="r">
												<input type="hidden" class="map" value="${map['r']}">
												${fn:length(rlist)} 건
											</td>
										</tr>
										<tr>
											<th>종결 문서</th>
											<td class="aplist">
												<input type="hidden" class="tag" value="end">
												<input type="hidden" class="map" value="${map['end']}">
												${fn:length(endlist)} 건
											</td>
										</tr>
									</table>
								</div>
								<div class="col-lg-8">
									<table class="table table-bordered"  style="text-align: center;">
										<tr>
											<th colspan="4">개인 문서함</th>
										</tr>
										<tr>
											<th>상신 문서</th>
											<td class="aplist">
												<input type="hidden" class="tag" value="m">
												<input type="hidden" class="map" value="${map['m']}">
												${fn:length(mlist)}  건
											</td>
											<th>시행 문서</th>
											<td class="aplist">
												<input type="hidden" class="tag" value="s">
												<input type="hidden" class="map" value="${map['s']}">
												${fn:length(slist)} 건
											</td>
										</tr>
										<tr>
											<th>결재 완료 문서</th>
											<td class="aplist">
												<input type="hidden" class="tag" value="mf">
												<input type="hidden" class="map" value="${map['mf']}">
												${fn:length(mflist)}  건
											</td>
											<th>참조문서</th>
											<td class="aplist">
												<input type="hidden" class="tag" value="c">
												<input type="hidden" class="map" value="${map['c']}">
												${fn:length(clist)} 건
											</td>
										</tr>
										<tr>
											<th>반려 문서</th>
											<td class="aplist">
												<input type="hidden" class="tag" value="mr">
												<input type="hidden" class="map" value="${map['mr']}">
												${fn:length(mrlist)} 건
											</td>
											<th></th>
											<td></td>
										</tr>
									</table>
									<script type="text/javascript">
									//목록 불러오는 script
										$(document).on('click',".aplist",function(){
											var tag = $(this).find('.tag').val();
											var map = $(this).find('.map').val();
											$.ajax({
												url:"aplist.do",
												data:{map:map},
												dataType:"json",
												success:function(data){
													
												$area = $("#contentArea");	
												$area.html("");
												
												var $div = $("<div class='table-responsive'>");
												var $table =$('<table class="table table-bordered" style="text-align: center;">');
												var $thead=$("<thead>");
												var $tr1 = $("<tr>");
												var $th1 = $("<th>").text("품의 번호");
												var $th2 = $("<th>").text("문서 분류");
												var $th3 = $("<th>").text("제목");
												var $th4 = $("<th>").text("기안자");
												var $th5 = $("<th>").text("기안일");
												var $th6 = $("<th>").text("상태");
												var $tbody = $("<tbody>");
												var $caption = $("<caption>");
												
												if(tag=='m'){
													$caption.text("● 기안문서 > 진행 문서");
												}else if(tag=='mf'){
													$caption.text("● 기안문서 > 종결 문서");
												}else if(tag=='mr'){
													$caption.text("● 기안문서 > 중지(반려)문서");
												}else if(tag=='g'){
													$caption.text("● 결재문서 > 결재문서");
												}else if(tag=='f'){
													$caption.text("● 결재문서 > 결재완료");
												}else if(tag=='r'){
													$caption.text("● 결재문서 > 중단문서");
												}else if(tag=='end'){
													$caption.text("● 결재문서 > 종결문서");
												}else if(tag=='s'){
													$caption.text("● 결재문서 > 시행문서");
												}else if(tag=='c'){
													$caption.text("● 결재문서 > 참조문서");
												}
												
												
												if(data.length > 0){
													for(var i in data){
														var $tr = $("<tr>");
														var $td1 = $("<td>").text(data[i].apNo);
														var $td2 = $("<td>");
															if(data[i].a_v_first==null){
																$td2.text("일반결재");
															}else if(data[i].a_v_first!=null){
																$td2.text("근태결재");
															}
														var $td3 = $("<td class='detailView' style='cursor:pointer;'>").text(decodeURIComponent(data[i].apTitle.replace(/\+/g," ")));
														var $td4 = $("<td>").text(decodeURIComponent(data[i].empNo.replace(/\+/g," ")));
														var $td5 = $("<td>").text(data[i].apDate);
														var $td6 = $("<td>");
															if(data[i].apStatus=="Y"){
																if((data[i].hEmp)== null || (data[i].hEmp)==""){
																	if((data[i].approvalEmp).includes(",Y") ){
																		$td6.text("진행");
																	}else{
																		$td6.text("상신");
																	}
																}else{
																	if((data[i].hEmp).includes(",Y") || (data[i].approvalEmp).includes(",Y") ){
																		$td6.text("진행");
																	}else{
																		$td6.text("상신");
																	}
																}
															}else if(data[i].apStatus=="D"){
																$td6.text("종결");
															}else if(data[i].apStatus=="R"){
																$td6.text("중단-거부");
															}
														var $input1 =$("<input type='hidden' class='apNo'>").val(data[i].apNo);	
														var $input2 =$("<input type='hidden' class='tag'>").val(tag);	
														$td3.append($input1);
														$td3.append($input2);
														
														
														$tr.append($td1);
														$tr.append($td2);
														$tr.append($td3);
														$tr.append($td4);
														$tr.append($td5);
														$tr.append($td6);
														$tbody.append($tr);
													}
												}else{
													var $tr =$("<tr>");
													var $td = $("<td colspan='6'>").text("데이터가 없습니다.");
													$tr.append($td);
													$tbody.append($tr);
												}
																							
												$tr1.append($th1);
												$tr1.append($th2);
												$tr1.append($th3);
												$tr1.append($th4);
												$tr1.append($th5);
												$tr1.append($th6);
												
												$thead.append($tr1);
												$table.append($caption);
												$table.append($thead);
												$table.append($tbody);
												
												$div.append($table);
												$area.append($div);
												}
											});										
										});
									
										$(document).on('click',".detailView",function(){
											var apNo = $(this).find(".apNo").val();
											var tag = $(this).find(".tag").val();
											location.href="apDetail.do?apNo="+apNo+"&tag="+tag;										
										});
									</script>
								</div>
							</div>
						</div>
					</div>
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">문서함</h6>
						</div>
						<div class="card-body" id="contentArea">
							<!-- 매결재문서  -->
							<div class="table-responsive">
								<table class="table table-bordered" style="text-align: center;">
									<caption>● 결재 진행 > 미결재 문서</caption>
									<table class="table table-bordered" style="text-align: center;">
										<tr>
											<th>품의 번호</th>
											<th>문서 분류</th>
											<th>제목</th>
											<th>기안자</th>
											<th>기안일</th>
											<th>상태</th>
										</tr>
									</thead>
									<tbody>
										<c:if test="${empty glist}">
											<tr>
												<td colspan="6">데이터가 없습니다.</td>
											</tr>
										</c:if>
										<c:if test="${!empty glist}">
											<c:forEach var="ap" items="${glist}">
												<tr>
													<td>${ap.apNo}</td>
													<c:if test="${empty ap.a_v_first}">
														<td>일반결재</td>
													</c:if>
													<c:if test="${!empty ap.a_v_first}">
														<td>근태결재</td>
													</c:if>
													<td>
														<c:url var="apDetail" value="apDetail.do">
															<c:param name="apNo" value="${ap.apNo}"/>
															<c:param name="tag" value="g"/>
														</c:url>
														<a href="${apDetail}">${ap.apTitle}</a>
													</td>
													<td>${ap.empNo}</td>
													<td>${ap.apDate}</td>
													<c:if test="${ap.apStatus eq 'Y'}">
														<c:set var="approvalEmp" value="${ap.approvalEmpstatus}"/>
														<c:set var="hEmp" value="${ap.hEmpstatus}"/>
														
														<c:if test="${fn:contains(hEmp, ',Y') or fn:contains(approvalEmp, ',Y')}">
															<td>진행</td>
														</c:if>
														<c:if test="${!fn:contains(hEmp, ',Y') and !fn:contains(approvalEmp, ',Y')}">
															<td>상신</td>
														</c:if>
													</c:if>
													<c:if test="${ap.apStatus eq 'D'}">
														<td>종결</td>
													</c:if>
													<c:if test="${ap.apStatus eq 'R'}">
														<td>거부</td>
													</c:if>
												</tr>
											</c:forEach>
										</c:if>
									</tbody>
								</table>
							</div>

							<!-- 참조문서  -->
							<div class="table-responsive">
								<table class="table table-bordered" style="text-align: center;">
									<caption>● 참조문서함</caption>
									<thead>
										<tr>
											<th>품의 번호</th>
											<th>문서 분류</th>
											<th>제목</th>
											<th>기안자</th>
											<th>기안일</th>
											<th>상태</th>
										</tr>
									</thead>
									<tbody>
										<c:if test="${empty clist}">
											<tr>
												<td colspan="6">데이터가 없습니다.</td>
											</tr>
										</c:if>
										<c:if test="${!empty clist}">
											<c:forEach var="ap" items="${clist}">
												<tr>
													<td>${ap.apNo}</td>
													<c:if test="${empty ap.a_v_first}">
														<td>일반결재</td>
													</c:if>
													<c:if test="${!empty ap.a_v_first}">
														<td>근태결재</td>
													</c:if>
													<td>
														<c:url var="apDetail" value="apDetail.do">
															<c:param name="apNo" value="${ap.apNo}"/>
															<c:param name="tag" value="c"/>
														</c:url>
														<a href="${apDetail}">${ap.apTitle}</a>
													</td>
													<td>${ap.empNo}</td>
													<td>${ap.apDate}</td>
													<c:if test="${ap.apStatus eq 'Y'}">
														<c:set var="approvalEmp" value="${ap.approvalEmpstatus}"/>
														<c:set var="hEmp" value="${ap.hEmpstatus}"/>
														
														<c:if test="${fn:contains(hEmp, ',Y') or fn:contains(approvalEmp, ',Y')}">
															<td>진행</td>
														</c:if>
														<c:if test="${!fn:contains(hEmp, ',Y') and !fn:contains(approvalEmp, ',Y')}">
															<td>상신</td>
														</c:if>
													</c:if>
													<c:if test="${ap.apStatus eq 'D'}">
														<td>종결</td>
													</c:if>
													<c:if test="${ap.apStatus eq 'R'}">
														<td>거부</td>
													</c:if>
												</tr>
											</c:forEach>
										</c:if>
									</tbody>
								</table>
							</div>

							<!-- 시행문서  -->
							<div class="table-responsive">
								<table class="table table-bordered" style="text-align: center;">
									<caption>● 시행문서함</caption>
									<thead>
										<tr>
											<th>품의 번호</th>
											<th>문서 분류</th>
											<th>제목</th>
											<th>기안자</th>
											<th>기안일</th>
											<th>상태</th>
										</tr>
									</thead>
									<tbody>
										<c:if test="${empty slist}">
											<tr>
												<td colspan="6">데이터가 없습니다.</td>
											</tr>
										</c:if>
										<c:if test="${!empty slist}">
											<c:forEach var="ap" items="${slist}">
												<tr>
													<td>${ap.apNo}</td>
													<c:if test="${empty ap.a_v_first}">
														<td>일반결재</td>
													</c:if>
													<c:if test="${!empty ap.a_v_first}">
														<td>근태결재</td>
													</c:if>
													<td>
														<c:url var="apDetail" value="apDetail.do">
															<c:param name="apNo" value="${ap.apNo}"/>
															<c:param name="tag" value="s"/>
														</c:url>
														<a href="${apDetail }">${ap.apTitle}</a>
													</td>
													<td>${ap.empNo}</td>
													<td>${ap.apDate}</td>
													<c:if test="${ap.apStatus eq 'Y'}">
														<c:set var="approvalEmp" value="${ap.approvalEmpstatus}"/>
														<c:set var="hEmp" value="${ap.hEmpstatus}"/>
														
														<c:if test="${( fn:contains(hEmp, ',Y')) or fn:contains(approvalEmp, ',Y')}">
															<td>진행</td>
														</c:if>
														<c:if test="${!fn:contains(hEmp, ',Y') and !fn:contains(approvalEmp, ',Y')}">
															<td>상신</td>
														</c:if>
													</c:if>
													<c:if test="${ap.apStatus eq 'D'}">
														<td>종결</td>
													</c:if>
													<c:if test="${ap.apStatus eq 'R'}">
														<td>거부</td>
													</c:if>
												</tr>
											</c:forEach>
										</c:if>
									</tbody>
								</table>
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
