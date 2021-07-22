<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

	<%@ include file="/WEB-INF/views/ecommerce/fragments/header.jsp" %>
	 
	<div class="container">
	
		<c:if test="${userAddresses.size() <= 0 || userPaymentMethods.size() <= 0}">
			<div class="my-account-pages-title">
				<h2>Inserisci i dati mancanti per poter continuare.</h2>
			</div>
		</c:if>
		
		<div class="my-account-pages-error" id="addressError">
		</div>
		
		<div class="my-account-pages-error" id="paymentMethodError">
		</div>

	 	<form action="${pageContext.request.contextPath}/finalize-order" method="POST" class="addressForm paymentMethodForm">
	 		<c:choose>
	 			<c:when test="${userAddresses.size() > 0}">
	 				<h1>Scegli l'indirizzo di spedizione</h1>
		 			<div class="my-account-row">
						<c:forEach var="addr" items="${userAddresses}">
							<div class="my-account-box">
								<input type="radio" id="${addr.addressId}" name="chosen-address" value="${addr.addressId}">
								<label for="${addr.addressId}">Indirizzo n° ${addr.addressId}</label>
								<p>Stato: ${addr.state}</p>
								<p>Città: ${addr.city}</p>
								<p>Provincia: ${addr.province}</p>
								<p>CAP: ${addr.cap}</p>
								<p>Indirizzo: ${addr.address}</p>
							</div>
						</c:forEach>
					</div>
	 			</c:when>
	 			<c:otherwise>
		 			<div class="address-form-container">
						<div class="address-column">		
				            <h1>
				                <i class='bx bxs-plane-take-off'></i>
				                Dettagli spedizione
				            </h1>
				            <input type="text" name="state" placeholder="Stato" autofocus required/>
							<br><br>
							<input type="text" name="city" placeholder="Città" autofocus required/>
							<br><br>
							<input type="text" name="province" placeholder="Provincia (Due lettere: NA, MI, ecc.)" autofocus required/>
							<br><br>
							<input type="text" name="cap" placeholder="CAP" autofocus required/>
							<br><br>
							<input type="text" name="address" placeholder="Indirizzo" autofocus required/>
						</div>
					</div>
	 			</c:otherwise>
	 		</c:choose>
	 		<c:choose>
	 			<c:when test="${userPaymentMethods.size() > 0}">
		 			<div class="payment-methods-container">
						<h1>Scegli il metodo di pagamento</h1>
						<div class="my-account-row">
							<c:forEach var="paymentMethod" items="${userPaymentMethods}">
								<div class="my-account-box">
									<input type="radio" id="${addr.paymentMethodId}" name="chosen-payment-method" value="${paymentMethod.paymentMethodId}">
									<label for="${paymentMethod.paymentMethodId}">Metodo di pagamento n° ${paymentMethod.paymentMethodId}</label>
									<p>Numero carta: ${paymentMethod.cardNumber}</p>
									<p>Data scadenza: ${paymentMethod.expiryDate}</p>
									<p>CVV: ${paymentMethod.cvv}</p>
								</div>
							</c:forEach>
						</div>
					</div>
	 			</c:when>
	 			<c:otherwise>
		 			<div class="payment-methods-container">
						<h1>Inserisci i dati del tuo metodo di pagamento</h1>
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
					</div>
	 			</c:otherwise>
	 		</c:choose>
	 		<div class="centered-button">
	 			<button type="submit" class="button-flat button-hover">Completa l'acquisto</button>
	 		</div>
	 	</form>
	 </div>
	 
	<%@ include file="/WEB-INF/views/ecommerce/fragments/footer.jsp" %>
