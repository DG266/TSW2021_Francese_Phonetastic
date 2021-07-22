<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

	<%@ include file="/WEB-INF/views/ecommerce/fragments/header.jsp" %>
	
	<div class="container">
		<div class="purchase-completed-content">
			<div class="my-account-pages-title">
				<h2>Grazie per aver scelto Phonetastic!</h2>
			</div>
			<div class="my-account-pages-title">
				<h2>Il tuo ordine (N° ${newOrderId}) è stato registrato con successo.</h2>
			</div>
			
			<div class="my-account-pages-title">
				<h3>Clicca <a href="${pageContext.request.contextPath}/my-orders">qui</a> per visualizzare la pagina "I tuoi ordini"!</h3>
			</div>
		</div>
	</div>
	
	<%@ include file="/WEB-INF/views/ecommerce/fragments/footer.jsp" %>
