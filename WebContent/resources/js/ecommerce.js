// N.B.: Ho lasciato i commenti in italiano per chiarezza

$(document).ready(function(){
	
	// NECESSARIO PER IL FUNZIONAMENTO DEL MENU MOBILE
	$("#open").click(function(){
		$("#header-wrapper").addClass("active");
	});
	
	$("#close").click(function(){
		$("#header-wrapper").removeClass("active");
	});
	
	// SLIDESHOW
	
	let slideIndex = 0;
	
	function hideAllSlide(){
		$(".slide").each(function(){
			$(this).removeClass("active");
		});
	}
	
	function showSlide(){
		hideAllSlide();
		$(".slide").eq(slideIndex).addClass("active");
	}
	
	function nextSlide(){
		if(slideIndex + 1 == $(".slide").length){
			slideIndex = 0;
		}
		else{
			slideIndex++;
		}
	}
	
	function prevSlide(){
		if(slideIndex - 1 < 0){
			slideIndex = $(".slide").length - 1;
		}
		else{
			slideIndex--;
		}
	}
	
	$(".slide-next").click(function(){
	    nextSlide();
	    showSlide();
	})
	
	$(".slide-prev").click(function(){
	    prevSlide();
	    showSlide();
	})
	
	showSlide();
	
	// FINE SLIDESHOW
	
	
	// CARRELLO CON AJAX
	$(".button-cart-add").click(function(event) {
		
	    event.preventDefault();		// previene l'invio del form
		
	    var form = $(this).closest(".cart-form");       
	    
		// richiesta AJAX per aggiungere un prodotto al carrello
		$.ajax({
		    type: "POST",
		    url: "./cart",
		    async: true,
		    data: form.serialize(),
		    success: function() {
			
				// aggiornamento icona carrello
				$.get("./cart", function(responseJson) {  
					$(".cart-quantity-number").html(responseJson.length);
				});
				
				// notifica aggiunta prodotto al carrello
				$("body").append("<div class=\"cart-notification\"><span>Prodotto aggiunto al carrello</span></div>");
				$(".cart-notification").fadeOut(5000);
				//$(".addtocartconfirmation").show();
		    },
		    error: function(jqXHR, errorType, exception) { 
			
                //alert("Errore." + form.serialize());
	
				
				//$("body").append("<div class=\"cart-notification\"><span>C'è stato un problema, non ho aggiunto il prodotto al carrello.</span></div>");
				//$(".cart-notification").fadeOut(5000);
				
			
				$("body").append("<div class=\"cart-notification\"><span>" + jqXHR.responseText +"</span></div>");
				$(".cart-notification").fadeOut(5000);
            }
		});
		
	});	
	
	var timer = null;
	
	// SEARCHBAR CON AJAX
	$("#searchText").keyup(function(){
		
		// preleva la stringa inserita dall'utente nella barra di ricerca
        var search = $(this).val();
		
		// nel caso l'utente abbia inserito/cancellato un carattere, annullo il timeout precedente (posso farlo perchè timer è fuori da questo codeblock)
		clearTimeout(timer);
		
		// la richiesta ajax viene inviata dopo 500 ms (evito troppe richieste verso il server)
        timer = setTimeout(function() {
			if(search != ""){
	            $.ajax({
		            type: "GET",
	                url: "./search",
	                data: {partialName : search},
	                dataType: 'json',
	                success:function(response){
	               
						// svuota la lista di suggerimenti precedente
	                    $(".suggestions").empty();
	
						// aggiunge alla lista di suggerimenti tutti i risultati
	                    for( var i = 0; i < response.length; i++) {
							$(".suggestions").append(
								"<li><div class=\"suggestions-element\">" +
								"<div class=\"suggestions-image\"><img src=\"" +  response[i].imagePath + "\"></div>" +
		  						"<div class=\"suggestions-text\"><a href=\"info?id=" + response[i].id + "\">" + response[i].name + "</a></div>" +
		    					"</div></li>"
							);
	                    }	
	                }
	            });
        	} 
			else{
				$(".suggestions").empty();
			}
		}, 500);
    });

	// RIMOZIONE PRODOTTI DAL CARRELLO CON AJAX
	$(".removeCartItem").click(function(event){
		
		event.preventDefault();
		
		var form = $(this);   
		var productToRemove = $(this).closest(".cart-product");
		
		$.ajax({
		    type: "POST",
		    url: "./cart",
		    async: true,
		    data: form.serialize(),
		    success: function() {
				productToRemove.remove();    
				
				// aggiornamento icona carrello e prezzi
				$.get("./cart", {updatePrice : true},function(responseJson) { 
					if(responseJson.cartSize > 0){
						$(".cart-quantity-number").html(responseJson.cartSize);
					} 
					else{
						$(".cart").append("<h2>Il tuo carrello è vuoto</h2>");
					}
					$("#cart-subtotal").html(responseJson.totalWithIva);
					$("#cart-promo").html("-" + responseJson.totalDiscount);
					$("#cart-total").html(responseJson.totalWithDiscountAndIva);
				});
		    }
		});
	});
	
	
});






