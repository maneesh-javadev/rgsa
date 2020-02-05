<%@include file="../taglib/taglib.jsp"%>
<link
	href="https://unpkg.com/bootstrap-table@1.15.5/dist/bootstrap-table.min.css"
	rel="stylesheet">
<script
	src="<%=request.getContextPath()%>/resources/plugins/jquery/jquery.min.js"></script>
<script
	src="https://unpkg.com/tableexport.jquery.plugin/tableExport.min.js"></script>
<script
	src="https://unpkg.com/tableexport.jquery.plugin/libs/jsPDF/jspdf.min.js"></script>
<script
	src="https://unpkg.com/tableexport.jquery.plugin/libs/jsPDF-AutoTable/jspdf.plugin.autotable.js"></script>
<script
	src="https://unpkg.com/bootstrap-table@1.15.5/dist/bootstrap-table.min.js"></script>
<script
	src="https://unpkg.com/bootstrap-table@1.15.5/dist/extensions/export/bootstrap-table-export.min.js"></script>
<%-- <script
	src="${pageContext.request.contextPath}/resources/bootstrap-table/extensions/export/bootstrap-table-export.min.js"></script>
 --%>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugins/angular/angular-route.min.js"></script>

<script src="${pageContext.request.contextPath}/resources/plugins/angular/ui-bootstrap-tpls-0.11.0.js"></script>
   <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/js/utils/captcha.js"></script>
<script>
var userType ='${user_type}';
$( document ).ready(function() {
	//alert(userType);
	
	if(userType== 'M'){
		 $("#accordion").hide();
			}
	else if(userType== ''){
		 $("#accordion").show();
	}
	
	
	$("#trainDetails").hide();
	$("#trainRA").hide();
	$("#trainATS").hide();
	$("#trainEE").hide();
	$("#trainPMU").hide();
	$("#trainIE").hide();
	$("#trainAF").hide();
	$("#trainDLS").hide();
	$("#trainPP").hide();
});

function getformDetail()
{
	var  imageCaptua=$("#img_Capatcha").attr("src");
	alert(imageCaptua);
	var slc =0;
	var fin =0;
	var answerCap =0;
	var imageCaptua=0;
	if(userType== 'M'){
	 slc=$("#selectSLC option:selected").val();
	if(slc != 0){
	 $("#accordion").show();
	}else{
		alert('kindly select state list');
	}
	}
	else if(userType== ''){
		 slc=$("#selectSLC option:selected").val();
		 fin=$("#selectFin option:selected").val();
		 if(slc != 0){
			 $("#accordion").show();
			}else{
				alert('kindly select state list');
			} 
		  imageCaptua=$("#img_Capatcha").attr("src");
		 answerCap=$("#captchaAnswer").val();
			/* if(slc != 0 && fin != 0 && imageCaptua == answerCap){
			 $("#accordion").show();
			}else{
				alert('kindly select  Detail properlly');
			} */
			
	}
}
	
 function collapseShow() {
    
    $('.abc').addClass("in");
    collapseDetails('td');
    collapseDetails('TD');
    collapseDetails('TRA');		
    collapseDetails('II');		
    collapseDetails('PB');		
    collapseDetails('ATS');	
    collapseDetails('EE');	
    collapseDetails('EGOV');		
    collapseDetails('PP');	
    collapseDetails('PP');	
    collapseDetails('DLS');	
	collapseDetails('AFD');	
	collapseDetails('IA');	
	collapseDetails('HR');	
	collapseDetails('IE');	
	collapseDetails('IEC');		
	collapseDetails('PMU');	
}

function collapseHide() {
    
    $('.abc').removeClass("in");
}
</script>
<script>
	var createLabel = function(labelName) {
		th = $("<TH/>");
		templateLabel = $("<label/>");
		templateLabel.html(labelName);
		th.append(templateLabel);
		return th;
	};
	
	function collapseDetails(val) {
		
		var fin=0;
		var slc=0;
		if(userType == 'M'){
		 slc=$("#selectSLC option:selected").val();
		
		}else if(userType == ''){
			 slc=$("#selectSLC option:selected").val();
			 fin=$("#selectFin option:selected").val();
			
			}
		//alert(val);

		$
				.ajax({
					type : "POST",
					contentType : "application/json",
					url : "actionPlanPhysicalReport.html?<csrf:token uri='actionPlanPhysicalReport.html'/>&component="+val+"&slc="+slc+"&fin="+fin,
					dataType : 'json',
					cache : false,
					timeout : 100000,
					success : function(data) {
						var items = [];
						var count =0;
						$.each(data,function(key, value) {
											
                                   
											if (key == "1") {
												
												$("#trainDetails").show();
												var divTemplate = $("#collapse1");
												$("#collapse1").empty();

												//$("#collapse2").text(activityName+" Finalize Work Location of "+$scope.selectDistrictCode.districtNameEnglish+" District");

												table = $("<table/>");
												table.attr("id", "table1");
												
												table
														.addClass("table table-hover table-bordered dashboard-task-infos table-responsive");

												thead = $("<thead/>");

												tr = $("<TR/>");

												th = createLabel("Training Category");
												th.attr("style","thead {color : black; background-color: #e87b7b;")
												tr.append(th);

												th = createLabel("Training Subjects");
												th.attr("style","thead {color : black; background-color: #e87b7b;")
												tr.append(th);

												th = createLabel("Training Target Group");
												th.attr("style","thead {color : black; background-color: #e87b7b;")
												tr.append(th);

												th = createLabel("Venue Level");
												th.attr("style","thead {color : black; background-color: #e87b7b;")
												tr.append(th);

												th = createLabel("Mode Of Training");
												th.attr("style","thead {color : black; background-color: #e87b7b;")
												tr.append(th);

												th = createLabel("No. of Participants");
												th.attr("style","thead {color : black; background-color: #e87b7b;")
												tr.append(th);
												th = createLabel("No.of Days");
												th.attr("style","thead {color : black; background-color: #e87b7b;")
												tr.append(th);

												th = createLabel("Unit Cost");
												th.attr("style","thead {color : black; background-color: #e87b7b;")
												tr.append(th);

												th = createLabel("Funds Proposed 	");
												th.attr("style","thead {color : black; background-color: #e87b7b;")
												tr.append(th);

												th = createLabel("Remarks");
												th.attr("style","thead {color : black; background-color: #e87b7b;")
												tr.append(th);

												thead.append(tr);

												table.append(thead);

												tbody = $("<tbody/>");
												
												tr = $("<TR/>");
												$.each(value, function(key1,
														value1) {
													 
													console.log(key1 + " === "
															+ value1.column1);

													tbody.append(tr);
													table.append(tbody);

													var tdnext;
													$('#addRequ').val(value1.column13);
													td = $("<TD/>");
													td.append(value1.column1);
													tr.append(td);
													tdnext = $("<td>"
															+ value1.column2
															+ "</td>");
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column3
															+ "</td>");
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column4
															+ "</td>");
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column5
															+ "</td>");
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column6
															+ "</td>");
													
													tdnext.attr("id", "noOfParticipant_"+key1);
													//tdnext.append(<input type="text" id="noOfParticipant_"+key1 >);
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column7
															+ "</td>");
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column8
															+ "</td>");
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column9
															+ "</td>");
													tdnext.attr("id", "unitFund_"+key1);
													
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column10
															+ "</td>");
													tr.append(tdnext);
													tr = $("<TR/>");
													count ++;
													
												});
												
												divTemplate.append(table);
												rowCount(count);

											} else if (key == "6") {
												var divTemplate = $("#collapse8");
												$("#trainPP").show();
												$("#collapse8").empty();
												//$("#collapse2").text(activityName+" Finalize Work Location of "+$scope.selectDistrictCode.districtNameEnglish+" District");

												table = $("<table/>");
												table.attr("id", "table8");
												table
														.addClass("table table-hover dashboard-task-infos table-responsive");

												thead = $("<thead/>");

												tr = $("<TR/>");

												th = createLabel("Designation");
												tr.append(th);

												th = createLabel("No. of Units A ");
												tr.append(th);

												th = createLabel("Unit Cost per month (in Rs) B ");
												tr.append(th);

												th = createLabel("No. of Months   C ");
												tr.append(th);

												th = createLabel("Funds (in Rs)  D = A * B * C ");
												tr.append(th);

												th = createLabel("Remarks");
												tr.append(th);

												thead.append(tr);

												table.append(thead);

												tbody = $("<tbody/>");

												tr = $("<TR/>");
												$.each(value, function(key1,
														value1) {
													console.log(key1 + " === "
															+ value1.column1);

													tbody.append(tr);
													table.append(tbody);

													var tdnext;
													$('#addRequPP').val(value1.column6);
													
													
													td = $("<TD/>");
													td.append(value1.column1);
													tr.append(td);
													tdnext = $("<td>"
															+ value1.column2
															+ "</td>");
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column3
															+ "</td>");
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column4
															+ "</td>");
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column5
															+ "</td>");
													tdnext.attr("id", "unitFundPP_"+key1);
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column8
															+ "</td>");
													tr.append(tdnext);
													tr = $("<TR/>");
													count ++;
												});

												divTemplate.append(table);
												rowCountPP(count);
											} else if (key == "11") {
												$.each(value, function(key1,
														value1) {

													$('#Remarks').val(
															value1.column3);
													$('#total').val(
															value1.column2);
													// $('#natureActivity').val(value.column1);
													//alert(value1.column1);
													$('#natureActivity').val(
															value1.column1);
												});
											} else if (key == "5") {
												var divTemplate = $("#collapse6");

												$("#collapse6").empty();
												//$("#collapse2").text(activityName+" Finalize Work Location of "+$scope.selectDistrictCode.districtNameEnglish+" District");
                                              $("#trainEE").show();
												table = $("<table/>");
												table.attr("id", "table6");
												table
														.addClass("table table-hover dashboard-task-infos table-responsive");

												thead = $("<thead/>");

												tr = $("<TR/>");

												th = createLabel("E-infrastructure Resource");
												tr.append(th);

												th = createLabel("No. of G.Ps A");
												tr.append(th);

												th = createLabel("No. of Aspirational Gps");
												tr.append(th);

												th = createLabel("Unit Cost(in Rs.) B ");
												tr.append(th);

												th = createLabel("Funds (in Rs) C = A*B  ");
												tr.append(th);

												th = createLabel("Remarks");
												tr.append(th);

												thead.append(tr);

												table.append(thead);

												tbody = $("<tbody/>");
												tbody1 = $("<tbody/>");
												tr1 = $("<TR/>");
												tr = $("<TR/>");
												$.each(value, function(key1,
														value1) {
													tbody.append(tr);
													table.append(tbody);

													var tdnext;
													$('#addRequEE').val(value1.column7);
													$('#fundEE').val(value1.column6);
													
													td = $("<TD/>");
													td.append(value1.column1);
													tr.append(td);
													tdnext = $("<td>"
															+ value1.column2
															+ "</td>");
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column3
															+ "</td>");
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column4
															+ "</td>");
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column6
															+ "</td>");
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column5
															+ "</td>");
													tr.append(tdnext);
													tr = $("<TR/>");
												});

												
												divTemplate.append(table);

											} else if (key == "13") {
												var divTemplate = $("#collapse2");
												$("#trainRA").show();
												$("#collapse2").empty();
												//$("#collapse2").text(activityName+" Finalize Work Location of "+$scope.selectDistrictCode.districtNameEnglish+" District");

												table = $("<table/>");
												table.attr("id", "table2");
												table
														.addClass("table table-hover dashboard-task-infos table-responsive");

												thead = $("<thead/>");

												tr = $("<TR/>");

												th = createLabel("Activity");
												tr.append(th);

												th = createLabel("No. of Days");
												tr.append(th);

												th = createLabel("No. of Units");
												tr.append(th);

												th = createLabel("Unit Cost(In Rs)");
												tr.append(th);

												th = createLabel("Funds Proposed(In Rs) ");
												tr.append(th);

												th = createLabel("Collaboration with Institute");
												tr.append(th);
												th = createLabel("Remarks");
												tr.append(th);

												thead.append(tr);

												table.append(thead);

												tbody = $("<tbody/>");
												tbody1 = $("<tbody/>");
												tr1 = $("<TR/>");
												tr = $("<TR/>");
												$.each(value, function(key1,
														value1) {
													tbody.append(tr);
													table.append(tbody);

													var tdnext;
													$('#addRequTa').val(value1.column6);
													td = $("<TD/>");
													td.append(value1.column1);
													tr.append(td);
													tdnext = $("<td>"
															+ value1.column2
															+ "</td>");
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column3
															+ "</td>");
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column4
															+ "</td>");
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column5
															+ "</td>");
													tdnext.attr("id", "unitFund_"+key1);
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column8
															+ "</td>");
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column7
															+ "</td>");
													tr.append(tdnext);

													tr = $("<TR/>");
													count ++;
												});

												divTemplate.append(table);
												rowCountTRA(count);

											} else if (key == "3") {
												var divTemplate = $("#collapse4");

												$("#collapse4").empty();
												//$("#collapse2").text(activityName+" Finalize Work Location of "+$scope.selectDistrictCode.districtNameEnglish+" District");
                                               $("#collapse4").append("<br><label>New Building</label>");
												
												table = $("<table/>");
												table.attr("id", "table4");
												table
														.addClass("table table-hover dashboard-task-infos table-responsive");

												thead = $("<thead/>");

												tr = $("<TR/>");

												th = createLabel("Activities");
												tr.append(th);

												th = createLabel("No. of G.Ps");
												tr.append(th);

												th = createLabel("No. of Aspirational GPs selected selected ");
												tr.append(th);

												th = createLabel("Unit Cost (in Rs) ");
												tr.append(th);

												th = createLabel("Funds (in Rs)");
												tr.append(th);

												th = createLabel("Remarks");
												tr.append(th);

												thead.append(tr);

												table.append(thead);

												tbody = $("<tbody/>");
												tbody1 = $("<tbody/>");
												tr1 = $("<TR/>");
												tr = $("<TR/>");
												$.each(value, function(key1,
														value1) {
													tbody.append(tr);
													table.append(tbody);

													var tdnext;
													
													td = $("<TD/>");
													td.append(value1.column1);
													tr.append(td);
													tdnext = $("<td>"
															+ value1.column7
															+ "</td>");
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column5
															+ "</td>");
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column3
															+ "</td>");
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column4
															+ "</td>");
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column6
															+ "</td>");
													tr.append(tdnext);

													tr = $("<TR/>");
												});

												divTemplate.append(table);

											} else if (key == "4") {
												var divTemplate = $("#collapse5");
												$("#trainATS").show();
												$("#collapse5").empty();
												//$("#collapse2").text(activityName+" Finalize Work Location of "+$scope.selectDistrictCode.districtNameEnglish+" District");

												table = $("<table/>");
												table.attr("id", "table5");
												table
														.addClass("table table-hover dashboard-task-infos table-responsive");

												thead = $("<thead/>");

												tr = $("<TR/>");

												th = createLabel("Post Type");
												tr.append(th);

												th = createLabel("Post Name");
												tr.append(th);

												th = createLabel("Level");
												tr.append(th);

												th = createLabel("No. of Block(s) ");
												tr.append(th);

												th = createLabel("Unit Cost");
												tr.append(th);

												th = createLabel("No. of Months ");
												tr.append(th);

												th = createLabel("Funds    (in ï) ");
												tr.append(th);

												thead.append(tr);

												table.append(thead);

												tbody = $("<tbody/>");
												tbody1 = $("<tbody/>");
												tr1 = $("<TR/>");
												tr = $("<TR/>");
												$.each(value, function(key1,
														value1) {
													tbody.append(tr);
													table.append(tbody);

													var tdnext;
													
													$('#addRequATS').val(value1.column8);
													
													td = $("<TD/>");
													td.append(value1.column1);
													tr.append(td);
													tdnext = $("<td>"
															+ value1.column2
															+ "</td>");
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column3
															+ "</td>");
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column4
															+ "</td>");
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column5
															+ "</td>");
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column6
															+ "</td>");
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column7
															+ "</td>");
													tdnext.attr("id", "unitCost_"+key1);
													
													tr.append(tdnext);

													tr = $("<TR/>");
													count ++;
												});

												divTemplate.append(table);
												rowCountATS(count);
											}

											else if (key == "8") {
												var divTemplate = $("#collapse10");
												$("#trainAF").show();
												$("#collapse10").empty();
												//$("#collapse2").text(activityName+" Finalize Work Location of "+$scope.selectDistrictCode.districtNameEnglish+" District");

												table = $("<table/>");
												table.attr("id", "table10");
												table
														.addClass("table table-hover dashboard-task-infos table-responsive");

												thead = $("<thead/>");

												tr = $("<TR/>");

												th = createLabel("Type of Center");
												tr.append(th);

												th = createLabel("Domain Experts");
												tr.append(th);

												th = createLabel("No of Staff proposed");
												tr.append(th);

												th = createLabel("Unit Cost");
												tr.append(th);

												th = createLabel("No. of Months");
												tr.append(th);

												th = createLabel("Funds (in Rs)");
												tr.append(th);

												th = createLabel("Remarks ");
												tr.append(th);

												thead.append(tr);

												table.append(thead);

												tbody = $("<tbody/>");
												tbody1 = $("<tbody/>");
												tr1 = $("<TR/>");
												tr = $("<TR/>");
												$.each(value, function(key1,
														value1) {
													tbody.append(tr);
													table.append(tbody);

													var tdnext;
													$('#addRequAF').val(value1.column8);
													td = $("<TD/>");
													td.append(value1.column1);
													tr.append(td);
													tdnext = $("<td>"
															+ value1.column2
															+ "</td>");
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column3
															+ "</td>");
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column4
															+ "</td>");
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column5
															+ "</td>");
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column9
															+ "</td>");
													tdnext.attr("id", "unitFundAF_"+key1);
													
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column7
															+ "</td>");
													tr.append(tdnext);

													tr = $("<TR/>");
													count ++;
												});

												divTemplate.append(table);
												rowCountAF(count);
											} else if (key == "10") {
												var divTemplate = $("#collapse13");
												$("#trainIE").show();
												$("#collapse13").empty();
												//$("#collapse2").text(activityName+" Finalize Work Location of "+$scope.selectDistrictCode.districtNameEnglish+" District");

												table = $("<table/>");
												table.attr("id", "table13");
												table
														.addClass("table table-hover dashboard-task-infos table-responsive");

												thead = $("<thead/>");

												tr = $("<TR/>");

												th = createLabel("Name of the Activity");
												tr.append(th);

												th = createLabel("Select Scheme");
												tr.append(th);

												th = createLabel("District Name");
												tr.append(th);

												th = createLabel("Block Name");
												tr.append(th);

												th = createLabel("Total No. of GP's Covered 	");
												tr.append(th);

												th = createLabel("No. of Aspirational GPs");
												tr.append(th);

												th = createLabel("From ");
												tr.append(th);
												th = createLabel("To ");
												tr.append(th);
												th = createLabel("Total cost of project ");
												tr.append(th);
												th = createLabel("Funds Proposed in current year ");
												tr.append(th);
												th = createLabel("Brief about the Activity");
												tr.append(th);
												th = createLabel("Remarks ");
												tr.append(th);

												thead.append(tr);

												table.append(thead);

												tbody = $("<tbody/>");
												tbody1 = $("<tbody/>");
												tr1 = $("<TR/>");
												tr = $("<TR/>");
												$.each(value, function(key1,
														value1) {
													tbody.append(tr);
													table.append(tbody);

													var tdnext;
													
													$('#addRequIE').val(value1.column13);
													//$('#fundIE').val(value1.column10);
													
													td = $("<TD/>");
													td.append(value1.column1);
													tr.append(td);
													tdnext = $("<td>"
															+ value1.column2
															+ "</td>");
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column3
															+ "</td>");
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column4
															+ "</td>");
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column5
															+ "</td>");
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column6
															+ "</td>");
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column7
															+ "</td>");
													tr.append(tdnext);
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column8
															+ "</td>");
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column9
															+ "</td>");
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column10
															+ "</td>");
													tdnext.attr("id", "unitFundIE_"+key1);
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column11
															+ "</td>");
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column12
															+ "</td>");
													tr.append(tdnext);

													tr = $("<TR/>");
													count++;
												});

												divTemplate.append(table);
												rowCountIE(count);
											} else if (key == "12") {
												var divTemplate = $("#collapse15");
												
												$("#trainPMU").show();
												$("#collapse15").empty();
												//$("#collapse2").text(activityName+" Finalize Work Location of "+$scope.selectDistrictCode.districtNameEnglish+" District");

												table = $("<table/>");
												table.attr("id", "table15");
												table
														.addClass("table table-hover dashboard-task-infos table-responsive");

												thead = $("<thead/>");

												tr = $("<TR/>");

												th = createLabel("Type of Center");
												tr.append(th);

												th = createLabel("Faculty and Staff");
												tr.append(th);

												th = createLabel("No. of Units");
												tr.append(th);

												th = createLabel("No. of Months");
												tr.append(th);

												th = createLabel("Funds (in Rs) 	");
												tr.append(th);

												th = createLabel("Remarks");
												tr.append(th);

												thead.append(tr);

												table.append(thead);

												tbody = $("<tbody/>");
												tbody1 = $("<tbody/>");
												tr1 = $("<TR/>");
												tr = $("<TR/>");
												$.each(value, function(key1,
														value1) {
													tbody.append(tr);
													table.append(tbody);

													var tdnext;

													td = $("<TD/>");
													td.append(value1.column1);
													tr.append(td);
													tdnext = $("<td>"
															+ value1.column2
															+ "</td>");
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column3
															+ "</td>");
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column4
															+ "</td>");
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column5
															+ "</td>");
													tdnext.attr("id", "total_"+key1);
													
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column6
															+ "</td>");

													tr = $("<TR/>");
													count ++;
												});

												divTemplate.append(table);
												rowCountPMU(count);
											}
											else if (key == "7") {
												var divTemplate = $("#collapse9");
												
												$("#trainDLS").show();
												$("#collapse9").empty();
												//$("#collapse2").text(activityName+" Finalize Work Location of "+$scope.selectDistrictCode.districtNameEnglish+" District");

												table = $("<table/>");
												table.attr("id", "table9");
												table
														.addClass("table table-hover dashboard-task-infos table-responsive");

												thead = $("<thead/>");

												tr = $("<TR/>");

												th = createLabel("Name of the Activity");
												tr.append(th);

												th = createLabel("Panchayat Level");
												tr.append(th);

												th = createLabel("No. of Units");
												tr.append(th);

												th = createLabel("Unit Cost (in Rs)");
												tr.append(th);

												th = createLabel("Fund Proposed (in Rs)");
												
												tr.append(th);

												th = createLabel("Remarks");
												tr.append(th);

												thead.append(tr);

												table.append(thead);

												tbody = $("<tbody/>");
												tbody1 = $("<tbody/>");
												tr1 = $("<TR/>");
												tr = $("<TR/>");
												$.each(value, function(key1,
														value1) {
													tbody.append(tr);
													table.append(tbody);
															 	     
													var tdnext;
													$('#addRequDLS').val(value1.column8);
													
													td = $("<TD/>");
													td.append(value1.column1);
													tr.append(td);
													tdnext = $("<td>"
															+ value1.column2
															+ "</td>");
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column3
															+ "</td>");
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column4
															+ "</td>");
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column5
															+ "</td>");
													tdnext.attr("id", "unitFundDLS_"+key1);
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column6
															+ "</td>");

													tr = $("<TR/>");
													
													count ++;
												});

												divTemplate.append(table);
												rowCountDLS(count);
											}
											else if (key == "14") {
												var divTemplate = $("#collapse12");

												$("#collapse12").empty();
												//$("#collapse2").text(activityName+" Finalize Work Location of "+$scope.selectDistrictCode.districtNameEnglish+" District");

												table = $("<table/>");
												table.attr("id", "table12");
												table
														.addClass("table table-hover dashboard-task-infos table-responsive");

												thead = $("<thead/>");

												tr = $("<TR/>");

												th = createLabel("Type of Center");
												tr.append(th);

												th = createLabel("Faculty and Staff");
												tr.append(th);

												th = createLabel("No. of Units");
												tr.append(th);

												th = createLabel("No. of Months");
												tr.append(th);

												th = createLabel("Funds (in Rs)");
												tr.append(th);

												th = createLabel("Remarks");
												tr.append(th);

												thead.append(tr);

												table.append(thead);

												tbody = $("<tbody/>");
												tbody1 = $("<tbody/>");
												tr1 = $("<TR/>");
												tr = $("<TR/>");
												$.each(value, function(key1,
														value1) {
													tbody.append(tr);
													table.append(tbody);
                                    
                                    	var tdnext;

													td = $("<TD/>");
													td.append(value1.column1);
													tr.append(td);
													tdnext = $("<td>"
															+ value1.column2
															+ "</td>");
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column3
															+ "</td>");
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column5
															+ "</td>");
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column7
															+ "</td>");
													tdnext.attr("id", "expenditure_"+key1);
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column8
															+ "</td>");
													tr.append(tdnext);
													tr = $("<TR/>");
                                    
												});

												divTemplate.append(table);

											}
											
											else if (key == "15") {
												var divTemplate = $("#collapse7");

												$("#collapse7").empty();
												//$("#collapse2").text(activityName+" Finalize Work Location of "+$scope.selectDistrictCode.districtNameEnglish+" District");

												table = $("<table/>");
												table.attr("id", "table7");
												table
														.addClass("table table-hover dashboard-task-infos table-responsive");

												thead = $("<thead/>");

												tr = $("<TR/>");

												th = createLabel("Level");
												tr.append(th);

												th = createLabel("Designation");
												tr.append(th);

												th = createLabel("No. of Posts proposed");
												tr.append(th);

												th = createLabel("No. of Months");
												tr.append(th);

												th = createLabel("Unit Cost(in Rs)");
												tr.append(th);
												th = createLabel("Fund Proposed (in Rs)");
												tr.append(th);
												
												th = createLabel("Remarks");
												tr.append(th);

												thead.append(tr);

												table.append(thead);

												tbody = $("<tbody/>");
												tbody1 = $("<tbody/>");
												tr1 = $("<TR/>");
												tr = $("<TR/>");
												$.each(value, function(key1,
														value1) {
													tbody.append(tr);
													table.append(tbody);
                                    
                                    	var tdnext;

													td = $("<TD/>");
													td.append(value1.column1);
													tr.append(td);
													tdnext = $("<td>"
															+ value1.column2
															+ "</td>");
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column3
															+ "</td>");
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column5
															+ "</td>");
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column4
															+ "</td>");
													tdnext.attr("id", "expenditureEGOV_"+key1);
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column7
															+ "</td>");
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column8
															+ "</td>");
													tr.append(tdnext);
													tr = $("<TR/>");
                                    
												});

												divTemplate.append(table);

											}
											
										});
					},
					error : function(e) {
						console.log(e);
					}
				});

	}
</script>



<section class="content">

	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h3 style="padding-top: 25px;">&nbsp;&nbsp; Action Plan
							Physical Report</h3>
					</div>
					<br />
					<form:form method="post" name="" action="">
						
						<div class="card">
                        <div class="container">
                          <div class="body">
							<div class="row ">
							<div class="form-group">
							<div class="col-sm-12">
							<div class="col-sm-4">
							<c:if test="${ShowState}">
								
									
										<label ><strong>Select State :</strong></label>
									
									
										<select name="" id="selectSLC" 
											
											class="form-control">
											<option value="0">Select State:</option>
											<c:forEach items="${stateList}" var="slc">
												<option value="${slc.stateCode}">${slc.stateNameEnglish}</option>
											</c:forEach>
										</select>
									
								
								</c:if>
								</div>
								<div class="col-sm-4">
							<c:if test="${showFin}">
									
										<label for="QuaterId1"><strong>Select FinYear :</strong></label>
									
									
										<select name="" id="selectFin" 
											
											class="form-control">
											<option value="0">Select FinYear</option>
											<c:forEach items="${FIN_YEAR_LIST}" var="year">
												<option value="${year.yearId}">${year.finYear}</option>
											</c:forEach>
										</select>
									
							</c:if>
								</div><c:if test="${ShowState}">
								<div class="col-sm-4">
							 <button class="btn  bg-primary" type="button" onclick="getformDetail();"> Get Detail</button>
							</div>
							</c:if>
							<c:if test="${showFin}">
							<div class="row">
							<div class="form-group">
							<div class="col-sm-12">
							<div class="col-sm-4">
							<div class="form-group">  
									<img src="captchaImage" width="200px" id="img_Capatcha" /></div>
									<div class="col-sm-1">
									 <i class="fa fa-refresh pull-right" onclick="refreshCaptcha()"></i>
								</div>
								</div>
								<div class="form-group">
							<div class="col-sm-12">
							
								<div class=" has-feedback">
									<label class="control-label">Captcha Answer</label>
									<form:input cssStyle="color:black;" id="captchaAnswer" path="captchaAnswer" placeholder="Captcha Answer" class="form-control"  htmlEscape="true" autocomplete="off" required="required"/>
									<span class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true"></span>
								</div></div>
								</div>
							</div>
							</div>
							</div>
							</c:if>
							</div>
							</div>
							</div>
							
						</div>
						</div>
						</div>
							<div class="container">
<div id="print">
								<main>
								<article class="panel-group bs-accordion" id="accordion"
									role="tablist" aria-multiselectable="true">
									
									<section class="panel panel-default xxx">
										<div class="panel-heading" role="tab" id="heading1"
											onclick="collapseDetails('TD');">
											<h4 class="panel-title">
												<a role="button" data-toggle="collapse"
													data-parent="#accordion" href="#collapse1"
													aria-expanded="false" aria-controls="collapse1">
													Training Details <span
													class="glyphicon glyphicon-chevron-right pull-right"
													aria-hidden="true"></span>
												</a>
											</h4>
										</div>
										
										<div class="">
										<div id="collapse1"
											class="panel-collapse collapse abc "
											role="tabpanel"  aria-labelledby="heading1">
											</div>
											<div class="row form-group" id ="trainDetails">
											<div class="col-sm-12">
											
											<div class="col-sm-9">
											<label>Total No. of Participants</label>
											</div>
											<div class="col-sm-2" >
											<input type="text" id="noOfPart" readonly="readonly" class="form-control" />
											</div>
											</div>
											<div class="col-sm-12">
											
											<div class="col-sm-9">
											<label>Total Funds</label>
											</div>
											<div class="col-sm-2" >
											<input type="text" id="totalCost" readonly="readonly" class="form-control" />
											</div>
											</div>
											<div class="col-sm-12">
											
											<div class="col-sm-9">
											
											
											<label>Additional Requirements</label>
											</div>
											<div class="col-sm-2" >
											<input type="text" id="addRequ" readonly="readonly" class="form-control" />
											</div>
											</div>
											<div class="col-sm-12">
											
											<div class="col-sm-9">
											<label>Total Proposed Fund</label>
											</div>
											<div class="col-sm-2" id="">
											<input type="text" id="fund" readonly="readonly" class="form-control"/>
											</div>
											</div>
										</div>
										
											</div>
									</section>
									<section class="panel panel-default xxx">
										<div class="panel-heading" role="tab" id="heading2"
											onclick="collapseDetails('TRA');">
											<h4 class="panel-title">
												<a class="collapsed" role="button" data-toggle="collapse"
													data-parent="#accordion" href="#collapse2"
													aria-expanded="false" aria-controls="collapse2">
													Training Related Activities <span
													class="glyphicon glyphicon-chevron-right pull-right"
													aria-hidden="true"></span>
									</a>
											</h4>
										</div>
										<div id="collapse2" class="panel-collapse collapse abc"
											role="tabpanel" aria-labelledby="heading2"></div>
											<div class="row form-group" id ="trainRA">
											<div class="col-sm-12">
											
											<div class="col-sm-8">
											<label>Total Funds</label>
											</div>
											<div class="col-sm-4" >
											<input type="text" id="taTotFund" readonly="readonly" class="form-control" />
											</div>
											</div>
											
											<div class="col-sm-12">
											
											<div class="col-sm-8">
											
											
											<label>Additional Requirements</label>
											</div>
											<div class="col-sm-4" >
											<input type="text" id="addRequTa" readonly="readonly" class="form-control" />
											</div>
											</div>
											<div class="col-sm-12">
											
											<div class="col-sm-8">
											<label>Total Proposed Fund</label>
											</div>
											<div class="col-sm-4" id="">
											<input type="text" id="fundTa" readonly="readonly" class="form-control"/>
											</div>
											</div>
										</div>
									</section>
									<section class="panel panel-default xxx">
										<div class="panel-heading" role="tab" id="heading3"
											onclick="collapseDetails('II');">
											<h4 class="panel-title">
												<a class="collapsed" role="button" data-toggle="collapse"
													data-parent="#accordion" href="#collapse3"
													aria-expanded="false" aria-controls="collapse3">
													Institutional Infrastructure <span
													class="glyphicon glyphicon-chevron-right pull-right"
													aria-hidden="true"></span>
												</a>
											</h4>
										</div>
										<div id="collapse3" class="panel-collapse collapse abc"
											role="tabpanel" aria-labelledby="heading3">
											<div class="panel-body">
												
											</div>
										</div>
									</section>
									<section class="panel panel-default xxx">
										<div class="panel-heading" role="tab" id="heading4"
											onclick="collapseDetails('PB');">
					                         <h4 class="panel-title">
												<a role="button" data-toggle="collapse"
													data-parent="#accordion" href="#collapse4"
													aria-expanded="false" aria-controls="collapse4">
													Support for Panchayat Bhawan <span
													class="glyphicon glyphicon-chevron-right pull-right"
													aria-hidden="true"></span>
												</a>
											</h4>
										</div>

										<div id="collapse4" class="panel-collapse collapse abc"
											role="tabpanel" aria-labelledby="heading4">
											<div class="panel-body">
												</div>

											
										</div>
									</section>
									<section class="panel panel-default xxx">
										<div class="panel-heading" role="tab" id="heading5"
											onclick="collapseDetails('ATS');">
											<h4 class="panel-title">
												<a class="collapsed" role="button" data-toggle="collapse"
													data-parent="#accordion" href="#collapse5"
													aria-expanded="false" aria-controls="collapse5">
													Administrative and Technical Activity <span
													class="glyphicon glyphicon-chevron-right pull-right"
													aria-hidden="true"></span>
												</a>
											</h4>
										</div>
										<div id="collapse5" class="panel-collapse collapse abc"
											role="tabpanel" aria-labelledby="heading5">
											<div class="panel-body"></div>
										</div>
												<div class="row form-group" id ="trainATS">
											<div class="col-sm-12">
											
											<div class="col-sm-10">
											<label>Total Funds</label>
											</div>
											<div class="col-sm-2" >
											<input type="text" id="taTotFundATS" readonly="readonly" class="form-control" />
											</div>
											</div>
											
											<div class="col-sm-12">
											
											<div class="col-sm-10">
											
											
											<label>Additional Requirements</label>
											</div>
											<div class="col-sm-2" >
											<input type="text" id="addRequATS" readonly="readonly" class="form-control" />
											</div>
											</div>
											<div class="col-sm-12">
											
											<div class="col-sm-10">
											<label>Total Proposed Fund</label>
											</div>
											<div class="col-sm-2" id="">
											<input type="text" id="fundATS" readonly="readonly" class="form-control"/>
											</div>
											</div>
										</div>
									</section>
									<section class="panel panel-default xxx">
										<div class="panel-heading" role="tab" id="heading6"
											onclick="collapseDetails('EE');">
											<h4 class="panel-title">
												<a class="collapsed" role="button" data-toggle="collapse"
													data-parent="#accordion" href="#collapse6"
													aria-expanded="false" aria-controls="collapse6">
													E-enablement <span
													class="glyphicon glyphicon-chevron-right pull-right"
													aria-hidden="true"></span>
												</a>
											</h4>
										</div>
										<div id="collapse6" class="panel-collapse collapse abc"
											role="tabpanel" aria-labelledby="heading6"></div>
											<div class="row form-group" id ="trainEE">
											
											<div class="col-sm-12">
											
											<div class="col-sm-10">
											
											
											<label>Additional Requirements</label>
											</div>
											<div class="col-sm-2" >
											<input type="text" id="addRequEE" readonly="readonly" class="form-control" />
											</div>
											</div>
											<div class="col-sm-12">
											
											<div class="col-sm-10">
											<label>Total Proposed Fund</label>
											</div>
											<div class="col-sm-2" id="">
											<input type="text" id="fundEE" readonly="readonly" class="form-control"/>
											</div>
											</div>
										</div>
											
											
									</section>
									<section class="panel panel-default xxx">
										<div class="panel-heading" role="tab" id="heading7"
											onclick="collapseDetails('EGOV');">
					<h4 class="panel-title">
												<a role="button" data-toggle="collapse"
													data-parent="#accordion" href="#collapse7"
													aria-expanded="false" aria-controls="collapse7">
													E-Governance <span
													class="glyphicon glyphicon-chevron-right pull-right"
													aria-hidden="true"></span>
												</a>
											</h4>
										</div>
										<div id="collapse7" class="panel-collapse collapse abc"
											role="tabpanel" aria-labelledby="heading7">
											<div class="panel-body">
												
											</div>
										</div>
									</section>
									<section class="panel panel-default xxx">
										<div class="panel-heading" role="tab" id="heading8"
											onclick="collapseDetails('PP');">
											<h4 class="panel-title">
												<a class="collapsed" role="button" data-toggle="collapse"
													data-parent="#accordion" href="#collapse8"
													aria-expanded="false" aria-controls="collapse8"> Pesa
													Plan <span
													class="glyphicon glyphicon-chevron-right pull-right"
													aria-hidden="true"></span>
												</a>
											</h4>
										</div>
										<div id="collapse8" class="panel-collapse collapse abc"
											role="tabpanel" aria-labelledby="heading8"></div>
											<div class="row form-group" id ="trainPP">
											<div class="col-sm-12">
											
											<div class="col-sm-10">
											<label> Funds</label>
											</div>
											<div class="col-sm-2" >
											<input type="text" id="taTotFundPP" readonly="readonly" class="form-control" />
											</div>
											</div>
											
											<div class="col-sm-12">
											
											<div class="col-sm-10">
											
								 
											<label>Additional Requirements</label>
											</div>
											<div class="col-sm-2" >
											<input type="text" id="addRequPP" readonly="readonly" class="form-control" />
											</div>
											</div>
											<div class="col-sm-12">
											
											<div class="col-sm-10">
											<label>Total Proposed Fund</label>
											</div>
											<div class="col-sm-2" id="">
											<input type="text" id="fundPP" readonly="readonly" class="form-control"/>
											</div>
											</div>
										</div>
									</section>
									<section class="panel panel-default xxx">
										<div class="panel-heading" role="tab" id="heading9"
											onclick="collapseDetails('DLS');">
											<h4 class="panel-title">
												<a class="collapsed" role="button" data-toggle="collapse"
													data-parent="#accordion" href="#collapse9"
													aria-expanded="false" aria-controls="collapse9">
													Distance Learning Facility through SATCOM/IP <span
													class="glyphicon glyphicon-chevron-right pull-right"
													aria-hidden="true"></span>
												</a>
											</h4>
										</div>
										<div id="collapse9" class="panel-collapse collapse abc"
											role="tabpanel" aria-labelledby="heading9">
											<div class="panel-body">
												
											</div>
										</div>
										<div class="row form-group" id ="trainDLS">
											<div class="col-sm-12">
											
											<div class="col-sm-8">
											<label> Funds</label>
											</div>
											<div class="col-sm-2" >
											<input type="text" id="taTotFundDLS" readonly="readonly" class="form-control" />
											</div>
											</div>
											
											<div class="col-sm-12">
											
											<div class="col-sm-10">
											
								 
											<label>Additional Requirements</label>
											</div>
											<div class="col-sm-2" >
											<input type="text" id="addRequDLS" readonly="readonly" class="form-control" />
											</div>
											</div>
											<div class="col-sm-12">
											
											<div class="col-sm-10">
											<label>Total Proposed Fund</label>
											</div>
											<div class="col-sm-2" id="">
											<input type="text" id="fundDLS" readonly="readonly" class="form-control"/>
											</div>
											</div>
										</div>
									</section>
									<section class="panel panel-default xxx">
										<div class="panel-heading" role="tab" id="heading10"
											onclick="collapseDetails('AFD');">
											<h4 class="panel-title">
												<a role="button" data-toggle="collapse"
													data-parent="#accordion" href="#collapse10"
													aria-expanded="false" aria-controls="collapse10">
													Administrative and Financial Data Analysis and Planning
													Cell <span
													class="glyphicon glyphicon-chevron-right pull-right"
													aria-hidden="true"></span>
												</a>
											</h4>
										</div>
										<div id="collapse10" class="panel-collapse collapse abc"
											role="tabpanel" aria-labelledby="heading10">
											<div class="panel-body">
												
											</div>
										</div>
										<div class="row form-group" id ="trainAF">
											<div class="col-sm-12">
											
											<div class="col-sm-10">
											<label> Funds</label>
											</div>
											<div class="col-sm-2" >
											<input type="text" id="taTotFundAF" readonly="readonly" class="form-control" />
											</div>
											</div>
											
											<div class="col-sm-12">
											
											<div class="col-sm-10">
											
											
											<label>Additional Requirements</label>
											</div>
											<div class="col-sm-2" >
											<input type="text" id="addRequAF" readonly="readonly" class="form-control" />
											</div>
											</div>
											<div class="col-sm-12">
											
											<div class="col-sm-10">
											<label>Total Proposed Fund</label>
											</div>
											<div class="col-sm-2" id="">
											<input type="text" id="fundAF" readonly="readonly" class="form-control"/>
											</div>
											</div>
										</div>
									</section>
									<section class="panel panel-default xxx">
										<div class="panel-heading" role="tab" id="heading11"
											onclick="collapseDetails('IA');">
											<h4 class="panel-title">
												<a class="collapsed" role="button" data-toggle="collapse"
								data-parent="#accordion" href="#collapse11"
													aria-expanded="false" aria-controls="collapse11">
													Innovative Activities <span
													class="glyphicon glyphicon-chevron-right pull-right"
													aria-hidden="true"></span>
												</a>
											</h4>
										</div>
										<div id="collapse11" class="panel-collapse collapse abc"
											role="tabpanel" aria-labelledby="heading11">
											<div class="panel-body">
												
											</div>
										</div>
									</section>
									<section class="panel panel-default xxx" >
										<div class="panel-heading" role="tab" id="heading12"
											onclick="collapseDetails('HR');">
											<h4 class="panel-title">
												<a class="collapsed" role="button" data-toggle="collapse"
													data-parent="#accordion" href="#collapse12"
													aria-expanded="false" aria-controls="collapse12"> HR
													Support SPRC and DPRC <span
													class="glyphicon glyphicon-chevron-right pull-right"
													aria-hidden="true"></span>
												</a>
											</h4>
										</div>
										<div id="collapse12" class="panel-collapse collapse abc"
											role="tabpanel" aria-labelledby="heading12">
											
										</div>
									</section>
									<section class="panel panel-default xxx">
										<div class="panel-heading" role="tab" id="heading13"
											onclick="collapseDetails('IE');">
											<h4 class="panel-title">
												<a role="button" data-toggle="collapse"
													data-parent="#accordion" href="#collapse13"
													aria-expanded="false" aria-controls="collapse13">
													Project Based Support for Income Development and Income
													Enhancement <span
													class="glyphicon glyphicon-chevron-right pull-right"
													aria-hidden="true"></span>
												</a>
											</h4>
										</div>
										<div id="collapse13" class="panel-collapse collapse abc"
											role="tabpanel" aria-labelledby="heading13">
						<div class="panel-body"></div>
										</div>
										<div class="row form-group" id ="trainIE">
											<div class="col-sm-12">
											
											<div class="col-sm-10">
											<label> Funds</label>
											</div>
											<div class="col-sm-2" >
											<input type="text" id="taTotFundIE" readonly="readonly" class="form-control" />
											</div>
											</div>
											
											<div class="col-sm-12">
											
											<div class="col-sm-10">
											
											
											<label>Additional Requirements</label>
											</div>
											<div class="col-sm-2" >
											<input type="text" id="addRequIE" readonly="readonly" class="form-control" />
											</div>
											</div>
											<div class="col-sm-12">
											
											<div class="col-sm-10">
											<label>Total Proposed Fund</label>
											</div>
											<div class="col-sm-2" id="">
											<input type="text" id="fundIE" readonly="readonly" class="form-control"/>
											</div>
											</div>
										</div>
										 	
	

									</section>
									<section class="panel panel-default xxx">
										<div class="panel-heading" role="tab" id="heading14"
											onclick="collapseDetails('IEC');">
											<h4 class="panel-title">
												<a class="collapsed" role="button" data-toggle="collapse"
													data-parent="#accordion" href="#collapse14"
													aria-expanded="false" aria-controls="collapse14"> IEC <span
													class="glyphicon glyphicon-chevron-right pull-right"
													aria-hidden="true"></span>
												</a>
											</h4>
										</div>
										<div id="collapse14" class="panel-collapse collapse abc"
											role="tabpanel" aria-labelledby="heading14">
											<div class="container">
												<br>
												<div class="row">
													<div class="form-group">
														<div class="col-sm-12">
															<label>Nature of the IEC Activity:</label>
														</div>
														<br>
														<div class="col-sm-8">
															<div id="">
																<input type="text" id="natureActivity"
																	class="form-control" />
															</div>
														</div>
														<br>
													</div>
													<div class="form-group">
														<div class="col-sm-12">
															<div class="">
																<label>Amount Proposed:</label>
															</div>
														</div>
														<br>
														<div class="col-sm-8">
															<div id="">
																<input type="text" id="total" class="form-control" />
															</div>
														</div>
														<br>
													</div>
													<div class="form-group">
														<div class="col-sm-8">
															<div class="">
																<label>Remarks:</label>

															</div>
														</div>
														<br>
														<div class="col-sm-8">
															<div id="Remarks">
																<input type="text" id="Remarks" class="form-control" />
															</div>
														</div>

													</div>
												</div>
											</div>
										</div>
									</section>
									<section class="panel panel-default xxx">
										<div class="panel-heading" role="tab" id="heading15"
											onclick="collapseDetails('PMU');">
											<h4 class="panel-title">
												<a role="button" data-toggle="collapse"
													data-parent="#accordion" href="#collapse15"
													aria-expanded="false" aria-controls="collapse15"> PMU <span
													class="glyphicon glyphicon-chevron-right pull-right"
													aria-hidden="true"></span>
												</a>
											</h4>
										</div>
										<div id="collapse15" class="panel-collapse collapse abc"
											role="tabpanel" aria-labelledby="heading15">
											<div class="panel-body"></div>
										</div>
											<div class="row form-group" id ="trainPMU">
											
											
											
											<div class="col-sm-12">
											<div class="col-sm-1"></div>
											<div class="col-sm-7">
											<label>Total SPMU Fund</label>
											</div>
											<div class="col-sm-2" id="">
											<input type="text" id="fundPMU" readonly="readonly" class="form-control"/>
											</div>
											</div>
										</div>
									</section>
								
								<div class="text-right">
										<button  type="button"   class="btn bg-green waves-effect"  onclick="collapseShow();">Expand all</button>

										<button  type="button" class="btn bg-red waves-effect" id=collapse_hide onclick="collapseHide();">Collapse all</button>
										 <button type="button" class="btn bg-primary waves-effect"
										id="exportButtonId"
										onclick="exportToPdf('print')">Print
										File</button> 
									</div>
									</article>
								</main>
								</div>
									
							</div>
						
					</form:form>
				</div>
			</div>
		</div>
		</div>
	</div>
</section>
<style>


.card {
    background: 
#f0eaea;
min-height: 50px;
box-shadow: 0 2px 10px
    rgba(0, 0, 0, 0.2);
    position: relative;
    margin-bottom: 30px;
}
.panel-default {
    border-color: 
    #b5abab;
}

.table thead tr th {
    padding: 10px;
        padding-top: 10px;
        padding-right: 10px;
        padding-bottom: 10px;
        padding-left: 10px;
    border-bottom: 3px solid 
    #5d1616;
    background-color: !blue!aliceblue;
}
.bs-accordion { .panel-heading { // remove the padding on the heading so
	we can increase the click area of the anchor padding:0;a { // increase
	the click area of the anchor trigger to match the original
	.panel-heading display:block;
	padding: 10px 15px; // spin the chevron! &[aria-expanded=true] {
	.glyphicon.glyphicon-chevron-right { transform : rotate( 90deg);
	transition: transform 350ms cubic-bezier(0.645, 0.045, 0.355, 1);
}

}
.glyphicon.glyphicon-chevron-right {
	transition: transform 350ms cubic-bezier(0.645, 0.045, 0.355, 1);
}
}
}
}
</style>
<script>
function rowCount(ind){
	var noOfP=0;
	var addRequi=0;
	var unitFund=0;
	
	for (var i = 0; i < ind; i++) {
		//var r=$('#table1':noOfParticipant_i).val();
		// var r=$('#table1').children('noOfParticipant_'+i).text();
		//alert(r);
		noOfP += +$('#noOfParticipant_'+i).html();	
		
		unitFund +=+$('#unitFund_'+i).html();
	}
	$('#totalCost').val(+unitFund);
	
	$('#noOfPart').val(+noOfP);
	addRequi= $('#addRequ').val();
	$('#fund').val(+unitFund + +addRequi);
	}
function rowCountTRA(ind){
	var unitCost=0;
	var addRequi=0;
	var unitFund=0;
	
	for (var i = 0; i < ind; i++) {
		//var r=$('#table1':noOfParticipant_i).val();
		// var r=$('#table1').children('noOfParticipant_'+i).text();
		//alert(r);
		unitCost += +$('#unitFund_'+i).html();	
		
		//unitFund +=+$('#unitFund_'+i).html();
	}
	$('#taTotFund').val(+unitCost);
	
	//$('#noOfPart').val(+unitCost);
	addRequi= $('#addRequTRA').html();
	if(addRequi ==null){
		addRequi=0;
	}
	$('#fundTa').val(+unitCost + +addRequi);
	}
function rowCountATS(ind){
	var unitCost=0;
	var addRequi=0;
	var unitFund=0;
	
	for (var i = 0; i < ind; i++) {
		//var r=$('#table1':noOfParticipant_i).val();
		// var r=$('#table1').children('noOfParticipant_'+i).text();
		//alert(r);
		unitCost = +$('#unitCost_'+i).html();	
		if(isNaN(unitCost)) {
			 unitCost = 0;
			}
		unitFund +=unitCost;
		//unitFund +=+$('#unitFund_'+i).html();
	}
	$('#taTotFundATS').val(+unitFund);
	
	//$('#noOfPart').val(+unitCost);
	addRequi= $('#addRequATS').html();
	if(addRequi ==null){
		addRequi=0;
	}
	$('#fundATS').val(+unitFund + +addRequi);
	}
function rowCountPMU(ind){
	var unitCost=0;
	
	for (var i = 0; i < ind; i++) {
		unitCost += +$('#total_'+i).html();	
		
		//unitFund +=+$('#unitFund_'+i).html();
	}
	$('#fundPMU').val(+unitCost);
	
	
	}

function rowCountIE(ind){
	var noOfP=0;
	var addRequi=0;
	var unitFund=0;
	
	for (var i = 0; i < ind; i++) {
		//var r=$('#table1':noOfParticipant_i).val();
		// var r=$('#table1').children('noOfParticipant_'+i).text();
		//alert(r);
		unitFund += +$('#unitFundIE_'+i).html();	
		
		//unitFund +=+$('#unitFund_'+i).html();
	}
	//$('#totalCost').val(+unitFund);
	
	$('#taTotFundIE').val(+unitFund);
	 addRequi= $('#addRequIE').val();
	$('#fundIE').val(+unitFund + +addRequi);
	}
function rowCountAF(ind){
	var unitCost=0;
	var addRequi=0;
	var unitFund=0;
	
	for (var i = 0; i < ind; i++) {
		//var r=$('#table1':noOfParticipant_i).val();
		// var r=$('#table1').children('noOfParticipant_'+i).text();
		//alert(r);
		unitCost += +$('#unitFundAF_'+i).html();	
		if(isNaN(unitCost)) {
			 unitCost = 0;
			}
		unitFund +=unitCost;
		//unitFund +=+$('#unitFund_'+i).html();
	}
	//$('#totalCost').val(+unitFund);
	
	$('#taTotFundAF').val(+unitFund);
	 addRequi= $('#addRequAF').val();
	$('#fundAF').val(+unitFund + +addRequi);
	}
function rowCountDLS(ind){
	var unitCost=0;
	var addRequi=0;
	var unitFund=0;
	
	for (var i = 0; i < ind; i++) {
		//var r=$('#table1':noOfParticipant_i).val();
		// var r=$('#table1').children('noOfParticipant_'+i).text();
		//alert(r);
		unitCost += +$('#unitFundDLS_'+i).html();	
		if(isNaN(unitCost)) {
			 unitCost = 0;
			}
		unitFund +=unitCost;
		//unitFund +=+$('#unitFund_'+i).html();
	}
	//$('#totalCost').val(+unitFund);
	
	$('#taTotFundDLS').val(+unitFund);
	 addRequi= $('#addRequDLS').val();
	$('#fundDLS').val(+unitFund + +addRequi);
	}
function rowCountPP(ind){
	var unitCost=0;
	var addRequi=0;
	var unitFund=0;
	
	for (var i = 0; i < ind; i++) {
		//var r=$('#table1':noOfParticipant_i).val();
		// var r=$('#table1').children('noOfParticipant_'+i).text();
		//alert(r);
		unitCost += +$('#unitFundPP_'+i).html();	
		if(isNaN(unitCost)) {
			 unitCost = 0;
			}
		unitFund +=unitCost;
		//unitFund +=+$('#unitFund_'+i).html();
	}
	//$('#totalCost').val(+unitFund);
	
	$('#taTotFundPP').val(+unitFund);
	 addRequi= $('#addRequPP').val();
	$('#fundPP').val(+unitFund + +addRequi);
	}
	
function refreshCaptcha()
{
	  $('#img_Capatcha').attr('src', 'captchaImage?cache=' + new Date().getTime());
    $('#captchaAnswer').val('');
    $('#captchaAnswer').focus();
}
function exportToPdf(id) {
	var header = 'Training Activities';
	var sTable =$('#'+id).html();
	var style = "<style>";

	style = style + "table,th,td{border: solid 1px black;border-collapse: collapse;}";
	       style = style + "thead {color : black; background-color: #e87b7b;";
	       style = style + "</style>";

	  var win = window.open('', '', 'height=1000,width=1000');
	   win.document.write('<html><head>');
	   win.document.write('<title>'+header+'</title>');  
	   win.document.write(style);
	   win.document.write('</head>');
	   win.document.write('<body>');
	   win.document.write(sTable);        
	   win.document.write('</body></html>');
	  win.document.close();
	  win.print();    
	} 
		
		</script>