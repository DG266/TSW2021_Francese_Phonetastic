<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

	<%@ include file="/WEB-INF/views/ecommerce/fragments/header.jsp" %>
	
	<c:if test="${errorMessage != null}">
		<h2>${errorMessage}</h2>
	</c:if>
	

	<div class="cart-title"><h2>Il tuo Carrello</h2></div>
		<c:choose>
			<c:when test="${cart != null && cart.products.size() > 0}">
				<div class="cart-grid">
						<c:forEach var="cartItem" items="${cart.products}">
							<div class="cart-grid-item">
								<div class="cart-element">
									<div class="cart-img">
									<img src="${cartItem.product.imagePath}" alt="">
									</div>
									<div class="cart-details">
										${cartItem.product.name}
										<br>
										${cartItem.product.price * cartItem.quantity}
									</div>
									<div class="cart-action">
										<form action="cart" method="POST">
											<input type="hidden" name="action" value="changeQuantity">
											<input type="hidden" name="id" value="${cartItem.product.id}"> 
											<input type="text" name="quantity" size="2" value="${cartItem.quantity}"> 	
											<input type="submit" value="Aggiorna ordine">
										</form>
										<form action="cart" method="POST">
											<input type="hidden" name="action" value="changeQuantity">
											<input type="hidden" name="id" value="${cartItem.product.id}"> 
											<input type="hidden" name="quantity" value="0">
											<input type="submit" value="Rimuovi dal carrello">
										</form>
									</div>
								</div>
							</div>
						</c:forEach>
				</div>
				<br>
				<form action="cart" method="POST">
					<input type="hidden" name="action" value="deleteCart">
					<input type="submit" value="Svuota il carrello">
				</form>
				<div class="payment-button">
				<form action="finalize-order" method="GET">
					<input type="submit" value="Procedi con il pagamento">
				</form>
				</div>
			</c:when>
			<c:otherwise>
				<h2>Il tuo carrello è vuoto</h2>
			</c:otherwise>
		</c:choose>
		
		<%@ include file="/WEB-INF/views/ecommerce/fragments/footer.jsp" %>