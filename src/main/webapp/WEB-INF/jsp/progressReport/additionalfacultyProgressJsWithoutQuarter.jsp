
<script>
var quater_id = '${QTR_ID}';
var fund_allocted_sprc = '${FUND_ALLOCATED_SPRC}';
var fund_allocted_dprc = '${FUND_ALLOCATED_DPRC}';
var fund_used_other_qtr_sprc = '${FUND_USED_IN_OTHER_QTR_SPRC}';
var fund_used_other_qtr_dprc = '${FUND_USED_IN_OTHER_QTR_DPRC}';
var pre_install_fund_sprc = '${PRE_INSTALLMENT_FUND_SPRC}';
var pre_install_fund_dprc = '${PRE_INSTALLMENT_FUND_DPRC}';
var total_fund_used_qtr_1_2_sprc = '${TOTAL_SPRC_FUND_USED_IN_QTR_1_AND_2}';
var total_fund_used_qtr_1_2_dprc = '${TOTAL_DPRC_FUND_USED_IN_QTR_1_AND_2}';
var total_add_req_sprc_filled = '${TOTAL_ADD_REQ_SPRC}';
var total_add_req_dprc_filled = '${TOTAL_ADD_REQ_DPRC}';
var domain_list = '${LIST_OF_DOMAINS}';
var qtr_1_2_filled='${QTR_ONE_TWO_FILLED}';
var balancesprc='${subcomponentwiseQuaterBalanceList[0].balanceAmount}';
var balancedprc='${subcomponentwiseQuaterBalanceList[1].balanceAmount}';
$(document).ready(function() {
	if(qtr_1_2_filled == "false"){
		alert('Please fill the quater 1 and 2 progress report first.');
	}
	$('#quaterDropDownId').val(quater_id);
	//showTablediv();
	calTotalExpenditure();
});

function saveAndGetDataQtrRprt(msg){
	var length=$("#additional_faculty_count_length").val();
	var flag=true;
	for(var i=0;i<length;i++)
		{
		if($("#noOfUnitCompleted_"+i).val()!='' && $("#noOfUnitCompleted_"+i).val()!=null && $("#noOfUnitCompleted_"+i).val()!='undefined')
			{
			if($("#expenditureIncurred_"+i).val()=='' || $("#expenditureIncurred_"+i).val()==null || $("#expenditureIncurred_"+i).val()==0)
			{
				alert("Row No. "+(i+1)+" fill expenditure");
				flag=false;
			}
		}
		}
	if(flag){
		if(validate_data()){
			$('#qtrIdJsp3').val($('#quaterDropDownId').val());
		 	$('#origin').val(msg);
		 	disabled_button();
		 	document.additionalFacultyProgress.method = "post";
			document.additionalFacultyProgress.action = "additionalfacultyProgress.html?<csrf:token uri='additionalfacultyProgress.html'/>";
			document.additionalFacultyProgress.submit();
		}
	}
	else
	{
	alert("Please fill expenditure");
	}
	 	
}

function disabled_button(){
	$('#savebtn').prop('disabled', true);
	$('#freezebtn').prop('disabled', true);
	$('#unfreezebtn').prop('disabled', true);
}

$( document ).ready(function() {
	$(".validate").keypress(function (e) {
	    //if the letter is not digit then display error and don't type anything
	    if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
	       //display error message
	       $("#errmsg").html("Digits Only").show().fadeOut("slow");
	              return false;
	   }
	  });
});

function showTablediv(){
	if($('#quaterDropDownId').val() > 0){
		$('#mainDivId').show();
	}else{
		$('#mainDivId').hide();
	}
}

function validateFundByAllocatedFund(index){
	var noOfRows=$("#tbodyId tr").length;
	var fund_allocted_sprc_local = +fund_allocted_sprc;
	var fund_allocted_dprc_local = +fund_allocted_dprc;
	var total_fund_filled_sprc=0;
	var total_fund_filled_dprc=0;
	
	if(fund_used_other_qtr_sprc != '' && fund_used_other_qtr_sprc != null){
		fund_allocted_sprc_local -= +fund_used_other_qtr_sprc;
	}
	
	if(fund_used_other_qtr_dprc != '' && fund_used_other_qtr_dprc != null){
		fund_allocted_dprc_local -= +fund_used_other_qtr_dprc;
	}
	
	if(pre_install_fund_sprc != null && total_fund_used_qtr_1_2_sprc != null){
		fund_allocted_sprc_local += +(pre_install_fund_sprc - total_fund_used_qtr_1_2_sprc);
	}
	
	if(pre_install_fund_dprc != null && total_fund_used_qtr_1_2_dprc != null){
		fund_allocted_dprc_local += +(pre_install_fund_dprc - total_fund_used_qtr_1_2_dprc);
	}
	
	for(var i = 0; i < noOfRows;i++){
		if($('#expenditureIncurred_'+i).val() != null && $('#expenditureIncurred_'+i).val() != ''){
			if(i< 3){
				total_fund_filled_sprc += +$('#expenditureIncurred_'+i).val();
			}else{
				total_fund_filled_dprc += +$('#expenditureIncurred_'+i).val();
			}
		}
	}
	if(total_fund_filled_sprc > fund_allocted_sprc_local){
		alert('Total expenditure should not exceed total remaining for this component which is Rs. '+ (fund_allocted_sprc_local - (total_fund_filled_sprc - $('#expenditureIncurred_'+index).val())));
		$('#expenditureIncurred_'+index).val('');
		$('#expenditureIncurred_'+index).focus();
	}
	if(total_fund_filled_dprc > fund_allocted_dprc_local){
		alert('Total expenditure should not exceed total remaining for this component which is Rs. '+ (fund_allocted_dprc_local - (total_fund_filled_dprc - $('#expenditureIncurred_'+index).val())));
		$('#expenditureIncurred_'+index).val('');
		$('#expenditureIncurred_'+index).focus();
	}
}

function isNoOfUnitAndExpInurredFilled(index){
	if(($('#noOfUnitCompleted_'+index).val() == null || $('#noOfUnitCompleted_'+index).val() =='') && (index != 2 && index != 5)){
		alert('Expenditure incurred cannot be filled if number of unit filled is zero or blank.');
		$('#expenditureIncurred_'+index).val('');
		$('#noOfUnitCompleted_'+index).focus();
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

function validateNoOfUnits(index){
	var no_of_unit_cec= +$('#noOfUnitCecId_'+index).text();	
	/* var total_no_of_unit_remaining = no_of_unit_cec - $('#totalNoOfUnit_'+index).val(); */
	if($('#noOfUnitCompleted_'+index).val() > no_of_unit_cec){
		alert('total number of units should not exceed '+no_of_unit_cec);
		$('#noOfUnitCompleted_'+index).val('');
		$('#noOfUnitCompleted_'+index).focus();
	}
}

function validateAddReq(msg){
	var main_add_req_sprc = $('#additionalReqSprcStateId').text();
	var main_add_req_dprc = $('#additionalReqDprcStateId').text();
	
	if(msg == 'sprc'){
		if($('#additionalReqSprcId').val() > (main_add_req_sprc - total_add_req_sprc_filled)){
			alert('Additional requirement for SPRC should not exceed : ' + (main_add_req_sprc - total_add_req_sprc_filled));
			$('#additionalReqSprcId').val('');
			$('#additionalReqSprcId').focus();
			
		}		
	}else{
		if($('#additionalReqDprcId').val() > (main_add_req_dprc - total_add_req_dprc_filled)){
			alert('Additional requirement for DPRC should not exceed : ' + (main_add_req_dprc - total_add_req_dprc_filled));
			$('#additionalReqDprcId').val('');
			$('#additionalReqDprcId').focus();		
		}
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
	$('#totalExpenditureId').val(total_expenditure + +$('#additionalReqSprcId').val() + +$('#additionalReqDprcId').val());
}

function domainValidation(index){
	var rowCountSprc=$('#sprcModalTbody tr').length;
	var rowCountDprc=$('#dprcModalTbody tr').length * domain_list.split(',').length / 2;
	var noOfDomainSprc=0;
	var noOfDomainDprc=0;
	for(var i=0;i<rowCountSprc;i++){
		noOfDomainSprc += Number($('#noOfExpertsSprc_'+i).val()) ;
	}
	for(var i=0;i<rowCountDprc;i++){
		noOfDomainDprc += Number($('#noOfExpertsDprc_'+(i)).val());
	}
	
	if(!isNaN(index)){
		if($('#noOfUnitCompleted_0').val() < noOfDomainSprc){
			alert('Total domains experts should be equal to or less than '+ $('#noOfUnitCompleted_0').val());
			$('#noOfExpertsSprc_'+index).val('');
		}else if($('#noOfUnitCompleted_3').val() < noOfDomainDprc){
			alert('Total domains experts should be equal to or less than '+ $('#noOfUnitCompleted_3').val());
			$('#noOfExpertsDprc_'+index).val('');
		}
		}else{ if(index == 'noOfUnitCompleted_0' && noOfDomainSprc != 0){
				var result= confirm("If you change Number of units you have to fill domain details.");
				if(result){
				if($('#noOfUnitCompleted_0').val() < noOfDomainSprc){
					alert('No of units in SPRC should not exceed the sum of domain detail :'+ noOfDomainSprc + ' please fill the domain details again.');
					emptyDomainDetails('sprc',rowCountSprc);
				}
				}else{
					if($('#noOfUnitCompleted_0').val() < noOfDomainSprc){
						alert('No of units in SPRC should not exceed the sum of domain detail '+ noOfDomainSprc );
						$('#noOfUnitCompleted_0').val('');
					}
				}
		}else if(index == 'noOfUnitCompleted_3' && noOfDomainDprc != 0){
			var result= confirm("If you change Number of units you have to fill domain details.");
			if(result){
			if($('#noOfUnitCompleted_3').val() < noOfDomainDprc){
				alert('No of units in DPRC should not exceed the sum of domain detail :'+ noOfDomainDprc + ' please fill the domain details again.');
				emptyDomainDetails('dprc',rowCountDprc);
			}
			}else{
				if($('#noOfUnitCompleted_3').val() < noOfDomainSprc){
					alert('No of units in DPRC should not exceed the sum of domain detail '+ noOfDomainDprc );
					$('#noOfUnitCompleted_3').val('');
				}
			}
		  }
		}
}

/* this function used in domainValidation function */
function emptyDomainDetails(level,count){
	if(level == 'sprc'){
		for(var i=0;i<count;i++){
			$('#noOfExpertsSprc_'+i).val('');
		}
	}else{
		for(var i=0;i<count;i++){
			$('#noOfExpertsDprc_'+i).val('');
		}
	}
}

function FreezeAndUnfreeze(msg){
	if(msg=="freeze"){
		if(validate_data()){
			disabled_button();
			var componentId=14;
			var qprActivityId=$('#qprActivityId').val();
			var quaterId = $('#quaterDropDownId').val();
			var length=$("#additional_faculty_count_length").val();
			var flag=true;
			for(var i=0;i<length;i++)
				{
				if($("#noOfUnitCompleted_"+i).val()!='' && $("#noOfUnitCompleted_"+i).val()!=null && $("#noOfUnitCompleted_"+i).val()!='undefined')
					{
					if($("#expenditureIncurred_"+i).val()=='' || $("#expenditureIncurred_"+i).val()==null || $("#expenditureIncurred_"+i).val()==0)
					{
						alert("Row No. "+(i+1)+" fill expenditure");
						flag=false;
					}
				}
				}
			if(flag){
			document.additionalFacultyProgress.method = "post";
			document.additionalFacultyProgress.action = "freezeAndUnfreezeReport.html?<csrf:token uri='freezeAndUnfreezeReport.html'/>&componentId="+componentId+"&qprActivityId="+qprActivityId+"&quaterId="+quaterId+"&msg="+msg;
			document.additionalFacultyProgress.submit();
			}
			else
			{
			alert("Please fill expenditure");
			}
		}
	}else{
		var componentId=14;
		var qprActivityId=$('#qprActivityId').val();
		var quaterId = $('#quaterDropDownId').val();
		disabled_button();
		document.additionalFacultyProgress.method = "post";
		document.additionalFacultyProgress.action = "freezeAndUnfreezeReport.html?<csrf:token uri='freezeAndUnfreezeReport.html'/>&componentId="+componentId+"&qprActivityId="+qprActivityId+"&quaterId="+quaterId+"&msg="+msg;
		document.additionalFacultyProgress.submit();
	}
	
	
}

function validate_expenditureIncurred(balancesprc,balancedprc,sanAmount,obj,objId){
	if(obj==null){
		temp=("#"+objId+"_0");
		if(temp.length>0){
			obj=temp;
		}
	}	

	sanAmount=sanAmount!=null && sanAmount!=undefined && sanAmount!="" ?parseInt(sanAmount):0;
	
	if(obj!=null){
		id=$( obj ).attr('id');
		idn=id.split("_")[0];
		var i=0;
		var totsprc=0;
		var totdprc=0;
		var tot=0;
		var balance=0;
		var l=$('#'+idn+'_'+i).length;

			while(l>0){
			temp=$('#'+idn+'_'+i).val(); 
			vali=temp!=null && temp!=undefined && temp!="" ?parseInt(temp):0;
			if(i<3){
				totsprc=totsprc+vali;
			}else if(i<6){
				totdprc=totdprc+vali;
			}
			
			l=$('#'+idn+'_'+i).length;
			i++;
			}
			tot=objId<3?totsprc:totdprc;
			balance=objId<3?balancesprc:balancedprc;
			temp=$( obj ).val();
			vali=temp!=null && temp!=undefined && temp!="" ?parseInt(temp):0;
			
			if(vali>sanAmount){
				$("#error_"+id).text("expenditure Incurred must be less then Fund Sanctioned");
				$("#error_"+id).addClass('errormsg show');
				$( obj ).val('');
				$(obj).focus();	  
			}else	
			if(tot>balance){
				$("#error_"+id).text("expenditure Incurred must be less then balance amount");
				$("#error_"+id).addClass('errormsg show');
				$( obj ).val('');
				$(obj).focus();	  
			}else{
				$("#error_"+id).removeClass("errormsg show");
				$("#error_"+id).text("");
				
			}
	}
	calculcate_total();	
	}
	
	
function validate_data(obj){
	var flag=true;
	
	if(obj!=undefined || obj==null){
		temp=("#expenditureIncurred_0");
		if(temp.length>0){
			obj=temp;
		}
	}	

	if(obj!=null){
		id=$( obj ).attr('id');
		idn=id.split("_")[0];
		var i=0;
		var totsprc=0;
		var totdprc=0;
		var tot=0;
		var balance=0;
		var l=$('#'+idn+'_'+i).length;
	   
		
		  
			while(l>0){
			temp=$('#'+idn+'_'+i).val(); 
			vali=temp!=null && temp!=undefined && temp!="" ?parseInt(temp):0;
			if(i!=2)
			{
			if(i!=5)
			  {
			if(vali>0){
				temp=$('#noOfUnitCompleted_'+i).val(); 
				valu=temp!=null && temp!=undefined && temp!="" ?parseInt(temp):0;
				if(valu<=0){
					$("#error_noOfUnitCompleted_"+i).text("Please fill No. of Unit");
					$("#error_noOfUnitCompleted_"+i).addClass('errormsg show');
					 flag=false;
				}
			}
			  }
			}
			if(i<3){
				totsprc=totsprc+vali;
			}else if(i<6){
				totdprc=totdprc+vali;
			}
			
			l=$('#'+idn+'_'+i).length;
			i++;
			
			   }
			if(totsprc>balancesprc){
				flag=false;
			}
			if(totdprc>balancedprc){
				flag=false;
			}
			
	}
	return flag;
	}
	
function calculcate_total(){
		tot=0;
		var i=0;
		var l=$('#expenditureIncurred_'+i).length;

		while(l>0){
			temp=$('#expenditureIncurred_'+i).val(); 
			vali=temp!=null && temp!=undefined && temp!="" ?parseInt(temp):0;
			
			tot=tot+vali;
			l=$('#expenditureIncurred_'+i).length;
			i++;
			}
		subtotal=tot;
		
	
	
	temp= $("#additionalReqSprcId").val();
	addReqSPRC=0;
	if(temp!=null && temp!=undefined && temp!=""){
		addReqSPRC=parseInt(temp);	
	}
	addReqDPRC=0;
	temp= $("#additionalReqDprcId").val();
	if(temp!=null && temp!=undefined && temp!=""){
		addReqDPRC=parseInt(temp);	
	}
	total=subtotal+addReqSPRC+addReqDPRC;
	$("#totalExpenditureId").val(total);
	
	
	
	
}

</script>
                       