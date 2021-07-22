<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>  

<%@ include file="/WEB-INF/views/ecommerce/fragments/header.jsp" %>

	<!-- HERO SECTION -->
	<section class="hero">
		<div class="slider">
			<div class="container">
				<!-- SLIDE ITEM -->
				<div class="slide">
					<div class="info">
						<div class="info-content">
							<h3 class="top-down">ONEPLUS NORD CE 5G</h3>
							<h2 class="top-down trans-delay-0-2">Novità per te!</h2>
                            <p class="top-down trans-delay-0-4">
                                Clicca qui sotto per acquistarlo!
                            </p>
                            <div class="top-down trans-delay-0-6">
                                <button class="button-flat button-hover"><span>Acquista adesso</span></button>
                            </div>
						</div>
					</div>
					<div class="img top-down">
						<img src="${pageContext.request.contextPath}/resources/images/ProductImages/OnePlus-Nord-CE-5G-128GB-Blue-Void.png" alt="">
					</div>
				</div>
				<!-- END SLIDE ITEM -->
				<!-- SLIDE ITEM -->
				<div class="slide active">
					<div class="info">
						<div class="info-content">
							<h3 class="top-down">APPLE WATCH SERIES 6</h3>
							<h2 class="top-down trans-delay-0-2">Novità per te!</h2>
                            <p class="top-down trans-delay-0-4">
                                Clicca qui sotto per acquistarlo!
                            </p>
                            <div class="top-down trans-delay-0-6">
                                <button class="button-flat button-hover"><span>Acquista adesso</span></button>
                            </div>
						</div>
					</div>
					<div class="img top-down">
						<img src="${pageContext.request.contextPath}/resources/images/ProductImages/Apple-Watch-Series-6.png" alt="">
					</div>
				</div>
				<!-- END SLIDE ITEM -->
				<!-- SLIDE ITEM -->
				<div class="slide">
					<div class="info">
						<div class="info-content">
							<h3 class="top-down">APPLE IPHONE 12 PRO</h3>
							<h2 class="top-down trans-delay-0-2">Novità per te!</h2>
                            <p class="top-down trans-delay-0-4">
                                Clicca qui sotto per acquistarlo!
                            </p>
                            <div class="top-down trans-delay-0-6">
                                <button class="button-flat button-hover"><span>Acquista adesso</span></button>
                            </div>
						</div>
					</div>
					<div class="img top-down">
						<img src="${pageContext.request.contextPath}/resources/images/ProductImages/Apple-IPhone-12-Pro-Gold.png" alt="">
					</div>
				</div>
				<!-- END SLIDE ITEM -->
			</div>
			 <!-- SLIDESHOW ARROWS -->
            <button class="slide-control slide-next">
                <i class='bx bxs-chevron-right'></i>
            </button>
            <button class="slide-control slide-prev">
                <i class='bx bxs-chevron-left'></i>
            </button>
            <!-- END SLIDESHOW ARROWS -->
		</div>
	</section>
	<!-- END HERO SECTION -->
	
	<!-- PROMOTION SECTION -->
	<section class="promotion">
		<div class="promotion-box">
			<div class="promotion-content">
				<div class="text">
                	<h3>Xiaomi</h3>
                		<a href="${pageContext.request.contextPath}/catalog?manufacturer=Xiaomi">
	                	<button class="button-flat button-hover">
	                		<span>Scopri i prodotti Xiaomi</span>
	                	</button>
                	</a>
            	</div>
            	<img src="${pageContext.request.contextPath}/resources/images/LogoImages/Xiaomi-Logo.png" alt="">
			</div>
		</div>
		<div class="promotion-box">
			<div class="promotion-content">
				<div class="text">
	                <h3>Apple</h3>
	               	<a href="${pageContext.request.contextPath}/catalog?manufacturer=Apple">
	                	<button class="button-flat button-hover">
	                		<span>Scopri i prodotti Apple</span>
	                	</button>
	               	</a>
            	</div>
            	<img src="${pageContext.request.contextPath}/resources/images/LogoImages/Apple-Logo.png" alt="">
			</div>
		</div>
		<div class="promotion-box">
			<div class="promotion-content">
				<div class="text">
                	<h3>OnePlus</h3>
                	<a href="${pageContext.request.contextPath}/catalog?manufacturer=OnePlus">
	                	<button class="button-flat button-hover">
	                		<span>Scopri i prodotti OnePlus</span>
	                	</button>
                	</a>
            	</div>
            	<img src="${pageContext.request.contextPath}/resources/images/LogoImages/Oneplus-Logo.png" alt="">
			</div>
		</div>
	</section>
	<!-- END PROMOTION SECTION -->
	
	<!-- NEW PRODUCTS SECTION -->
	<section class="latest-products">
		<div class="container">
			<div class="latest-products-title">
                <h2>Ultime uscite</h2>
            </div>
            <div class="product-grid">
            	<c:choose>
					<c:when test="${products != null && products.size() != 0}">
						<c:forEach var="product" items="${products}">
							<c:if test="${product.quantity > 0 && !product.deleted}">
								<div class="product-grid-item">
					                <div class="product-card">
					                    <div class="product-card-img">
					                        <img src="${product.imagePath}" alt="">
					                    </div>
					                    <div class="product-card-name">
					                        <p>${product.name}</p>
					                    </div>
					                    <div class="product-card-price">
					                    	<c:set var="productPriceWithIva">
					                    		<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${product.getPriceWithIva()}" />
					                    	</c:set>
					                    	<c:set var="productPriceWithDiscountAndIva">
					                    		<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${product.getPriceWithDiscountAndIva()}" />
					                    	</c:set>
					                    	<c:choose>
					                    		<c:when test="${product.discount > 0}">
					                    			<del>${productPriceWithIva}&euro;</del> <span class="discount-price">${productPriceWithDiscountAndIva}&euro;</span>
					                    		</c:when>
					                    		<c:otherwise>
					                    			<p>${productPriceWithDiscountAndIva}&euro;</p>
					                    		</c:otherwise>
					                    	</c:choose>
					                    </div>
					                    <div class="product-card-buttons">
					                        <a href="info?id=${product.id}"><button class="button-flat button-hover button-buy">Acquista adesso</button></a>
					                        <form action="${pageContext.request.contextPath}/cart" method="POST" class="cart-form">
					                        	<input type="hidden" name="id" value ="${product.id}">
					                        	<input type="hidden" name="productName" value ="${product.name}">
					                        	<input type="hidden" name="quantity" value ="1">
					                        	<input type="hidden" name="action" value ="addCart">
					                        	<button class="button-flat button-hover button-cart-add" type="submit">
						                            <i class='bx bxs-cart-add'></i>
						                        </button>
					                        </form>
					                    </div>
					                </div>     
					            </div>
							</c:if>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<h1>Non ci sono prodotti disponibili.</h1>
					</c:otherwise>
				</c:choose>
            </div>
		</div>
	</section>
	<!-- END NEW PRODUCTS SECTION -->
	
<%@ include file="/WEB-INF/views/ecommerce/fragments/footer.jsp" %>
