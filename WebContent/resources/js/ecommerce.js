// N.B.: Ho lasciato i commenti in italiano per chiarezza

// NECESSARIO PER IL FUNZIONAMENTO DEL MENU MOBILE
document.querySelector('#open').addEventListener('click', () => document.querySelector('#header-wrapper').classList.add('active'));

document.querySelector('#close').addEventListener('click', () => document.querySelector('#header-wrapper').classList.remove('active'));




$(document).ready(function(){
	
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
});






