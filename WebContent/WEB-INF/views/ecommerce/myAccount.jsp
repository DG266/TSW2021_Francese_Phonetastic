<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

	<%@ include file="/WEB-INF/views/ecommerce/fragments/header.jsp" %>
		<a href="${pageContext.request.contextPath}/my-orders">Visualizza i tuoi ordini</a>
		<br><br><br><br>
		<a href="${pageContext.request.contextPath}/my-addresses">Imposta i tuoi indirizzi di spedizione</a>
		<br><br><br><br>
		<a href="${pageContext.request.contextPath}/my-payment-methods">Imposta i tuoi metodi di pagamento</a>
	<%@ include file="/WEB-INF/views/ecommerce/fragments/footer.jsp" %>