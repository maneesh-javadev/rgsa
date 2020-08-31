<script>
var quater_id = '${QTR_ID}';
var remaining_add_req = '${REMAINING_ADD_REQ}';
var qtr_1_2_filled='${QTR_ONE_TWO_FILLED}';
var fund_allocated_by_state='${FUND_ALLOCATED_BY_STATE}';
var fund_used='${FUND_USED_IN_OTHER_QUATOR}';
if(quater_id > 2){
	var fund_allocated_in_pre_qtr = '${FUND_ALLOCATED_BY_STATE_PREVIOUS}';
	var fund_used_in_qtr_1_and_2 = '${TOTAL_FUND_USED_IN_QTR_1_AND_2}';
}
$('document').ready(function(){
	$('#quaterDropDownId').val(quater_id);
	showTablediv();
	calTotalExpenditure();
	if(qtr_1_2_filled == "false"){
		alert('Please fill the quater 1 and 2 progress report first.');
	}
	
	setTimeout(function(){ 
		
		if($("#disabledID").val()=="true"){ 
			 $(".disableClass").attr("disabled", "disabled"); 
			$("#trainingSubIdDiseable").prop("disabled", true);
			$("#sel").prop("disabled", true);
		}
	}, 1000);  
	
});


function showTablediv(){
	if($('#quaterDropDownId').val() > 0){
		$('#mainDivId').show();
	}else{
		$('#mainDivId').hide();
	}
}

function showImage(tableName,tableId){
	disabled_button();
	document.qpqCapacityBuilding.method = "post";
	document.qpqCapacityBuilding.action = "getQprCbActivityPdf.html?<csrf:token uri='getQprCbActivityPdf.html'/>&tableName="+tableName+"&tableId="+tableId;
	document.qpqCapacityBuilding.submit();
}

function disabled_button(){
	$('#savebtn').prop('disabled', true);
	$('#freezebtn').prop('disabled', true);
	$('#unfreezebtn').prop('disabled', true);
}

function getSelelctedQtrRprt(){
	$('#quaterTransient').val($('#quaterDropDownId').val());
	// document.qpqCapacityBuilding.action = "saveQprCapacityBuilding.html?<csrf:token uri='saveQprCapacityBuilding.html'/>";
	document.qpqCapacityBuilding.submit(); 
}

function isNoOfUnitAndExpInurredFilled(index){
	if(($('#noOfUnitCompleted_'+index).val() == 0 || $('#noOfUnitCompleted_'+index).val() == null || $('#noOfUnitCompleted_'+index).val() =='') && ($('#expenditureIncurred_'+index).val() != 0 && $('#expenditureIncurred_'+index).val() != '')){
		alert('Expenditure incurred cannot be filled if number of unit filled is zero or blank.');
		$('#expenditureIncurred_'+index).val('');
		$('#noOfUnitCompleted_'+index).focus();
	}
}

function validateNoOfUnits(index){
	var no_of_unit_cec= +$('#noOfUnitCecId_'+index).text();	
	/* var total_no_of_unit_remaining = no_of_unit_cec - $('#totalNoOfUnit_'+index).val(); */
	if($('#noOfUnitCompleted_'+index).val() > no_of_unit_cec){
		alert('total number of units should not exceed '+no_of_unit_cec);
		$('#noOfUnitCompleted_'+index).val('');
		$('#noOfUnitCompleted_'+index).focus();
	}
}

function validateFundByAllocatedFund(obj){
	var noOfRows=$("#tbodyId tr").length;
	var fund_allocated_by_state_local = +fund_allocated_by_state;
	var fund_used_local= +fund_used;
	var total=0;
	
	if(quater_id > 2){
		fund_allocated_by_state_local += +(fund_allocated_in_pre_qtr - fund_used_in_qtr_1_and_2);
	}
	if(fund_used !=0){
		fund_allocated_by_state_local -=  +fund_used_local;
	}
	for (var index = 0; index < noOfRows; index++) {
		total +=  +$('#expenditureIncurred_'+index).val();
	}
	if(total > fund_allocated_by_state_local){
		if(fund_used != 0){
			alert('Total expenditure should not exceed total remaining for this component which is Rs. '+ (fund_allocated_by_state_local - (total - $('#expenditureIncurred_'+obj).val())));
		}else{
			alert('Total expenditure should not exceed total fund allocted by state for this component which is Rs. '+ (fund_allocated_by_state_local - (total - $('#expenditureIncurred_'+obj).val())));
		}
		$('#expenditureIncurred_'+obj).val('');
	}
}

function validateAddReq(){
	if(+$('#additionalReqId').val() > +remaining_add_req){
		alert('Additional requirementshould not exceed : ' + remaining_add_req);
		$('#additionalReqId').val('');
		$('#additionalReqId').focus();
	}
			
}

function validateWithCorrespondingFund(index){
	var tota_fund_cec= +$('#fundCecId_'+index).text();	
	var total_corresponding_fund_remaining = tota_fund_cec - $('#totalExpenditureIncurred_'+index).val();
	if($('#expenditureIncurred_'+index).val() > total_corresponding_fund_remaining){
		alert('total expenditure should not exceed '+ total_corresponding_fund_remaining);
		$('#expenditureIncurred_'+index).val('');
		$('#expenditureIncurred_'+index).focus();
	}
}

function calTotalExpenditure(){
	var rowCount=$('#tbodyId tr').length -2;
	var total_expenditure=0;
	for( var i=0;i < rowCount; i++){
		if($('#expenditureIncurred_'+i).val() != null && $('#expenditureIncurred_'+i).val() != undefined){
			total_expenditure += +$('#expenditureIncurred_'+i).val();
		}
	}
	$('#totalExpenditureId').val(total_expenditure + +$('#additionalReqId').val());
}

function FreezeAndUnfreeze(msg){
	
	if(msg=="freeze"){
		var validateFlag=validate_data();
		if(validateFlag){
			disabled_button();
			var componentId=13;
			var qprActivityId=$('#qprActivityId').val();
			var quaterId = $('#quaterDropDownId').val();
			document.qpqCapacityBuilding.method = "post";
			document.qpqCapacityBuilding.action = "freezeAndUnfreezeReport.html?<csrf:token uri='freezeAndUnfreezeReport.html'/>&componentId="+componentId+"&qprActivityId="+qprActivityId+"&quaterId="+quaterId+"&msg="+msg;
			document.qpqCapacityBuilding.submit();
		}
		
	}else{
		disabled_button();
		var componentId=13;
		var qprActivityId=$('#qprActivityId').val();
		var quaterId = $('#quaterDropDownId').val();
		document.qpqCapacityBuilding.method = "post";
		document.qpqCapacityBuilding.action = "freezeAndUnfreezeReport.html?<csrf:token uri='freezeAndUnfreezeReport.html'/>&componentId="+componentId+"&qprActivityId="+qprActivityId+"&quaterId="+quaterId+"&msg="+msg;
		document.qpqCapacityBuilding.submit();
	}
	

}

function validate_expenditureIncurred(balance,obj,objId){
	if(obj==null){
	temp=("#"+objId+"_0");
	if(temp.length>0){
		obj=temp;
	}



	}	

	if(obj!=null){
		id=$( obj ).attr('id');
		idn=id.split("_")[0];
		var i=0;
		var tot=0;
		var l=$('#'+idn+'_'+i).length;

			while(l>0){
			temp=$('#'+idn+'_'+i).val(); 
			vali=temp!=null && temp!=undefined && temp!="" ?parseInt(temp):0;
			
			tot=tot+vali;
			l=$('#'+idn+'_'+i).length;
			i++;
			}

			if(tot>balance){
				$("#error_"+id).text("expenditure Incurred must be less then balance amount");
				$("#error_"+id).addClass('errormsg show');
				$( obj ).val('');
				$(obj).focus();	  
			}else{
				$("#error_"+id).removeClass("errormsg show");
				$("#error_"+id).text("");
				calculcate_total(tot,idn);
			}
	}
		
	}
	//--------------------------------------------------------------------------------
	
	function validate_data(){
	objId="expenditureIncurred";
	temp=("#"+objId+"_0");
	if(temp.length>0){
		obj=temp;
	}
	
	if(obj!=null){
		id=$( obj ).attr('id');
		idn=id.split("_")[0];
		var i=0;
		var tot=0;
		var l=$('#'+idn+'_'+i).length;

			while(l>0){
			temp=$('#'+idn+'_'+i).val(); 
			vali=temp!=null && temp!=undefined && temp!="" ?parseInt(temp):0;
			
			
			
			tot=tot+vali;
			l=$('#'+idn+'_'+i).length;
			i++;
			}
			
			if(tot>balAmount){
				$("#error_total").text("expenditure Incurred must be less then balance amount");
				$("#error_total").addClass('errormsg show');
				return false;
			}else{
				return true;
			}

			
	}
	
}
</script>