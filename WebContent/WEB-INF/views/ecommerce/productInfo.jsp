<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
						${product.price} &euro;
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


    <!-- Product Description 
 
	<div class="column-maker">
		<div>
			<div class="product-description">
				<c:choose>
					<c:when test="${product.id != -1}">
						<img src="${product.imagePath}" width="300" height="300">
	
						<form action="${pageContext.request.contextPath}/cart"
							method="POST">
							<input type="hidden" name="id" value="${product.id}"> <input
								type="hidden" name="quantity" value="1">
						</form>
					</c:when>
					<c:otherwise>
						<h2>Prodotto non trovato</h2>
					</c:otherwise>
				</c:choose>
				<span class=> Nome: ${product.name}</span>
			</div>
		</div>
		-->
		<!-- Product Configuration 
		<div class="product-configuration">
			<div class="product-color">
				<span>Scelta dei colori molto Variegata!</span> <br> <br>
	
				<div class="color-choose">
					<div>
						<h4>Rosso</h4>
						<input data-image="red" type="radio" id="red" name="color"
							value="red" checked> <label for="red"><span></span></label>
					</div>
	
					<div>
						<h4>Blu</h4>
						<input data-image="blue" type="radio" id="blue" name="color"
							value="blue"> <label for="blue"><span></span></label>
					</div>
	
					<div>
						<h4>Nero</h4>
						<input data-image="black" type="radio" id="black" name="color"
							value="black"> <label for="black"><span></span></label>
					</div>
				</div>
	
				<br>
				-->
	
	
				<!-- Product Pricing 
				<div class="product-price">
					<c:choose>
						<c:when test="${product.id != -1}">
							<span>${product.price}</span>
							<span>Disponibili: ${product.quantity}</span>
							<form action="${pageContext.request.contextPath}/cart"
								method="POST" class="cart-form">
								<input type="hidden" name="id" value="${product.id}"> <input
									type="hidden" name="productName" value="${product.name}">
								<input type="hidden" name="quantity" value="1"> <input
									type="hidden" name="action" value="addCart">
								<button class="cart-btn" type="submit">
									Aggiungi al carrello <i class='bx bxs-cart-add'></i>
								</button>
							</form>
	
						</c:when>
					</c:choose>
				</div>
			</div>
		</div>
	</div>
	
	<div class="description-lovers">
		<span>Descrizione: ${product.description} </span>
	</div>
	-->
	



<%@ include file="/WEB-INF/views/ecommerce/fragments/footer.jsp"%>

