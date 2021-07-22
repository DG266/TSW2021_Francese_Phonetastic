<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

		<%@ include file="/WEB-INF/views/ecommerce/fragments/header.jsp" %>
			
		<div class="products-list-head">
			<h1>Prodotti in offerta</h1>
		</div>
		
		<div class="product-grid-container">
			<section class="product-grid">
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
						<h1>Non c'è alcuna offerta in corso :(</h1>
					</c:otherwise>
				</c:choose>
	        </section>
		</div>
        
        
		<%@ include file="/WEB-INF/views/ecommerce/fragments/footer.jsp" %>
	</body>
</html>