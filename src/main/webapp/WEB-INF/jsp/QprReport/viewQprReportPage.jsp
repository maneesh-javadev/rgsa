<html>
<head>
<%@include file="../taglib/taglib.jsp"%>
 

	
	<script type="text/javascript">
	 function ajaxCallFunction(detailId){
		 $("#tableExp").hide();
		  var statecode=$("#inputState").val();
		  var yearId=$("#inputFinYear").val();
		  var quarterId=$("#quarterId").val();
		  if(statecode=='-1' && yearId=='-1' && quarterId=='-1' )
			  {
			  alert("Please Select all Dependent DropDown Value!");
			  return false;
			  } 
		  
		  $("#tableExp").show();
		 $.ajax({
			   type : "POST",
			   contentType : "application/json",
			   url : "qprReportDetails.html?<csrf:token uri='qprReportDetails.html'/>&statecode="+statecode+"&yearId="+yearId+"&quarterId="+quarterId,
			   dataType : 'json',
			   cache : false,
			   timeout : 100000,
			   success : function(data) {
				   $.each( data, function(key,valueList){
					  // console.log("key = " + key + " valueList = " + valueList);
						if(key=='Training_Activities_Progress_Report'){
							  var tableBody='';
							   tableBody+= '<thead style="background-color: #eeb2b2">';
							   tableBody+= '<td><b>S.No.<b></td>';
							   tableBody+= '<td><b> Activity Name </b></td>';
							   tableBody+= '<td><b>No. Of Unit Proposed</b></td>';
							   tableBody+= '<td><b>Fund Proposed </b></td>';
							   tableBody+= '<td><b>No. of Days Completed </b></td>';
							   tableBody+= '<td><b>No. of Units Completed </b></td>';
							   tableBody+= '<td><b>Expenditure Incurred </b></td>';
							   tableBody+= '</thead>';
								   for (var key1 in valueList) {
									   //console.log(">>>"+valueList.length);
									    var slno=parseInt(key1)+1;
									    if(valueList.length==slno){
									    	// tableBody+='<tr style="background-color: #dbd0d0">';
									    	tableBody+='<tr>';
									    }else{
										    tableBody+='<tr>';
								   			}
									    tableBody+='<td>'+ slno +  '</td>';
									   $.each( valueList[key1], function(key2,listVal){
										    //console.log("key2 = " + key2 + " listVal = " + listVal); 
										    	tableBody+='<td>'+ listVal +  '</td>';
									   })
									   tableBody+='</tr>';
									}
								   $("#trainingActivityId").html(tableBody);
							  }
							if(key=='Training_Details_Progress_Report'){
								var tableBody='';
								   tableBody+= '<thead style="background-color: #eeb2b2">';
								   tableBody+= '<td><b>S.No.<b></td>';
								   tableBody+= '<td><b> Training Category </b></td>';
								   tableBody+= '<td><b>Training Subjects</b></td>';
								   tableBody+= '<td><b>Venue Level </b></td>';
								   tableBody+= '<td><b>Total Participants </b></td>';
								   tableBody+= '<td><b>Approved Amount </b></td>';
								   tableBody+= '<td><b>Expenditure Incurred </b></td>';
								   tableBody+= '</thead>';
									   for (var key1 in valueList) {
										   //console.log(">>>"+valueList.length);
										    var slno=parseInt(key1)+1;
											    tableBody+='<tr>';
										    	tableBody+='<td>'+ slno +  '</td>';
											   $.each( valueList[key1], function(key2,listVal){
												    //console.log("key2 = " + key2 + " listVal = " + listVal); 
												    	tableBody+='<td>'+ listVal +  '</td>';
											   })
											   tableBody+='</tr>';
										}
									   $("#trainingDetailsId").html(tableBody);
								  }
							if(key=='Additional_Faculty_Maintenance_SPRC_DPRC'){
								var tableBody='';
								   tableBody+= '<thead style="background-color: #eeb2b2">';
								   tableBody+= '<td><b>S.No.<b></td>';
								   tableBody+= '<td><b> Type of Center </b></td>';
								   tableBody+= '<td><b>Faculty and Staff</b></td>';
								   tableBody+= '<td><b>No of Units Approved </b></td>';
								   tableBody+= '<td><b>Fund Sanctioned </b></td>';
								   tableBody+= '<td><b>No. of Unit Filled </b></td>';
								   tableBody+= '<td><b>Expenditure Incurred </b></td>';
								   tableBody+= '</thead>';
									   for (var key1 in valueList) {
										   //console.log(">>>"+valueList.length);
										    var slno=parseInt(key1)+1;
											    tableBody+='<tr>';
										    	tableBody+='<td>'+ slno +  '</td>';
											   $.each( valueList[key1], function(key2,listVal){
												    //console.log("key2 = " + key2 + " listVal = " + listVal); 
												    	tableBody+='<td>'+ listVal +  '</td>';
											   })
											   tableBody+='</tr>';
										}
									   $("#hrSupportSprc").html(tableBody);               
								  }
							if(key=='e_Governance_Support_Group'){
								var tableBody='';
								   tableBody+= '<thead style="background-color: #eeb2b2">';
								   tableBody+= '<td><b>S.No.<b></td>';
								   tableBody+= '<td><b> Level </b></td>';
								   tableBody+= '<td><b>Designation</b></td>';
								   tableBody+= '<td><b>No. of Posts approved </b></td>';
								   tableBody+= '<td><b>Unit Cost Approved (in Rs) </b></td>';
								   tableBody+= '<td><b>No of Post filled </b></td>';
								   tableBody+= '<td><b>Expenditure Incurred </b></td>';
								   tableBody+= '</thead>';
									   for (var key1 in valueList) {
										   //console.log(">>>"+valueList.length);
										    var slno=parseInt(key1)+1;
											    tableBody+='<tr>';
										    	tableBody+='<td>'+ slno +  '</td>';
											   $.each( valueList[key1], function(key2,listVal){
												    //console.log("key2 = " + key2 + " listVal = " + listVal); 
												    	tableBody+='<td>'+ listVal +  '</td>';
											   })
											   tableBody+='</tr>';
										}
									   $("#egov_SupportGrpId").html(tableBody);
								  }
							if(key=='pesa_Plan'){
								var tableBody='';
								   tableBody+= '<thead style="background-color: #eeb2b2">';
								   tableBody+= '<td><b>S.No.<b></td>';
								   tableBody+= '<td><b> Designation </b></td>';
								   tableBody+= '<td><b>No. of Units Approved </b></td>';
								   tableBody+= '<td><b>Fund sanctioned </b></td>';
								   tableBody+= '<td><b>No. of Units Completed </b></td>';
								   tableBody+= '<td><b>Expenditure Incurred </b></td>';
								   tableBody+= '</thead>';
									   for (var key1 in valueList) {
										   //console.log(">>>"+valueList.length);
										    var slno=parseInt(key1)+1;
											    tableBody+='<tr>';
										    	tableBody+='<td>'+ slno +  '</td>';
											   $.each( valueList[key1], function(key2,listVal){
												    //console.log("key2 = " + key2 + " listVal = " + listVal); 
												    	tableBody+='<td>'+ listVal +  '</td>';
											   })
											   tableBody+='</tr>';
										}
									   $("#pesa_PlanId").html(tableBody);
								  }
							
							if(key=='iecProgressReport'){
								var tableBody='';
								   tableBody+= '<thead style="background-color: #eeb2b2">';
								   tableBody+= '<td><b>S.No.<b></td>';
								   tableBody+= '<td><b> Nature of the IEC Activity </b></td>';
								   tableBody+= '<td><b>Total Amount Proposed</b></td>';
								   tableBody+= '<td><b> Expenditure Incurred </b></td>';
								   tableBody+= '</thead>';
									   for (var key1 in valueList) {
										   //console.log(">>>"+valueList.length);
										    var slno=parseInt(key1)+1;
											    tableBody+='<tr>';
										    	tableBody+='<td>'+ slno +  '</td>';
											   $.each( valueList[key1], function(key2,listVal){
												    //console.log("key2 = " + key2 + " listVal = " + listVal); 
												    	tableBody+='<td>'+ listVal +  '</td>';
											   })
											   tableBody+='</tr>';
										}
									   $("#iecProgressReportId").html(tableBody);
								  }
							
							if(key=='pmuProgressReport'){
								var tableBody='';
								   tableBody+= '<thead style="background-color: #eeb2b2">';
								   tableBody+= '<td><b>S.No.<b></td>';
								   tableBody+= '<td><b> Type of Center </b></td>';
								   tableBody+= '<td><b>Faculty and Staff</b></td>';
								   tableBody+= '<td><b> No. of Units Approved </b></td>';
								   tableBody+= '<td><b>Fund Sanctioned</b></td>';
								   tableBody+= '<td><b> No. of units completed/Persons involved </b></td>';
								   tableBody+= '<td><b> Expenditure Incurred </b></td>';
								   tableBody+= '</thead>';
									   for (var key1 in valueList) {
										   //console.log(">>>"+valueList.length);
										    var slno=parseInt(key1)+1;
											    tableBody+='<tr>';
										    	tableBody+='<td>'+ slno +  '</td>';
											   $.each( valueList[key1], function(key2,listVal){
												    //console.log("key2 = " + key2 + " listVal = " + listVal); 
												    	tableBody+='<td>'+ listVal +  '</td>';
											   })
											   tableBody+='</tr>';
										}
									   $("#pmuProgressReportId").html(tableBody);
								  }
							if(key=='panchyatbhawanProgressReport'){
								var tableBody='';
								   tableBody+= '<thead style="background-color: #eeb2b2">';
								   tableBody+= '<td><b>S.No.<b></td>';
								   tableBody+= '<td><b> Activity Type </b></td>';
								   tableBody+= '<td><b>Gram Panchayat</b></td>';
								   tableBody+= '<td><b> G.P Bhawan Status </b></td>';
								   tableBody+= '<td><b> Expenditure Incurred </b></td>';
								   tableBody+= '</thead>';
									   for (var key1 in valueList) {
										   //console.log(">>>"+valueList.length);
										    var slno=parseInt(key1)+1;
											    tableBody+='<tr>';
										    	tableBody+='<td>'+ slno +  '</td>';
											   $.each( valueList[key1], function(key2,listVal){
												    //console.log("key2 = " + key2 + " listVal = " + listVal); 
												    	tableBody+='<td>'+ listVal +  '</td>';
											   })
											   tableBody+='</tr>';
										}
									   $("#panchyatbhawanProgressReportId").html(tableBody);
								  }
							if(key=='administrativeAndTechnicalSupportId'){
								var tableBody='';
								   tableBody+= '<thead style="background-color: #eeb2b2">';
								   tableBody+= '<td><b>S.No.<b></td>';
								   tableBody+= '<td><b> Post Type </b></td>';
								   tableBody+= '<td><b>Post Name</b></td>';
								   tableBody+= '<td><b> No. Of Unit Approved </b></td>';
								   tableBody+= '<td><b>Unit Cost Approved</b></td>';
								   tableBody+= '<td><b> Fund Sanctioned </b></td>';
								   tableBody+= '<td><b> No. of Unit Filled </b></td>';
								   tableBody+= '<td><b> Expenditure Incurred </b></td>';
								   tableBody+= '</thead>';
									   for (var key1 in valueList) {
										   //console.log(">>>"+valueList.length);
										    var slno=parseInt(key1)+1;
											    tableBody+='<tr>';
										    	tableBody+='<td>'+ slno +  '</td>';
											   $.each( valueList[key1], function(key2,listVal){
												    //console.log("key2 = " + key2 + " listVal = " + listVal); 
												    	tableBody+='<td>'+ listVal +  '</td>';
											   })
											   tableBody+='</tr>';
										}
									   $("#adminAndTechSupportReportId").html(tableBody);
								  }
							if(key=='IncomeEnhancementId'){
								var tableBody='';
								   tableBody+= '<thead style="background-color: #eeb2b2">';
								   tableBody+= '<td><b>S.No.<b></td>';
								   tableBody+= '<td><b> Name of Activity </b></td>';
								   tableBody+= '<td><b>District Name</b></td>';
								   tableBody+= '<td><b>Fund Sanctioned </b></td>';
								   tableBody+= '<td><b>Expenditure incurred</b></td>';
								   tableBody+= '</thead>';
									   for (var key1 in valueList) {
										   //console.log(">>>"+valueList.length);
										    var slno=parseInt(key1)+1;
											    tableBody+='<tr>';
										    	tableBody+='<td>'+ slno +  '</td>';
											   $.each( valueList[key1], function(key2,listVal){
												    //console.log("key2 = " + key2 + " listVal = " + listVal); 
												    	tableBody+='<td>'+ listVal +  '</td>';
											   })
											   tableBody+='</tr>';
										}
									   $("#IncomeEnhancementId").html(tableBody);
								  }
							
							
							if(key=='SATCOMIP'){
								var tableBody='';
								   tableBody+= '<thead style="background-color: #eeb2b2">';
								   tableBody+= '<td><b>S.No.<b></td>';
								   tableBody+= '<td><b> Name of the Activity </b></td>';
								   tableBody+= '<td><b>Panchayat Level</b></td>';
								   tableBody+= '<td><b> No. Of Unit Approved </b></td>';
								   tableBody+= '<td><b>Unit Cost Approved</b></td>';
								   tableBody+= '<td><b> Fund Proposed  </b></td>';
								   tableBody+= '<td><b> No. of Persons Trained </b></td>';
								   tableBody+= '<td><b> Expenditure Incurred </b></td>';
								   tableBody+= '</thead>';
									   for (var key1 in valueList) {
										   //console.log(">>>"+valueList.length);
										    var slno=parseInt(key1)+1;
											    tableBody+='<tr>';
										    	tableBody+='<td>'+ slno +  '</td>';
											   $.each( valueList[key1], function(key2,listVal){
												    //console.log("key2 = " + key2 + " listVal = " + listVal); 
												    	tableBody+='<td>'+ listVal +  '</td>';
											   })
											   tableBody+='</tr>';
										}
									   $("#satcomipid").html(tableBody);
								  }
							if(key=='EenablementProgressReportId'){
								var tableBody='';
								   tableBody+= '<thead style="background-color: #eeb2b2">';
									   tableBody+= '<td><b>S.No.<b></td>';
									   tableBody+= '<td><b> GP Name </b></td>';
									   tableBody+= '<td><b>Amount Sanctioned</b></td>';
									   tableBody+= '<td><b> Expenditure Incurred(in Rs.)</b></td>';
									   tableBody+= '<td><b>Status</b></td>';
								   tableBody+= '</thead>';
									   for (var key1 in valueList) {
										   //console.log(">>>"+valueList.length);
										    var slno=parseInt(key1)+1;
											    tableBody+='<tr>';
										    	tableBody+='<td>'+ slno +  '</td>';
											   $.each( valueList[key1], function(key2,listVal){
												    //console.log("key2 = " + key2 + " listVal = " + listVal); 
												    	tableBody+='<td>'+ listVal +  '</td>';
											   })
											   tableBody+='</tr>';
										}
									   $("#eEnablementId").html(tableBody);
								  }
							if(key=='InstitutionalInfrastructureId'){
								var tableBody='';
								   tableBody+= '<thead style="background-color: #eeb2b2">';
									   tableBody+= '<td><b>S.No.<b></td>';
									   tableBody+= '<td><b> Type </b></td>';
									   tableBody+= '<td><b>District</b></td>';
									   tableBody+= '<td><b>Work Type </b></td>';
									   tableBody+= '<td><b>Institute Status</b></td>';
									   tableBody+= '<td><b>Approved Amount</b></td>';
									   tableBody+= '<td><b> Expenditure Incurred(in Rs.)</b></td>';
								   tableBody+= '</thead>';
									   for (var key1 in valueList) {
										   //console.log(">>>"+valueList.length);
										    var slno=parseInt(key1)+1;
											    tableBody+='<tr>';
										    	tableBody+='<td>'+ slno +  '</td>';
											   $.each( valueList[key1], function(key2,listVal){
												    //console.log("key2 = " + key2 + " listVal = " + listVal); 
												     
												    	tableBody+='<td>'+ listVal +  '</td>';
												   	  
												    	
											   })
											   tableBody+='</tr>';
										}
									   $("#InstitutionalInfrastructureId").html(tableBody);
								  }
							
				   })
			   },
			   error : function(e) {
			    console.log(e);
			   }
			  });
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
	
</head>
<section class="content">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12">
				<div class="card">
				 <div class="header">
							<h2>
								QPR Report
							</h2>
					 </div>
					<div class="body">
					
					 
					
					<div class="row">
					<div class="col-md-3">
					<label class="control-label" > Financial year : </label>
					<select class="form-control" id="inputFinYear" path=""  >
					<option value="-1">--Select--</option>
                                <c:forEach var="item" items="${FIN_YEAR_LIST}">
                                            <option value="${item.yearId}"> ${item.finYear} </option>
                                </c:forEach>
                            <select>
					</div>
					 
					 
					
					<div class="col-md-3">
					<label class="control-label" > State: </label>
					<select class="form-control" id="inputState"   >
						<option value="-1">--Select--</option>
                                 <c:forEach var="item" items="${STATE}">
                                            <option value="${item.stateCode}"> ${item.stateNameEnglish} </option>
                                </c:forEach>  
                            </select>
					</div>
					
					<div class="col-md-3">
					<label class="control-label" > Quarter Duration: </label>
					<select path="" class="form-control" id="quarterId">
					<option value="-1">--Select--</option>
					<c:forEach var="item" items="${QUARTER}">
                                            <option value="${item.qtrId}"> ${item.qtrDuration} </option>
                                </c:forEach>
					</select>
					</div>
					
					<div class="col-md-3" style="margin-top:2%">
					<button type="button" onclick="ajaxCallFunction();" class="btn btn-primary"><span class="glyphicon glyphicon-search"></span>&nbsp; Search</button>
					<button type="button" onclick="exportToPdf('tableExp');" class="btn btn-primary"><span class="glyphicon glyphicon-download"></span>&nbsp; Download</button>
					</div>
					
					</div><!--  row -->
					
				<div class="table-responsive" id="tableExp" style="width: auto; display:none">
 
	<div class="panel-group" id="accordion">
 	 
			   <div class="panel panel-default">
			    <div class="panel-heading">
			    <a data-toggle="collapse" data-parent="" href="#collapse1">
			      <h4 class="panel-title">
			        Training Activities
			      </h4>
			      </a>
			    </div>
				    <div id="collapse1" class="panel-collapse collapse in">
				      <div class="panel-body"> 
					     <table class="table table-bordered" id="trainingActivityId">  </table>
				      </div>
				    </div>
				  </div>
		  
  
		   <div class="panel panel-default">
		    <div class="panel-heading">
		     <a data-toggle="collapse" data-parent="" href="#collapse2">
		      <h4 class="panel-title">
		        Training Details Progress Report
		      </h4></a>
		    </div>
		    <div id="collapse2" class="panel-collapse collapse">
		      <div class="panel-body">
		      	<table class="table table-bordered" id="trainingDetailsId"> </table>
		      </div>
		    </div>
		  </div>
		   
   
  
  
		  <div class="panel panel-default">
		    <div class="panel-heading">
		     <a data-toggle="collapse" data-parent="" href="#collapse3">
		      <h4 class="panel-title">
		        Additional Faculty and Maintenance at SPRC and DPRC
		      </h4></a>
		    </div>
		    <div id="collapse3" class="panel-collapse collapse">
		      <div class="panel-body">
		      	<table class="table table-bordered" id="hrSupportSprc"></table>
		      </div>
		    </div>
		  </div>
		  
		   <div class="panel panel-default">
		    <div class="panel-heading">
		     <a data-toggle="collapse" data-parent="" href="#collapse5">
		      <h4 class="panel-title">
		       	e-Governance Support Group
		      </h4></a>
		    </div>
		    <div id="collapse5" class="panel-collapse collapse">
		      <div class="panel-body">
		      	<table class="table table-bordered" id="egov_SupportGrpId"></table>
		      </div>
		    </div>
		  </div>
		  
		  
		  
		  <div class="panel panel-default">
		    <div class="panel-heading">
		     <a data-toggle="collapse" data-parent="" href="#collapse6">
		      <h4 class="panel-title">
		       	PESA Plan
		      </h4></a>
		    </div>
		    <div id="collapse6" class="panel-collapse collapse">
		      <div class="panel-body">
		      	<table class="table table-bordered" id="pesa_PlanId"></table>
		      </div>
		    </div>
		  </div>


		<div class="panel panel-default">
				    <div class="panel-heading">
				     <a data-toggle="collapse" data-parent="" href="#collapse11">
				      <h4 class="panel-title">
				      	Distance learning Facility through SATCOM/IP based virtual Class room/similar technology
				      </h4></a>
				    </div>
				    <div id="collapse11" class="panel-collapse collapse">
				      <div class="panel-body">
				      	<table class="table table-bordered" id="satcomipid"></table>
				      </div>
				    </div>
				  </div>

				<div class="panel panel-default">
				    <div class="panel-heading">
				     <a data-toggle="collapse" data-parent="" href="#collapse12">
				      <h4 class="panel-title">
				      	Income Enhancement Quaterly Report
				      </h4></a>
				    </div>
				    <div id="collapse12" class="panel-collapse collapse">
				      <div class="panel-body">
				      	<table class="table table-bordered" id="IncomeEnhancementId"></table>
				      </div>
				    </div>
				  </div>


			<div class="panel panel-default">
		    <div class="panel-heading">
		     <a data-toggle="collapse" data-parent="" href="#collapse7">
		      <h4 class="panel-title">
		      	 Proposal for Information, Education, Communication (IEC) Progress Report
		      </h4></a>
		    </div>
		    <div id="collapse7" class="panel-collapse collapse">
		      <div class="panel-body">
		      	<table class="table table-bordered" id="iecProgressReportId"></table>
		      </div>
		    </div>
		  </div>
		  
		  <div class="panel panel-default">
		    <div class="panel-heading">
		     <a data-toggle="collapse" data-parent="" href="#collapse8">
		      <h4 class="panel-title">
		      	 PMU Progress Report
		      </h4></a>
		    </div>
		    <div id="collapse8" class="panel-collapse collapse">
		      <div class="panel-body">
		      	<table class="table table-bordered" id="pmuProgressReportId"></table>
		      </div>
		    </div>
		  </div>
		  
		  <div class="panel panel-default">
		    <div class="panel-heading">
		     <a data-toggle="collapse" data-parent="" href="#collapse9">
		      <h4 class="panel-title">
		      	 Administrative And Technical Support to Gram Panchayat
		      </h4></a>
		    </div>
		    <div id="collapse9" class="panel-collapse collapse">
		      <div class="panel-body">
		      	<table class="table table-bordered" id="adminAndTechSupportReportId"></table>
		      </div>
		    </div>
		  </div>
		  
		  
		  <div class="panel panel-default">
		    <div class="panel-heading">
		     <a data-toggle="collapse" data-parent="" href="#collapse10">
		      <h4 class="panel-title">
		      	 Panchayat Bhawan Progress Report
		      </h4></a>
		    </div>
		    <div id="collapse10" class="panel-collapse collapse">
		      <div class="panel-body">
		      	<table class="table table-bordered" id="panchyatbhawanProgressReportId"></table>
		      </div>
		    </div>
		  </div>
		  
		  
		  <div class="panel panel-default">
		    <div class="panel-heading">
		     <a data-toggle="collapse" data-parent="" href="#collapse13">
		      <h4 class="panel-title">
		       e-Enablement Quarter Progress Report
		      </h4></a>
		    </div>
		    <div id="collapse13" class="panel-collapse collapse">
		      <div class="panel-body">
		      	<table class="table table-bordered" id="eEnablementId"></table>
		      </div>
		    </div>
		  </div>
		  
		   <div class="panel panel-default">
		    <div class="panel-heading">
		     <a data-toggle="collapse" data-parent="" href="#collapse14">
		      <h4 class="panel-title">
		       Institutional Infrastructure
		      </h4></a>
		    </div>
		    <div id="collapse14" class="panel-collapse collapse">
		      <div class="panel-body">
		      	<table class="table table-bordered" id="InstitutionalInfrastructureId"></table>
		      </div>
		    </div>
		  </div>
		  
		  

</div> 


								</div>	 
 			 
					
	 
						 
					</div>
				</div>
			</div>
		</div>
	</div>
 </section>
</html>
