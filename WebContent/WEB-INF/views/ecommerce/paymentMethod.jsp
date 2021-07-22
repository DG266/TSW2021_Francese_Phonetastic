<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="/WEB-INF/views/ecommerce/fragments/header.jsp"%>

<div class="my-account-pages-title">
	<h2>Aggiungi un metodo di pagamento</h2>
</div>

<div id="success-message">
</div>
<div id="error-message">
</div>
<form action="${pageContext.request.contextPath}/my-payment-methods" method="POST" id="paymentMethodForm">
	<div class="payment-method-form-container">
		<div class="card-front">
			<div class="shadow">
			</div>
	
			<label for="card-number">Numero carta</label> 
			<input type="text" id="card-number" placeholder="1234 5678 9101 1112" name="card-number" autofocus required>
			<!--  
			<div class="cardholder-container">
				<label for="card-holder"> Intestatario </label> 
				<input type="text" id="card-holder" placeholder="Nome Cognome" />
			</div>
			-->
			<div class="exp-container">
				<label for="card-exp"> Scadenza </label> 
				<input id="card-month" type="text" placeholder="MM" name="exp-month" autofocus required> 
				<input id="card-year" type="text" placeholder="YY" name="exp-year" autofocus required>
			</div>
			<div class="cvc-container">
				<label for="card-cvc">CVV</label> 
				<input id="card-cvc" placeholder="XXX" type="text" name="cvv" autofocus required>
			</div>
	
		</div>
		<div class="card-back">
			<div class="card-stripe">
			</div>
		</div>
	</div>
	
	<div class="centered-button">
		<button type="submit" class="button-flat button-hover">Aggiungi</button>
	</div>
</form>


<div class="my-account-pages-title">
	<h2>Metodi di pagamento salvati</h2>
</div>

<c:choose>
	<c:when test="${paymentMethods != null && paymentMethods.size() != 0}">
		<div class="my-account-row">
			<c:forEach var="paymentMethod" items="${paymentMethods}">
				<div class="my-account-box">
					<p>Numero carta: ${paymentMethod.cardNumber}</p>
					<p>Data scadenza: ${paymentMethod.expiryDate}</p>
					<p>CVV: ${paymentMethod.cvv}</p>
				</div>
			</c:forEach>
		</div>
		
	</c:when>
	<c:otherwise>
		<div class="my-account-pages-title">
			<h2>Non hai inserito alcun metodo di pagamento.</h2>
		</div>
	</c:otherwise>
</c:choose>

<%@ include file="/WEB-INF/views/ecommerce/fragments/footer.jsp"%>