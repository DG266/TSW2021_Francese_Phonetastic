<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>  
    
<%@ include file="/WEB-INF/views/admin/fragments/header.jsp" %>

	<!-- MAIN CONTENT -->
	<div class="main">
		<div class="main-header">
			<div class="mobile-toggle" id="mobile-toggle">
				<i class='bx bx-menu-alt-right'></i>
			</div>
			<div class="main-title">
				dashboard
			</div>
		</div>
		<div class="main-content">
			<table border="1">
				<tr>
					<th>ID</th>
					<th>Nome</th>
					<th>Casa Produttrice</th>
					<th>Quantità</th>
					<th>Prezzo</th>
					<th>IVA</th>
					<th>Sconto</th>
					<th>Data inserimento</th>
					<th>Data ultimo aggiornamento</th>
					<th>Nascosto</th>
					<th>Azioni</th>
				</tr>
				<c:choose>
					<c:when test="${products != null && products.size() != 0}">
						<c:forEach var="product" items="${products}">
							<tr>
								<td>${product.id}</td>
								<td>${product.name}</td>
								<td>${product.manufacturer}</td>
								<td>${product.quantity}</td>
								<td>${product.price}</td>
								<td>${product.iva}%</td>
								<td>${product.discount}%</td>
								<td><fmt:formatDate type="both" timeZone="UTC" value="${product.insertionDate}"/></td>
								<td><fmt:formatDate type="both" timeZone="UTC" value="${product.lastUpdateDate}"/></td>
								<td>${product.deleted}</td>
								
								<td><a href="update-product?id=${product.id}">Aggiorna Info</a></td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="6">Non ci sono prodotti disponibili.</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</table>
		</div>
	</div>

<%@ include file="/WEB-INF/views/admin/fragments/footer.jsp" %>
