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
			
			<h3>Clicca sull'ID ordine (in rosso) per visualizzare i dettagli</h3>
			<br>
			
			<form action="orders" method="POST">	
				<p>Ricerca per data</p>
				<br>
				<label for="start-date">Da</label>
				<input type="date" id="start-date" name="start-date">
				<label for="end-date">a</label>
				<input type="date" id="end-date" name="end-date">
				<br><br>
				<input type="submit" value="Cerca">
			</form>
			<br>
			<form action="orders" method="POST">	
				<p>Ricerca per codice utente</p>
				<br>
				<label for="customer-id">ID: </label>
				<input type="text" id="customer-id" name="customer-id" value="">
				
				<br><br>
				<input type="submit" value="Cerca ID">
			</form>
			
			<br><br>
			<table border="1">
				<tr>
					<th>ID</th>
					<th>Totale</th>
					<th>Data creazione</th>
					<th>Ultimo aggiornamento</th>
					<th>Codice cliente</th>
				</tr>
				<c:choose>
					<c:when test="${orders != null && orders.size() != 0}">
						<c:forEach var="order" items="${orders}">
							<tr>
								<td><a class="admin-order-ids" href="${pageContext.request.contextPath}/my-orders?id=${order.id}">${order.id}</a></td>
								<td>${order.total}</td>
								<td><fmt:formatDate type="both" timeZone="UTC" value="${order.creationDate}"/></td>
								<td><fmt:formatDate type="both" timeZone="UTC" value="${order.lastUpdateDate}"/></td>
								<td>${order.customerId}</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="6">Non è stato effettuato alcun ordine.</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</table>
		</div>
	</div>

<%@ include file="/WEB-INF/views/admin/fragments/footer.jsp" %>
