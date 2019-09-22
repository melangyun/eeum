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
<link href="${contextPath}/resources/bootstrap/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
<script	src="${contextPath}/resources/bootstrap/vendor/jquery/jquery.min.js"></script>
<script	src="${contextPath}/resources/bootstrap/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="${contextPath}/resources/bootstrap/vendor/jquery-easing/jquery.easing.min.js"></script>
<script src="${contextPath}/resources/bootstrap/js/sb-admin-2.min.js"></script>
<script src="${contextPath}/resources/bootstrap/vendor/chart.js/Chart.min.js"></script>
<script src="${contextPath}/resources/bootstrap/js/demo/chart-area-demo.js"></script>
<script src="${contextPath}/resources/bootstrap/js/demo/chart-pie-demo.js"></script>
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
		                <div class="card-header"><b>사원 관리</b></div>
		                <div class="card-body">
		                <form name="newEmpForm" method="post" action="updateEmp.do" autocomplete="off">
		                  <table class="table table-bordered" id="dataTable">
							<colgroup>
								<col width="30%">
								<col>
							</colgroup>
							<tr>
								<td style="vertical-align: middle">사번</td>
								<td><input type="text" name="empNo" value="${emp.empNo}" class="form-control form-control-user" style="width: 50%;" readonly></td>
							</tr>
							<tr>
								<td style="vertical-align: middle">이름</td>
								<td><input type="text" name="empName" value="${emp.empName}" class="form-control form-control-user" style="width: 50%;" readonly></td>
							</tr>
							<tr>
								<td style="vertical-align: middle">소속부서코드</td>
								<td>
									<div class="col-sm-5 mb-sm-0" style="margin-left: 0">
										<input type="text" id="deptNo" name="deptNo" value="${emp.deptNo}" class="form-control form-control-user">
										<span id="guide" style="font-size: 0.8em"></span>
									</div>
									
									<script type="text/javascript">
									//부서코드 입력시 소속 부서명으로 교체 유효하지 않을 경우,멘트를 바꾸는용
									$(function(){
										$("#deptNo").on('keyup', function(){
											var deptNo = $(this).val().trim();
											if(deptNo.length<1){
												$("#guide").html("부서코드를 입력해주세요");
												$("#guide").css("color","gray");
												return;
											}
											
											$.ajax({
												url:"selectDeptName.do",
												data : {deptNo:deptNo},
												success : function(data){
													var deptName = decodeURIComponent(data.replace(/\+/g,"")).replace(/\"/gi, ""); ;
													
													if(deptName!=""){
														$("#guide").html("유효한 부서 코드입니다.");
														$("#deptName").val(deptName);
														$("#guide").css("color","green");
													}else{
														$("#guide").html("부서코드를 확인해주세요");
														$("#deptName").val("");
														$("#guide").css("color","red");
													}
													
												}
											});
										});										
									});
									</script>
								</td>
							</tr>
							<tr>
								<td style="vertical-align: middle">소속부서명</td>
								<td><input type="text" id="deptName" name="deptName" value="${emp.deptName}" class="form-control form-control-user" style="width: 70%;" readonly></td>
							</tr>
							<tr>
								<td style="vertical-align: middle">직급</td>
								<td><input type="number" min="1" max="9" name="empPosition" value="${emp.empPosition}" class="form-control form-control-user" style="width: 50%;"></td>
							</tr>
							<tr>
								<td style="vertical-align: middle">입사일</td>
								<td><input type="date" name="joinDate" value="${emp.joinDate}" class="form-control form-control-user" style="width: 50%;" readonly></td>
							</tr>
							<tr>
								<c:set var="phone" value="${emp.phone}"/>
								<td style="vertical-align: middle">개인번호</td>
								<td>
									<div class="row">
										<div class="col-sm-3 mb-sm-0">
											<input type="text" name="phone" value="${fn:split(phone,'-')[0]}" class="form-control form-control-user">
										</div>
										<div class="col-sm-3">
											<input type="text" name="phone" value="${fn:split(phone,'-')[1]}" class="form-control form-control-user">
										</div>
										<div class="col-sm-3">
											<input type="text" name="phone" value="${fn:split(phone,'-')[2]}" class="form-control form-control-user">
										</div>
									</div>
								</td>
							</tr>
							<tr>
								<c:set var="empphone" value="${emp.empphone}"/>
								<td style="vertical-align: middle">내선번호</td>
								<td>
									<div class="row">
										<div class="col-sm-3 mb-sm-0">
											<input type="text" name="empphone" value="${fn:split(empphone,'-')[0]}" class="form-control form-control-user">
										</div>
										<div class="col-sm-3">
											<input type="text" name="empphone" value="${fn:split(empphone,'-')[1]}" class="form-control form-control-user">
										</div>
										<div class="col-sm-3">
											<input type="text" name="empphone" value="${fn:split(empphone,'-')[2]}" class="form-control form-control-user">
										</div>
									</div>
								</td>
							</tr>
							<tr>
								<c:set var="email" value="${emp.email}"/>
								<td style="vertical-align: middle">이메일</td>
								<td>
									<div class="row">
										<div class="col-sm-5 mb-sm-0">
											<input type="text" value="${fn:split(email,'@')[0]}" name="email" class="form-control form-control-user">
										</div>
										<div class="col-sm-5">
											<input type="text" value="${fn:split(email,'@')[1]}" name="email" class="form-control form-control-user">
										</div>
									</div>
								</td>
							</tr>
							<tr>
								<c:set var="address" value="${emp.address}"/>
								<td style="vertical-align: middle">주소</td>
								<td id="addressArea">
									<div class="col-sm-3">
										<input type="text" name="address" value="${fn:split(address,'|')[0]}" id="postcode" class="form-control form-control-user" placeholder="우편번호" onclick="execDaumPostcode()" style="background-color: white" readonly>
										
									</div>
									<div class="col-sm-9">
										<input type="text" name="address1" value="${fn:split(address,'|')[1]}" id="roadAddress" class="form-control form-control-user" placeholder="도로명주소" onclick="execDaumPostcode()" style="background-color: white" readonly>
									</div>
									<div class="col-sm-9">
										<input type="text" name="address2" value="${fn:split(address,'|')[2]}" id="jibunAddress" class="form-control form-control-user" placeholder="지번주소" onclick="execDaumPostcode()" style="background-color: white" readonly>
									</div>
									<div class="col-sm-9">
										<input type="text" name="address3" value="${fn:split(address,'|')[3]}" id="extraAddress" class="form-control form-control-user" placeholder="상세주소" onclick="execDaumPostcode()" style="background-color: white" readonly>
									</div>
									<div class="col-sm-9">
										<input type="text" name="address4" value="${fn:split(address,'|')[4]}" id="detailAddress" class="form-control form-control-user" placeholder="참조항목" >
									</div>
								</td>
							</tr>
		                 </table>
		                 
						<a href="javascript:history.back();" class="btn btn-light btn-icon-split">
		                    <span class="icon text-gray-600">
		                      <i class="fas fa-arrow-left"></i>
		                    </span>
		                    <span class="text">취소</span>
		                  </a>

		                 <button class="btn btn-primary btn-icon-split">
							<span class="icon text-white-50">
								<i class="fas fa-check"></i>
							</span>
							<span class="text">수정</span>
						</button>


						<a href="javascript:deleteEmp();"class=" btn btn-secondary btn-icon-split" style="float: right;">
		                    <span class="icon text-white-50">
		                      <i class="fas fa-trash"></i>
		                    </span>
		                    <span class="text">퇴사처리</span>
		                  </a>
		                  <!-- </button> -->
						<script type="text/javascript">
						function deleteEmp(){
								var empNo = "${emp.empNo}";
							if(confirm("${emp.empName} 사원을 정말로 퇴사처리 하시겠습니까?")){
								$.ajax({
									url:"deleteEmp.do",
									data:{empNo:empNo},
									type:"get",
									success:function(data){
										alert("퇴사처리가 완료되었습니다. 사원 관리화면으로 돌아갑니다.");
										history.back();
									}
								});
							}
						}
						</script>
						</form>
		                 <!--다음 주소찾기 스크립트 -->
											<script>
										    function execDaumPostcode() {
										        new daum.Postcode({
										            oncomplete: function(data) {
										                var roadAddr = data.roadAddress;
										                var extraRoadAddr = '';
										
										                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
										                    extraRoadAddr += data.bname;
										                }
										                if(data.buildingName !== '' && data.apartment === 'Y'){
										                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
										                }
										                if(extraRoadAddr !== ''){
										                    extraRoadAddr = ' (' + extraRoadAddr + ')';
										                }
										
										                document.getElementById('postcode').value = data.zonecode;
										                document.getElementById("roadAddress").value = roadAddr;
										                document.getElementById("jibunAddress").value = data.jibunAddress;
										                
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
						
		                </div>
		           </div>
				</div>
			</div>
	
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" flush="false"></jsp:include>

</body>

</html>
