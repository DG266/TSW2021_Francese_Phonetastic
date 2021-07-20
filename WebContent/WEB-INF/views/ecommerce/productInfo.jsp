<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="/WEB-INF/views/ecommerce/fragments/header.jsp" %>
<main class="container-info-product">
 
    <!-- Product Description -->
    
    <div class="column-maker">
    <div>	
    <div class="product-description">
     <c:choose>
			<c:when test="${product.id != -1}">
				<img src="${product.imagePath}" width="300" height="300">
								
				<form action="${pageContext.request.contextPath}/cart" method="POST">
                	<input type="hidden" name="id" value ="${product.id}">
                	<input type="hidden" name="quantity" value ="1">
            	</form>
			</c:when>
			<c:otherwise>
				<h2>Prodotto non trovato</h2>
			</c:otherwise>
		</c:choose>			
				<span class=> Nome: ${product.name}</span>							
    </div>
 	</div>
    <!-- Product Configuration -->
    <div class="product-configuration">
      <div class="product-color">
        <span>Scelta dei colori molto Variegata!</span>
        
        <br>
        
        <br>
 
        <div class="color-choose">
          <div>
            <h4>Rosso</h4>
            <input data-image="red" type="radio" id="red" name="color" value="red" checked>
            <label for="red"><span></span></label>
          </div>
  
          <div>
            <h4>Blu</h4>
            <input data-image="blue" type="radio" id="blue" name="color" value="blue">
            <label for="blue"><span></span></label>
          </div>

          <div>
            <h4>Nero</h4>
            <input data-image="black" type="radio" id="black" name="color" value="black">
            <label for="black"><span></span></label>
          </div>
        </div>
        
        <br>
        
        
        			    <!-- Product Pricing -->
    <div class="product-price">
    <c:choose>
			<c:when test="${product.id != -1}">
      			<span>${product.price}</span>    
      			<span>Disponibili: ${product.quantity}</span> 
      			 <form action="${pageContext.request.contextPath}/cart" method="POST" class="cart-form">
				                        	<input type="hidden" name="id" value ="${product.id}">
				                        	<input type="hidden" name="productName" value ="${product.name}">
				                        	<input type="hidden" name="quantity" value ="1">
				                        	<input type="hidden" name="action" value ="addCart">
      <button class="cart-btn" type="submit">Aggiungi al carrello
				<i class='bx bxs-cart-add'></i>
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
<%@ include file="/WEB-INF/views/ecommerce/fragments/footer.jsp" %>
		
<script type="text/javascript">
$(document).ready(function() {
	 
	  $('.color-choose input').on('click', function() {
	      var Color = $(this).attr('data-image');
	 
	      $('.active').removeClass('active');
	      $('.left-column img[data-image = ' + Color + ']').addClass('active');
	      $(this).addClass('active');
	  });
	 
	});
</script>
</main>
	</body>
</html>