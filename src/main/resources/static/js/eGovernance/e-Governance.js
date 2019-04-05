$('document').ready(function() {
	$(".reset").bind("click", function() {
		$("input[type=text]").val('');
	});
	calculateTotalFund();
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
	calculateTotalFund();
};

function calculateTotalFund() {
	var count = $("#count").val();
	var grand_total = 0;
	for (var i = 0; i < count; i++) {
		grand_total += +document.getElementById("fundId_" + i).value;
	}
	var totalFund = document.getElementById("total_fund").value = grand_total;
	calculateGrandTotal();
};

function validateCielingValue(obj) {
	var total_spmu_unit_cost = 0;
	var total_dpmu_unit_cost = 0;
	for (var i = 0; i < ($('#tbodyId tr').length-3); i++) {
		total_fund += +document.getElementById("fundId_"+ i).value;
		if (document.getElementById("postId_" + i).value == 1) {
			total_spmu_unit_cost += +document.getElementById("unitCostId_" + i).value;
		} else {
			total_dpmu_unit_cost += +document.getElementById("unitCostId_" + i).value;
		}
	}
	if (total_spmu_unit_cost > 50000) {
		alert("Total unit cost for SPMU should be less than 50,000");
		document.getElementById("unitCostId_" + obj).value = 0;
		document.getElementById("fundId_" + obj).value = 0;
	}
	if (total_dpmu_unit_cost > 35000) {
		alert("Total unit cost for DPMU should be less than 35,000");
		document.getElementById("unitCostId_" + obj).value = 0;
		document.getElementById("fundId_" + obj).value = 0;
	}
	calculateTotalFund();
};

function validateMonth(obj) {
	var month = document.getElementById("monthId_" + obj).value;
	if (month != '' && (+month < 1 || +month > 12)) {
		alert("Month should be less than 12 and greater than 0!");
		document.getElementById("monthId_" + obj).value = '';
		document.getElementById("fundId_" + obj).value = 0;
	}
	calculateTotalFund();
};

function calculateGrandTotal() {
	var grand_total = 0;
	if($('#additionalRequirementId').val() != ''){
		if (document.getElementById("additionalRequirementId").value > 0.25 * document
				.getElementById("total_fund").value) {
			alert("Additional Requirement should be less than or equal to 25% of Total Fund");
			document.getElementById("additionalRequirementId").value = '';
			document.getElementById("grandTotalId").value = '';
		} else {
			document.getElementById("grandTotalId").value = +document
					.getElementById("additionalRequirementId").value
					+ +document.getElementById("total_fund").value;
		}
	}
	
};