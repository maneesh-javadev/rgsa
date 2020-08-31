
 

	
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
	 
	function refreshCaptcha()
	{
		  $('#img_Capatcha').attr('src', 'captchaImage?cache=' + new Date().getTime());
	    $('#captchaAnswer').val('');
	    $('#captchaAnswer').focus();
	}
	
	function ajaxCallFunction(detailId){
		
		var imageCaptua=$("#captchaAnswer").val();
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
							ajaxCallFunction123(detailId);
						}else{
							alert("kindly enter captcha correctly");
						}
	 			},error : function(e) {
			console.log(e);
		}
			}); 	
		}
	}
	
	 function ajaxCallFunction123(detailId){
		 
		 $("#tableExp").hide();
		 $("#hideShow").hide();
		 $("#backButtonId").show();
		 
		  var statecode=$("#inputState").val();
		  var yearId=$("#inputFinYear").val();
		  
		  var quarterId=yearId==2 || yearId==3 ?0:  $("#quarterId").val();
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
				   $("#printButtonDiv").show();
				   $('#inputFinYear').prop('disabled',true);
				   $('#inputState').prop('disabled',true);
				   $('#quarterId').prop('disabled',true);
				   $.each( data, function(key,valueList){
					  // console.log("key = " + key + " valueList = " + valueList);
						if(key=='Training_Activities_Progress_Report'){
							  var tableBody='';
							  var total=0;
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
								   $("#trainingActivityId").html(tableBody);
							  }
							if(key=='Training_Details_Progress_Report'){
								var tableBody='';
								var total=0;
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
												   if( key2!='additional_requirement' && key2!='Trained_Participants'){
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
									   $("#trainingDetailsId").html(tableBody);
								  }
							if(key=='Additional_Faculty_Maintenance_SPRC_DPRC'){
								var tableBody='';
								var total=0;
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
							if(key=='e_Governance_Support_Group'){
								var tableBody='';
								var total=0;
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
												   tableBody+='<td colspan=6> <b>Total </b> </td>';
											    	tableBody+='<td><b>'+ total +  '</b></td>';
												   tableBody+='</tr>';
											   }
											   tableBody+='</tr>';
										}
									   $("#egov_SupportGrpId").html(tableBody);
								  }
							if(key=='pesa_Plan'){
								
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
								var total=0;
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
							if(key=='panchyatbhawanProgressReport'){
								var tableBody='';
								var total=0;
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
									   $("#panchyatbhawanProgressReportId").html(tableBody);
								  }
							if(key=='administrativeAndTechnicalSupportId'){
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
							if(key=='IncomeEnhancementId'){
								var tableBody='';
								var total=0;
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
									   $("#IncomeEnhancementId").html(tableBody);
								  }
							
							
							if(key=='SATCOMIP'){
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
							if(key=='EenablementProgressReportId'){
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
							if(key=='InstitutionalInfrastructureId'){
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
							if(key=='InnovativeActiveId'){
								var tableBody='';
								var total=0;
								   tableBody+= '<thead style="background-color: #eeb2b2">';
									   tableBody+= '<td><b>S.No.<b></td>';
									   tableBody+= '<td><b> Name of Activity </b></td>';
									   tableBody+= '<td><b>Fund Proposed</b></td>';
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
							if(key=='adminFinancialId'){
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
			  var yearId=$("#inputFinYear").val();
			 
			  var quarter=$("#quarterId option:selected").text();
			  
			 var style = "<style>";
			 
			 	style = style + "table,th,td{border: solid 1px black;border-collapse: collapse;}";
		        style = style + "thead {color : black; background-color: #e87b7b;";
		        style = style + "</style>";
			 
		   var win = window.open('', '', 'height=1000,width=1000');
		    win.document.write('<html><head>');
		    win.document.write('<title>'+header+'</title>');  
		    if(yearId==2 || yearId==3){
		    	win.document.write('<h3 style="border: 4px solid black;"> Quaterly Progress Report of '+stateName+' for'+year+' </h3>');  
		    }else{
		    	 win.document.write('<h3 style="border: 4px solid black;"> Quaterly Progress Report of '+stateName+' for'+year+' ('+ quarter +' ) </h3>');  
				    
		    }
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
	
