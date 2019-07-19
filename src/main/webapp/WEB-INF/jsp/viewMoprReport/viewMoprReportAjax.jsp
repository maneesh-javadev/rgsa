<%@include file="../taglib/taglib.jsp"%>
<script>
 function showStateDropDown(){
	 
	 $('#finYearSelectId').val() > 0 ? $('#stateDropDownBlock').show() : $('#stateDropDownBlock').hide();
	 var finYear =  $('#finYearSelectId').val();
	 $.ajax({
	        type : "POST",
	        url : "fetchStateList.html?<csrf:token uri='fetchStateList.html'/>&finYear="+finYear,  
	        success : function(data) {
	        	var stateList = data.StateList;
	        	for(let i=0;i<stateList.length;i++){
	        		$('#stateSelectId').append('<option value='+stateList[i].stateCode+'>'+stateList[i].stateNameEnglish+'</option>');
	        	}
	        },
	        error : function(e) {
	            console.log("ERROR: ", e);
	        }
	        
	    });
 }
 
 function showDemoGraphAndAnnualOption(){
	 $('#stateSelectId').val() > 0 ? $('#optionChoosingBlock').show() : $('#optionChoosingBlock').hide();
 }
 
 function showDemographicData(){
	 if ($('#annualActionPlanId').is(':checked')) {
			$('#annualActionPlanId').attr("checked", false);
		}
	 $('#demoGraphicBlock').show();
	 $('#annualPlanBlock').hide();
	 $('#demoGraphicId').val(true);
	 
	 $.ajax({
	        type : "POST",
	        url : "",  
	        success : function(data) {
	        },
	        error : function(e) {
	            console.log("ERROR: ", e);
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
						<h3 style="padding-top : 25px;">&nbsp;&nbsp; Demographic Profile and Annual Action Plan Wise Report</h3>
					</div>
					<br />
					<form:form method="post" name="viewReportAtMopr" action=""
						modelAttribute="VIEW_REPORT_MODEL">
						<div class="row">
							<div class="col-sm-2">
								<label for="finYear">&nbsp;&nbsp; Select financial year
									: </label>
							</div>
							<div class="col-sm-4">
								<form:select class="form-control"
									onchange="showStateDropDown()"
									id="finYearSelectId" path="">
									<option value="0">Select fin year</option>
									<c:forEach items="${FIN_YEAR_LIST}" var="finYear">
										<option value="${finYear.yearId}">${finYear.finYear}</option>
									</c:forEach>
								</form:select>
							</div>
						</div>
						<br />

						 <div class="row" id="stateDropDownBlock" style="display: none;">
							<div class="col-sm-2">
								<label for="state">&nbsp;&nbsp; Select State : </label>
							</div>
							<div class="col-sm-4">
								<form:select class="form-control" id="stateSelectId"
									onchange="showDemoGraphAndAnnualOption()" path="">
									<option value="0">Select State</option>
								</form:select>
							</div>
						</div>
						<br />

						 <div class="row" id="optionChoosingBlock" style="display : none;">
							<div class="col-sm-2" >
								<label for="DemoGraphicProfile">&nbsp;&nbsp;Demographic
									Profile : </label>
							</div>
							<div class="col-sm-3">
								<input type="radio" id="demoGraphicId" class="radio"
									name="" onclick="showDemographicData()" />
							</div>
							<div class="col-sm-2">
								<label for="DemoGraphicProfile">Annual Action Plan : </label>
							</div>
							<div class="col-sm-3">
								<input type="radio" id="annualActionPlanId" class="radio"
									name="" onclick="showAnnualActionPlanData()" />
							</div>
						</div>
						<!-- <div class="body">
							<div id="demoGraphicBlock" style="display: none;">
								Demographic block is under Development</div>
							<div id="annualPlanBlock" style="display: none;">
								Annual Action Plan
							</div>
						</div> -->
					</form:form>
				</div>
			</div>
		</div>
	</div>
</section>