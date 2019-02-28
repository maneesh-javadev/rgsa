<html>
<head>
<%@include file="../taglib/taglib.jsp"%>
<script type="text/javascript">
$(document).ready(function() {
	$("#unFrzButtn").hide();
	
	
	var myBoolean = document.getElementById("isFreeze").value;
	if(myBoolean == "true"){
		 $(".expnditureId").prop('disabled', true);
		 $("#saveButtn").prop('disabled', true);
		 $("#frzButtn").hide();
		 $("#unFrzButtn").show();
		 $("#clearButtn").prop('disabled', true);
	 }
	
	if(myBoolean == "false"){
		 $(".expnditureId").prop('disabled', false);
		 $("#saveButtn").prop('disabled', false);
		 $("#frzButtn").show();
		 $("#unFrzButtn").hide();
		 $("#clearButtn").prop('disabled', false);
	 }
	
	if($('#expnditureId').val()>$('#fundsName').val()){
		alert('Expenditure Incurred should be less than fund approved.')
	}
	
}); 

function compareFunds(indx){
	if(parseInt($('#expnditureId_'+indx).val()) > parseInt($('#fundsName_'+indx).val())){
		alert('Expenditure Incurred should be less than fund approved.');
		$('#expnditureId_'+indx).val('');
	}
}

function getSelelctedQtrRprt(){
	 var qtId = $('#qtrIdDurtn').val();
	  $('#showQqrtrId').val(qtId); 
	 	 document.incomeEnhancement.method = "post";
		document.incomeEnhancement.action = "incomeEnhancementBasedOnQtr.html?<csrf:token uri='incomeEnhancementBasedOnQtr.html'/>";
		document.incomeEnhancement.submit(); 
}
function toFreeze(){
	 $("input").prop('disabled', false);
	document.incomeEnhancement.method = "post";
	document.incomeEnhancement.action = "frzUnfrzQprIncomeEnhancement.html?<csrf:token uri='frzUnfrzQprIncomeEnhancement.html'/>";
	document.incomeEnhancement.submit();
}	
</script>
</head>
    <section class="content">
        <div class="container-fluid">
            <div class="block-header">
            </div>
            
            <div class="row clearfix">
                <!-- Task Info -->
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <div class="card">
                        <div class="header">
                            <h2>Income Enhancement Quaterly Report</h2>
                        </div>
                            <form:form method="POST" id="incomeEnhancementId" name="incomeEnhancement" class="form-inline" action="incomeEnhancementQuaterly.html" modelAttribute="Qpr_Income_Enhancement" enctype="multipart/form-data">
                        <div class="body">
                           <input type="hidden" name="<csrf:token-name/>" value="<csrf:token-value uri="incomeEnhancementQuaterly.html"/>" />
                            <div><label><strong align="left">Quarter Duration</strong></label></div>
							<div align="center"><label>
								<select name="quarterDuration.qtrId" id="qtrIdDurtn" onchange="getSelelctedQtrRprt();"  class="form-control">
									 <c:forEach items="${quarter_duration}" var="duration">
										<c:choose>
					            				<c:when test="${duration.qtrId == SetNewQtrId}">
				                   					<option value="${duration.qtrId}" selected="selected">${duration.qtrDuration} </option>
				                   				</c:when>
				                   				<c:otherwise>
				                   					<option value="${duration.qtrId}">${duration.qtrDuration} </option>
				                   				</c:otherwise>
						                   	</c:choose>
		                   					<%-- <option value="${duration.qtrId}">${duration.qtrDuration} </option> --%>
			                       		</c:forEach>
                             	</select>
                             </label></div>
                             <br>
                            <div class="table-responsive">
                           <!--  <button type="button" id="addNewRowBtn" class="btn bg-green" onclick="addNewRow()">Add New Row</button> -->
                                <table class="table table-bordered" id="mytable">
                                    <thead>
                                        <tr>
                                        	<th rowspan="2">S.No.</th>
                                        	<th rowspan="2">Name of Activity</th>
                                        	<th rowspan="2">District Name</th>
                                        	<th rowspan="2">Fund Approved (in RS.)</th>
											<th rowspan="2"><div align="center"> Expenditure incurred</div></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                        <c:if test="${not empty dbActivitiesList}">
                           <c:forEach items="${dbActivitiesList.incomeEnhancementDetails}" var="dblist" varStatus="count">
                                    <tr>
                                       	<td>${count.count}</td>
                                       	<td><input  disabled="disabled" value="${dblist.activtyName}" required="required" maxlength="80" type="text" class="form-control"/></td>
	                                    	<td>
											<select required="required" class="form-control dId" onchange='callBlockList("${count.index}");' disabled="disabled" id="districtId${count.index}" >
												<c:forEach items="${districtList}" var="dlist">
		                                       			<c:if test="${dblist.districtCode == dlist.districtCode}">
						                               		<option value="${dlist.districtCode}" selected="selected">${dlist.districtNameEnglish}</option>
						                               	</c:if>
				                               	</c:forEach>
			                              	</select>
                                       	</td>
	                                    <td><input type="text" disabled="disabled" oninput="validity.valid||(value='');" min="1" value="${dblist.fundsRequired}" id="fundsName_${count.index}"  required="required" class="form-control"/></td>
									    <td><input type="text" maxlength="7" class="form-control expnditureId" id="expnditureId_${count.index}" oninput="compareFunds('${count.index}');" name="qprIncomeEnhancementDetails[${count.index}].expenditureIncurred" value="${qprEnhancement.qprIncomeEnhancementDetails[count.index].expenditureIncurred}" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');" /></td>
									 
                                 </tr>
                                        <input type="hidden" name="qprIncomeEnhancementDetails[${count.index}].incomeEnhancementDetails.incomeEnhancementDetailsId" value="${dblist.incomeEnhancementDetailsId}"/>
                                        <input type="hidden" name="incomeEnhancementActivity.incomeEnhancementId" value="${dbActivitiesList.incomeEnhancementId}">
										<input type="hidden" name="qprIncomeEnhancementId" value="${qprEnhancement.qprIncomeEnhancementId}">
										<input type="hidden" name="showQqrtrId" id="showQqrtrId">
										<input type="hidden" name="isFreeze" id="isFreeze" value="${qprEnhancement.isFreeze}" />
										<input type="hidden" name="qprIncomeEnhancementDetails[${count.index}].qprIncomeEnhancementDetailsId" value="${qprEnhancement.qprIncomeEnhancementDetails[count.index].qprIncomeEnhancementDetailsId}"/>
                      	 </c:forEach>
                      </c:if>
                                    </tbody>
                                </table><br><br><br><br><br><br>
                            </div>
                            <br/>
                           <%--  <div class="row clearfix">
                            		<div class="col-sm-2">
		                            <label >Total Funds</label>
		                            <input type="number" id="subTotal" value="${totalFundToCalc}" readonly="readonly">
	                            </div>
	                            <br>
	                            </div>
	                            <div class="row clearfix">
	                            <div class="col-sm-2">
		                            <label >Additional Requirements</label>
		                            <c:set var="addtnlReqrmnt" value="${addtnlReqrmnt + dbActivitiesList.additionalRequirement}"></c:set>
		                            <input type="number" oninput="validity.valid||(value='');" onKeyPress="if(this.value.length==7) return false;" value="${dbActivitiesList.additionalRequirement}" min="1" name="additionalRequirement" id="additioinalRequirements" required="required">
		                            </div>
	                           </div> <div class="row clearfix">
	                            <div class="col-sm-2">
		                            <label >Grand Total</label>
		                            <input type="number" id="grandTotal" value="${addtnlReqrmnt + totalFundToCalc}" readonly="readonly">
	                            </div> --%>
	                           </div> 
                              <div class="form-group text-right">
                               		<button type="button" id="frzButtn" onclick="toFreeze();" class="btn bg-green waves-effect">FREEZE</button>
	                                <button type="button" id="unFrzButtn" onclick="toFreeze();" class="btn bg-green waves-effect">UNFREEZE</button>
                                	<button type="submit" id="saveButtn" class="btn bg-green waves-effect">SAVE</button>
                                	<button type="button" id="clearButtn" onclick="onClear(this)" class="btn bg-light-blue waves-effect">CLEAR</button>
                                	<button type="button" onclick="onClose('home.html?<csrf:token uri='home.html'/>')"  class="btn bg-orange waves-effect">CLOSE</button>
                               </div>
                           </form:form>     
                        </div>
                    </div>
                </div>
                <!-- #END# Task Info -->
            </div>
    </section>
    </html>