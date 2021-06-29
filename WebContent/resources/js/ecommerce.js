// N.B.: Ho lasciato i commenti in italiano per chiarezza

document.querySelector('#open').addEventListener('click', () => document.querySelector('#header-wrapper').classList.add('active'));

document.querySelector('#close').addEventListener('click', () => document.querySelector('#header-wrapper').classList.remove('active'));

// CARRELLO CON AJAX
$(document).ready(function(){
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
		    error: function() { //on failure
                alert("Errore." + form.serialize());
            }
		});
		
	});	
});




