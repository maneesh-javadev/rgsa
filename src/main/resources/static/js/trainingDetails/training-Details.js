var delTrainingIdArr=[];
$(document).ready(function() {
	 var myBoolean ="false";
	/*calTotalFundAndGrandTotal();
	 alert(${sessionScope['scopedTarget.userPreference'].userType} == 'M');*/
	 if($('#dataUserType').val() == 'S' && (userTypeSession == 'C' || userTypeSession == 'M')){
		 var myBoolean ="false";
		 $("#frzButtn").prop('disabled', true);
	 }else{
		 var myBoolean = document.getElementById("isFreeze").value;
	 }
	
	if(myBoolean == "true"){
		 $("#addTrainingLink").prop('disabled',
				 true);
		 $("#saveButtn").prop('disabled', true);
		 $("#frzButtn").hide();
		 $("#unFrzButtn").show();
		 $("#clearButtn").prop('disabled', true);
		 $("#addTrainingLink").prop('disabled', true);
		 $("#additioinalRequirements").prop('disabled', true);
		 $(".active123").prop('disabled', true);
		 $('input[type=checkbox]').attr('disabled',true);
	 }
	if(myBoolean == "false"){
		 $("#addTrainingLink").prop('disabled', false);
		 $("#saveButtn").prop('disabled', false);
		 $("#frzButtn").show();
		 $("#unFrzButtn").hide();
		 $("#clearButtn").prop('disabled', false);
		 $("#addTrainingLink").prop('disabled', false);
		 $("#additioinalRequirements").prop('disabled', false);
		 $(".active123").prop('disabled', false);
		 $('input[type=checkbox]').attr('disabled',false);
	 }
	
	 if($('#userTypeId').val() == 'M'){
		$('#trainingActivityTblId , #fundsName').each(function () {
			$('#trainingActivityTblId ,#fundsName').prop('readonly',false);
			});
	}
	 if($('#userTypeId').val() == 'C'){
			$('#trainingActivityTblId , #fundsName').each(function () {
				$('#trainingActivityTblId ,#fundsName').prop('readonly',false);
				});
		}
	
	
	$('#trainingActivityTblId').on('input[type="text"]',$('#fundsName'),function (){
		var subTotal = 0;
			$('#trainingActivityTblId,#fundsName').each(function(){
				var text_box_value = $(this).val();
				if($.isNumeric(text_box_value)){
					subTotal += parseFloat(text_box_value);
				}
			});
			$("#subTotal").val(subTotal);
			 $("#grandTotal").val(parseFloat($("#additioinalRequirements").val()) + parseFloat((subTotal)));
	}); 
	
 $("#additioinalRequirements").on('input',$("#additioinalRequirements"), function () {     
	var subTotal = $("#subTotal").val();
	 var check = (25*subTotal)/100;
	 if($("#additioinalRequirements").val() > check){
		 alert("Additional Requirement Should Be Less Than 25% of Total Fund");
		 $("#additioinalRequirements").val(0);
		 $("#grandTotal").val(subTotal);
	 }
	 else{
		 $("#grandTotal").val(parseFloat($("#additioinalRequirements").val()) + parseFloat((subTotal)));
	 }
 });

	}); 
 
 function isNumber(evt) {
	    evt = (evt) ? evt : window.event;
	    var charCode = (evt.which) ? evt.which : evt.keyCode;
	    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
	        return false;
	    }
	    return true;
	}
	
function toDelete(idToDelete){
	
	 if(!delTrainingIdArr.includes(idToDelete)){
		 delTrainingIdArr.push(idToDelete);
		 $("#delete"+idToDelete).addClass('glyphicon-repeat');
		 $("#delete"+idToDelete).removeClass('glyphicon-trash');
		 $("#modifyButtn"+idToDelete).addClass('not-active');
	  }else{
		  var index = delTrainingIdArr.indexOf(idToDelete);
		 	if (index > -1) {
		 		delTrainingIdArr.splice(index, 1);
		   }
		 	 $("#delete"+idToDelete).removeClass('glyphicon-repeat');
			 $("#delete"+idToDelete).addClass('glyphicon-trash');
			 $("#modifyButtn"+idToDelete).removeClass('not-active');
	  }
	 
	
	/*document.getElementById("idToEdit").value = idToDelete;
	document.cpbaddtraining.method = "post";
	document.cpbaddtraining.action = "deleteTrainingActivity.html?<csrf:token uri='deleteTrainingActivity.html'/>";
	document.cpbaddtraining.submit();*/
}
function toFreeze(){
	 $(".sbjctClass").prop('disabled', false);
	 $(".trgtClass").prop('disabled', false);
	document.cpbaddtraining.method = "post";
	document.cpbaddtraining.action = "frzUnfrzTrainingActivity.html?<csrf:token uri='frzUnfrzTrainingActivity.html'/>";
	document.cpbaddtraining.submit();
}
function toModify(idToModify){
	document.getElementById("idToEdit").value = idToModify;
	document.cpbaddtraining.method = "post";
	document.cpbaddtraining.action = "modifyTrainingActivity.html?<csrf:token uri='modifyTrainingActivity.html'/>";
	document.cpbaddtraining.submit();
}

function toValidate() {
	if(delTrainingIdArr.length>0){
		document.getElementById("idToDelete").value = delTrainingIdArr.toString();
	}
	 $(".sbjctClass").prop('disabled', false);
	 $(".trgtClass").prop('disabled', false);
}

function calTotalFundAndGrandTotal(){
		var rowCountState = $('#tbodyState tr').length;
		var total_fund = 0;
		for (var i = 0; i < rowCountState; i++) {
			total_fund += +$('#fundsName_'+i).val();
		}
		$('#subTotal').val(total_fund);
		$('#grandTotal').val(total_fund + +$('#additioinalRequirements').val());
}



function calculate(obj)
{
	
	if($('#venueId_'+obj).val() == '1'){
		var check = $('#noOfDays_'+obj).val() * 1900;
		var calc = 	$('#noOfDays_'+obj).val()* $('#unitCost_'+obj).val();
		if(calc <= check){
    $('#funds_'+obj).val($('#noOfParticipants_'+obj).val() * calc);
	}else {
		alert("Upper ceiling  limit  Rs. 1900 per participant per day");
		$('#unitCost_'+obj).val(0);
		 $('#noOfDays').val(0); 
		$('#funds_'+obj).val(0);
	}
		
		}if($('#venueId_'+obj).val() == '2'){
			var check = $('#noOfDays_'+obj).val() * 1100;
			var calc = 	$('#noOfDays_'+obj).val()* $('#unitCost_'+obj).val();
			if(calc <= check){
	    $('#funds_'+obj).val($('#noOfParticipants_'+obj).val() * calc);
		}else {
			alert("Upper ceiling  limit  Rs. 1100 per participant per day");
			$('#unitCost_'+obj).val(0);
			 $('#noOfDays').val(0); 
			$('#funds_'+obj).val(0);
		}
			
		}
				    if($('#venueId_'+obj).val() == '3'){
				    	var check = $('#noOfDays_'+obj).val() * 800;
						var calc = 	$('#noOfDays_'+obj).val()* $('#unitCost_'+obj).val();
						if(calc <= check){
				    $('#funds_'+obj).val($('#noOfParticipants_'+obj).val() * calc);
					}else {
						alert("Upper ceiling  limit  Rs. 800 per participant per day");
						$('#unitCost_'+obj).val(0);
						 $('#noOfDays').val(0); 
						$('#funds_'+obj).val(0);
					}
				}
				    calTotalFundAndGrandTotal()
}
function calTotalFundAndGrandTotal(){
	var rowCountState = $('#tbodyState tr').length;
	var total_fund = 0;
	for (var i = 0; i < rowCountState; i++) {
		total_fund += +$('#funds_'+i).val();
	}
	$('#subTotal').val(total_fund);
	if (document.getElementById("additioinalRequirements").value > 0.25 * document
			.getElementById("subTotal").value) {
		alert("Additional Requirement should be less than or equal to 25% of Total Fund");
		document.getElementById("additioinalRequirements").value = '';
		document.getElementById("grandTotal").value = '';
	}
	else {
	$('#grandTotal').val(total_fund + +$('#additioinalRequirements').val());
}
}
