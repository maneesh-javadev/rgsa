<html>
<head>
<%@include file="../taglib/taglib.jsp"%>
 
<script type="text/javascript">
	
	function diabledQuarterFn(yearObj){
		yearId=$(yearObj).val();
		
		if(yearId==2 || yearId==3){
			$("#quarterId").val('-1');
			$('#quarterId').prop('disabled',true);
		}else{
			$('#quarterId').prop('disabled',false);
			$("#quarterId").val('-1');
		}
	}
	
	
	function ajaxCallFunction(detailId){
		 var quarterId=0;
		 $("#tableExp").hide();
		 var statecode=$("#inputState").val(); 
		 var yearId=$("#inputFinYear").val();
		 if(yearId==2||yearId==3 )
			  {
			  quarterId=0;
			  }
		  else
			  {
			  var quarterId=$("#quarterId").val();
			  }
		 
		  if(statecode=='-1' && yearId=='-1' && quarterId=='-1' )
			  {
			  alert("Please Select all Dependent DropDown Value!");
			  return false;
			  } 
		  $("#tableExp").show();
		  $.ajax({
			   type : "POST",
			   contentType : "application/json",
			   url : "qprReportDetailsYearWise.html?<csrf:token uri='qprReportDetailsYearWise.html'/>&statecode="+statecode+"&yearId="+yearId+"&quarterId="+quarterId,
			   dataType : 'json',
			   cache : false,
			   timeout : 100000,
			   success : function(data) {
				   $("#printButtonDiv").show();
				   $('#inputFinYear').prop('disabled',true);
				   $('#inputState').prop('disabled',true);
				   $('#quarterId').prop('disabled',true);
				   $.each( data, function(key,valueList){
					  // console.log("key = " + key + " valueList = " + valueList);
						if(key=='Training_Activities_Progress_Report_Year_Wise_New'){
							  var tableBody='';
							  var total=0;
							   tableBody+= '<thead style="background-color: #eeb2b2">';
							   tableBody+= '<td><b>S.No.<b></td>';
							   tableBody+= '<td><b> Activity </b></td>';
							   tableBody+= '<td><b>No. Of Days</b></td>';
							   tableBody+= '<td><b>No. Of Units </b></td>';
							   tableBody+= '<td><b>Unit Costs(In Rs)</b></td>';
							   tableBody+= '<td><b>Funds Approved </b></td>';
							   tableBody+= '<td><b>Expenditure Inccured</b></td>';
							   tableBody+= '<td><b>Collaboration With Institutes </b></td>';
							   tableBody+= '<td><b>Remarks </b></td>';
							   tableBody+= '</thead>';
								   for (var key1 in valueList) {
									   //console.log(">>>key1===="+key1);
									    var slno=parseInt(key1)+1;
										    tableBody+='<tr>';
									   	 tableBody+='<td>'+ slno +  '</td>';
									   $.each( valueList[key1], function(key2,listVal){
										    //console.log("key2 = " + key2 + " listVal = " + listVal); 
										    if( key2!='additional_requirement'){
										    	 if( key2=='expenditure_incurred'){
										    		 total=parseInt(total)+parseInt(listVal);
										    		 tableBody+='<td>'+ listVal +  '</td>';
										    	 }else{
										    		 tableBody+='<td>'+ listVal +  '</td>';
										    	 }
										    }
									   })
										   if(valueList.length==slno){
											   tableBody+='</tr>';
											   tableBody+='<tr  style="background-color: #dbd0d0">';
											   $.each( valueList[key1], function(key2,listVal){
												    if( key2=='additional_requirement'){
												    	tableBody+='<td colspan=8> <b>Additional Requirement </b> </td>';
												    	tableBody+='<td><b>'+ listVal +  '</b></td>';
												    	total=parseInt(total)+parseInt(listVal);
												    }
											   })
											   tableBody+='</tr>';
											   tableBody+='<tr  style="background-color: #dbd0d0">';  
											   tableBody+='<td colspan=8> <b>Total </b> </td>';
										    	tableBody+='<td><b>'+ total +  '</b></td>';
											   tableBody+='</tr>';
										   }
									   tableBody+='</tr>';
									}
								   $("#trainingActivityId").html(tableBody);
							  }
						
						
						
						if(key=='iecProgressReportYearWiseNew'){
							var tableBody='';
							
							   tableBody+= '<thead style="background-color: #eeb2b2">';
							   tableBody+= '<td><b>S.No.<b></td>';
							   tableBody+= '<td><b>Nature of the IEC Activity </b></td>';
							   tableBody+= '<td><b>Funds Approved</b></td>';
							   tableBody+= '<td><b>Funds Utilized </b></td>';
							   tableBody+= '<td><b>Remarks </b></td>';
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
						
						if(key=='pesa_Plan_Year_Wise_New'){
							
							var tableBody='';
							var total=0;
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
											   if( key2!='additional_requirement'){
											    	 if( key2=='expenditure_incurred'){
											    		 total=parseInt(total)+parseInt(listVal);
											    		 tableBody+='<td>'+parseFloat(listVal)  +  '</td>';
											    	 }else if(key2=='Fund_sanctioned ' ){
											    		 if(listVal!='null'){
											    			 tableBody+='<td>'+parseFloat(listVal)  +  '</td>';
											    		 }else{
											    			 tableBody+='<td>0</td>';
											    		 }
											    		 
											    	 }
											    	 else{
											    		 tableBody+='<td>'+ listVal +  '</td>';
											    	 }
											    }
										   })
										   if(valueList.length==slno){
											   tableBody+='</tr>';
											   tableBody+='<tr  style="background-color: #dbd0d0">';
											   $.each( valueList[key1], function(key2,listVal){
												    if( key2=='additional_requirement'){
												    	tableBody+='<td colspan=5> <b>Additional Requirement </b> </td>';
												    	tableBody+='<td><b>'+ listVal +  '</b></td>';
												    	total=parseInt(total)+parseInt(listVal);
												    }
											   })
											   tableBody+='</tr>';
											   tableBody+='<tr  style="background-color: #dbd0d0">';  
											   tableBody+='<td colspan=5> <b>Total </b> </td>';
										    	tableBody+='<td><b>'+ total +  '</b></td>';
											   tableBody+='</tr>';
										   }   
										   
										   tableBody+='</tr>';
									}
								   $("#pesa_PlanId").html(tableBody);
							  }
						
						if(key=='administrativeAndTechnicalSupportIdYearWiseNew'){
							var tableBody='';
							var total=0;
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
												   if( key2!='additional_requirement'){
												    	 if( key2=='expenditure_incurred'){
												    		 total=parseInt(total)+parseInt(listVal);
												    		 tableBody+='<td>'+ listVal +  '</td>';
												    	 }else{
												    		 tableBody+='<td>'+ listVal +  '</td>';
												    	 }
												    } 
											   })
											   if(valueList.length==slno){
												   tableBody+='</tr>';
												   tableBody+='<tr  style="background-color: #dbd0d0">';
												   $.each( valueList[key1], function(key2,listVal){
													    if( key2=='additional_requirement'){
													    	tableBody+='<td colspan=7> <b>Additional Requirement </b> </td>';
													    	tableBody+='<td><b>'+ listVal +  '</b></td>';
													    	total=parseInt(total)+parseInt(listVal);
													    }
												   })
												   tableBody+='</tr>';
												   tableBody+='<tr  style="background-color: #dbd0d0">';  
												   tableBody+='<td colspan=7> <b>Total </b> </td>';
											    	tableBody+='<td><b>'+ total +  '</b></td>';
												   tableBody+='</tr>';
											   }  
										   tableBody+='</tr>';
									}
								   $("#adminAndTechSupportReportId").html(tableBody);
							  }
						
						if(key=='SATCOMIPYEARWISENEW'){
							var tableBody='';
							var total=0;
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
												   if( key2!='additional_requirement'){
												    	 if( key2=='expenditure_incurred'){
												    		 total=parseInt(total)+parseInt(listVal);
												    		 tableBody+='<td>'+ listVal +  '</td>';
												    	 }else{
												    		 tableBody+='<td>'+ listVal +  '</td>';
												    	 }
												    } 
											   })
											   if(valueList.length==slno){
												   tableBody+='</tr>';
												   tableBody+='<tr  style="background-color: #dbd0d0">';
												   $.each( valueList[key1], function(key2,listVal){
													    if( key2=='additional_requirement'){
													    	tableBody+='<td colspan=7> <b>Additional Requirement </b> </td>';
													    	tableBody+='<td><b>'+ listVal +  '</b></td>';
													    	total=parseInt(total)+parseInt(listVal);
													    }
												   })
												   tableBody+='</tr>';
												   tableBody+='<tr  style="background-color: #dbd0d0">';  
												   tableBody+='<td colspan=7> <b>Total </b> </td>';
											    	tableBody+='<td><b>'+ total +  '</b></td>';
												   tableBody+='</tr>';
											   }  
										   tableBody+='</tr>';
									}
								   $("#satcomipid").html(tableBody);
							  }
						
						if(key=='EenablementProgressReportIdYearWiseNew'){
							var tableBody='';
							var total=0;
							   tableBody+= '<thead style="background-color: #eeb2b2">';
								   tableBody+= '<td><b>S.No.<b></td>';
								   tableBody+= '<td><b> GP Name </b></td>';
								   tableBody+= '<td><b>Amount Sanctioned</b></td>';
								   tableBody+= '<td><b>Status</b></td>';
								   tableBody+= '<td><b> Expenditure Incurred(in Rs.)</b></td>';
							   tableBody+= '</thead>';
								   for (var key1 in valueList) {
									   //console.log(">>>"+valueList.length);
									    var slno=parseInt(key1)+1;
										    tableBody+='<tr>';
									    	tableBody+='<td>'+ slno +  '</td>';
									    	 $.each( valueList[key1], function(key2,listVal){
												   if( key2!='additional_requirement'){
												    	 if( key2=='expenditure_incurred'){
												    		 total=parseInt(total)+parseInt(listVal);
												    		 tableBody+='<td>'+ listVal +  '</td>';
												    	 }else{
												    		 tableBody+='<td>'+ listVal +  '</td>';
												    	 }
												    } 
											   })
											   if(valueList.length==slno){
												   tableBody+='</tr>';
												   tableBody+='<tr  style="background-color: #dbd0d0">';
												   $.each( valueList[key1], function(key2,listVal){
													    if( key2=='additional_requirement'){
													    	tableBody+='<td colspan=4> <b>Additional Requirement </b> </td>';
													    	tableBody+='<td><b>'+ listVal +  '</b></td>';
													    	total=parseInt(total)+parseInt(listVal);
													    }
												   })
												   tableBody+='</tr>';
												   tableBody+='<tr  style="background-color: #dbd0d0">';  
												   tableBody+='<td colspan=4> <b>Total </b> </td>';
											    	tableBody+='<td><b>'+ total +  '</b></td>';
												   tableBody+='</tr>';
											   }  
										   tableBody+='</tr>';
									}
								   $("#eEnablementId").html(tableBody);
							  }
						if(key=='InstitutionalInfrastructureIdYearWiseNew'){
							var tableBody='';
							var total=0;
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
												   if( key2!='additional_requirement'){
												    	 if( key2=='expenditure_incurred'){
												    		 total=parseInt(total)+parseInt(listVal);
												    		 tableBody+='<td>'+ listVal +  '</td>';
												    	 }else{
												    		 tableBody+='<td>'+ listVal +  '</td>';
												    	 }
												    } 
											   })
											   if(valueList.length==slno){
												   tableBody+='</tr>';
												   tableBody+='<tr  style="background-color: #dbd0d0">';
												   $.each( valueList[key1], function(key2,listVal){
													    if( key2=='additional_requirement'){
													    	tableBody+='<td colspan=6> <b>Additional Requirement </b> </td>';
													    	tableBody+='<td><b>'+ listVal +  '</b></td>';
													    	total=parseInt(total)+parseInt(listVal);
													    }
												   })
												   tableBody+='</tr>';
												   tableBody+='<tr  style="background-color: #dbd0d0">';  
												   tableBody+='<td colspan=6> <b>Total </b> </td>';
											    	tableBody+='<td><b>'+ total +  '</b></td>';
												   tableBody+='</tr>';
											   }  
										   tableBody+='</tr>';
									}
								   $("#InstitutionalInfrastructureId").html(tableBody);
							  }
						if(key=='adminFinancialIdYearWiseNew'){
							var tableBody='';
							var total=0;
							   tableBody+= '<thead style="background-color: #eeb2b2">';
								   tableBody+= '<td><b>S.No.<b></td>';
								   tableBody+= '<td><b> Type of Center </b></td>';
								   tableBody+= '<td><b>Domain Experts</b></td>';
								   tableBody+= '<td><b>Approved No. of Staff </b></td>';
								   tableBody+= '<td><b>Approved Unit Cost</b></td>';
								   tableBody+= '<td><b>Fund Sanctioned </b></td>';
								   tableBody+= '<td><b>no. Of Units Filled</b></td>';
								   tableBody+= '<td><b>Expenditure Incurred </b></td>';
							   tableBody+= '</thead>';
								   for (var key1 in valueList) {
									   //console.log(">>>"+valueList.length);
									    var slno=parseInt(key1)+1;
										    tableBody+='<tr>';
									    	tableBody+='<td>'+ slno +  '</td>';
									    	 $.each( valueList[key1], function(key2,listVal){
												   if( key2!='additional_requirement'){
												    	 if( key2=='expenditure_incurred'){
												    		 total=parseInt(total)+parseInt(listVal);
												    		 tableBody+='<td>'+ listVal +  '</td>';
												    	 }else{
												    		 tableBody+='<td>'+ listVal +  '</td>';
												    	 }
												    } 
											   })
											   if(valueList.length==slno){
												   tableBody+='</tr>';
												   tableBody+='<tr  style="background-color: #dbd0d0">';
												   $.each( valueList[key1], function(key2,listVal){
													    if( key2=='additional_requirement'){
													    	tableBody+='<td colspan=7> <b>Additional Requirement </b> </td>';
													    	tableBody+='<td><b>'+ listVal +  '</b></td>';
													    	total=parseInt(total)+parseInt(listVal);
													    }
												   })
												   tableBody+='</tr>';
												   tableBody+='<tr  style="background-color: #dbd0d0">';  
												   tableBody+='<td colspan=7> <b>Total </b> </td>';
											    	tableBody+='<td><b>'+ total +  '</b></td>';
												   tableBody+='</tr>';
											   }  
										   tableBody+='</tr>';
									}
								   $("#adminFinancialId").html(tableBody);
							  }
						if(key=='InnovativeActiveIdYearWiseNew'){
							var tableBody='';
							var total=0;
							   tableBody+= '<thead style="background-color: #eeb2b2">';
								   tableBody+= '<td><b>S.No.<b></td>';
								   tableBody+= '<td><b> Name of Activity </b></td>';
								   tableBody+= '<td><b>Funds(In Rs) </b></td>';
								   tableBody+= '<td><b>Brief About the Activity</b></td>';
								   tableBody+= '<td><b>From</b></td>';
								   tableBody+= '<td><b>To</b></td>';
								   
								  
							   tableBody+= '</thead>';
								   for (var key1 in valueList) {
									   //console.log(">>>"+valueList.length);
									    var slno=parseInt(key1)+1;
										    tableBody+='<tr>';
									    	tableBody+='<td>'+ slno +  '</td>';
									    	 $.each( valueList[key1], function(key2,listVal){
												   if( key2!='additional_requirement'){
												    	 if( key2=='expenditure_incurred'){
												    		 total=parseInt(total)+parseInt(listVal);
												    		 tableBody+='<td>'+ listVal +  '</td>';
												    	 }else{
												    		 tableBody+='<td>'+ listVal +  '</td>';
												    	 }
												    } 
											   })
											   if(valueList.length==slno){
												   tableBody+='</tr>';
												   tableBody+='<tr  style="background-color: #dbd0d0">';
												   $.each( valueList[key1], function(key2,listVal){
													    if( key2=='additional_requirement'){
													    	tableBody+='<td colspan=3> <b>Additional Requirement </b> </td>';
													    	tableBody+='<td><b>'+ listVal +  '</b></td>';
													    	total=parseInt(total)+parseInt(listVal);
													    }
												   })
												   tableBody+='</tr>';
												   tableBody+='<tr  style="background-color: #dbd0d0">';  
												   tableBody+='<td colspan=3> <b>Total </b> </td>';
											    	tableBody+='<td><b>'+ total +  '</b></td>';
												   tableBody+='</tr>';
											   }  
										   tableBody+='</tr>';
									}
								   $("#InnovativeActiveId").html(tableBody);
							  }
						
						if(key=='pmuProgressReportYearWiseNew'){
							var tableBody='';
							var total=0;
							   tableBody+= '<thead style="background-color: #eeb2b2">';
							   tableBody+= '<td><b>S.No.<b></td>';
							   tableBody+= '<td><b> Type of Center </b></td>';
							   tableBody+= '<td><b>Faculty and Staff</b></td>';
							   tableBody+= '<td><b> No. of Units</b></td>';
							   tableBody+= '<td><b>Funds Approved</b></td>';
							   tableBody+= '<td><b>Funds Utilized</b></td>';
							   tableBody+= '<td><b>Remarks </b></td>';
							   tableBody+= '</thead>';
								   for (var key1 in valueList) {
									    var slno=parseInt(key1)+1;
										    tableBody+='<tr>';
									    	tableBody+='<td>'+ slno +  '</td>';
										   $.each( valueList[key1], function(key2,listVal){
											   if( key2!='additional_requirement'){
											    	 if( key2=='expenditure_incurred'){
											    		 total=parseInt(total)+parseInt(listVal);
											    		 tableBody+='<td>'+ listVal +  '</td>';
											    	 }else{
											    		 tableBody+='<td>'+ listVal +  '</td>';
											    	 }
											    } 
										   })
										   if(valueList.length==slno){
											   tableBody+='</tr>';
											   tableBody+='<tr  style="background-color: #dbd0d0">';
											   $.each( valueList[key1], function(key2,listVal){
												    if( key2=='additional_requirement'){
												    	tableBody+='<td colspan=6> <b>Additional Requirement </b> </td>';
												    	tableBody+='<td><b>'+ listVal +  '</b></td>';
												    	total=parseInt(total)+parseInt(listVal);
												    }
											   })
											   tableBody+='</tr>';
											   tableBody+='<tr  style="background-color: #dbd0d0">';  
											   tableBody+='<td colspan=6> <b>Total </b> </td>';
										    	tableBody+='<td><b>'+ total +  '</b></td>';
											   tableBody+='</tr>';
										   }   
										   tableBody+='</tr>';
									}
								   $("#pmuProgressReportId").html(tableBody);
							  }
						if(key=='e_Governance_Support_Group_Year_Wise_New'){
							var tableBody='';
							var total=0;
							   tableBody+= '<thead style="background-color: #eeb2b2">';
							   tableBody+= '<td><b>S.No.<b></td>';
							   tableBody+= '<td><b> Level </b></td>';
							   tableBody+= '<td><b>Designation</b></td>';
							   tableBody+= '<td><b>No. of Posts Proposed </b></td>';
							   tableBody+= '<td><b>Unit Cost Approved (in Rs) </b></td>';
							   tableBody+= '<td><b>Funds Approved</b></td>';
							   tableBody+= '<td><b>Funds Utilized </b></td>';
							   tableBody+= '<td><b>Remarks </b></td>';
							   tableBody+= '</thead>';
								   for (var key1 in valueList) {
									   //console.log(">>>"+valueList.length);
									    var slno=parseInt(key1)+1;
										    tableBody+='<tr>';
									    	tableBody+='<td>'+ slno +  '</td>';
										   $.each( valueList[key1], function(key2,listVal){
											   if( key2!='additional_requirement_dpmu' && key2!='additional_requirement_spmu'){
											    	 if( key2=='expenditure_incurred'){
											    		 total=parseInt(total)+parseInt(listVal);
											    		 tableBody+='<td>'+ listVal +  '</td>';
											    	 }else{
											    		 tableBody+='<td>'+ listVal +  '</td>';
											    	 }
											    }
										   })
										   if(valueList.length==slno){
											   tableBody+='</tr>';
											   tableBody+='<tr  style="background-color: #dbd0d0">';
											   tableBody+='<td>  </td>';
											   $.each( valueList[key1], function(key2,listVal){
												    if( key2=='additional_requirement_dpmu'){
												    	tableBody+='<td colspan=2> <b>Additional Requirement DPMU </b> </td>';
												    	tableBody+='<td><b>'+ listVal +  '</b></td>';
												    	total=parseInt(total)+parseInt(listVal);
												    }
												    if( key2=='additional_requirement_spmu'){
												    	tableBody+='<td colspan=2> <b>Additional Requirement SPMU</b> </td>';
												    	tableBody+='<td><b>'+ listVal +  '</b></td>';
												    	total=parseInt(total)+parseInt(listVal);
												    }
											   })
											   tableBody+='</tr>';
											   tableBody+='<tr  style="background-color: #dbd0d0">';  
											   tableBody+='<td colspan=8> <b>Total </b> </td>';
										    	tableBody+='<td><b>'+ total +  '</b></td>';
											   tableBody+='</tr>';
										   }
										   tableBody+='</tr>';
									}
								   $("#egov_SupportGrpId").html(tableBody);
							  }
						
						
						if(key=='Training_Details_Progress_Report_Year_Wise_New'){
							var tableBody='';
							var total=0;
							   tableBody+= '<thead style="background-color: #eeb2b2">';
							   tableBody+= '<td><b>S.No.<b></td>';
							   tableBody+= '<td><b> Training Category </b></td>';
							   tableBody+= '<td><b>Training Subjects</b></td>';
							   tableBody+= '<td><b>Training Target Group</b></td>';
							   tableBody+= '<td><b>Venue Level </b></td>';
							   tableBody+= '<td><b>Mode of Trainings</b></td>';
							   tableBody+= '<td><b>No of Participants </b></td>';
							   tableBody+= '<td><b>Funds Approved </b></td>';
							   tableBody+= '<td><b>Funds Utilized </b></td>';
							   tableBody+= '<td><b>Total Trained Participants </b></td>';
							   tableBody+= '<td><b>Remarks</b></td>';
							 
							  
							   tableBody+= '</thead>';
								   for (var key1 in valueList) {
									   //console.log(">>>"+valueList.length);
									    var slno=parseInt(key1)+1;
										    tableBody+='<tr>';
									    	tableBody+='<td>'+ slno +  '</td>';
										   $.each( valueList[key1], function(key2,listVal){
											   if( key2!='additional_requirement'){
											    	 if( key2=='expenditure_incurred'){
											    		 total=parseInt(total)+parseInt(listVal);
											    		 tableBody+='<td>'+ listVal +  '</td>';
											    	 }else{
											    		 tableBody+='<td>'+ listVal +  '</td>';
											    	 }
											    }
										   })
										   if(valueList.length==slno){
											   tableBody+='</tr>';
											   tableBody+='<tr  style="background-color: #dbd0d0">';
											   $.each( valueList[key1], function(key2,listVal){
												    if( key2=='additional_requirement'){
												    	tableBody+='<td colspan=7> <b>Additional Requirement </b> </td>';
												    	tableBody+='<td><b>'+ listVal +  '</b></td>';
												    	total=parseInt(total)+parseInt(listVal);
												    }
											   })
											   tableBody+='</tr>';
											   tableBody+='<tr  style="background-color: #dbd0d0">';  
											   tableBody+='<td colspan=10> <b>Total </b> </td>';
										    	tableBody+='<td><b>'+ total +  '</b></td>';
											   tableBody+='</tr>';
										   }
										   tableBody+='</tr>';
									}
								   $("#trainingDetailsId").html(tableBody);
							  }
						
				
						
						
						
						if(key=='Additional_Faculty_Maintenance_SPRC_DPRC_Year_Wise_New'){
							var tableBody='';
							var total=0;
							   tableBody+= '<thead style="background-color: #eeb2b2">';
							   tableBody+= '<td><b>S.No.<b></td>';
							   tableBody+= '<td><b> Type of Center </b></td>';
							   tableBody+= '<td><b>Faculty and Staff</b></td>';
							   tableBody+= '<td><b>No of Units </b></td>';
							   tableBody+= '<td><bFunds Approved(In Rs.) </b></td>';
							   tableBody+= '<td><b>Funds Utilized  (In Rs.) </b></td>';
							   tableBody+= '<td><b>Remarks</b></td>';
									 
							   tableBody+= '</thead>';
								   for (var key1 in valueList) {
									   //console.log(">>>"+valueList.length);
									    var slno=parseInt(key1)+1;
										    tableBody+='<tr>';
									    	tableBody+='<td>'+ slno +  '</td>';
										   $.each( valueList[key1], function(key2,listVal){
											   if( key2!='additional_req_dprc' && key2!='additional_req_sprc'){
											    	 if( key2=='expenditure_incurred'){
											    		 total=parseInt(total)+parseInt(listVal);
											    		 tableBody+='<td>'+ listVal +  '</td>';
											    	 }else{
											    		 tableBody+='<td>'+ listVal +  '</td>';
											    	 }
											    }
										   })
										   if(valueList.length==slno){
											   tableBody+='</tr>';
											   tableBody+='<tr  style="background-color: #dbd0d0">';
											   tableBody+='<td> <b> </b> </td>';
											   $.each( valueList[key1], function(key2,listVal){
												    if( key2=='additional_req_dprc'){
												    	tableBody+='<td colspan=2> <b>Additional Requirement DPRC </b> </td>';
												    	tableBody+='<td><b>'+ listVal +  '</b></td>';
												    	total=parseInt(total)+parseInt(listVal);
												    }
												    if( key2=='additional_req_sprc'){
												    	tableBody+='<td colspan=2> <b>Additional Requirement SPRC </b> </td>';
												    	tableBody+='<td><b>'+ listVal +  '</b></td>';
												    	total=parseInt(total)+parseInt(listVal);
												    }
											   })
											   tableBody+='</tr>';
											   tableBody+='<tr  style="background-color: #dbd0d0">';  
											   tableBody+='<td colspan=6> <b>Total </b> </td>';
										    	tableBody+='<td><b>'+ total +  '</b></td>';
											   tableBody+='</tr>';
										   }
										   tableBody+='</tr>';
									}
								   $("#hrSupportSprc").html(tableBody);               
							  }
						
					
						
						
						if(key=='panchyatbhawanProgressReportYearWiseNew'){
							var tableBody='';
							var total=0;
							   tableBody+= '<thead style="background-color: #eeb2b2">';
							   tableBody+= '<td><b>S.No.<b></td>';
							   tableBody+= '<td><b> Activities</b></td>';
							   tableBody+= '<td><b>No. of Aspirational GPs selected selected</b></td>';
							   tableBody+= '<td><b> Unit Cost (In Rs) </b></td>';
							   tableBody+= '<td><b> Funds Utilized(In Rs)</b></td>';
							   tableBody+= '<td><b> Remarks</b></td>';
							   tableBody+= '</thead>';
								   for (var key1 in valueList) {
									   //console.log(">>>"+valueList.length);
									    var slno=parseInt(key1)+1;
										    tableBody+='<tr>';
									    	tableBody+='<td>'+ slno +  '</td>';
									    	 $.each( valueList[key1], function(key2,listVal){
												   if( key2!='additional_requirement'){
												    	 if( key2=='expenditure_incurred'){
												    		 total=parseInt(total)+parseInt(listVal);
												    		 tableBody+='<td>'+ listVal +  '</td>';
												    	 }else{
												    		 tableBody+='<td>'+ listVal +  '</td>';
												    	 }
												    } 
											   })
											   if(valueList.length==slno){
												   tableBody+='</tr>';
												   tableBody+='<tr  style="background-color: #dbd0d0">';
												   $.each( valueList[key1], function(key2,listVal){
													    if( key2=='additional_requirement'){
													    	tableBody+='<td colspan=6> <b>Additional Requirement </b> </td>';
													    	tableBody+='<td><b>'+ listVal +  '</b></td>';
													    	total=parseInt(total)+parseInt(listVal);
													    }
												   })
												   tableBody+='</tr>';
												   tableBody+='<tr  style="background-color: #dbd0d0">';  
												   tableBody+='<td colspan=6> <b>Total </b> </td>';
											    	tableBody+='<td><b>'+ total +  '</b></td>';
												   tableBody+='</tr>';
											   }  
										   tableBody+='</tr>';
									}
								   $("#panchyatbhawanProgressReportId").html(tableBody);
							  }
					
						
						
						if(key=='IncomeEnhancementIdYearWiseNew'){
							var tableBody='';
							var total=0;
							   tableBody+= '<thead style="background-color: #eeb2b2">';
							   tableBody+= '<td><b>S.No.<b></td>';
							   tableBody+= '<td><b>	Name of the Activity </b></td>';
							   tableBody+= '<td><b>Coverage with Scheme</b></td>';
							   tableBody+= '<td><b>District Name </b></td>';
							   tableBody+= '<td><b>Block Name</b></td>';
							   tableBody+= '<td><b>Total No.of GPs </b></td>';
							   tableBody+= '<td><b>Covered	No. of Gps<b></td>';
							   tableBody+= '<td><b>Aspirational GPs<b></td>';
							   tableBody+= '<td><b>From<b></td>';
							   tableBody+= '<td><b>To	<b></td>';
							   tableBody+= '<td><b>Total cost of project<b></td>';
							   tableBody+= '<td><b>Funds Approved<b></td>';
							   tableBody+= '<td><b>Funds Utilized	<b></td>';
							   tableBody+= '<td><b>Brief about the Activity	<b></td>';
							   tableBody+= '<td><b>Remarks<b></td>';
							   tableBody+= '</thead>';
								   for (var key1 in valueList) {
									   //console.log(">>>"+valueList.length);
									    var slno=parseInt(key1)+1;
										    tableBody+='<tr>';
									    	tableBody+='<td>'+ slno +  '</td>';
									    	 $.each( valueList[key1], function(key2,listVal){
												   if( key2!='additional_requirement'){
												    	 if( key2=='expenditure_incurred'){
												    		 total=parseInt(total)+parseInt(listVal);
												    		 tableBody+='<td>'+ listVal +  '</td>';
												    	 }else{
												    		 tableBody+='<td>'+ listVal +  '</td>';
												    	 }
												    } 
											   })
											   if(valueList.length==slno){
												   tableBody+='</tr>';
												   tableBody+='<tr  style="background-color: #dbd0d0">';
												   $.each( valueList[key1], function(key2,listVal){
													    if( key2=='additional_requirement'){
													    	tableBody+='<td colspan=10> <b>Additional Requirement </b> </td>';
													    	tableBody+='<td><b>'+ listVal +  '</b></td>';
													    	total=parseInt(total)+parseInt(listVal);
													    }
												   })
												   tableBody+='</tr>';
												   tableBody+='<tr  style="background-color: #dbd0d0">';  
												   tableBody+='<td colspan=10> <b>Total </b> </td>';
											    	tableBody+='<td><b>'+ total +  '</b></td>';
												   tableBody+='</tr>';
											   }  
										   tableBody+='</tr>';
									}
								   $("#IncomeEnhancementId").html(tableBody);
							  }
						
				   })
			   },
			   error : function(e) {
			    console.log(e);
			   }
			  });
	 }
						
						
					
	 
	 
	  function exportToPdf(id) {
		  
		  
		  var today = new Date();
		  var dd = String(today.getDate()).padStart(2, '0');
		  var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
		  var yyyy = today.getFullYear();

		  today = mm + '/' + dd + '/' + yyyy;
		  
		  
	   
			 var header = 'Training Activities';
			 var sTable =$('#'+id).html();
			 
			 var stateName=$("#inputState option:selected").text();
			  var year=$("#inputFinYear option:selected").text();
			  var quarter=$("#quarterId option:selected").text();
			  
			 var style = "<style>";
			 
			 	style = style + "table,th,td{border: solid 1px black;border-collapse: collapse;}";
		        style = style + "thead {color : black; background-color: #e87b7b;";
		        style = style + "</style>";
			 
		   var win = window.open('', '', 'height=1000,width=1000');
		    win.document.write('<html><head>');
		    win.document.write('<title>'+header+'</title>');  
		    win.document.write('<h3 style="border: 4px solid black;"> Quaterly Progress Report of '+stateName+' for'+year+' ('+ quarter +' ) </h3>');  
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
					<select class="form-control" id="inputFinYear" path="" onchange="diabledQuarterFn(this)" >
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
					<button type="button" onclick="exportToPdf('tableExp');" class="btn btn-primary"><span class="glyphicon glyphicon-print"></span>&nbsp; Print</button>
					</div>
					
					</div><!--  row -->
					
				<div class="table-responsive" id="tableExp" style="width: auto; display:none">
 
	<div class="panel-group" id="accordion">
 	 
			   <div class="panel panel-default">
			    <div class="panel-heading" >
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
		  
		   <div class="panel panel-default">
		    <div class="panel-heading">
		     <a data-toggle="collapse" data-parent="" href="#collapse15">
		      <h4 class="panel-title">
		       Innovative Activity Quaterly Report
		      </h4></a>
		    </div>
		    <div id="collapse15" class="panel-collapse collapse">
		      <div class="panel-body">
		      	<table class="table table-bordered" id="InnovativeActiveId"></table>
		      </div>
		    </div>
		  </div>
		  
		  <div class="panel panel-default">
		    <div class="panel-heading">
		     <a data-toggle="collapse" data-parent="" href="#collapse16">
		      <h4 class="panel-title">
		       Admin And Financial Data Cell Quaterly Report 
		      </h4></a>
		    </div>
		    <div id="collapse16" class="panel-collapse collapse">
		      <div class="panel-body">
		      	<table class="table table-bordered" id="adminFinancialId"></table>
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
