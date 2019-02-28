 $(document).ready(function() {
	
	var myBoolean = document.getElementById("isFreeze").value;
	if(myBoolean == "true"){
		 $("#addTrainingLink").prop('disabled',
				 true);
		 $("#saveButtn").prop('disabled', true);
		 $("#frzButtn").hide();
		 $("#unFrzButtn").show();
		 $("#clearButtn").prop('disabled', true);
		 $("#addTrainingLink").prop('disabled', true);
		 $("#additioinalRequirements").prop('disabled', true);
	 }
	if(myBoolean == "false"){
		 $("#addTrainingLink").prop('disabled', false);
		 $("#saveButtn").prop('disabled', false);
		 $("#frzButtn").show();
		 $("#unFrzButtn").hide();
		 $("#clearButtn").prop('disabled', false);
		 $("#addTrainingLink").prop('disabled', false);
		 $("#additioinalRequirements").prop('disabled', false);
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
	
	
	$('#trainingActivityTblId').on('input',$('#fundsName'),function (){
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
	document.getElementById("idToEdit").value = idToDelete;
	document.cpbaddtraining.method = "post";
	document.cpbaddtraining.action = "deleteTrainingActivity.html?<csrf:token uri='deleteTrainingActivity.html'/>";
	document.cpbaddtraining.submit();
}
function toFreeze(){
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