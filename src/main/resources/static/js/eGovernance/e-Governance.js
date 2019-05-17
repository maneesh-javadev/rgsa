$('document').ready(function() {
	$(".reset").bind("click", function() {
		$("input[type=text]").val('');
	});
	calculateTotalFundSpmu();
	calculateTotalFundDpmu();
	calculateGrandTotal();
});

function isNumber(evt) {
	evt = (evt) ? evt : window.event;
	var charCode = (evt.which) ? evt.which : evt.keyCode;
	if (charCode > 31 && (charCode < 48 || charCode > 57)) {
		return false;
	}
	return true;
};

function addRow() {
	var tds = '<tr>';
	tds += $("#newRowHtml").html();
	tds += '</tr>';
	$("#tbodyId").append(tds);

};

function removeRow() {
	{
		if ($('#tableId tr').length > 2) {
			$('#tableId tr:last').remove();
		}
	}
};

function show(val) {

	if (val == 1) {
		$("#eSPMUid").css("display", "block")
		$("#eDPMUid").css("display", "none")
		$("#simple").css("display", "none")
	}
	if (val == 2) {
		$("#eDPMUid").css("display", "block")
		$("#eSPMUid").css("display", "none")
		$("#simple").css("display", "none")
	}
};

function freezeAndUnfreeze(obj) {
	document.getElementById("dbFileName").value = obj;
	document.egovernance.method = "post";
	document.egovernance.action = "freezAndUnfreez.html?<csrf:token uri='freezAndUnfreez.html'/>";
	document.egovernance.submit();
};

function calculateProposedFund(obj) {
	var total_fund = 0;
	var month = document.getElementById("monthId_" + obj).value;
	var noOfPost = document.getElementById("noOfPostId_" + obj).value;
	var unitCost = document.getElementById("unitCostId_" + obj).value;
	var fund = document.getElementById("fundId_" + obj).value;
	document.getElementById("fundId_" + obj).value = noOfPost * month
			* unitCost;
	calculateTotalFundDpmu();
	calculateTotalFundSpmu();
};

function calculateTotalFundSpmu() {
	var count = $("#countSpmuId").val();
	var total_spmu_fund=0;
	for (var i = 0; i < count; i++) {
		if($("#fundId_" + i).val() != null && $("#fundId_" + i).val() != ""){
			total_spmu_fund += +$("#fundId_" + i).val();
		}
	}
	$("#total_fund_spmu").val(+total_spmu_fund); 
	calculateGrandTotal();
};

function calculateTotalFundDpmu() {
	var count = $("#countDpmuId").val();
	var total_dpmu_fund=0;
	for (var i = 0; i < count; i++) {
		if($("#fundId_"+(i + +$("#countSpmuId").val())).val() != null && $("#fundId_"+(i + +$("#countSpmuId").val())).val() != ""){
			total_dpmu_fund += +$("#fundId_"+(i + +$("#countSpmuId").val())).val();
		}
	}
	$("#total_fund_dpmu").val(total_dpmu_fund); 
	calculateGrandTotal();
};

function validateCielingValue(obj) {
	var total_spmu_unit_cost = 0;
	var total_dpmu_unit_cost = 0;
	for (var i = 0; i < +$("#countSpmuId").val(); i++) {
		if(+$("#unitCostId_"+i).val() != "" && $("#unitCostId_"+i).val() != null){
			total_spmu_unit_cost += +document.getElementById("unitCostId_" + i).value;
		}
	}
	for (var i = 0; i < +$("#countDpmuId").val(); i++) {
		if(+$("#unitCostId_"+(i + +$("#countSpmuId").val())).val() != "" && $("#unitCostId_"+(i + +$("#countSpmuId").val())).val() != null){
			total_dpmu_unit_cost += +document.getElementById("unitCostId_" + (i + +$("#countSpmuId").val())).value;
		}
	}
	
	if (total_spmu_unit_cost > 50000) {
		alert("Total unit cost for SPMU should be less than 50,000");
		document.getElementById("unitCostId_" + obj).value = 0;
		document.getElementById("fundId_" + obj).value = 0;
	}
	if (total_dpmu_unit_cost > 35000 * $('#districtSupportedId').val()) {
		alert("Total unit cost for DPMU per district should be less than 35,000");
		document.getElementById("unitCostId_" + obj).value = 0;
		document.getElementById("fundId_" + obj).value = 0;
	}
	calculateTotalFundDpmu();
	calculateTotalFundSpmu();
};

function validateMonth(obj) {
	var month = document.getElementById("monthId_" + obj).value;
	if (month != '' && (+month < 1 || +month > 12)) {
		alert("Month should be less than 12 and greater than 0!");
		document.getElementById("monthId_" + obj).value = '';
		document.getElementById("fundId_" + obj).value = 0;
	}
	calculateTotalFundDpmu();
	calculateTotalFundSpmu();
};

function calculateGrandTotal() {
	var grand_total = 0;
	if($('#additionalRequirementSpmuId').val() != '' && $('#total_fund_spmu').val() !=""){
		if($('#additionalRequirementSpmuId').val() > 0.25 * $('#total_fund_spmu').val()){
			alert("SPMU additional Requirement should be less than or equal to 25% of SPMU total Fund :" +  0.25 * $('#total_fund_spmu').val());
			$('#additionalRequirementSpmuId').val('');
			$('#grandTotalId').val('');
		}else{
			$('#grandTotalId').val(+$('#additionalRequirementDpmuId').val() + +$("#total_fund_dpmu").val() + +$('#additionalRequirementSpmuId').val() + +$("#total_fund_spmu").val());
		}
	}
	
	if($('#additionalRequirementDpmuId').val() != '' && $('#total_fund_dpmu').val() !=""){
		if($('#additionalRequirementDpmuId').val() > 0.25 * $('#total_fund_dpmu').val()){
			alert("DPMU additional Requirement should be less than or equal to 25% of DPMU total Fund :" + +  0.25 * $('#total_fund_dpmu').val());
			$('#additionalRequirementDpmuId').val('');
			$('#grandTotalId').val('');
		}else{							
			$('#grandTotalId').val(+$('#additionalRequirementDpmuId').val() + +$("#total_fund_dpmu").val() + +$('#additionalRequirementSpmuId').val() + +$("#total_fund_spmu").val());
		}
	}
};

function validateDistricts(){
	var total_dpmu_unit_cost=0;
	for (var i = 0; i < +$("#countDpmuId").val(); i++) {
		if(+$("#unitCostId_"+(i + +$("#countSpmuId").val())).val() != "" && $("#unitCostId_"+(i + +$("#countSpmuId").val())).val() != null){
			total_dpmu_unit_cost += +document.getElementById("unitCostId_" + (i + +$("#countSpmuId").val())).value;
		}
	}
	
	if(+$('#districtSupportedId').val() > +$('#districtsInState').val()){
		alert('District supported should be less than or equal to total districts in state : ' + $('#districtsInState').val());
		$('#districtSupportedId').val('');
		$('#districtSupportedId').focus();
	}
	
	if($('#districtSupportedId').val() != ''){
		if(total_dpmu_unit_cost > 35000*$('#districtSupportedId').val()){
			alert('Total unit cost for DPMU per district should be less than 35,000.Either change number of district or unit cost.');
			$('#districtSupportedId').val('');
		}
	}
}	

function validationOnSubmit(){
	
	if($('#districtSupportedId').val() == "" && $('#total_fund_dpmu').val() != ''){
		alert('No. of districts supported For DPMU should not be ')
		return false;
	}
}