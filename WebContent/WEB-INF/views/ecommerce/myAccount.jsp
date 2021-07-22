<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="/WEB-INF/views/ecommerce/fragments/header.jsp" %>

<div class="container">
	<div class="my-account-row">
	
		<div class="my-account-box">
			<div class="my-account-box-content">
				<div class="my-account-title">
					I miei ordini
				</div>
				<a href="${pageContext.request.contextPath}/my-orders">
					<span class="my-account-icons">
						<i class='bx bx-receipt'></i>
					</span>
				</a>
			</div>
		</div>
		
		<div class="my-account-box">
			<div class="my-account-box-content">
				<div class="my-account-title">
					I miei indirizzi
				</div>
				<a href="${pageContext.request.contextPath}/my-addresses">
					<span class="my-account-icons">
						<i class='bx bx-map-alt' ></i>
					</span>
				</a>
			</div>
		</div>
		
		<div class="my-account-box">
			<div class="my-account-box-content">
				<div class="my-account-title">
					I miei metodi di pagamento
				</div>
				<a href="${pageContext.request.contextPath}/my-payment-methods">
					<span class="my-account-icons">
						<i class='bx bxs-credit-card'></i>
					</span>
				</a>
			</div>
		</div>
		  
	</div>
</div>

<%@ include file="/WEB-INF/views/ecommerce/fragments/footer.jsp" %>