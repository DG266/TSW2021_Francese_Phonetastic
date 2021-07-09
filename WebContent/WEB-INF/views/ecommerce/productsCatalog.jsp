<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

		<%@ include file="/WEB-INF/views/ecommerce/fragments/header.jsp" %>
			
        <section class="product-grid">
	        <c:choose>
				<c:when test="${products != null && products.size() != 0}">
					<c:forEach var="product" items="${products}">
						<c:if test="${product.quantity > 0}">
							<div class="product-grid-item">
				                <div class="product-card">
				                    <div class="product-card-img">
				                        <img src="${product.imagePath}" alt="">
				                    </div>
				                    <div class="product-card-name">
				                        <p>${product.name}</p>
				                    </div>
				                    <div class="product-card-price">
				                        <p>${product.price}&euro;</p>
				                    </div>
				                    <div class="product-card-buttons">
				                        <a href="info?id=${product.id}"><button class="button-flat button-hover button-buy">Acquista adesso</button></a>
				                        
				                        <form action="${pageContext.request.contextPath}/cart" method="POST" class="cart-form">
				                        	<input type="hidden" name="id" value ="${product.id}">
				                        	<input type="hidden" name="productName" value ="${product.name}">
				                        	<input type="hidden" name="quantity" value ="1">
				                        	<input type="hidden" name="action" value ="addCart">
				                        	<!-- WITH (TEMP) AJAX -->
				                        	<button class="button-flat button-hover button-cart-add" type="submit">
					                            <i class='bx bxs-cart-add'></i>
					                        </button>
				                        </form>
				                        
				                        <!-- NO AJAX
				                        <a href="catalog?action=addCart&id=${bean.id}">
					                        <button class="button-flat button-hover button-cart-add">
					                            <i class='bx bxs-cart-add'></i>
					                        </button>
				                        </a>
				                        -->
				                    </div>
				                </div>     
				            </div>
						</c:if>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="6">Non ci sono prodotti disponibili.</td>
					</tr>
				</c:otherwise>
			</c:choose>
        </section>
        
		<%@ include file="/WEB-INF/views/ecommerce/fragments/footer.jsp" %>
	</body>
</html>