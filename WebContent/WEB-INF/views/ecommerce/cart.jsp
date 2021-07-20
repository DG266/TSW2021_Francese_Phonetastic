<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ include file="/WEB-INF/views/ecommerce/fragments/header.jsp"%>

	<c:if test="${errorMessage != null}">
		<h2>${errorMessage}</h2>
	</c:if>

<div class="container">
	<div class="cart-main">
		<div class="cart">
			<div class="cart-labels">
				<ul>
					<li class="item item-heading">Prodotto</li>
					<li class="price">Prezzo</li>
					<li class="quantity">Quantità</li>
					<li class="subtotal">Subtotale</li>
				</ul>
			</div>
			
			<c:choose>
				<c:when test="${cart != null && cart.products.size() > 0}">
					<c:forEach var="cartItem" items="${cart.products}">
						<div class="cart-product">
							<div class="item">
								<div class="product-image">
									<img src="${cartItem.product.imagePath}"
										alt="Placholder Image 2" class="product-frame">
								</div>
								<div class="product-details">
									<h1>
										<span class="item-quantity">${cartItem.quantity} x ${cartItem.product.name}</span> 
									</h1>
								</div>
							</div>
							<div class="price">
								<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${cartItem.product.getPriceWithDiscountAndIva()}"/> &euro;
							</div>
							<div class="quantity">
								<form action="cart" method="POST">
									<input type="hidden" name="action" value="changeQuantity">
									<input type="hidden" name="id" value="${cartItem.product.id}"> 
									<input type="number" name="quantity" size="2" value="${cartItem.quantity}" min="0" class="quantity-field"> 	
									<button type="submit">Cambia q.tà</button>
								</form>
							</div>
							<div class="subtotal">
								<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${cartItem.product.getPriceWithDiscountAndIva() * cartItem.quantity}"/> &euro;
							</div>
							<div class="remove">
								<form class="removeCartItem" action="cart" method="POST">
									<input type="hidden" name="action" value="changeQuantity">
									<input type="hidden" name="id" value="${cartItem.product.id}"> 
									<input type="hidden" name="quantity" value="0">
									<button type="submit">Rimuovi</button>
								</form>
								
							</div>
						</div>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<h2>Il tuo carrello è vuoto</h2>
				</c:otherwise>
			</c:choose>

		</div>
		<aside>
			<div class="summary">
				<div class="summary-total-items">
					<span class="total-items"></span> Prodotti nel carrello
				</div>
				<div class="summary-subtotal">					
					<div class="subtotal-title">Subtotale (+IVA)</div>
					<div class="subtotal-value final-value" id="cart-subtotal">
						<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${cart.getTotalWithIva()}"/> &euro;
					</div>
					
					<div class="summary-promo hide">
						<div class="promo-title">Sconto</div>
						<div class="promo-value final-value" id="cart-promo">
							-<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${cart.getTotalDiscount()}"/> &euro;
						</div>
					</div>
					
				</div>
				<div class="summary-total">
					<div class="total-title">Totale</div>
					<div class="total-value final-value" id="cart-total">
						<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${cart.getTotalWithDiscountAndIva()}"/> &euro;
					</div>
				</div>
				<div class="summary-checkout">
					<form action="finalize-order" method="GET">
						<button type="submit" class="checkout-button">Completa l'acquisto</button>
					</form>			
				</div>
			</div>
		</aside>
	</div>
</div>


<%@ include file="/WEB-INF/views/ecommerce/fragments/footer.jsp"%>