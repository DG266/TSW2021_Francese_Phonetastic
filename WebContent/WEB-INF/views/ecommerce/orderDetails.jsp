<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>  

		<%@ include file="/WEB-INF/views/ecommerce/fragments/header.jsp" %>
		
		<c:choose>
			<c:when test="${orderInfo.id != -1}">
				<div class="my-account-pages-title">
					<h2>Informazioni relative all'ordine N° ${orderInfo.id} (<fmt:formatDate type="both" timeZone="UTC" value="${orderInfo.lastUpdateDate}"/>)</h2>
				</div>
			</c:when>
			<c:otherwise>
				<h2>Non ci sono informazioni riguardanti questo ordine.</h2>
			</c:otherwise>
		</c:choose>

		
		<div class="container">
			<div class="order-details-container">
				<c:if test="${orderInfo.id != -1}">
					<div class="my-account-row">
						<div class="my-account-box">
							<p><strong>Indirizzo di spedizione:</strong></p>
							<p>${customerData.firstName} ${customerData.lastName}</p>
							<p>${orderAddress.address}</p>
							<p>${orderAddress.cap} ${orderAddress.city} (${orderAddress.province}) ${orderAddress.state}</p>
						</div>
						<div class="my-account-box">
							<p><strong>Metodo di pagamento:</strong></p>
							<p>Numero carta: ${orderPaymentMethod.cardNumber}</p>
							<p>Data di scadenza: ${orderPaymentMethod.expiryDate}</p>
							<!-- <p>Codice di sicurezza: ${orderPaymentMethod.cvv}</p> -->
						</div>
					</div>
	
					<c:set var="totalWithoutIva" value="0"/>
					<c:set var="totalIva" value="0"/>
					<c:set var="total" value="0"/>
				
					<div class="order-details-table">
						<table border="1">
							<tr>
								<th>Nome prodotto</th>
								<th>Imponibile</th>
								<th>IVA</th>
								<th>Sconto</th>
								<th>Quantità</th>
								<th>Totale (Sconto incluso)</th>
								<th>Totale (IVA e Sconto inclusi)</th>
							</tr>
							<c:choose>
								<c:when test="${orderInfo.id != -1}">
									<c:forEach var="composition" items="${orderInfo.elements}">
									
										<c:set var="totalWithoutIva" value="${totalWithoutIva = totalWithoutIva + composition.getTotalPriceWithDiscount()}"/>
										<c:set var="totalIva" value="${totalIva = totalIva + composition.getTotalIva()}"/>
										<c:set var="total" value="${total = total + composition.getTotalPriceWithDiscountAndIva()}"/>
										
										<tr>
											<td>${composition.productName}</td>
											<td>${composition.price} &euro;</td>
											<td>${composition.iva}%</td>
											<td>${composition.discount}%</td>
											<td>${composition.quantity}</td>
											<td><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${composition.getTotalPriceWithDiscount()}"/> &euro;</td>
											<td><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${composition.getTotalPriceWithDiscountAndIva()}"/> &euro;</td>
										</tr>
									</c:forEach>
		
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="7">Non ci sono informazioni riguardanti questo ordine.</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</table>
					</div>
					
					<div class="my-order-details-title">
						<h2>Totale merce: <fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${totalWithoutIva}"/> &euro;</h2>
					</div>
					<div class="my-order-details-title">
						<h2>Totale IVA: <fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${totalIva}"/> &euro;</h2>
					</div>
					<div class="my-order-details-title">
						<h2>Totale: <fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${total}"/> &euro;</h2>
					</div>
				</c:if>
			</div>
		</div>
		
			
		<%@ include file="/WEB-INF/views/ecommerce/fragments/footer.jsp" %>
	</body>
</html>
