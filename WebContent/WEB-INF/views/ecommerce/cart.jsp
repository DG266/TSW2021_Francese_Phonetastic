<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

	<%@ include file="/WEB-INF/views/ecommerce/fragments/header.jsp" %>
	
	<c:if test="${errorMessage != null}">
		<h2>${errorMessage}</h2>
	</c:if>
	
	<h2>Carrello</h2>
		<c:choose>
			<c:when test="${cart != null && cart.products.size() > 0}">
				<table border="1">
					<tr>
						<th>Nome</th>
						<th>Quantità</th>
						<th>Prezzo</th>
						<th>Azione</th>
					</tr>
					<c:forEach var="cartItem" items="${cart.products}">
						<tr>
							<td>${cartItem.product.name}</td>
							<td>
								<form action="cart" method="POST">
									<input type="hidden" name="action" value="changeQuantity">
									<input type="hidden" name="id" value="${cartItem.product.id}"> 
									<input type="number" name="quantity" min="0" max="${initParam['max-quantity']}" value="${cartItem.quantity}">
									<input type="submit" value="Aggiorna ordine">
								</form>
							</td>
							<td>${cartItem.product.price * cartItem.quantity}</td>
							<td>
								<form action="cart" method="POST">
									<input type="hidden" name="action" value="changeQuantity">
									<input type="hidden" name="id" value="${cartItem.product.id}"> 
									<input type="hidden" name="quantity" value="0">
									<input type="submit" value="Rimuovi dal carrello">
								</form>
							</td>
						</tr>
					</c:forEach>
				</table>
				<br>
				<form action="finalize-order" method="GET">
					<input type="submit" value="Procedi con il pagamento">
				</form>
				<br><br>
				<form action="cart" method="POST">
					<input type="hidden" name="action" value="deleteCart">
					<input type="submit" value="Svuota il carrello">
				</form>
			</c:when>
			<c:otherwise>
				<h2>Il tuo carrello è vuoto</h2>
			</c:otherwise>
		</c:choose>
		
		<%@ include file="/WEB-INF/views/ecommerce/fragments/footer.jsp" %>