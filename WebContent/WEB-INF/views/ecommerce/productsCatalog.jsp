<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

		<c:import url="/WEB-INF/views/ecommerce/header.jsp" />
		
		<!-- NEEDS SOME FIXES
		<div class="b">
			<p class="b">Prodotti</p>
			<%@ include file="slideshow2.jsp" %>
		</div>
		-->
		
        <section class="product-grid">
	        <c:choose>
				<c:when test="${products != null && products.size() != 0}">
					<c:forEach var="bean" items="${products}">
						<div class="product-grid-item">
			                <div class="product-card">
			                    <div class="product-card-img">
			                        <img src="${bean.imagePath}" alt="">
			                    </div>
			                    <div class="product-card-name">
			                        <p>${bean.name}</p>
			                    </div>
			                    <div class="product-card-price">
			                        <p>${bean.price}&euro;</p>
			                    </div>
			                    <div class="product-card-buttons">
			                        <a href="info?id=${bean.id}"><button class="button-flat button-hover button-buy">Acquista adesso</button></a>
			                        <a href="catalog?action=addCart&id=${bean.id}">
				                        <button class="button-flat button-hover button-cart-add">
				                            <i class='bx bxs-cart-add'></i>
				                        </button>
			                        </a>
			                    </div>
			                </div>     
			            </div>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="6">Non ci sono prodotti disponibili.</td>
					</tr>
				</c:otherwise>
			</c:choose>
        </section>
        
		<c:import url="/WEB-INF/views/ecommerce/footer.jsp" />
	</body>
</html>