<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ include file="/WEB-INF/views/ecommerce/fragments/header.jsp"%>

	<div class="container">
		<div class="product-info-row">
			<div class="left-column">
				<div class="product-info-image">
					<div class="img-zoom-container">
						<img id="productImage" src="${product.imagePath}" alt="${product.name}">
						<div id="zoomContainer" class="img-zoom-result">
						</div>
					</div>
				</div>
			</div>
			<div class="right-column">
				<div class="product-basic-info">
					<h1>${product.name}</h1>
					<div class="product-manufacturer-info">
						<span class="product-manufacturer-info-title">Casa produttrice:</span>
						<a href="${pageContext.request.contextPath}/catalog?manufacturer=${product.manufacturer}">${product.manufacturer}</a>
					</div>
					<div class="product-info-instock">
						<span class="product-info-instock-title">In stock:</span>
						<span>${product.quantity}</span>
					</div>
					<p class="product-description-info">
						${product.description}
					</p>
					<div class="product-info-price">
						<c:choose>
	                   		<c:when test="${product.discount > 0}">
	                   			<del><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${product.getPriceWithIva()}"/> &euro;</del> <span class="discount-price"><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${product.getPriceWithDiscountAndIva()}"/> &euro;</span>
	                   		</c:when>
	                   		<c:otherwise>
	                   			<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${product.getPriceWithDiscountAndIva()}"/> &euro;
	                   		</c:otherwise>
	                   	</c:choose>	
					</div>
					<div class="product-info-quantity">
						<span id="decreaseQuantity" class="product-info-quantity-button"><i class="bx bx-minus"></i></span>
						<span id="productInfoQuantityVal" class="product-info-quantity-value">1</span>
						<span id="increaseQuantity"class="product-info-quantity-button"><i class="bx bx-plus"></i></span>
					</div>
					<div class="product-info-cart-button">
						<form action="${pageContext.request.contextPath}/cart" method="POST" id="productInfoCartForm">
                        	<input type="hidden" name="id" value ="${product.id}">
                        	<input type="hidden" name="quantity" value ="1">
                        	<input type="hidden" name="action" value ="addCart">
                        	<button type="submit" class="button-flat button-hover">Aggiungi al carrello</button>
                        </form>
					</div>
				</div>
			</div>
		</div>
		<div class="product-info-large-description">
			<div class="product-info-large-description-title">
				Descrizione
			</div>
			<div class="product-info-large-description-text">
				${product.description} 
			</div>
		</div>
	</div>

<%@ include file="/WEB-INF/views/ecommerce/fragments/footer.jsp"%>

