<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
	<%@ include file="/WEB-INF/views/ecommerce/fragments/header.jsp" %>
		<c:choose>
			<c:when test="${paymentMethods != null && paymentMethods.size() != 0}">
				<c:forEach var="paymentMethod" items="${paymentMethods}">
					<p>Numero carta: ${paymentMethod.cardNumber}</p>
					<p>Data scadenza: ${paymentMethod.expiryDate}</p>
					<p>CVV: ${paymentMethod.cvv}</p>
					<br><br>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<p>Non hai inserito alcun metodo di pagamento.</p>
			</c:otherwise>
		</c:choose>
		
		<form action="${pageContext.request.contextPath}/my-payment-methods" method="POST">
			<input type="text" name="card-number" placeholder="Numero della carta" autofocus required/>
			<br><br>
			<input type="text" name="expiry-date" placeholder="Data di scadenza" autofocus required/>
			<br><br>
			<input type="text" name="cvv" placeholder="Codice di sicurezza" autofocus required/>
			<br><br>
			<input type="submit" value="Aggiungi carta">
		</form>
	<%@ include file="/WEB-INF/views/ecommerce/fragments/footer.jsp" %>