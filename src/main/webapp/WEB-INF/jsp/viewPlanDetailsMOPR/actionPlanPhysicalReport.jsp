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
//alert(document.referrer);
var userType ='${user_type}';
$( document ).ready(function() {
	//alert(userType);
	
	if(userType== 'M'){
		 $("#print").hide();
			var finYear = '${FIN_YEAR}';
			var state = '${STATE.stateNameEnglish}';
			
		}
	else if(userType== ''){
		
		var finYear = '${FIN_YEAR}';
		var state = '${STATE.stateNameEnglish}';
		
		$('#print').css("display","none");
		$('.abcv').css("display","block");
		$('.content').css({'margin':'0 0 0 0','margin-top':'150px'});
	}
	if(userType== 'S'){
		 $("#print").show();
			var finYear = '${FIN_YEAR}';
			var state = '${STATE.stateNameEnglish}';
		    var stateCode ='${STATE.stateCode}';
			$('#selectSLC').val(stateCode);
			$('#selectFin').val(finYear);
			 
			
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

function getStateList(){
	var fin =$("#selectFin option:selected").val();
	
	 		$
			.ajax({
				type : "GET",
				contentType : "application/json",
				url : "getStateList.html?<csrf:token uri='getStateList.html'/>&finYear="+fin,
				dataType : 'json',
				cache : false,
				timeout : 100000,
				success : function(data) {
				   var temp = $('#selectSLC'); // cache it
			        temp.empty();
			        $("#selectSLC").append("<option value=''>--Select--</option>");

			        $.each(data, function (i, value2) {  
			        	$.each(value2, function (j, value1) {// bind the dropdown list using json result              
			        	
			        	$('<option>',
			               {
			            	
			                   value:value1.stateCode,
			                   text: value1.stateNameEnglish
			               }).html(value1.stateNameEnglish).appendTo("#selectSLC");
			        });
			        });
			        $('#selectSLC').trigger("chosen:updated");
			    
					/*  $.each(data, function (index, value) {
		                    // APPEND OR INSERT DATA TO SELECT ELEMENT.
		                    $('#selectSLC').append('<option value="' + index + '">' + value + '</option>');
		                });
						 */
	 },error : function(e) {
			console.log(e);
		}
			}); 	
		
	 
}

function getformDetail()
{
	
	
	//alert(imageCaptua);
	var slc =0;
	var fin =0;
	var imageCaptua =0;
	var imageCaptua=0;
	var flag=0;
	if(userType== 'M'){
	 slc=$("#selectSLC option:selected").val();
	 $('#stateSelect').html("of "+$("#selectSLC option:selected").html()+ " for ");
	if(slc != 0){
		$('.abcv').css("display","none");
		$('#print').css("display","block");

	}else{
		alert('kindly select state list');
	}
	}
	else if(userType== ''){
		
		$('#stateSelect').html("of "+$("#selectSLC option:selected").html()+ " for ");
		$('#finSelect').html($("#selectFin option:selected").html());
		 imageCaptua=$("#captchaAnswer").val();
		 slc=$("#selectSLC option:selected").val();
		 fin=$("#selectFin option:selected").val();
		
			if(slc != 0){
				flag=1;
			}else{
				flag=0;
				alert('kindly select state list');
			}if(fin != 0){
				flag=1;
			}else{
				flag=0;
				alert('kindly select fin year');
			}
			 if(imageCaptua != ''){
				$
				.ajax({
					type : "GET",
					contentType : "application/json",
					url : "validateCaptcha.html?<csrf:token uri='validateCaptcha.html'/>&captchaAnswer="+imageCaptua,
					dataType : 'json',
					cache : false,
					timeout : 100000,
					success : function(data) {
							
							if (data == true) {
								flag=1;
								$('.abcv').css("display","none");
								$('#print').css("display","block");
							}else{
								
								alert("kindly enter captcha correctly");
								flag =0;
							}
		 },error : function(e) {
				console.log(e);
			}
				}); 	
			} 
		
		
}
}
 function collapseShow() {
    
    $('.abc').addClass("in");
    collapseDetails('td');
    collapseDetails('TD');
    collapseDetails('TRA');		
    collapseDetails('IIF');		
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
	
	if ($('.abc').attr('aria-expanded') === 'false') {
		$("#trainDetails").hide();
		$("#trainRA").hide();
		$("#trainATS").hide();
		$("#trainEE").hide();
		$("#trainPMU").hide();
		$("#trainIE").hide();
		$("#trainAF").hide();
		$("#trainDLS").hide();
		$("#trainPP").hide();
	    }
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
												var divTemplate = $("#collapse1Div");
												$("#collapse1Div").empty();
												var noOfPart =0;
												var funds =0;
												var additionlReq =0;
												var totalFunds =0;
												
												
												//$("#collapse2").text(activityName+" Finalize Work Location of "+$scope.selectDistrictCode.districtNameEnglish+" District");

												table = $("<table/>");
												table.attr("id", "table1");
												
												table
														.addClass("table table-hover table-bordered dashboard-task-infos table-responsive");

												thead = $("<thead/>");

												tr = $("<TR/>");

												th = createLabel("Training Category");
												
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("Training Subjects");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("Training Target Group");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("Venue Level");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("Mode Of Training");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("No. of Participants");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);
												th = createLabel("No.of Days");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("Unit Cost");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("Funds Proposed 	");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("Remarks");
												th.attr("style","background-color: #eeb2b2");
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
													noOfPart =noOfPart + +value1.column6;
													funds=funds + +value1.column9
													
													 if(value1.column13 != ''){
				                                          additionlReq= value1.column13;
			                                                   }
													
													
												});
												
												totalFunds  =funds  + +additionlReq;
												tbody.append(tr);
												table.append(tbody);
												var tdnext;
												 td = $("<TD/>");
												
												 td.attr('colspan',8);
												
												/*  td.attr('style','text-align:right;'); */
												 td.append("<label class='control-label'>Total no. of Participants</label>");
												 td.attr("style","background-color: #CCCEDF;");
												 tr.append(td);
												
												 tdnext = $("<td >"
															+ noOfPart+ "</td>");
												
												 tdnext.attr("id", "noOfPart");
												 tdnext.attr("style","background-color: #CCCEDF;font-weight:bold;text-align:right;");
												 tdnext.attr('colspan',2);
													tr.append(tdnext);
													
													
													
													
													tr.append(tdnext);
												 
												 tr = $("<TR/>");
												 tbody.append(tr);
													table.append(tbody);
													var tdnext;
													 td = $("<TD/>");
													
													 td.attr('colspan',8);
													
													/*  td.attr('style','text-align:right;'); */
													 td.append("<label class='control-label'>Total Funds</label>");
													 td.attr("style","background-color: #CCCEDF;");
													 tr.append(td);
													
													 tdnext = $("<td >"
																+ funds+ "</td>");
													
													 tdnext.attr("id", "noOfPart");
													 tdnext.attr("style","background-color: #CCCEDF;font-weight:bold; text-align:right;");
													 tdnext.attr('colspan',2);
														tr.append(tdnext);
														
														
														
														
														tr.append(tdnext);
													 
													 tr = $("<TR/>");
													 
													 tbody.append(tr);
														table.append(tbody);
														var tdnext;
														 td = $("<TD/>");
														
														 td.attr('colspan',8);
														
														/*  td.attr('style','text-align:right;'); */
														 td.append("<label class='control-label'>Additional Requirements</label>");
														 td.attr("style","background-color: #CCCEDF;");
														 tr.append(td);
														
														 tdnext = $("<td >"
																	+ additionlReq+ "</td>");
														
														 tdnext.attr("id", "noOfPart");
														 tdnext.attr("style","background-color: #CCCEDF;font-weight:bold;text-align:right;");
														 tdnext.attr('colspan',2);
															tr.append(tdnext);
															
															
															
															
															tr.append(tdnext);
														 
														 tr = $("<TR/>");
														 
														 
														 tbody.append(tr);
															table.append(tbody);
															var tdnext;
															 td = $("<TD/>");
															
															 td.attr('colspan',8);
															
															/*  td.attr('style','text-align:right;'); */
															 td.append("<label class='control-label'>Grand Total</label>");
															 td.attr("style","background-color: #CCCEDF;");
															 tr.append(td);
															
															 tdnext = $("<td >"
																		+ totalFunds+ "</td>");
															
															 tdnext.attr("id", "noOfPart");
															 tdnext.attr("style","background-color: #CCCEDF;font-weight:bold;text-align:right;");
															 tdnext.attr('colspan',2);
																tr.append(tdnext);
																
																
																
																
																tr.append(tdnext);
															 
															 tr = $("<TR/>");
															 
												
												divTemplate.append(table);
												

											} else if (key == "6") {
												var divTemplate = $("#collapseDIV8");
												$("#trainPP").show();
												$("#collapseDIV8").empty();
												//$("#collapse2").text(activityName+" Finalize Work Location of "+$scope.selectDistrictCode.districtNameEnglish+" District");

													  var funds =0;
		                                              var additionlReq =0;
		                                               var totalFunds =0;

												table = $("<table/>");
												table.attr("id", "table8");
												table
														.addClass("table table-hover table-bordered dashboard-task-infos table-responsive");

												thead = $("<thead/>");

												tr = $("<TR/>");

												th = createLabel("Designation");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("No. of Units  ");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("Unit Cost per month (in Rs) ");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("No. of Months   ");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("Funds (in Rs)");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("Remarks");
												th.attr("style","background-color: #eeb2b2");
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
													
													
													funds=funds + +value1.column5
													
													 if(value1.column6 != '' || value1.column6 ==null){
				                                          additionlReq= value1.column6;
			                                                   }
												});

											
												totalFunds  =funds  + +additionlReq;
												
													
													tr.append(tdnext);
												 
												 tr = $("<TR/>");
												 tbody.append(tr);
													table.append(tbody);
													var tdnext;
													 td = $("<TD/>");
													
													 td.attr('colspan',5);
													
													/*  td.attr('style','text-align:right;'); */
													 td.append("<label class='control-label'>Total Funds</label>");
													 td.attr("style","background-color: #CCCEDF;");
													 tr.append(td);
													
													 tdnext = $("<td >"
																+ funds+ "</td>");
													
													 tdnext.attr("id", "noOfPart");
													 tdnext.attr("style","background-color: #CCCEDF;font-weight:bold; text-align:right;");
													 tdnext.attr('colspan',2);
														tr.append(tdnext);
														
														
														
														
														tr.append(tdnext);
													 
													 tr = $("<TR/>");
													 
													 tbody.append(tr);
														table.append(tbody);
														var tdnext;
														 td = $("<TD/>");
														
														 td.attr('colspan',5);
														
														/*  td.attr('style','text-align:right;'); */
														 td.append("<label class='control-label'>Additional Requirements</label>");
														 td.attr("style","background-color: #CCCEDF;");
														 tr.append(td);
														
														 tdnext = $("<td >"
																	+ additionlReq+ "</td>");
														
														 tdnext.attr("id", "noOfPart");
														 tdnext.attr("style","background-color: #CCCEDF;font-weight:bold;text-align:right;");
														 tdnext.attr('colspan',2);
															tr.append(tdnext);
															
															
															
															
															tr.append(tdnext);
														 
														 tr = $("<TR/>");
														 
														 
														 tbody.append(tr);
															table.append(tbody);
															var tdnext;
															 td = $("<TD/>");
															
															 td.attr('colspan',5);
															
															/*  td.attr('style','text-align:right;'); */
															 td.append("<label class='control-label'>Grand Total</label>");
															 td.attr("style","background-color: #CCCEDF;");
															 tr.append(td);
															
															 tdnext = $("<td >"
																		+ totalFunds+ "</td>");
															
															 tdnext.attr("id", "noOfPart");
															 tdnext.attr("style","background-color: #CCCEDF;font-weight:bold;text-align:right;");
															 tdnext.attr('colspan',2);
																tr.append(tdnext);
																
																
															
												divTemplate.append(table);
												
											} else if (key == "11") {
												
												var divTemplate = $("#collapseDIV14");
												  var funds =0;
	                                              var additionlReq =0;
	                                            
												$("#collapseDIV14").empty();
												//$("#collapse2").text(activityName+" Finalize Work Location of "+$scope.selectDistrictCode.districtNameEnglish+" District");
                                            $("#trainEE").show();
												table = $("<table/>");
												table.attr("id", "table6");
												table
														.addClass("table table-hover table-bordered dashboard-task-infos table-responsive");

												thead = $("<thead/>");

												tr = $("<TR/>");

												th = createLabel("Nature of the IEC Activity");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("Amount Proposed");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("Remarks");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												
												thead.append(tr);

												table.append(thead);

												tbody = $("<tbody/>");
												tr = $("<TR/>");
												
												 $.each(value, function(key1,
															value1) {

												 tbody.append(tr);
													table.append(tbody);
													var tdnext;
													 td = $("<TD/>");
													
													
													/*  td.attr('style','text-align:right;'); */
													/*  td.append("<label class='control-label'>Additional Requirements</label>");
													 td.attr("style","background-color: #CCCEDF;");
													 tr.append(td);
													 */
													 tdnext = $("<td >"
																+ value1.column1+ "</td>");
													
													 tdnext.attr("id", "noOfPart");
													 tdnext.attr("style","font-weight:bold;text-align:left;");
													
														tr.append(tdnext);
												
														 tbody.append(tr);
															table.append(tbody);
															var tdnext;
															 td = $("<TD/>");
															
															
															/*  td.attr('style','text-align:right;'); */
															/*  td.append("<label class='control-label'>Additional Requirements</label>");
															 td.attr("style","background-color: #CCCEDF;");
															 tr.append(td);
														 */	
															 tdnext = $("<td >"
																		+ value1.column2+ "</td>");
															
															 tdnext.attr("id", "noOfPart");
															 tdnext.attr("style","font-weight:bold;text-align:right;");
															
																tr.append(tdnext);
														
																 tbody.append(tr);
																	table.append(tbody);
																	
																	var tdnext;
																	 td = $("<TD/>");
																	
																	
																	/*  td.attr('style','text-align:right;'); */
															/* 		 td.append("<label class='control-label'>Additional Requirements</label>");
																	 td.attr("style","background-color: #CCCEDF;");
																	 tr.append(td);
																	
															 */		 tdnext = $("<td >"
																				+ value1.column3+ "</td>");
																	
																	 tdnext.attr("id", "noOfPart");
																	 tdnext.attr("style","font-weight:bold;text-align:right;");
																	
																		tr.append(tdnext);
																
																		 tr = $("<TR/>");
																		 tbody.append(tr);
																			table.append(tbody);
																			var tdnext;
																			 td = $("<TD/>");
																			
																			 td.attr('colspan',1);
																			
																			/*  td.attr('style','text-align:right;'); */
																			 td.append("<label class='control-label'>Total Proposed Funds</label>");
																			 td.attr("style","background-color: #CCCEDF;");
																			 tr.append(td);
																			
																			 tdnext = $("<td >"
																						+ value1.column2+ "</td>");
																			
																			 tdnext.attr("id", "noOfPart");
																			 tdnext.attr("style","background-color: #CCCEDF;font-weight:bold; text-align:right;");
																			 tdnext.attr('colspan',2);
																				tr.append(tdnext);
																		
														divTemplate.append(table);
												/* $.each(value, function(key1,
														value1) {

													$('#Remarks').val(
															value1.column3);
													$('#total').val(
															value1.column2);
													// $('#natureActivity').val(value.column1);
													//alert(value1.column1);
													$('#natureActivity').val(
															value1.column1);
												}); */});
											} 
											
											
											
											
											else if (key == "5") {
												var divTemplate = $("#collapseDIV6");
												  var funds =0;
	                                              var additionlReq =0;
	                                            
												$("#collapseDIV6").empty();
												//$("#collapse2").text(activityName+" Finalize Work Location of "+$scope.selectDistrictCode.districtNameEnglish+" District");
                                              $("#trainEE").show();
												table = $("<table/>");
												table.attr("id", "table6");
												table
														.addClass("table table-hover table-bordered dashboard-task-infos table-responsive");

												thead = $("<thead/>");

												tr = $("<TR/>");

												th = createLabel("E-infrastructure Resource");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("No. of G.Ps ");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("No. of Aspirational Gps");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("Unit Cost(in Rs.)  ");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("Funds (in Rs)   ");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("Remarks");
												th.attr("style","background-color: #eeb2b2");
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
													funds=funds + +value1.column6
													
													 if(value1.column7 != ''){
				                                          additionlReq= value1.column7;
			                                                   }
												
												});
												
												 tr = $("<TR/>");
												 
												 tbody.append(tr);
													table.append(tbody);
													var tdnext;
													 td = $("<TD/>");
													
													 td.attr('colspan',4);
													
													/*  td.attr('style','text-align:right;'); */
													 td.append("<label class='control-label'>Additional Requirements</label>");
													 td.attr("style","background-color: #CCCEDF;");
													 tr.append(td);
													
													 tdnext = $("<td >"
																+ additionlReq+ "</td>");
													
													 tdnext.attr("id", "noOfPart");
													 tdnext.attr("style","background-color: #CCCEDF;font-weight:bold;text-align:right;");
													 tdnext.attr('colspan',2);
														tr.append(tdnext);
														
													
												 
												 tr = $("<TR/>");
												 tbody.append(tr);
													table.append(tbody);
													var tdnext;
													 td = $("<TD/>");
													
													 td.attr('colspan',4);
													
													/*  td.attr('style','text-align:right;'); */
													 td.append("<label class='control-label'>Total Funds</label>");
													 td.attr("style","background-color: #CCCEDF;");
													 tr.append(td);
													
													 tdnext = $("<td >"
																+ funds+ "</td>");
													
													 tdnext.attr("id", "noOfPart");
													 tdnext.attr("style","background-color: #CCCEDF;font-weight:bold; text-align:right;");
													 tdnext.attr('colspan',2);
														tr.append(tdnext);
														
														
														
														
														tr.append(tdnext);
													 
													
															
												
												divTemplate.append(table);

											} else if (key == "13") {
												var divTemplate = $("#collapseDIV2");
												$("#trainRA").show();
												$("#collapseDIV2").empty();
												//$("#collapse2").text(activityName+" Finalize Work Location of "+$scope.selectDistrictCode.districtNameEnglish+" District");

                                              var funds =0;
                                              var additionlReq =0;
                                               var totalFunds =0;

												table = $("<table/>");
												table.attr("id", "table2");
												table
														.addClass("table table-hover table-bordered dashboard-task-infos table-responsive");

												thead = $("<thead/>");

												tr = $("<TR/>");

												th = createLabel("Activity");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("No. of Days");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("No. of Units");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("Unit Cost(In Rs)");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("Funds Proposed(In Rs) ");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("Collaboration with Institute");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);
												th = createLabel("Remarks");
												th.attr("style","background-color: #eeb2b2");
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
													if(value1.column4 == '0'){
														tdnext = $("<td>"
																+ '1'
																+ "</td>");
													}else{
														tdnext = $("<td>"
																+ value1.column4
																+ "</td>");
													}
													
													tr.append(tdnext);
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
													
													
													funds=funds + +value1.column5
													
													 if(value1.column6 != ''){
				                                          additionlReq= value1.column6;
			                                                   }
												
												});
												
												totalFunds  =funds  + +additionlReq;
												
													
													tr.append(tdnext);
												 
												 tr = $("<TR/>");
												 tbody.append(tr);
													table.append(tbody);
													var tdnext;
													 td = $("<TD/>");
													
													 td.attr('colspan',5);
													
													/*  td.attr('style','text-align:right;'); */
													 td.append("<label class='control-label'>Total Funds</label>");
													 td.attr("style","background-color: #CCCEDF;");
													 tr.append(td);
													
													 tdnext = $("<td >"
																+ funds+ "</td>");
													
													 tdnext.attr("id", "noOfPart");
													 tdnext.attr("style","background-color: #CCCEDF;font-weight:bold; text-align:right;");
													 tdnext.attr('colspan',2);
														tr.append(tdnext);
														
														
														
														
														tr.append(tdnext);
													 
													 tr = $("<TR/>");
													 
													 tbody.append(tr);
														table.append(tbody);
														var tdnext;
														 td = $("<TD/>");
														
														 td.attr('colspan',5);
														
														/*  td.attr('style','text-align:right;'); */
														 td.append("<label class='control-label'>Additional Requirements</label>");
														 td.attr("style","background-color: #CCCEDF;");
														 tr.append(td);
														
														 tdnext = $("<td >"
																	+ additionlReq+ "</td>");
														
														 tdnext.attr("id", "noOfPart");
														 tdnext.attr("style","background-color: #CCCEDF;font-weight:bold;text-align:right;");
														 tdnext.attr('colspan',2);
															tr.append(tdnext);
															
															
															
															
															tr.append(tdnext);
														 
														 tr = $("<TR/>");
														 
														 
														 tbody.append(tr);
															table.append(tbody);
															var tdnext;
															 td = $("<TD/>");
															
															 td.attr('colspan',5);
															
															/*  td.attr('style','text-align:right;'); */
															 td.append("<label class='control-label'>Grand Total</label>");
															 td.attr("style","background-color: #CCCEDF;");
															 tr.append(td);
															
															 tdnext = $("<td >"
																		+ totalFunds+ "</td>");
															
															 tdnext.attr("id", "noOfPart");
															 tdnext.attr("style","background-color: #CCCEDF;font-weight:bold;text-align:right;");
															 tdnext.attr('colspan',2);
																tr.append(tdnext);
																
																
																
																
																tr.append(tdnext);
															 
															 tr = $("<TR/>");
															 
												divTemplate.append(table);
											

											} else if (key == "3") {
												var divTemplate = $("#collapsediv4");

												$("#collapsediv4").empty();
												var divTemplate1 = $("#collapseSP4");

												$("#collapseSP4").empty();
											
												//$("#collapse2").text(activityName+" Finalize Work Location of "+$scope.selectDistrictCode.districtNameEnglish+" District");
                                              /*  $("#collapse4").append("<br><label>New Building</label>"); */
													
													var additionlReq =0;
													var totalFunds =0;
													
												table = $("<table/>");
												table.attr("id", "table4");
												table
														.addClass("table table-hover table-bordered dashboard-task-infos table-responsive");
                                                 
												thead = $("<thead/>");
												thead5 = $("<thead/>");
												 var cap =$("<caption/>");
												  var span =$("<span />");
												  span.attr("style","color: #fff;font-weight:bold;font-size:18px;");
												  cap.append(span);
												  span.append("NEW BUILDING");
													cap.attr("style","background-color: #5AAA5A; color: #fff;text-align:center;");
												/* th = createLabel("New Building");
												th.attr("style","background-color: #5AAA5A; color: #fff;");
												tr5.append(th);
												thead5.append(tr5);
 */
												table.append(cap);
												
												tr = $("<TR/>");

												th = createLabel("Activities");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("No. of G.Ps");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);
												
												th = createLabel("No. of Aspirational GPs selected selected ");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("Unit Cost (in Rs) ");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("Funds (in Rs)");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("Remarks");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												thead.append(tr);

												table.append(thead);
												
												tbody = $("<tbody/>");
													tr = $("<TR/>");
												$.each(value, function(key1,
														value1) {
													tbody.append(tr);
													table.append(tbody);
                                              if(value1.column10 <4){
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
															+ value1.column9
															+ "</td>");
													tr.append(tdnext);

													tr = $("<TR/>");
                                              if(value1.column2 != ''){
	                                          additionlReq= value1.column2;
                                                   }
													
													
													totalFunds =totalFunds + +value1.column4;
               }
												});

												
														tr.append(tdnext);
													 
																					
															
												
												
												
												divTemplate.append(table);
												
												var total_car =0
												var total =0;
												table1 = $("<table/>");
												table1.attr("id", "table5");
												table1
														.addClass("table table-hover table-bordered dashboard-task-infos table-responsive");

												thead1 = $("<thead/>");
												thead6 = $("<thead/>");
												tr6 = $("<TR/>");
												  var cap =$("<caption/>");
												  var span =$("<span />");
												  span.attr("style","color: #fff;font-weight:bold;font-size:18px;");
												  cap.append(span);
												  span.append("CARRY FORWARD");
													cap.attr("style","background-color: #5AAA5A; color: #fff;text-align:center;");
													
												/* th = createLabel("Carry Forward");
												th.attr("style","background-color: #5AAA5A; color: #fff;");
												 *//* tr6.append(cap);
												thead6.append(tr6);
 */
												table1.append(cap);
												
												tr = $("<TR/>");

												th = createLabel("Activities");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);
	
												
												
												th = createLabel("Fund Sanctioned ");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("Fund Released ");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("Fund Utilized");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

											
											
												th = createLabel("Funds (in Rs)");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												
												thead1.append(tr);
												
												
												table1.append(thead1);
												
												tbody2 = $("<tbody/>");
													tr = $("<TR/>");
												$.each(value, function(key1,
														value1) {
													tbody2.append(tr);
													table1.append(tbody2);
													if(value1.column10 >3){
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
												
													tr = $("<TR/>");
	
													
													total_car =total_car + +value1.column4;
													}
												});
                                            total =total_car + +totalFunds + +additionlReq;
												divTemplate1.append(table1);
												 tr = $("<TR/>");
												 
												 tbody2.append(tr);
													table.append(tbody2);
													var tdnext;
													 td = $("<TD/>");
													
													 td.attr('colspan',3);
													
													/*  td.attr('style','text-align:right;'); */
													 td.append("<label class='control-label'>Additional Requirements (New Building)</label>");
													 td.attr("style","background-color: #CCCEDF;");
													 tr.append(td);
													
													 tdnext = $("<td >"
																+ additionlReq+ "</td>");
													
													 tdnext.attr("id", "noOfPart");
													 tdnext.attr("style","background-color: #CCCEDF;font-weight:bold;text-align:right;");
													 tdnext.attr('colspan',2);
														tr.append(tdnext);
														
														
														
														tr.append(tdnext);
														 
														 tr = $("<TR/>");
														 tbody2.append(tr);
															table1.append(tbody2);
															var tdnext;
															 td = $("<TD/>");
															
															 td.attr('colspan',3);
															
															/*  td.attr('style','text-align:right;'); */
															 td.append("<label class='control-label'>Total Proposed Fund </label>");
															 td.attr("style","background-color: #CCCEDF;");
															 tr.append(td);
															
															 tdnext = $("<td >"
																		+ total+  "</td>");
															
															 tdnext.attr("id", "noOfPart");
															 tdnext.attr("style","background-color: #CCCEDF;font-weight:bold; text-align:right;");
															 tdnext.attr('colspan',2);
																tr.append(tdnext);
																
									
											} else if (key == "4") {
												var divTemplate = $("#collapseDIV5");
												$("#trainATS").show();
												$("#collapseDIV5").empty();
												//$("#collapse2").text(activityName+" Finalize Work Location of "+$scope.selectDistrictCode.districtNameEnglish+" District");
                                           		 
													
													var funds =0;
													var additionlReq =0;
													var totalFunds =0;
													
												table = $("<table/>");
												table.attr("id", "table5");
												table
														.addClass("table table-hover table-bordered dashboard-task-infos table-responsive");

												thead = $("<thead/>");

												tr = $("<TR/>");

												th = createLabel("Post Type");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("Post Name");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("Level");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("No. of Block(s) ");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("Unit Cost");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("No. of Months ");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("Funds  ");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("Remarks  ");
												th.attr("style","background-color: #eeb2b2");
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
													tdnext = $("<td>"
															+ value1.column9
															+ "</td>");
													
												
													tr.append(tdnext);

													tr = $("<TR/>");
													count ++;
													
														funds=funds + +value1.column7
														 if(value1.column8 != ''){
					                                          additionlReq= value1.column8;
				                                                   }
														
														
												
												});

												totalFunds  =funds  + +additionlReq;
												tbody.append(tr);
												table.append(tbody);
												var tdnext;
												 td = $("<TD/>");
												
												 td.attr('colspan',6);
												
												/*  td.attr('style','text-align:right;'); */
												 td.append("<label class='control-label'>Additional Requirements</label>");
												 td.attr("style","background-color: #CCCEDF;");
												 tr.append(td);
												
												 tdnext = $("<td >"
															+ additionlReq+ "</td>");
												
												 tdnext.attr("id", "noOfPart");
												 tdnext.attr("style","background-color: #CCCEDF;font-weight:bold;text-align:right;");
												 tdnext.attr('colspan',2);
													tr.append(tdnext);
													
													
													
													
													tr.append(tdnext);
												 
												 tr = $("<TR/>");
												 tbody.append(tr);
													table.append(tbody);
													var tdnext;
													 td = $("<TD/>");
													
													 td.attr('colspan',6);
													
													/*  td.attr('style','text-align:right;'); */
													 td.append("<label class='control-label'>Total Funds</label>");
													 td.attr("style","background-color: #CCCEDF;");
													 tr.append(td);
													
													 tdnext = $("<td >"
																+ funds+ "</td>");
													
													 tdnext.attr("id", "noOfPart");
													 tdnext.attr("style","background-color: #CCCEDF;font-weight:bold; text-align:right;");
													 tdnext.attr('colspan',6);
														tr.append(tdnext);
														
														
														
														
														tr.append(tdnext);
													 
													 tr = $("<TR/>");
													 
													 tbody.append(tr);
														table.append(tbody);
														var tdnext;
														 td = $("<TD/>");
														
														 td.attr('colspan',6);
														
														/*  td.attr('style','text-align:right;'); */
														 td.append("<label class='control-label'>Grand Total</label>");
														 td.attr("style","background-color: #CCCEDF;");
														 tr.append(td);
														
														 tdnext = $("<td >"
																	+ totalFunds+ "</td>");
														
														 tdnext.attr("id", "noOfPart");
														 tdnext.attr("style","background-color: #CCCEDF;font-weight:bold;text-align:right;");
														 tdnext.attr('colspan',2);
															tr.append(tdnext);
															
															
												divTemplate.append(table);
											
											}

											else if (key == "8") {
												var divTemplate = $("#collapseDIV10");
												$("#trainAF").show();
												$("#collapseDIV10").empty();
												//$("#collapse2").text(activityName+" Finalize Work Location of "+$scope.selectDistrictCode.districtNameEnglish+" District");
	                                                  var funds =0;
		                                              var additionlReq =0;
		                                               var totalFunds =0;

											
												table = $("<table/>");
												table.attr("id", "table10");
												table
														.addClass("table table-hover table-bordered dashboard-task-infos table-responsive");

												thead = $("<thead/>");

												tr = $("<TR/>");

												th = createLabel("Type of Center");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("Domain Experts");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("No of Staff proposed");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("Unit Cost");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("No. of Months");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("Funds (in Rs)");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("Remarks ");
												th.attr("style","background-color: #eeb2b2");
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
													funds=funds + +value1.column9
													 if(value1.column8 != ''){
				                                          additionlReq= value1.column8;
			                                                   }
													
											
												});
											
												totalFunds  =funds  + +additionlReq;
												
													
													tr.append(tdnext);
												 
												 tr = $("<TR/>");
												 tbody.append(tr);
													table.append(tbody);
													var tdnext;
													 td = $("<TD/>");
													
													 td.attr('colspan',5);
													
													/*  td.attr('style','text-align:right;'); */
													 td.append("<label class='control-label'>Total Funds</label>");
													 td.attr("style","background-color: #CCCEDF;");
													 tr.append(td);
													
													 tdnext = $("<td >"
																+ funds+ "</td>");
													
													 tdnext.attr("id", "noOfPart");
													 tdnext.attr("style","background-color: #CCCEDF;font-weight:bold; text-align:right;");
													 tdnext.attr('colspan',2);
														tr.append(tdnext);
														
														
														
														
														tr.append(tdnext);
													 
													 tr = $("<TR/>");
													 
													 tbody.append(tr);
														table.append(tbody);
														var tdnext;
														 td = $("<TD/>");
														
														 td.attr('colspan',5);
														
														/*  td.attr('style','text-align:right;'); */
														 td.append("<label class='control-label'>Additional Requirements</label>");
														 td.attr("style","background-color: #CCCEDF;");
														 tr.append(td);
														
														 tdnext = $("<td >"
																	+ additionlReq+ "</td>");
														
														 tdnext.attr("id", "noOfPart");
														 tdnext.attr("style","background-color: #CCCEDF;font-weight:bold;text-align:right;");
														 tdnext.attr('colspan',2);
															tr.append(tdnext);
															
															
															
															
															tr.append(tdnext);
														 
														 tr = $("<TR/>");
														 
														 
														 tbody.append(tr);
															table.append(tbody);
															var tdnext;
															 td = $("<TD/>");
															
															 td.attr('colspan',5);
															
															/*  td.attr('style','text-align:right;'); */
															 td.append("<label class='control-label'>Grand Total</label>");
															 td.attr("style","background-color: #CCCEDF;");
															 tr.append(td);
															
															 tdnext = $("<td >"
																		+ totalFunds+ "</td>");
															
															 tdnext.attr("id", "noOfPart");
															 tdnext.attr("style","background-color: #CCCEDF;font-weight:bold;text-align:right;");
															 tdnext.attr('colspan',2);
																tr.append(tdnext);
																
														
												divTemplate.append(table);
												
											}  if (key == "10") {
												var divTemplate = $("#collapseDIV13");
												$("#trainIE").show();
												$("#collapseDIV13").empty();
												//$("#collapse2").text(activityName+" Finalize Work Location of "+$scope.selectDistrictCode.districtNameEnglish+" District");
		                                              var funds =0;
		                                              var additionlReq =0;
		                                               var totalFunds =0;

											
												table = $("<table/>");
												table.attr("id", "table13");
												table
														.addClass("table table-hover table-bordered dashboard-task-infos table-responsive");

												thead = $("<thead/>");

												tr = $("<TR/>");

												th = createLabel("Name of the Activity");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("Select Scheme");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("District Name");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("Block Name");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("Total No. of GP's Covered 	");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("No. of Aspirational GPs");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("From ");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);
												th = createLabel("To ");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);
												th = createLabel("Total cost of project ");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);
												th = createLabel("Funds Proposed in current year ");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);
												th = createLabel("Brief about the Activity");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);
												th = createLabel("Remarks ");
												th.attr("style","background-color: #eeb2b2");
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
															+ value1.column12
															+ "</td>");
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column14
															+ "</td>");
													tr.append(tdnext);

													tr = $("<TR/>");
													count++;
													funds=funds + +value1.column10
													
													 if(value1.column13 != ''){
				                                          additionlReq= value1.column13;
			                                                   }
													
											
												});
											
												totalFunds  =funds  + +additionlReq;
												
													
													tr.append(tdnext);
												 
												 tr = $("<TR/>");
												 tbody.append(tr);
													table.append(tbody);
													var tdnext;
													 td = $("<TD/>");
													
													 td.attr('colspan',10);
													
													/*  td.attr('style','text-align:right;'); */
													 td.append("<label class='control-label'>Total Funds</label>");
													 td.attr("style","background-color: #CCCEDF;");
													 tr.append(td);
													
													 tdnext = $("<td >"
																+ funds+ "</td>");
													
													 tdnext.attr("id", "noOfPart");
													 tdnext.attr("style","background-color: #CCCEDF;font-weight:bold; text-align:right;");
													 tdnext.attr('colspan',2);
														tr.append(tdnext);
														
														
														
														
														tr.append(tdnext);
													 
													 tr = $("<TR/>");
													 
													 tbody.append(tr);
														table.append(tbody);
														var tdnext;
														 td = $("<TD/>");
														
														 td.attr('colspan',10);
														
														/*  td.attr('style','text-align:right;'); */
														 td.append("<label class='control-label'>Additional Requirements</label>");
														 td.attr("style","background-color: #CCCEDF;");
														 tr.append(td);
														
														 tdnext = $("<td >"
																	+ additionlReq+ "</td>");
														
														 tdnext.attr("id", "noOfPart");
														 tdnext.attr("style","background-color: #CCCEDF;font-weight:bold;text-align:right;");
														 tdnext.attr('colspan',2);
															tr.append(tdnext);
															
															
															
															
															tr.append(tdnext);
														 
														 tr = $("<TR/>");
														 
														 
														 tbody.append(tr);
															table.append(tbody);
															var tdnext;
															 td = $("<TD/>");
															
															 td.attr('colspan',10);
															
															/*  td.attr('style','text-align:right;'); */
															 td.append("<label class='control-label'>Grand Total</label>");
															 td.attr("style","background-color: #CCCEDF;");
															 tr.append(td);
															
															 tdnext = $("<td >"
																		+ totalFunds+ "</td>");
															
															 tdnext.attr("id", "noOfPart");
															 tdnext.attr("style","background-color: #CCCEDF;font-weight:bold;text-align:right;");
															 tdnext.attr('colspan',2);
																tr.append(tdnext);
													
												divTemplate.append(table);
												
											}  if (key == "12") {
												var divTemplate = $("#collapseDIV15");
												 
												$("#trainPMU").show();
												$("#collapseDIV15").empty();
												//$("#collapse2").text(activityName+" Finalize Work Location of "+$scope.selectDistrictCode.districtNameEnglish+" District");
                                                var totalFunds =0;
												table = $("<table/>");
												table.attr("id", "table15");
												table
														.addClass("table table-hover table-bordered dashboard-task-infos table-responsive");

												thead = $("<thead/>");

												tr = $("<TR/>");

												th = createLabel("Type of Center");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("Faculty and Staff");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("No. of Units");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("No. of Months");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("Funds (in Rs) 	");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("Remarks");
												th.attr("style","background-color: #eeb2b2");
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
															+ value1.column9
															+ "</td>");
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column7
															+ "</td>");
													tr.append(tdnext);
												
													count ++;
													   totalFunds = totalFunds + +value1.column9;
											
													tr = $("<TR/>");
														});
												tr.append(tdnext);
												 
												 tr = $("<TR/>");
												 tbody.append(tr);
													table.append(tbody);
													var tdnext;
													 td = $("<TD/>");
													
													 td.attr('colspan',4);
													
													/*  td.attr('style','text-align:right;'); */
													 td.append("<label class='control-label'>Total Funds</label>");
													 td.attr("style","background-color: #CCCEDF;");
													 tr.append(td);
													
													 tdnext = $("<td >"
																+ totalFunds+ "</td>");
													
													 tdnext.attr("id", "noOfPart");
													 tdnext.attr("style","background-color: #CCCEDF;font-weight:bold; text-align:right;");
													 tdnext.attr('colspan',2);
														tr.append(tdnext);
														
														
												divTemplate.append(table);
											
											}
											else if (key == "7") {
												var divTemplate = $("#collapseDIV9");
												
												$("#trainDLS").show();
												$("#collapseDIV9").empty();
												//$("#collapse2").text(activityName+" Finalize Work Location of "+$scope.selectDistrictCode.districtNameEnglish+" District");
	                                                     var funds =0;
		                                              var additionlReq =0;
		                                               var totalFunds =0;

												table = $("<table/>");
												table.attr("id", "table9");
												table
														.addClass("table table-hover table-bordered dashboard-task-infos table-responsive");

												thead = $("<thead/>");

												tr = $("<TR/>");

												th = createLabel("Name of the Activity");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("Panchayat Level");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("No. of Units");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("Unit Cost (in Rs)");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("Fund Proposed (in Rs)");
												th.attr("style","background-color: #eeb2b2");
												
												tr.append(th);

												th = createLabel("Remarks");
												th.attr("style","background-color: #eeb2b2");
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
													tr.append(tdnext);
													tr = $("<TR/>");
													
													count ++;
												
													funds=funds + +value1.column5
													
													 if(value1.column8 != ''){
				                                          additionlReq= value1.column8;
			                                                   }
												});
												
												totalFunds  =funds  + +additionlReq;
												
													
													tr.append(tdnext);
												 
												 tr = $("<TR/>");
												 tbody.append(tr);
													table.append(tbody);
													var tdnext;
													 td = $("<TD/>");
													
													 td.attr('colspan',4);
													
													/*  td.attr('style','text-align:right;'); */
													 td.append("<label class='control-label'>Total Funds</label>");
													 td.attr("style","background-color: #CCCEDF;");
													 tr.append(td);
													
													 tdnext = $("<td >"
																+ funds+ "</td>");
													
													 tdnext.attr("id", "noOfPart");
													 tdnext.attr("style","background-color: #CCCEDF;font-weight:bold; text-align:right;");
													 tdnext.attr('colspan',2);
														tr.append(tdnext);
														
														
														
														
														tr.append(tdnext);
													 
													 tr = $("<TR/>");
													 
													 tbody.append(tr);
														table.append(tbody);
														var tdnext;
														 td = $("<TD/>");
														
														 td.attr('colspan',4);
														
														/*  td.attr('style','text-align:right;'); */
														 td.append("<label class='control-label'>Additional Requirements</label>");
														 td.attr("style","background-color: #CCCEDF;");
														 tr.append(td);
														
														 tdnext = $("<td >"
																	+ additionlReq+ "</td>");
														
														 tdnext.attr("id", "noOfPart");
														 tdnext.attr("style","background-color: #CCCEDF;font-weight:bold;text-align:right;");
														 tdnext.attr('colspan',2);
															tr.append(tdnext);
															
															
															
															
															tr.append(tdnext);
														 
														 tr = $("<TR/>");
														 
														 
														 tbody.append(tr);
															table.append(tbody);
															var tdnext;
															 td = $("<TD/>");
															
															 td.attr('colspan',4);
															
															/*  td.attr('style','text-align:right;'); */
															 td.append("<label class='control-label'>Grand Total</label>");
															 td.attr("style","background-color: #CCCEDF;");
															 tr.append(td);
															
															 tdnext = $("<td >"
																		+ totalFunds+ "</td>");
															
															 tdnext.attr("id", "noOfPart");
															 tdnext.attr("style","background-color: #CCCEDF;font-weight:bold;text-align:right;");
															 tdnext.attr('colspan',2);
																tr.append(tdnext);
																
																
														
												divTemplate.append(table);
												
											}
											else if (key == "14") {
												var divTemplate = $("#collapsediv12");
												  var spmuAdd =0;
													var dpmuAdd =0;
													var spmufund =0;
													var dpmuFund =0;
													var totalFunds =0;
										
												$("#collapsediv12").empty();
												//$("#collapse2").text(activityName+" Finalize Work Location of "+$scope.selectDistrictCode.districtNameEnglish+" District");

												table = $("<table/>");
												table.attr("id", "table12");
												table
														.addClass("table table-hover table-bordered dashboard-task-infos table-responsive");

												thead = $("<thead/>");

												tr = $("<TR/>");

												th = createLabel("Type of Center");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("Faculty and Staff");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("No. of Units");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("No. of Months");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("Funds (in Rs)");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("Remarks");
												th.attr("style","background-color: #eeb2b2");
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
													tdnext.attr("id", "expenditureSPRC_"+key1);
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column8
															+ "</td>");
													tr.append(tdnext);
													tr = $("<TR/>");
                                   
												  
												if(value1.column9 == 2){
													if(value1.column12 != null){
														spmuAdd = value1.column12;
														
													}
													
													spmufund =spmufund + +value1.column7;
												}if(value1.column9 == 4){
													if(value1.column10 != null){
														spmuAdd = value1.column12;
														dpmuAdd= value1.column10;
														
													}
													
													dpmuFund =dpmuFund + +value1.column7;
												}
									
                                     	count++
                                  
												});
											
												totalFunds  =spmufund  + +dpmuFund + +spmuAdd + +dpmuAdd;
												tbody.append(tr);
												table.append(tbody);
												var tdnext;
												 td = $("<TD/>");
												
												 td.attr('colspan',5);
												
												/*  td.attr('style','text-align:right;'); */
												 td.append("<label class='control-label'>Total SPRC Fund</label>");
												 td.attr("style","background-color: #CCCEDF;");
												 tr.append(td);
												
												 tdnext = $("<td >"
															+ spmufund+ "</td>");
												
												 tdnext.attr("id", "noOfPart");
												 tdnext.attr("style","background-color: #CCCEDF;font-weight:bold;text-align:right;");
												 tdnext.attr('colspan',2);
													tr.append(tdnext);
													
													
													
													
													tr.append(tdnext);
												 
												 tr = $("<TR/>");
												 tbody.append(tr);
													table.append(tbody);
													var tdnext;
													 td = $("<TD/>");
													
													 td.attr('colspan',5);
													
													/*  td.attr('style','text-align:right;'); */
													 td.append("<label class='control-label'>Total DPRC Fund</label>");
													 td.attr("style","background-color: #CCCEDF;");
													 tr.append(td);
													
													 tdnext = $("<td >"
																+ dpmuFund+ "</td>");
													
													 tdnext.attr("id", "noOfPart");
													 tdnext.attr("style","background-color: #CCCEDF;font-weight:bold; text-align:right;");
													 tdnext.attr('colspan',2);
														tr.append(tdnext);
														
														
														
														
														tr.append(tdnext);
													 
													 tr = $("<TR/>");
													 
													 tbody.append(tr);
														table.append(tbody);
														var tdnext;
														 td = $("<TD/>");
														
														 td.attr('colspan',5);
														
														/*  td.attr('style','text-align:right;'); */
														 td.append("<label class='control-label'>SPRC Additional  Requirements</label>");
														 td.attr("style","background-color: #CCCEDF;");
														 tr.append(td);
														
														 tdnext = $("<td >"
																	+ spmuAdd+ "</td>");
														
														 tdnext.attr("id", "noOfPart");
														 tdnext.attr("style","background-color: #CCCEDF;font-weight:bold;text-align:right;");
														 tdnext.attr('colspan',2);
															tr.append(tdnext);
															
															
															
															
															tr.append(tdnext);
														 
														 tr = $("<TR/>");
														 
														 
														 tbody.append(tr);
															table.append(tbody);
															var tdnext;
															 td = $("<TD/>");
															
															 td.attr('colspan',5);
															
															/*  td.attr('style','text-align:right;'); */
															 td.append("<label class='control-label'>DPRC Additional Requirement</label>");
															 td.attr("style","background-color: #CCCEDF;");
															 tr.append(td);
															
															 tdnext = $("<td >"
																		+ dpmuAdd+ "</td>");
															
															 tdnext.attr("id", "noOfPart");
															 tdnext.attr("style","background-color: #CCCEDF;font-weight:bold;text-align:right;");
															 tdnext.attr('colspan',2);
																tr.append(tdnext);
																
																
																
																
																tr.append(tdnext);
																 tr = $("<TR/>");
																 
																 
																 tbody.append(tr);
																	table.append(tbody);
																	var tdnext;
																	 td = $("<TD/>");
																	
																	 td.attr('colspan',5);
																	
																	/*  td.attr('style','text-align:right;'); */
																	 td.append("<label class='control-label'>Total Proposed Fund</label>");
																	 td.attr("style","background-color: #CCCEDF;");
																	 tr.append(td);
																	
																	 tdnext = $("<td >"
																				+ totalFunds+ "</td>");
																	
																	 tdnext.attr("id", "noOfPart");
																	 tdnext.attr("style","background-color: #CCCEDF;font-weight:bold;text-align:right;");
																	 tdnext.attr('colspan',2);
																		tr.append(tdnext);
																		
																		
																		
																		
																		tr.append(tdnext);
																	 
																		
												divTemplate.append(table);

											}
											
											else if (key == "15") {
												var divTemplate = $("#collapseDIV7");
                                              var count =0; 
												$("#collapseDIV7").empty();
												//$("#collapse2").text(activityName+" Finalize Work Location of "+$scope.selectDistrictCode.districtNameEnglish+" District");
                                                   var spmuAdd =0;
													var dpmuAdd =0;
													var spmufund =0;
													var dpmuFund =0;
													var totalFunds =0;
												table = $("<table/>");
												table.attr("id", "table7");
												table
														.addClass("table table-hover table-bordered dashboard-task-infos table-responsive");

												thead = $("<thead/>");

												tr = $("<TR/>");

												th = createLabel("Level");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("Designation");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("No. of Posts proposed");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("No. of Months");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("Unit Cost(in Rs)");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);
												th = createLabel("Fund Proposed (in Rs)");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);
												
												th = createLabel("Remarks");
												th.attr("style","background-color: #eeb2b2");
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
													if(value1.column12 ==1){
														if(value1.column9 !=''){
														spmuAdd =value1.column9;
														}
														spmufund =spmufund + +value1.column7;
													
													}if(value1.column12 ==2){
														if(value1.column10 !=''){
															dpmuAdd=value1.column10;
															}
														
														dpmuFund =dpmuFund + +value1.column7;
														
													}
												
													count++;
												});
											
												totalFunds  =spmufund  + +dpmuFund + +spmuAdd + +dpmuAdd;
												tbody.append(tr);
												table.append(tbody);
												var tdnext;
												 td = $("<TD/>");
												
												 td.attr('colspan',5);
												
												/*  td.attr('style','text-align:right;'); */
												 td.append("<label class='control-label'>Total SPMU Fund</label>");
												 td.attr("style","background-color: #CCCEDF;");
												 tr.append(td);
												
												 tdnext = $("<td >"
															+ spmufund+ "</td>");
												
												 tdnext.attr("id", "noOfPart");
												 tdnext.attr("style","background-color: #CCCEDF;font-weight:bold;text-align:right;");
												 tdnext.attr('colspan',2);
													tr.append(tdnext);
													
													
													
													
													tr.append(tdnext);
												 
												 tr = $("<TR/>");
												 tbody.append(tr);
													table.append(tbody);
													var tdnext;
													 td = $("<TD/>");
													
													 td.attr('colspan',5);
													
													/*  td.attr('style','text-align:right;'); */
													 td.append("<label class='control-label'>Total DPMU Fund</label>");
													 td.attr("style","background-color: #CCCEDF;");
													 tr.append(td);
													
													 tdnext = $("<td >"
																+ dpmuFund+ "</td>");
													
													 tdnext.attr("id", "noOfPart");
													 tdnext.attr("style","background-color: #CCCEDF;font-weight:bold; text-align:right;");
													 tdnext.attr('colspan',2);
														tr.append(tdnext);
														
														
														
														
														tr.append(tdnext);
													 
													 tr = $("<TR/>");
													 
													 tbody.append(tr);
														table.append(tbody);
														var tdnext;
														 td = $("<TD/>");
														
														 td.attr('colspan',5);
														
														/*  td.attr('style','text-align:right;'); */
														 td.append("<label class='control-label'>SPMU Additional  Requirements</label>");
														 td.attr("style","background-color: #CCCEDF;");
														 tr.append(td);
														
														 tdnext = $("<td >"
																	+ spmuAdd+ "</td>");
														
														 tdnext.attr("id", "noOfPart");
														 tdnext.attr("style","background-color: #CCCEDF;font-weight:bold;text-align:right;");
														 tdnext.attr('colspan',2);
															tr.append(tdnext);
															
															
															
															
															tr.append(tdnext);
														 
														 tr = $("<TR/>");
														 
														 
														 tbody.append(tr);
															table.append(tbody);
															var tdnext;
															 td = $("<TD/>");
															
															 td.attr('colspan',5);
															
															/*  td.attr('style','text-align:right;'); */
															 td.append("<label class='control-label'>DPMU Additional Requirement</label>");
															 td.attr("style","background-color: #CCCEDF;");
															 tr.append(td);
															
															 tdnext = $("<td >"
																		+ dpmuAdd+ "</td>");
															
															 tdnext.attr("id", "noOfPart");
															 tdnext.attr("style","background-color: #CCCEDF;font-weight:bold;text-align:right;");
															 tdnext.attr('colspan',2);
																tr.append(tdnext);
																
																
																
																
																tr.append(tdnext);
																 tr = $("<TR/>");
																 
																 
																 tbody.append(tr);
																	table.append(tbody);
																	var tdnext;
																	 td = $("<TD/>");
																	
																	 td.attr('colspan',5);
																	
																	/*  td.attr('style','text-align:right;'); */
																	 td.append("<label class='control-label'>Total Proposed Fund</label>");
																	 td.attr("style","background-color: #CCCEDF;");
																	 tr.append(td);
																	
																	 tdnext = $("<td >"
																				+ totalFunds+ "</td>");
																	
																	 tdnext.attr("id", "noOfPart");
																	 tdnext.attr("style","background-color: #CCCEDF;font-weight:bold;text-align:right;");
																	 tdnext.attr('colspan',2);
																		tr.append(tdnext);
																		
																		
																		
																		
																		tr.append(tdnext);
																	 
																		
																		
																	 tr = $("<TR/>");
												divTemplate.append(table);

											}
	                                      if (key == "2") {
												
												
												var divTemplate = $("#collapseDIV3");
												$("#collapseDIV3").empty();
												var addNsprc =0;
												var addNdprc =0;
												var sfundN =0;
												var sfundC =0;
												var grandTotal =0;
												
												
												//$("#collapse2").text(activityName+" Finalize Work Location of "+$scope.selectDistrictCode.districtNameEnglish+" District");

												table = $("<table/>");
												table.attr("id", "table1");
												
												table
														.addClass("table table-hover table-bordered dashboard-task-infos table-responsive");

												thead = $("<thead/>");

												tr = $("<TR/>");

											
												
												th = createLabel("Building Type");
												
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("District");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("Fund Sanctioned");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("Fund Released");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("Fund Utilized");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("Fund Required");
												th.attr("style","background-color: #eeb2b2");
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
															+ value1.column5
															+ "</td>");
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column10
															+ "</td>");
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column7
															+ "</td>");
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column12
															+ "</td>");
													tr.append(tdnext);
													tdnext = $("<td>"
															+ value1.column9
															+ "</td>");
													
													tr.append(tdnext);
													tr = $("<TR/>");
													count ++;
													
													
													var sfundN =0;
													var sfundC =0;
													var grandTotal =0;
													
													sfundN =sfundN + +value1.column3;
													sfundC=sfundC + +value1.column9
													addNsprc =addNsprc + +value1.column13;
													addNdprc =addNdprc + +value1.column14;
													 
													
													
												});
												
												totalFunds  =sfundN  + +sfundC + +addNsprc + +addNdprc;
												tbody.append(tr);
												table.append(tbody);
												var tdnext;
												 td = $("<TD/>");
												
												 td.attr('colspan',4);
												
												/*  td.attr('style','text-align:right;'); */
												 td.append("<label class='control-label'>Additional Requirement (SPRC)</label>");
												 td.attr("style","background-color: #CCCEDF;");
												 tr.append(td);
												
												 tdnext = $("<td >"
															+ addNsprc+ "</td>");
												
												 tdnext.attr("id", "noOfPart");
												 tdnext.attr("style","background-color: #CCCEDF;font-weight:bold;text-align:right;");
												 tdnext.attr('colspan',2);
													tr.append(tdnext);
													
													
													
													
													tr.append(tdnext);
												 
												 tr = $("<TR/>");
												 tbody.append(tr);
													table.append(tbody);
													var tdnext;
													 td = $("<TD/>");
													
													 td.attr('colspan',4);
													
													/*  td.attr('style','text-align:right;'); */
													 td.append("<label class='control-label'>Additional Requirement (DPRC)</label>");
													 td.attr("style","background-color: #CCCEDF;");
													 tr.append(td);
													
													 tdnext = $("<td >"
																+ addNdprc+ "</td>");
													
													 tdnext.attr("id", "noOfPart");
													 tdnext.attr("style","background-color: #CCCEDF;font-weight:bold; text-align:right;");
													 tdnext.attr('colspan',2);
														tr.append(tdnext);
														
														
														
														
														tr.append(tdnext);
													 
													 tr = $("<TR/>");
													 
													 tbody.append(tr);
														table.append(tbody);
														var tdnext;
														 td = $("<TD/>");
														
														 td.attr('colspan',4);
														
														/*  td.attr('style','text-align:right;'); */
														 td.append("<label class='control-label'>Total Proposed Fund (New Building (SPRC) +New Building (DPRC))</label>");
														 td.attr("style","background-color: #CCCEDF;");
														 tr.append(td);
														
														 tdnext = $("<td >"
																	+ sfundN+ "</td>");
														
														 tdnext.attr("id", "noOfPart");
														 tdnext.attr("style","background-color: #CCCEDF;font-weight:bold;text-align:right;");
														 tdnext.attr('colspan',2);
															tr.append(tdnext);
															
															
															
															
															tr.append(tdnext);
														 
														 tr = $("<TR/>");
														 
														 
														 tbody.append(tr);
															table.append(tbody);
															var tdnext;
															 td = $("<TD/>");
															
															 td.attr('colspan',4);
															
															/*  td.attr('style','text-align:right;'); */
															 td.append("<label class='control-label'>Total Proposed Fund (Carry Forward (SPRC) +Carry Forward (DPRC))</label>");
															 td.attr("style","background-color: #CCCEDF;");
															 tr.append(td);
															
															 tdnext = $("<td >"
																		+ sfundC+ "</td>");
															
															 tdnext.attr("id", "noOfPart");
															 tdnext.attr("style","background-color: #CCCEDF;font-weight:bold;text-align:right;");
															 tdnext.attr('colspan',2);
																tr.append(tdnext);
																 tr = $("<TR/>");
																
																 tbody.append(tr);
																	table.append(tbody);
																	var tdnext;
																	 td = $("<TD/>");
																	
																	 td.attr('colspan',4);
																	
																	/*  td.attr('style','text-align:right;'); */
																	 td.append("<label class='control-label'>Grand Total</label>");
																	 td.attr("style","background-color: #CCCEDF;");
																	 tr.append(td);
																	
																	 tdnext = $("<td >"
																				+ totalFunds+ "</td>");
																	
																	 tdnext.attr("id", "noOfPart");
																	 tdnext.attr("style","background-color: #CCCEDF;font-weight:bold;text-align:right;");
																	 tdnext.attr('colspan',2);
																		tr.append(tdnext);
																		
																						
																		tr.append(tdnext);
																
															 
															 tr = $("<TR/>");
															 
												
												divTemplate.append(table);
												

											}if (key == "9") {
												var divTemplate = $("#collapsedIV11");
												
												$("#collapsedIV11").empty();
												//$("#collapse2").text(activityName+" Finalize Work Location of "+$scope.selectDistrictCode.districtNameEnglish+" District");
		                                              var funds =0;
		                                              var additionlReq =0;
		                                               var totalFunds =0;

											
												table = $("<table/>");
												table.attr("id", "table13");
												table
														.addClass("table table-hover table-bordered dashboard-task-infos table-responsive");

												thead = $("<thead/>");

												tr = $("<TR/>");

												th = createLabel("Name of the Activity");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("Funds (in Rs)");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("Brief about the Activity");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("From");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("To");
												th.attr("style","background-color: #eeb2b2");
												tr.append(th);

												th = createLabel("Remarks");
												th.attr("style","background-color: #eeb2b2");
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
															+ value1.column7
															+ "</td>");
													tr.append(tdnext);
													
													tr = $("<TR/>");
													count++;
													funds=funds + +value1.column2
													
													 if(value1.column6 != ''){
				                                          additionlReq= value1.column6;
			                                                   }
											
												});
											
												totalFunds  =funds  + +additionlReq;
												
													
													tr.append(tdnext);
												 
												 tr = $("<TR/>");
												 tbody.append(tr);
													table.append(tbody);
													var tdnext;
													 td = $("<TD/>");
													
													 td.attr('colspan',4);
													
													/*  td.attr('style','text-align:right;'); */
													 td.append("<label class='control-label'>Total Funds</label>");
													 td.attr("style","background-color: #CCCEDF;");
													 tr.append(td);
													
													 tdnext = $("<td >"
																+ funds+ "</td>");
													
													 tdnext.attr("id", "noOfPart");
													 tdnext.attr("style","background-color: #CCCEDF;font-weight:bold; text-align:right;");
													 tdnext.attr('colspan',2);
														tr.append(tdnext);
														
														
														
														
														tr.append(tdnext);
													 
													 tr = $("<TR/>");
													 
													 tbody.append(tr);
														table.append(tbody);
														var tdnext;
														 td = $("<TD/>");
														
														 td.attr('colspan',4);
														
														/*  td.attr('style','text-align:right;'); */
														 td.append("<label class='control-label'>Additional Requirements</label>");
														 td.attr("style","background-color: #CCCEDF;");
														 tr.append(td);
														
														 tdnext = $("<td >"
																	+ additionlReq+ "</td>");
														
														 tdnext.attr("id", "noOfPart");
														 tdnext.attr("style","background-color: #CCCEDF;font-weight:bold;text-align:right;");
														 tdnext.attr('colspan',2);
															tr.append(tdnext);
															
															
															
															
															tr.append(tdnext);
														 
														 tr = $("<TR/>");
														 
														 
														 tbody.append(tr);
															table.append(tbody);
															var tdnext;
															 td = $("<TD/>");
															
															 td.attr('colspan',4);
															
															/*  td.attr('style','text-align:right;'); */
															 td.append("<label class='control-label'>Grand Total</label>");
															 td.attr("style","background-color: #CCCEDF;");
															 tr.append(td);
															
															 tdnext = $("<td >"
																		+ totalFunds+ "</td>");
															
															 tdnext.attr("id", "noOfPart");
															 tdnext.attr("style","background-color: #CCCEDF;font-weight:bold;text-align:right;");
															 tdnext.attr('colspan',2);
																tr.append(tdnext);
													
												divTemplate.append(table);
												
											}
											
										});
					},
					error : function(e) {
						console.log(e);
					}
				});

	}
												
		
	function refreshCaptcha()
	{
		  $('#img_Capatcha').attr('src', 'captchaImage?cache=' + new Date().getTime());
	    $('#captchaAnswer').val('');
	    $('#captchaAnswer').focus();
	}
	function exportToPdf(id) {
		
		  
		  var today = new Date();
		  var dd = String(today.getDate()).padStart(2, '0');
		  var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
		  var yyyy = today.getFullYear();

		  today = mm + '/' + dd + '/' + yyyy;
		 
		
	if(userType == 'M'){
		 var stateName = $('#selectSLC').find('option:selected').text();
		 var finYear = '${FIN_YEAR}';
		 var header = 'Annual Plan Report of  '+ stateName + '  for '+ finYear;
		
		}
	else if(userType == 'S'){
			var finYear = '${FIN_YEAR}';
			var state = '${STATE.stateNameEnglish}';
		 var header = 'Annual Plan Report of  ' + state + ' for '+ finYear;
		}
		else{
			 var stateName = $('#selectSLC').find('option:selected').text();
			 var finYear = $('#selectFin').find('option:selected').text();
			 var header = 'Annual Plan Report of   '+ stateName +  ' for  '  +finYear;
		}
		
	

	 var stateName = $('#selectSLC').find('option:selected').text();
	   
		
		var sTable =$('#'+id).html();
		
		var style = "<style>";
		var style1 = "<style>";

		
		 var cap =$("<caption/>");
		  var span =$("<span />");
		  span.attr("style","color: #fff;font-weight:bold;font-size:18px;");
		  cap.append(span);
		 
			
		/* th = createLabel("New Building");
		th.attr("style","background-color: #5AAA5A; color: #fff;");
		tr5.append(th);
		thead5.append(tr5);
*/

    
		style = style + "table,th,td{border: solid 1px black;border-collapse: collapse;}";
		       style = style +"thead {color : black; background-color: #e87b7b;";
		       style = style + "</style>";

		  var win = window.open('', '', 'height=1000,width=1000');
		   win.document.write('<html><head>');
		   /* win.document.write('<title>'+header+'</title>'); */  
		   win.document.write('<h3 style="border: 4px solid black;text-align:center">'+ header+ '</h3>');  
		   win.document.write(style);
		   win.document.write('</head>');
		   win.document.write('<body>');
		   win.document.write(sTable);  
		   win.document.write('<h5 style=" margin-left: 35%">  https://rgsa.nic.in  </h5>');  
		    win.document.write('<h5 style=" margin-left: 15%"> Report Generated on '+today+' and Data is updated & managed by State Departments  </h5>'); 
		    win.document.write('<h5 style=" margin-left: 35%"> Rashtriya Gram Swaraj Abhiyan </h5>'); 
		  
		   win.document.write('</body></html>');
		  win.document.close();
		  win.print();    
		}
</script> 

<section class="content">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="table-responsive">
				<div class="col-lg-12">
				<div class="card">
					<div class="header">
						
						<c:choose>
						<c:when test="${user_type eq 'S'}">     
						<h3 style="padding-top: 25px;">&nbsp;&nbsp; Action Plan Report of <c:out value=" ${STATE.stateNameEnglish}"></c:out> for <c:out value="${FIN_YEAR}"></c:out> </h3> 
						</c:when>
						   
						<c:when test="${user_type eq 'M'}">
					<h3 style="padding-top: 25px;">&nbsp;&nbsp; Action Plan Report  <label id="stateSelect" ></label>  <c:out value="${FIN_YEAR}"></c:out> </h3> 
						</c:when>
						<c:otherwise>
						<h3 style="padding-top: 25px;">&nbsp;&nbsp; Action Plan Report  <label id="stateSelect" ></label>  <label id="finSelect" ></label> </h3> 
						</c:otherwise>
						
						</c:choose>
						
					</div>
					<br />
					<%-- <form:form method="post" name="" action=""> --%>
						
					
							<div class="">
                            <div id="print">

								<main>
								<article class="panel-group bs-accordion" id="accordion"
									role="tablist" aria-multiselectable="true">
									<div id="printElement">
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
										
										
										<div id="collapse1" 
											class="panel-collapse collapse abc "
											role="tabpanel"  aria-labelledby="heading1">
											<div class="panel-body">
											<div id="collapse1Div"></div>	
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
											role="tabpanel" aria-labelledby="heading2">
											<div class="panel-body">
											<div id="collapseDIV2"></div>
											</div>
										</div>
									</section>
									<section class="panel panel-default xxx">
										<div class="panel-heading" role="tab" id="heading3"
											onclick="collapseDetails('IIF');">
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
												<div id="collapseDIV3"></div>
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
												

											<div  id="collapsediv4"></div>
											<div  id="collapseSP4"></div>
										</div></div>
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
											<div class="panel-body">
											<div id="collapseDIV5" ></div>
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
											role="tabpanel" aria-labelledby="heading6">
											<div class="panel-body">
											<div id="collapseDIV6"></div>
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
												
											
											<div id="collapseDIV7"></div>
										</div></div>
									</section>
									<section class="panel panel-default xxx">
										<div class="panel-heading" role="tab" id="heading8"
											onclick="collapseDetails('PP');">
											<h4 class="panel-title">
												<a class="collapsed" role="button" data-toggle="collapse"
													data-parent="#accordion" href="#collapse8"
													aria-expanded="false" aria-controls="collapse8"> PESA
													Plan <span
													class="glyphicon glyphicon-chevron-right pull-right"
													aria-hidden="true"></span>
												</a>
											</h4>
										</div>
										<div id="collapse8" class="panel-collapse collapse abc"
											role="tabpanel" aria-labelledby="heading8">
											<div class="panel-body">
											<div id="collapseDIV8"></div>
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
												
											
										<div id="collapseDIV9"></div>
									
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
												<div id="collapseDIV10"></div>
											
									
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
												<div ID="collapsedIV11"></div>
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
										<div class="" >
										<div id="collapse12"  class="panel-collapse collapse abc"
											role="tabpanel" aria-labelledby="heading12">
											 <div class="panel-body">
										<div id="collapsediv12"></div>
										
										 	</div>
										</div>
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
						                  <div class="panel-body">
										<div id="collapseDIV13"></div>
										
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
											<div class="panel-body">
											<div id="collapseDIV14"></div>
											<div class="container">
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
											<div class="panel-body">
											<div id="collapseDIV15" ></div>
										
											
										</div>
										</div>
									</section>
								</div>
								<div class="text-right">
										<button  type="button"   class="btn bg-green waves-effect"  onclick="collapseShow();">Expand all</button>

										<button  type="button" class="btn bg-red waves-effect" id=collapse_hide onclick="collapseHide();">Collapse all</button>
										 <button type="button" class="btn bg-primary waves-effect"
										id="exportButtonId"
										onclick="exportToPdf('printElement')"><span class="glyphicon glyphicon-print"></span> Print
										File</button> 
								</div>
									
									</article>
								</main>
								</div>
							</div>
							
						<div class=" abcv">
                        <div class="container">
                          <div class="body">
							<div class="row ">
							
							<c:if test="${showFin}">
									<div class="col-md-3">
							
							
									<label class="control-label" > Financial year : </label>
										<select name="" id="selectFin" onchange="getStateList();"
											
											class="form-control">
											<option value="0">--Select--</option>
											<c:forEach items="${FIN_YEAR_LIST}" var="year">
												<option value="${year.yearId}">${year.finYear}</option>
											</c:forEach> 
										</select>
									</div>
									
							</c:if>
								
							
							<c:if test="${ShowState}">
								<c:if test="${user_type ne 'M'}">
								<div class="col-md-3">
										<label class="control-label" > State: </label>
										<select name="" id="selectSLC" 
											class="form-control">
											<%-- <option value="0">--Select--</option>
											<c:forEach items="${stateList}" var="slc">
												<option value="${slc.stateCode}">${slc.stateNameEnglish}</option>
											</c:forEach> --%>
										</select>
								</div>
								</c:if>
								<c:if test="${user_type eq 'M'}">
								<div class="col-md-3">
										<label class="control-label" > State: </label>
										<select name="" id="selectSLC" 
											class="form-control">
											 <option value="0">--Select--</option>
											<c:forEach items="${stateList}" var="slc">
												<option value="${slc.stateCode}">${slc.stateNameEnglish}</option>
											</c:forEach> 
										</select>
								</div>
								</c:if>
								</c:if>
							 <c:if test="${showFin}"> 
							 <div class="col-md-3">
											<label class="control-label" > Please enter Capatcha: </label>
								<input cssStyle="color:black;" id="captchaAnswer"  placeholder="Captcha Answer" class="form-control"  autocomplete="off" required="required"/>
								
							<div class="col-sm-2">  
									<img src="captchaImage" width="208px" id="img_Capatcha" /></div>
									<div class="col-sm-10">
									 <i class="fa fa-refresh pull-right" onclick="refreshCaptcha()"></i>
								
									
							</div>
							</div>
							 </c:if> 
							<c:if test="${ShowState}">
								
							<div class="col-md-3" style="margin-top:2%; text-align:right; ">
							 <button class="btn btn-primary" type="button" onclick="getformDetail();"> Get Detail</button>
							</div>
							
							</c:if>
							</div>
							</div>
							
							</div>
							</div>
						<c:choose>
							<c:when test="${user_type eq 'S' || user_type eq 'M'}">
								<div class="text-left">
									<button type="button"
										onclick="onClose('actionPlanPhysicalReport.html?<csrf:token uri='actionPlanPhysicalReport.html'/>&stateCode=0')"
										class="btn bg-orange waves-effect">
										<i class="fa fa-arrow-left" aria-hidden="true"></i>
										<spring:message code="Label.BACK" htmlEscape="true" />
									</button>
									<br />
								</div>
							</c:when>
							<c:otherwise>
								<div class="text-left">
									<button type="button"
										onclick="onClose('index.html?<csrf:token uri='index.html'/>')"
										class="btn bg-orange waves-effect">
										<i class="fa fa-arrow-left" aria-hidden="true"></i>
										<spring:message code="Label.BACK" htmlEscape="true" />
									</button>
									<br />
								</div>
							</c:otherwise>
						</c:choose>
					</div>
							
						</div>
						</div>
						
						</div> 
						
					<%-- </form:form> --%>
				</div>
			</div>
		</div>
		</div>
	
</section>

<script>

		</script>