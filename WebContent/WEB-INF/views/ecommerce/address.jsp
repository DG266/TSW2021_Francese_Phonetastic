<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
	<%@ include file="/WEB-INF/views/ecommerce/fragments/header.jsp" %>
	
	<div class="my-account-pages-title">
		<h2>Aggiungi un indirizzo di spedizione</h2>
	</div>
	
	<div class="my-account-pages-error" id="addressError">
	</div>
	
	
	<div class="container">
		<div class="address-form-container">
			<div class="address-column">
				<form action="${pageContext.request.contextPath}/my-addresses" method="POST" class="addressForm">
		            <h1>
		                <i class='bx bxs-plane-take-off'></i>
		                Dettagli spedizione
		            </h1>
		            <input type="text" name="state" placeholder="Stato" autofocus required/>
					<br><br>
					<input type="text" name="city" placeholder="Città" autofocus required/>
					<br><br>
					<input type="text" name="province" placeholder="Provincia (Due lettere: NA, MI, ecc.)" autofocus required/>
					<br><br>
					<input type="text" name="cap" placeholder="CAP" autofocus required/>
					<br><br>
					<input type="text" name="address" placeholder="Indirizzo" autofocus required/>
					<br><br>
					<input type="submit" value="Aggiungi indirizzo">
		        </form>
			</div>
	        
	    </div>
	</div>
	
	<div class="my-account-pages-title">
		<h2>Indirizzi di spedizione salvati</h2>
	</div>
	
	<c:choose>
		<c:when test="${addresses != null && addresses.size() != 0}">
			<div class="my-account-row">
				<c:forEach var="addr" items="${addresses}">
					<div class="my-account-box">
						<p>Stato: ${addr.state}</p>
						<p>Città: ${addr.city}</p>
						<p>Provincia: ${addr.province}</p>
						<p>CAP: ${addr.cap}</p>
						<p>Indirizzo: ${addr.address}</p>
					</div>
				</c:forEach>
			</div>
			
		</c:when>
		<c:otherwise>
			<div class="my-account-pages-title">
				<h2>Non hai inserito alcun indirizzo di spedizione.</h2>
			</div>
		</c:otherwise>
	</c:choose>
	
	<%@ include file="/WEB-INF/views/ecommerce/fragments/footer.jsp" %>