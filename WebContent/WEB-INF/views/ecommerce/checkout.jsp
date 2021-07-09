<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

	<%@ include file="/WEB-INF/views/ecommerce/fragments/header.jsp" %>
	 

	 	<form action="${pageContext.request.contextPath}/finalize-order" method="POST">
	 		<c:choose>
	 			<c:when test="${userAddresses.size() > 0}">
		 			<div class="address-container">
						<h1>Scegli l'indirizzo di spedizione</h1>
						<c:forEach var="addr" items="${userAddresses}">
							<input type="radio" id="${addr.addressId}" name="chosen-address" value="${addr.addressId}">
							<label for="${addr.addressId}">Indirizzo n° ${addr.addressId}</label>
							<p>Stato: ${addr.state}</p>
							<p>Città: ${addr.city}</p>
							<p>Provincia: ${addr.province}</p>
							<p>CAP: ${addr.cap}</p>
							<p>Indirizzo: ${addr.address}</p>
							<br><br>
						</c:forEach>
					</div>
	 			</c:when>
	 			<c:otherwise>
		 			<div class="address-container">
						<h1>Inserisci i dati del tuo indirizzo</h1>
						<input type="text" name="state" placeholder="Stato" autofocus required/>
						<br><br>
						<input type="text" name="city" placeholder="Città" autofocus required/>
						<br><br>
						<input type="text" name="province" placeholder="Provincia" autofocus required/>
						<br><br>
						<input type="text" name="cap" placeholder="CAP" autofocus required/>
						<br><br>
						<input type="text" name="address" placeholder="Indirizzo" autofocus required/>
					</div>
	 			</c:otherwise>
	 		</c:choose>
	 		<c:choose>
	 			<c:when test="${userPaymentMethods.size() > 0}">
		 			<div class="payment-methods-container">
						<h1>Scegli il metodo di pagamento</h1>
						<c:forEach var="paymentMethod" items="${userPaymentMethods}">
							<input type="radio" id="${addr.paymentMethodId}" name="chosen-payment-method" value="${paymentMethod.paymentMethodId}">
							<label for="${paymentMethod.paymentMethodId}">Metodo di pagamento n° ${paymentMethod.paymentMethodId}</label>
							<p>Numero carta: ${paymentMethod.cardNumber}</p>
							<p>Data scadenza: ${paymentMethod.expiryDate}</p>
							<p>CVV: ${paymentMethod.cvv}</p>
							<br><br>
						</c:forEach>
					</div>
	 			</c:when>
	 			<c:otherwise>
		 			<div class="payment-methods-container">
						<h1>Inserisci i dati del tuo metodo di pagamento</h1>
						<input type="text" name="card-number" placeholder="Numero della carta" autofocus required/>
						<br><br>
						<input type="text" name="expiry-date" placeholder="Data di scadenza" autofocus required/>
						<br><br>
						<input type="text" name="cvv" placeholder="Codice di sicurezza" autofocus required/>
						<br><br>
					</div>
	 			</c:otherwise>
	 		</c:choose>
	 		<input type="submit" value="Acquista">
	 	</form>
	 
	<%@ include file="/WEB-INF/views/ecommerce/fragments/footer.jsp" %>
