<%@include file="../taglib/taglib.jsp"%>

<html>
<head>

<style type="text/css">

#errmsg
{
color: red;
}
</style>

<script type="text/javascript"> 

$(document).ready(function(){
	$("#basicInfo :input").prop("disabled", true);
});

function removeDisabledAttr(){
	$("#basicInfo :input").prop("disabled", false);
}

function setValues(){
	for(var i=0;i<=2;i++){
		for(var j=0;j<=3;j++){
			var type="";
			var gender="";
			var memberType="";
			if(i==0){type="GP";}if(i==1){type="BP";}if(i==2){type="DP";}if(j==0 || j==1){gender="MALE";}if(j==2 || j==3){gender="FEMALE";}if(j==0 || j==2){memberType="Sarpanch";}
			if(j==1 || j==3){
				memberType="Members";
			}
			$("#erSC"+i+j).val($("#Elected"+type+"_"+gender+"_"+memberType+"_SC").val());
			$("#erST"+i+j).val($("#Elected"+type+"_"+gender+"_"+memberType+"_ST").val());
			$("#erGEN"+i+j).val($("#Elected"+type+"_"+gender+"_"+memberType+"_GEN").val());
			$("#erMinority"+i+j).val($("#Elected"+type+"_"+gender+"_"+memberType+"_Minority").val());
		}
	}
}

function setElectedRepData(){
	for(var i=0;i<=2;i++){
		for(var j=0;j<=3;j++){
			var type="";
			var gender="";
			var memberType="";
			if(i==0){type="GP";}if(i==1){type="BP";}if(i==2){type="DP";}if(j==0 || j==1){gender="MALE";}if(j==2 || j==3){gender="FEMALE";}if(j==0 || j==2){memberType="Sarpanch";}
			if(j==1 || j==3){
				memberType="Members";
			}
			$("#Elected"+type+"_"+gender+"_"+memberType+"_SC").val($("#erSC"+i+j).val());
			$("#Elected"+type+"_"+gender+"_"+memberType+"_ST").val($("#erST"+i+j).val());
			$("#Elected"+type+"_"+gender+"_"+memberType+"_GEN").val($("#erGEN"+i+j).val());
			$("#Elected"+type+"_"+gender+"_"+memberType+"_Minority").val($("#erMinority"+i+j).val());
		}
	}
	$("#myModal").modal('hide');
}



function setFocusArea(){
	var totalArea=document.getElementsByName("selectFocusArea").length;
	var count=0;
	$("#focusArea").html(' ');
	for (var int = 0; int < totalArea; int++) {
		var selectedItem=document.getElementsByName("selectFocusArea")[int];
		if(selectedItem.checked){
			var setValue = document.createElement("input");
			setValue.type="hidden";
			setValue.name="devolutionToGp["+count+"].focusAreas"
			setValue.value=$("#focusAre"+int).val();
			
			var pkVay = document.createElement("input");
			pkVay.type="hidden";
			pkVay.name="devolutionToGp["+count+"].sNumber"
			pkVay.value=$("#devolutionId"+int).val();
			$("#focusArea").append(pkVay);
			$("#focusArea").append(setValue);
			count++;
		}
		if(!selectedItem.checked && (selectedItem.value=="true")){
			var pkVay = document.createElement("input");
			pkVay.type="hidden";
			pkVay.name="devolutionToGp["+count+"].sNumber"
			pkVay.value=$("#devolutionId"+int).val();
			$("#focusArea").append(pkVay);
			count++;
		}
		
	}
	$("#subjectArea").modal('hide');
}

$( document ).ready(function() {
	$('.validate').find('input:number').val('');
	$("#data4_state").attr("disabled",true);
	$("#data21_state").attr("disabled",true);
	
	
	$("#data14_gp").attr("disabled",true);
	$("#data14_bp").attr("disabled",true);
	$("#data14_dp").attr("disabled",true);
	
	$("#data12_state").attr("disabled",true);
	
	$("#data16_gp,#data16_bp").attr("disabled",true);
	
	$("#data3_state").change(function() {
			if(parseInt($("#data2_state").val())<parseInt($("#data3_state").val())){
				alert("Value Should be less than Total Population of State");
				$("#data3_state").val(' ');
			}
			else{
				if($("#data2_state").val() != '' && $("#data3_state").val() != '')
					var value = (($("#data3_state").val() / $("#data2_state").val())*100).toFixed(2);
				$("#data4_state").val(value);
			}
		}
	);
	$("#data5_state,#data6_state,#data20_state,#data9_bp,#data9_dp,#data7_state,#data8_state,#data13_gp,#data13_bp,#data13_dp,#data10_state,#data11_state,#data27_gp,#data27_bp,#data45_state,#data30_gp,#data31_gp,#data32_gp,#data33_gp,#data9_gp,#data48_gp").change(function() {
		if(parseInt($("#data5_state").val())>100){
			alert("Value Should be less than 100");
			$("#data5_state").val(' ');
		}
		if(parseInt($("#data6_state").val())>100){
			alert("Value Should be less than 100");
			$("#data6_state").val(' ');
		}
		if(parseInt($("#data20_state").val())>100){
			alert("Value Should be less than 100");
			$("#data20_state").val(' ');
		}
		
		if(parseInt($("#data9_gp").val())<parseInt($("#data9_bp").val())){
			alert("Value Should be less than Gram Panchayat");
			$("#data9_bp").val(' ');
		}
		
		if($("#data3_state").val() != '' && $("#data9_gp").val() != ''){
				var value = ($("#data3_state").val() / $("#data9_gp").val()).toFixed(2);
			$("#data12_state").val(value);
		}
	
		
		if(parseInt($("#data9_bp").val())<parseInt($("#data9_dp").val())){
			alert("Value Should be less than Block Panchayat");
			$("#data9_dp").val(' ');
		}
		
		 if(parseInt($("#data7_state").val()) > parseInt($("#data9_gp").val())){
			alert("Value Should be less than Gram Panchayat");
			$("#data7_state").val(' ');
		} 
		
		var additionValue = (parseInt($("#data8_state").val()) + parseInt($("#data7_state").val()));
		if(additionValue > parseInt($("#data9_gp").val())){
			alert("Value Should be less than Gram Panchayat");
			$("#data8_state").val(' ');
		}else{
			$("#data21_state").val(parseInt($("#data9_gp").val()) - additionValue);
		}
		
		if(parseInt($("#data13_gp").val())>parseInt($("#data9_gp").val())){
			alert("Value Should be less than Gram Panchayat");
			$("#data13_gp").val(' ');
		}
		
		if(parseInt($("#data14_gp").val())>parseInt($("#data9_gp").val())){
			alert("Value Should be less than Gram Panchayat");
			$("#data14_gp").val(' ');
		}
		if(parseInt($("#data14_bp").val())>parseInt($("#data9_bp").val())){
			alert("Value Should be less than Gram Panchayat");
			$("#data14_bp").val(' ');
		}
		if(parseInt($("#data14_dp").val())>parseInt($("#data9_dp").val())){
			alert("Value Should be less than Gram Panchayat");
			$("#data14_dp").val(' ');
		}
		
		
		if(parseInt($("#data13_bp").val())>parseInt($("#data9_bp").val())){
			alert("Value Should be less than Block Panchayat");
			$("#data13_bp").val(' ');
		}
		
		if(parseInt($("#data13_dp").val())>parseInt($("#data9_dp").val())){
			alert("Value Should be less than District Panchayat");
			$("#data13_dp").val(' ');
		}
		
		if(parseInt($("#data10_state").val())>parseInt($("#data9_gp").val())){
			alert("Value Should be less than Gram Panchayat");
			$("#data10_state").val(' ');
		}
		
		if(parseInt($("#data11_state").val())>parseInt($("#data9_gp").val())){
			alert("Value Should be less than Gram Panchayat");
			$("#data11_state").val(' ');
		}
		
		 var AVG_GP = parseInt($("#data9_gp").val())/parseInt($("#data9_bp").val());
		 var AVG_BP = parseInt($("#data9_bp").val())/parseInt($("#data9_dp").val());
			$("#data16_gp").val(AVG_GP);
			$("#data16_bp").val(AVG_BP);
			
		
			if(parseInt($("#data27_gp").val()) > parseInt($("#data9_gp").val())){
				alert("Value Should be less than Gram Panchayat");
				$("#data27_gp").val(' ');
			}
			else{
				var BAL_NUMB=parseInt($("#data9_gp").val())-parseInt($("#data27_gp").val());
				$("#data27_bp").val(BAL_NUMB);
				
			}
			if(parseInt($("#data27_bp").val())>parseInt($("#data9_gp").val())){
				alert("Value Should be less than Gram Panchayat");
				$("#data27_bp").val(' ');
			}
			else{
				var BAL_NUMB=parseInt($("#data9_gp").val()) -parseInt($("#data27_bp").val());
				$("#data27_gp").val(BAL_NUMB);
			}
			
			if(parseInt($("#data45_state").val()) > parseInt($("#data27_gp").val())){
				alert("Value Should be less than or equal to number of Gram Panchayats having bhawan");
				$("#data45_state").val(' ');
			}
			
			if(parseInt($("#data30_gp").val()) > parseInt($("#data9_gp").val())){
				alert("Value Should be less than Gram Panchayat");
				$("#data30_gp").val(' ');
			}
			
			if(parseInt($("#data31_gp").val()) > parseInt($("#data9_gp").val())){
				alert("Value Should be less than Gram Panchayat");
				$("#data31_gp").val(' ');
			}
			
			if(parseInt($("#data32_gp").val()) > parseInt($("#data9_gp").val())){
				alert("Value Should be less than Gram Panchayat");
				$("#data32_gp").val(' ');
			}
			
			if(parseInt($("#data33_gp").val()) != parseInt($("#data9_gp").val()*10)){
				if(parseInt($("#data33_gp").val()) < parseInt($("#data9_gp").val()*10)){
					alert("Value Should be less than or equal to Gram Panchayat");
					$("#data33_gp").val(' ');
				}
			}
			
			if(parseInt($("#data48_gp").val()) != parseInt($("#data27_gp").val()*10)){
				if(parseInt($("#data48_gp").val()) > parseInt($("#data27_gp").val())){
					alert("Value Should be less than Gram Panchayat");
					$("#data48_gp").val(' ');
				}
			}
			
			var BAL_CSS=parseInt($("#data27_gp").val())-parseInt($("#data48_gp").val());
			$("#data48_bp").val(BAL_CSS);
			
		
	});
	
	
	
	$("#data18_gp").on('change', function () {
        var dateNext = Date.parse($(this).val());
        var datePRV = Date.parse($("#data18_bp").val());
        
        if (dateNext < datePRV) {
            alert('Next date must be greater than Previous date');
            $(this).val('');
        }
    });
	
	
	$(".validate").keypress(function (e) {
	     //if the letter is not digit then display error and don't type anything
	     if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
	        //display error message
	        $("#errmsg").html("Digits Only").show().fadeOut("slow");
	               return false;
	    }
	   });
	
	
});



</script>
</head>

<!-- Modal ER-  -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content" style="width: 1123px;margin-left: -198px;margin-top: 66px;">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Panchayat At each Level</h4>
        </div>
        <div class="modal-body" style="overflow-y: auto; ">
          	<table class="table table-bordered">
				<tr>
					<td  rowspan="4"><b>Panchayat</b></td>
					<td  colspan="18"><b>Elected Representative</b></td>
				</tr>
				<tr>
					<td  colspan="9"><b>Male</b></td>
					<td  colspan="9"><b>Female</b></td>
				</tr>
				<tr>
					<c:forEach begin="0" end="1" varStatus="condition">
					<td colspan="4"><b>Sarpanch</b></td>
					<td  colspan="4"><b>Members</b></td>
					
					<c:if test="${condition.index eq 0}">
							<td colspan="1"><b>Total Male</b></td>
						</c:if>
						<c:if test="${condition.index eq 1}">
							<td colspan="1"><b>Total Female</b></td>
						</c:if>
					
					</c:forEach>
					
				</tr>
				<tr>
					<c:forEach begin="0" end="3" varStatus="indexa">
						<td >SC</td>
						<td>ST</td>
						<td>General</td>
						<td>Minority</td>
						<c:if test="${indexa.index eq 1 or indexa.index eq 3 }">
							<td></td>
						</c:if>
					</c:forEach>
				</tr>
				
				<c:forEach begin="0" end="2" varStatus="index">
					<tr>
						<td style="text-align: center;"><b>
							<c:if test="${index.index eq 0}">GP</c:if>
							<c:if test="${index.index eq 1}">BP</c:if>
							<c:if test="${index.index eq 2}">DP</c:if>
							</b>
						</td>
						<c:forEach begin="0" end="3" varStatus="indx">
							<td><input type="text" id="erSC${indx.index}${index.index}"   class="form-control input-sm"></td>
							<td><input type="text" id="erST${indx.index}${index.index}"  class="form-control input-sm"></td>
							<td><input type="text" id="erGEN${indx.index}${index.index}"  class="form-control input-sm"></td>
							<td><input type="text" id="erMinority${indx.index}${index.index}"  class="form-control input-sm"></td>
							
							<c:if test="${indx.index eq 1 or indx.index eq 3 }">
							<td><input type="text"  class="form-control input-sm"></td>
							</c:if>
						</c:forEach>
						
					</tr>
				</c:forEach>
				
			</table>
          
          
        </div>
        <div class="modal-footer">
        	<button type="button" class="btn btn-success" onclick="setElectedRepData()">Save</button>
            <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>
  
  
  <!-- MODAL FOR FATCH FOCUS AREA -->
  
  <div class="modal fade" id="subjectArea" role="dialog">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Select the Flow/Subject area devolut to GPs</h4>
        </div>
        <div class="modal-body" style="height: 400px;">
          	<table class="table table-bordered table table-striped">
				<thead>
					<th>Sr.No</th>
					<th> Select</th>
					<th>Focus Area Name</th>
				</thead>
				<tbody>
					<c:forEach items="${FOCUS_AREAS_LIST}" var="focusAres" varStatus="index">
						<tr>
							<td>${index.count}</td>
							<td>
								<input type="checkbox" class="form-control" name="selectFocusArea"/>
								<input type="hidden" id="focusAre${index.index}" value="${focusAres.serialNumber}" />
							</td>
							<td>${focusAres.focusAreaName}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
          
          
        </div>
        <div class="modal-footer">
        	<button type="button" class="btn btn-success" onclick="setFocusArea()">Save</button>
            <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>

    <section class="content">
        <div class="container-fluid">
            <div class="row clearfix">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                	<div class="header">
                            <h4> Basic Information</h4>
                        </div>
                    
                         <form:form action="updateBasicInfoDetails.html" id="basicInfo" modelAttribute="BASIC_INFO_MODEL" method="POST">
                         <form:hidden path="basicInfoDefinationId" value="${BESIC_DEFINATION.basicInfoDefinationId}"/>
                         <form:hidden path="basicInfoId" value="${basicinfoId}"/>
                          	<c:set var="sNo" value="0"/>
							 <c:forEach items="${BESIC_DEFINATION.basicInfoDefinationDetails}" var="field" varStatus="count">
							 
							 <c:set value="${fn:length(BESIC_DEFINATION.basicInfoDefinationDetails)}" var="lenght"></c:set>
							 
							 <c:if test="${field.fieldType eq 'title'}">
							 <div class="card">
							 <div class="body">
							 </c:if>
	                              <c:choose>
	                              	<c:when test="${field.fieldType eq 'text'}">
	                              		
	                              		<c:if test="${!field.isState()}">
	                              			<label for="${field.labelName}">${sNo} . ${field.labelName}</label>
	                              		</c:if>
	                              		<c:if test="${field.isState()}">
									    	
								    	<div class="row clearfix">
		                                    <div class="col-sm-6  ">
		                                        <label >${sNo}. ${field.labelName}</label>
		                                    </div>
		                                    <div class="col-sm-6">
		                                        <div class="form-group">
		                                            <div class="form-line">
		                                            
		                                            <c:if test="${field.basicInfoDefinationDetailsId eq 2}">
		                                                <form:input   min="0" path="data[${field.basicInfoDefinationDetailsId}_state]" maxlength="10" class="form-control validate"  placeholder="Please enter ${field.labelName}"/>
		                                            </c:if>
		                                            <c:if test="${field.basicInfoDefinationDetailsId ne 2}">
		                                                <form:input   min="0" path="data[${field.basicInfoDefinationDetailsId}_state]"  class="form-control validate"  placeholder="Please enter ${field.labelName}"/>
		                                            </c:if>
		                                             
		                                            </div>
		                                        </div>
		                                    </div>
		                                </div>
									    
	                              		</c:if>
	                              		<c:if test="${!field.isState()}">
			                               <div class="form-group ">
			                                 <div class="row clearfix">
			                               
			                                 <c:if test="${field.isGP()}"> 
				                                <div class="col-sm-4">
				                                     <div class="form-group form-float">&nbsp;&nbsp;&nbsp;
				                                        <div class="form-line">
				                                            <form:input min="0" path="data[${field.basicInfoDefinationDetailsId}_gp]" cssClass="form-control validate"/>&nbsp;&nbsp;&nbsp;
				                                            <label class="form-label">
				                                            
				                                            <c:if test="${field.basicInfoDefinationDetailsId eq 27}">
				                                            Gram Panchayat with Bhawan
				                                            </c:if>
				                                            <c:if test="${field.basicInfoDefinationDetailsId eq 15}">
				                                            Number of ADCs
				                                            </c:if>
				                                            <c:if test="${field.basicInfoDefinationDetailsId eq 48}">
				                                           	Gram Panchayats with CSCs
				                                            </c:if>
				                                            <c:if test="${field.basicInfoDefinationDetailsId ne 27 && field.basicInfoDefinationDetailsId ne 15 && field.basicInfoDefinationDetailsId ne 48}">
				                                            Gram Panchayat
				                                            </c:if>
				                                            </label>
				                                        </div>
				                                    </div>
				                                </div>
			                              </c:if>
			                                
			                                <c:if test="${field.isBP()}">
			                                <div class="col-sm-4">
			                                     <div class="form-group form-float">&nbsp;&nbsp;&nbsp;
			                                        <div class="form-line">
			                                            <form:input  min="0" path="data[${field.basicInfoDefinationDetailsId}_bp]" cssClass="form-control validate"/> &nbsp;&nbsp;&nbsp;
			                                            <label class="form-label">
			                                            <c:if test="${field.basicInfoDefinationDetailsId eq 27}">
				                                            Gram Panchayat without Bhawan
				                                            </c:if>
				                                            
				                                             <c:if test="${field.basicInfoDefinationDetailsId eq 15}">
				                                            Number of VDCs
				                                            </c:if>
				                                            <c:if test="${field.basicInfoDefinationDetailsId eq 48}">
				                                           	Gram Panchayats without CSCs
				                                            </c:if>
				                                            <c:if test="${field.basicInfoDefinationDetailsId ne 27 && field.basicInfoDefinationDetailsId ne 15 && field.basicInfoDefinationDetailsId ne 48}">
				                                            Block Panchayat
				                                            </c:if>
			                                            </label>
			                                        </div>
			                                    </div>
			                                </div>
			                               </c:if>
			                              <c:if test="${field.isDP()}">
			                                <div class="col-sm-4">
			                                    <div class="form-group form-float">&nbsp;&nbsp;&nbsp;
			                                        <div class="form-line">
			                                            <form:input  min="0" path="data[${field.basicInfoDefinationDetailsId}_dp]" cssClass="form-control validate"/> &nbsp;&nbsp;&nbsp;
			                                            <label class="form-label">District Panchayat</label>
			                                        </div>
			                                    </div>
			                                </div>
			                                </c:if>
			                                
			                              <c:if test="${field.isSubInfo()}"> 
			                                <div class="col-sm-4">
			                                     <div class="form-group form-float">
			                                        <div class="form-line">
			                                            <c:forEach begin="0" end="2" varStatus="index">
				                                            	<c:if test="${index.index eq 0 }">
				                                            		<c:set var="type" value="GP"></c:set>
				                                            	</c:if>
				                                            	<c:if test="${index.index eq 1 }">
				                                            		<c:set var="type" value="BP"></c:set>
				                                            	</c:if>
				                                            	<c:if test="${index.index eq 2 }">
				                                            		<c:set var="type" value="DP"></c:set>
				                                            	</c:if>
																<c:forEach begin="0" end="3" varStatus="indx">
																	<c:if test="${indx.index eq 0 or index.index eq 1}">
					                                            		<c:set var="GENDER" value="MALE"></c:set>
					                                            	</c:if>
																	<c:if test="${indx.index eq 2 or index.index eq 3}">
					                                            		<c:set var="GENDER" value="FEMALE"></c:set>
					                                            	</c:if>
																	<c:if test="${indx.index eq 0 or index.index eq 2}">
					                                            		<c:set var="memberType" value="Sarpanch"></c:set>
					                                            	</c:if>
																	<c:if test="${indx.index eq 1 or index.index eq 3}">
					                                            		<c:set var="memberType" value="Members"></c:set>
					                                            	</c:if>
					                                            	
																	<form:hidden id="Elected${type}_${GENDER}_${memberType}_SC" path="data[${field.basicInfoDefinationDetailsId}_${type}_${GENDER}_${memberType}_SC]" class="form-control"/>
																	<form:hidden id="Elected${type}_${GENDER}_${memberType}_ST" path="data[${field.basicInfoDefinationDetailsId}_${type}_${GENDER}_${memberType}_ST]" class="form-control"/>
																	<form:hidden id="Elected${type}_${GENDER}_${memberType}_GEN" path="data[${field.basicInfoDefinationDetailsId}_${type}_${GENDER}_${memberType}_GEN]" class="form-control"/>
																	<form:hidden id="Elected${type}_${GENDER}_${memberType}_MINORITY" path="data[${field.basicInfoDefinationDetailsId}_${type}_${GENDER}_${memberType}_MINORITY]" class="form-control"/>
																</c:forEach>
															 </c:forEach>
			                                            <button type="button" class="btn btn-info btn-sm" style="background-color:#661a74"   data-toggle="modal" data-target="#myModal" onclick="setValues()">Click here for ER-</button>
			                                        </div>
			                                    </div>
			                                </div>
			                              </c:if>  
			                            </div>
			                           </div>
			                           </c:if>
	                              	</c:when>
	                              	
	                              	
	                              	<c:when test="${field.fieldType eq 'checkbox'}">
	                              		<label for="password">${sNo} . ${field.labelName}</label>
			                               <div class="form-group">
			                                 <div class="row clearfix">
			                                
			                                <c:if test="${field.isGP()}"> 
			                                <div class="col-sm-4">
			                                     <div class="form-group form-float">
			                                       <label class="form-label">Gram Panchayat</label>
			                                            <label for="yes">Yes</label>
			                                            <form:radiobutton path="data[${field.basicInfoDefinationDetailsId}_gp]" value="true" /> &nbsp;&nbsp;&nbsp;
			                                            <label for="yes">No</label>
			                                            <form:radiobutton path="data[${field.basicInfoDefinationDetailsId}_gp]" value="false" /> &nbsp;&nbsp;&nbsp;
			                                    </div>
			                                </div>
			                              </c:if> 
			                                <c:if test="${field.isBP()}">
			                                <div class="col-sm-4">
			                                     <div class="form-group form-float">
			                                     <label class="form-label">Block Panchayat</label>
			                                            <label for="yes">Yes</label>
			                                            <form:radiobutton path="data[${field.basicInfoDefinationDetailsId}_bp]" value="true" /> &nbsp;&nbsp;&nbsp;
			                                            <label for="yes">No</label>
			                                            <form:radiobutton path="data[${field.basicInfoDefinationDetailsId}_bp]" value="false" /> &nbsp;&nbsp;&nbsp;
			                                    </div>
			                                </div>
			                               </c:if>
			                               <c:if test="${field.isDP()}">
			                                <div class="col-sm-4">
			                                    <div class="form-group form-float">
			                                       <label class="form-label">District Panchayat</label>
			                                            <label for="yes">Yes</label>
			                                            <form:radiobutton path="data[${field.basicInfoDefinationDetailsId}_dp]" value="true" /> &nbsp;&nbsp;&nbsp;
			                                            <label for="yes">No</label>
			                                            <form:radiobutton path="data[${field.basicInfoDefinationDetailsId}_dp]" value="false" /> &nbsp;&nbsp;&nbsp;
			                                    </div>
			                                </div>
			                                </c:if>
			                               
			                              
			                              <c:if test="${field.isSubInfo()}"> 
			                              <div class="col-sm-4">
			                                    <div class="form-group form-float">&nbsp;&nbsp;&nbsp;
			                                        <div class="form-line">
														<button type="button" class="btn btn-info btn-sm" style="background-color:#661a74"   data-toggle="modal" data-target="#subjectArea">Click here for Focus Area</button>
													</div>
			                                    </div>
			                                </div>
			                              
			                              </c:if>
			                               
			                            </div>
			                           </div>
	                              	</c:when>
	                              	
	                              	<c:when test="${field.fieldType eq 'date'}">
	                              		<label for="password">${sNo} . ${field.labelName}</label>
			                               <div class="form-group">
			                                 <div class="row clearfix">
			                                
			                                <c:if test="${field.isDP()}">
			                                <div class="col-sm-4">
			                                    <div class="form-group form-float">&nbsp;&nbsp;&nbsp;
			                                        <div class="form-line">
			                                            <form:input type="date" class="form-control" path="data[${field.basicInfoDefinationDetailsId}_dp]" /> &nbsp;&nbsp;&nbsp;
			                                            <!-- <label class="form-label">District Panchayat/District</label> -->
			                                        </div>
			                                    </div>
			                                </div>
			                                </c:if>
			                                <c:if test="${field.isBP()}">
			                                <div class="col-sm-4">
			                                     <div class="form-group form-float">&nbsp;&nbsp;&nbsp;
			                                     <label class="form-label">Previous Date</label>
			                                        <div class="form-line">
			                                            <form:input type="date"  class="form-control" path="data[${field.basicInfoDefinationDetailsId}_bp]" /> &nbsp;&nbsp;&nbsp;
			                                            
			                                        </div>
			                                    </div>
			                                </div>
			                               </c:if>
			                               <c:if test="${field.isGP()}"> 
				                                <div class="col-sm-4">
				                                     <div class="form-group form-float">&nbsp;&nbsp;&nbsp;
				                                     <label class="form-label">Next Date</label>
				                                        <div class="form-line">
				                                            <form:input type="date"  class="form-control" path="data[${field.basicInfoDefinationDetailsId}_gp]" /> &nbsp;&nbsp;&nbsp;
				                                            
				                                        </div>
				                                    </div>
				                                </div>
			                              </c:if>  
			                            </div>
			                           </div>
	                              	</c:when>
	                              	<c:when test="${field.fieldType eq 'title'}">
	                             		 <div class="header">
				                            <h2> ${field.labelName}</h2>
				                        </div>
				                        <c:set var="sNo" value="0"/>
	                              	</c:when>
	                              </c:choose>
	                              <c:set var="sNo" value="${sNo+1}"/>
	                            <c:if test="${(BESIC_DEFINATION.basicInfoDefinationDetails[count.index+1].fieldType eq 'title') or lenght eq count.count}">
	                              </div>
	                              </div>
	                              </c:if>  
                           </c:forEach> 
                           <div class="card">
							 <div class="body">
                             <div class="form-group text-right">
                                	<button type="submit" class="btn bg-green waves-effect" onclick="removeDisabledAttr()">SAVE</button>
                                	<button type="button" onclick="onClear(this)" class="btn bg-light-blue waves-effect">CLEAR</button>
                                	<button type="button" onclick="onClose('home.html?<csrf:token uri='home.html'/>')"  class="btn bg-orange waves-effect">CLOSE</button>
                               </div>
                              </div>
                           </div>
                        </div>
                        </form:form>
                    </div>
                </div>
            </div>
    </section>
</html>