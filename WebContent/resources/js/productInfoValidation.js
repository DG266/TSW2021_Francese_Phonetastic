// VALIDAZIONE FORM CHE RIGUARDANO AGGIUNTA/AGGIORNAMENTO INFO PRODOTTI

function validatePricesAndPercentages(value) {
	if(value > 0){
		
		return true;
	}
	else{
		return false;
	}
}

$(document).ready(function(){
	
	$(".productForm").submit(function(event){
		
		var priceValid = validatePricesAndPercentages($(".productForm input[name=price]").val());
		var discountValid = validatePricesAndPercentages($(".productForm input[name=discount]").val());
		var ivaValid = validatePricesAndPercentages($(".productForm input[name=iva]").val());
		
		if(!priceValid || !discountValid || !ivaValid){
			$(".info").html("<h2>Ricontrolla i dati inseriti.<h2>");
			
			if(!priceValid){
				//$("input[name='price']").css({"border" : "solid red"});
				$("input[name=price]").focus();
			}
			
			if(!discountValid){
				//$("input[name='discount']").css({"border" : "solid red"});
				$("input[name=discount]").focus();
			}
			
			if(!ivaValid){
				//$("input[name='iva']").css({"border" : "solid red"});
				$("input[name=iva]").focus();
			}
			
			return false;
		}
	});
});