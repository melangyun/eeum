<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="kor">
<head>
  <title></title>
</head>
<style>
	input:-webkit-autofill {
   -webkit-box-shadow: 0 0 0 1000px white inset;
}
</style>
<body id="page-top">
	<!--ContextPath 설정 -->
	<c:set var="contextPath" value="${ pageContext.servletContext.contextPath }" scope="application"/>

	<c:if test="${empty sessionScope.loginEmp}">
		<jsp:forward page="eeum.do"></jsp:forward>
	</c:if>
	<c:if test="${!empty sessionScope.loginEmp}">
		<jsp:forward page="home.do"></jsp:forward>
	</c:if>
	
</body>

</html>
