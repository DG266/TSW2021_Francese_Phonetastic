
function validateCardNumber(cardNumber) {
	cardNumberRegexp = /\b\d{4}[ -]?\d{4}[ -]?\d{4}[ -]?\d{4}\b/;
	if(cardNumber.val().match(cardNumberRegexp)) {
		return true;
	}
	else {
		cardNumber.focus();
		return false;
	}
}

function validateMonth(month) {
	var monthRegexp = "^(0?[1-9]|1[012])$";
	if(month.val().match(monthRegexp)) {
		return true;
	}
	else {
		month.focus();
		return false;
	}
}

function validateYear(year) {
	var yearRegexp = /^\d{2}$/;
	if(year.val().match(yearRegexp)) {
		if(year.val() > 21) {   // male male male 
			return true;
		}  
	}
	year.focus();
	return false;
}

function validateCvv(cvv) {
	var cvvRegexp = /^[0-9]{3,4}$/;;
	if(cvv.val().match(cvvRegexp)) {
		return true;
	}
	else {
		cvv.focus();
		return false;
	}
}

$(document).ready(function(){
	
	$(".paymentMethodForm").submit(function(event){
		
		$("#paymentMethodError").empty();
		
		var cardNumberValid = validateCardNumber($(".paymentMethodForm input[name=card-number]"));
		var monthValid = validateMonth($(".paymentMethodForm input[name=exp-month]"));
		var yearValid = validateYear($(".paymentMethodForm input[name=exp-year]"));
		var cvvValid = validateCvv($(".paymentMethodForm input[name=cvv]"));
		
		if(!cardNumberValid || !monthValid || !yearValid || !cvvValid) {
			var error = "";
			
			if(!cardNumberValid){
				error = error + "Numero carta";
			}
			
			if(!monthValid){
				error = error + " Mese";
			}
			
			if(!yearValid){
				error = error + " Anno";
			}
			
			if(!cvvValid){
				error = error + " CVV";
			}
			
			$("#paymentMethodError").append("<h2>Ricontrolla i dati relativi al metodo di pagamento inseriti. (" + error +")<h2>");
			return false;
		}
	});
	
});