
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

$(document).ready(function() {
	if(qtr_1_2_filled == "false"){
		alert('Please fill the quater 1 and 2 progress report first.');
	}
	$('#quaterDropDownId').val(quater_id);
	showTablediv();
	calTotalExpenditure();
}); 

function compareFunds(indx){
	if(parseInt($('#expnditureId_'+indx).val()) > parseInt($('#fundsName_'+indx).val())){
		alert('Expenditure Incurred should be less than fund approved.');
		$('#expnditureId_'+indx).val('');
	}
} 

function saveAndGetDataQtrRprt(msg){
	disabled_button();
	  $('#showQqrtrId').val($('#quaterDropDownId').val()); 
	  $('#origin').val(msg);
	 	 document.qprAdminAndFinancialDataActivity.method = "post";
		document.qprAdminAndFinancialDataActivity.action = "adminDataFinQuaterlyGet.html?<csrf:token uri='adminDataFinQuaterlyGet.html'/>";
		document.qprAdminAndFinancialDataActivity.submit(); 
}

function disabled_button(){
	$('#saveButtn').prop('disabled', true);
	$('#freezebtn').prop('disabled', true);
	$('#unfreezebtn').prop('disabled', true);
}

function showTablediv(){
	if($('#quaterDropDownId').val() > 0){
		$('#mainDivId').show();
	}else{
		$('#mainDivId').hide();
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
	var noOfRows=$("#tbodyId tr").length-2;
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

function validateWithCorrespondingFund(index){
	var tota_fund_cec= +$('#fundCecId_'+index).text();	
	var total_corresponding_fund_remaining = tota_fund_cec - $('#totalExpenditureIncurred_'+index).val();
	if($('#expenditureIncurred_'+index).val() > total_corresponding_fund_remaining){
		alert('total expenditure should not exceed '+ total_corresponding_fund_remaining);
		$('#expenditureIncurred_'+index).val('');
		$('#expenditureIncurred_'+index).focus();
	}
}

function isNoOfUnitAndExpInurredFilled(index){
	if($('#noOfUnitCompleted_'+index).val() == 0 || $('#noOfUnitCompleted_'+index).val() == null || $('#noOfUnitCompleted_'+index).val() ==''){
		alert('Expenditure incurred cannot be filled if number of unit filled is zero or blank.');
		$('#expenditureIncurred_'+index).val('');
		$('#noOfUnitCompleted_'+index).focus();
	}
}

function validateAddReq(){
	if(+$('#additionalReqId').val() > +remaining_add_req){
		alert('Additional requirementshould not exceed : ' + remaining_add_req);
		$('#additionalReqId').val('');
		$('#additionalReqId').focus();
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
	disabled_button();
	var componentId=8;
	var qprActivityId=$('#qprActivityId').val();
	var quaterId = $('#quaterDropDownId').val();
	document.qprAdminAndFinancialDataActivity.method = "post";
	document.qprAdminAndFinancialDataActivity.action = "freezeAndUnfreezeReport.html?<csrf:token uri='freezeAndUnfreezeReport.html'/>&componentId="+componentId+"&qprActivityId="+qprActivityId+"&quaterId="+quaterId+"&msg="+msg;
	document.qprAdminAndFinancialDataActivity.submit();
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
				
			}
			calTotalExpenditure();
	}
		
	}
</script>
