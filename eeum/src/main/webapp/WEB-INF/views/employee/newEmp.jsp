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

<!-- 다음 주소찾기 API -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<style type="text/css">
	#addressArea > div{
		margin-bottom: 0.5em;
	}
</style>
</head>

<body id="page-top">
	<c:set var="empNo" value="${empNo}"/>
	<c:if test="${!empty empNo}">
		<script>
			alert("${empNo} 사번이 생성되었습니다.");
		</script>
	</c:if>
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
									<c:choose>
										<c:when test="<%=i==0 %>">
											<td>${tl.deptName}( ${tDeptNo} )</td>
										</c:when>
										<c:otherwise>
											</tr>
											<tr>
											<td></td>
											<td>${tl.deptName}( ${tDeptNo} )</td>
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
		                <div class="card-header"><b>신규 사원 등록</b></div>
		                <div class="card-body">
		                <form name="newEmpForm" method="post" autocomplete="off">
		                  <table class="table table-bordered" id="dataTable">
							<colgroup>
								<col width="30%">
								<col>
							</colgroup>
							<tr>
								<td style="vertical-align: middle">이름</td>
								<td><input type="text" name="empName" class="form-control form-control-user" style="width: 50%;"></td>
							</tr>
							<tr>
								<td style="vertical-align: middle">소속부서코드</td>
								<td><input type="text" name="deptNo" class="form-control form-control-user" style="width: 70%;"></td>
							</tr>
							<tr>
								<td style="vertical-align: middle">직급</td>
								<td><input type="number" min="1" max="9" name="empPosition" class="form-control form-control-user" style="width: 50%;"></td>
							</tr>
							<tr>
								<td style="vertical-align: middle">입사일</td>
								<td><input type="date" name="joinDate" class="form-control form-control-user" style="width: 50%;"></td>
							</tr>
							<tr>
								<td style="vertical-align: middle">개인번호</td>
								<td>
									<div class="row">
										<div class="col-sm-3 mb-sm-0">
											<input type="text" name="phone" class="form-control form-control-user">
										</div>
										<div class="col-sm-3">
											<input type="text" name="phone" class="form-control form-control-user">
										</div>
										<div class="col-sm-3">
											<input type="text" name="phone" class="form-control form-control-user">
										</div>
									</div>
								</td>
							</tr>
							<tr>
								<td style="vertical-align: middle">내선번호</td>
								<td>
									<div class="row">
										<div class="col-sm-3 mb-sm-0">
											<input type="text" name="empphone" class="form-control form-control-user">
										</div>
										<div class="col-sm-3">
											<input type="text" name="empphone" class="form-control form-control-user">
										</div>
										<div class="col-sm-3">
											<input type="text" name="empphone" class="form-control form-control-user">
										</div>
									</div>
								</td>
							</tr>
							<tr>
								<td style="vertical-align: middle">이메일</td>
								<td>
									<div class="row">
										<div class="col-sm-5 mb-sm-0">
											<input type="text" name="email" class="form-control form-control-user">
										</div>
										<div class="col-sm-5">
											<input type="text" name="email" class="form-control form-control-user">
										</div>
									</div>
								</td>
							</tr>
							<tr>
								<td style="vertical-align: middle">주소</td>
								<td id="addressArea">
									<div class="col-sm-3">
										<input type="text" name="address" id="postcode" class="form-control form-control-user" placeholder="우편번호" onclick="execDaumPostcode()" style="background-color: white" readonly>
										
									</div>
									<div class="col-sm-9">
										<input type="text" name="address1" id="roadAddress" class="form-control form-control-user" placeholder="도로명주소" onclick="execDaumPostcode()" style="background-color: white" readonly>
									</div>
									<div class="col-sm-9">
										<input type="text" name="address2" id="jibunAddress" class="form-control form-control-user" placeholder="지번주소" onclick="execDaumPostcode()" style="background-color: white" readonly>
									</div>
									<div class="col-sm-9">
										<input type="text" name="address3" id="extraAddress" class="form-control form-control-user" placeholder="상세주소" onclick="execDaumPostcode()" style="background-color: white" readonly>
									</div>
									<div class="col-sm-9">
										<input type="text" name="address4" id="detailAddress" class="form-control form-control-user" placeholder="참조항목" >
									</div>
								</td>
							</tr>
		                 </table>
						</form>
		                 <!--다음 주소찾기 스크립트 -->
											<script>
										    function execDaumPostcode() {
										        new daum.Postcode({
										            oncomplete: function(data) {
										                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
										
										                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
										                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
										                var roadAddr = data.roadAddress; // 도로명 주소 변수
										                var extraRoadAddr = ''; // 참고 항목 변수
										
										                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
										                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
										                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
										                    extraRoadAddr += data.bname;
										                }
										                // 건물명이 있고, 공동주택일 경우 추가한다.
										                if(data.buildingName !== '' && data.apartment === 'Y'){
										                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
										                }
										                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
										                if(extraRoadAddr !== ''){
										                    extraRoadAddr = ' (' + extraRoadAddr + ')';
										                }
										
										                // 우편번호와 주소 정보를 해당 필드에 넣는다.
										                document.getElementById('postcode').value = data.zonecode;
										                document.getElementById("roadAddress").value = roadAddr;
										                document.getElementById("jibunAddress").value = data.jibunAddress;
										                
										                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
										                if(roadAddr !== ''){
										                    document.getElementById("extraAddress").value = extraRoadAddr;
										                } else {
										                    document.getElementById("extraAddress").value = '';
										                }
										                $('#detailAddress').focus();
										            }
										        }).open();
										    }
										</script>
		                 <!-- 등록하기 버튼 -->
						<a href="javascript:confirm();" class="btn btn-primary btn-icon-split">
							<span class="icon text-white-50">
								<i class="fas fa-check"></i>
							</span>
							<span class="text">등록하기</span>
						</a>
						<script type="text/javascript">
							function confirm(){
								document.newEmpForm.method="post";
								document.newEmpForm.action="insertNewEmp.do";
								document.newEmpForm.submit();
							}
						</script>
		                </div>
		           </div>
				</div>
			</div>
	
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" flush="false"></jsp:include>

</body>

</html>
