<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
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
			<br><br>
			<c:choose>
				<c:when test="${productToUpdate != null && productToUpdate.id != -1}">
					<h2>Aggiorna le informazioni di ${productToUpdate.name} - (ID: ${productToUpdate.id})</h2>
					<form action="update-product" method="POST" class="productForm">
						<input type ="hidden" name="id" value="${productToUpdate.id}">
						<br><br>
						<label for="product-name">Nome</label> <br>
						<input type="text" id="product-name" name="name" value="${productToUpdate.name}" placeholder="${productToUpdate.name}" autofocus required/>
						<br><br>
						<label for="product-manufacturer">Casa produttrice</label> <br>
						<input type="text" id="product-manufacturer" name="manufacturer" value="${productToUpdate.manufacturer}" placeholder="${productToUpdate.manufacturer}" autofocus required/>
						<br><br>
						<label for="category">Categoria</label> <br>
						<input list="categories" name="category" id="category" placeholder="Categoria" autofocus required>
						<datalist id="categories">
							<c:forEach var="cat" items="${categories}">
							 	<option value="${cat.categoryName}"/>
							</c:forEach>
						</datalist>
						<br><br>
						<label for="product-price">Prezzo (&euro;)</label> <br>
						<input type="number" id="product-price" name="price" value="${productToUpdate.price}" placeholder="${productToUpdate.price}" step="any" min="1" autofocus required/>
						<br><br>
						<label for="product-discount">Sconto (%)</label> <br>
						<input type="number" id="product-discount" name="discount" value="${productToUpdate.discount}" placeholder="${productToUpdate.discount}" min="0" max="100" autofocus required/>
						<br><br>
						<label for="product-iva">IVA (%)</label> <br>
						<input type="number" id="product-iva" name="iva" value="${productToUpdate.iva}" placeholder="${productToUpdate.iva}" min="0" max="100" autofocus required/>
						<br><br>
						<label for="product-description">Descrizione</label> <br>
						<textarea name="description" id="product-description" rows="5" cols="48" placeholder="${productToUpdate.description}" autofocus required>${productToUpdate.description}</textarea>
						<br><br>
						<label for="product-quantity">Quantità</label> <br>
						<input type="number" id="product-quantity" name="quantity" value="${productToUpdate.quantity}" placeholder="${productToUpdate.quantity}" min="1" autofocus required/>
						<br><br>
						<label for="checkbox1">Da cancellare:</label><br>
						<input type="checkbox" name="is-deleted" id="checkbox1" value="true" autofocus <c:if test="${productToUpdate.deleted == true}"> checked</c:if> />
						<br><br>
						<!-- Maybe we should add the option to update the product image -->
						<input type ="hidden" name="insertion-date" value="${productToUpdate.insertionDate}">
						<input type ="hidden" name="image" value="${productToUpdate.imagePath}">
						<input type="submit" value="Aggiorna">
					</form>
				</c:when>
				<c:when test="${success != null && success == true}">
					<h2>Prodotto aggiornato con successo.</h2>
				</c:when>
				<c:when test="${success != null && success == false}">
					<h2>Non sono riuscito ad aggiornare il prodotto.</h2>
				</c:when>
				<c:otherwise>
					<h2>Qui puoi aggiornare le informazioni di un prodotto del catalogo.</h2>
					<c:if test="${productToUpdate.id == -1}">
					<h2>Non ho trovato il prodotto che cerchi.</h2>
					</c:if>
					<p>Scegli un prodotto da "Lista Prodotti" oppure inserisci qui l'ID del prodotto:</p>
					<br><br>
					<form action="update-product" method="get">
					    <input type="text" name="id" autofocus required/>
					    <input type="submit" value="Seleziona"/>
					</form>
				</c:otherwise>
			</c:choose>
		</div>
	</div>

<%@ include file="/WEB-INF/views/admin/fragments/footer.jsp" %>
