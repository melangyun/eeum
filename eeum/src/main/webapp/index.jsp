<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="kor">

<head>
  <title></title>
</head>
<body id="page-top">
	<!--ContextPath 설정 -->
	<c:set var="contextPath" value="${ pageContext.servletContext.contextPath }" scope="application"/>
	<c:if test="${empty sessionScope.loginEmp}">
		<jsp:include page="/WEB-INF/views/common/login.jsp" flush="false"></jsp:include>
	</c:if>
	<c:if test="${!empty sessionScope.loginEmp}">
		<jsp:include page="/WEB-INF/views/home.jsp" flush="false"></jsp:include>
	</c:if>
	
</body>

</html>
