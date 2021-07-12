<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

		<%@ include file="/WEB-INF/views/ecommerce/fragments/header.jsp" %>
			<div class="order-details-table">
				<table border="1">
					<tr>
						<th>Nome prodotto</th>
						<th>Costo</th>
						<th>Quantità</th>
						<th>IVA</th>
					</tr>
					<c:choose>
						<c:when test="${orderInfo.id != -1}">
							<c:forEach var="composition" items="${orderInfo.elements}">
								<tr>
									<td>${composition.productName}</td>
									<td>${composition.price}</td>
									<td>${composition.quantity}</td>
									<td>${composition.iva}</td>
								</tr>
							</c:forEach>
							<div class="purchase-details">
								<div class="shipping-address">
									<p>Indirizzo di spedizione:</p>
									<p>${orderAddress.address}</p>
									<p>${orderAddress.cap} ${orderAddress.city} (${orderAddress.province}) ${orderAddress.state}</p>
								</div>
								<div class="payment-method">
									<p>Metodo di pagamento</p>
									<p>Numero carta: ${orderPaymentMethod.cardNumber}</p>
									<p>Data di scadenza: ${orderPaymentMethod.expiryDate}</p>
									<p>Codice di sicurezza: ${orderPaymentMethod.cvv}</p>
								</div>
							</div>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="6">Non ci sono informazioni riguardanti questo ordine.</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</table>
			</div>
		<%@ include file="/WEB-INF/views/ecommerce/fragments/footer.jsp" %>
	</body>
</html>
