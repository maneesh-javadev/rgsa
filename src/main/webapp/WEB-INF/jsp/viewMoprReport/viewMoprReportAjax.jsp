<%@include file="../taglib/taglib.jsp"%>
<section class="content">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h3>&nbsp;&nbsp; Report</h3>
					</div>
					<br />
					<form:form method="post" name="viewReportAtMopr" action=""
						modelAttribute="">
						<div class="row">
							<div class="col-sm-2">
								<label for="finYear">&nbsp;&nbsp; Select financial year
									: </label>
							</div>
							<div class="col-sm-4">
								<form:select class="form-control"
									onchange="showStateDropDown()"
									id="finYearDropDownId" path="">
									<option value="0">Select fin year</option>
									<c:forEach items="${FIN_YEAR_LIST}" var="finYear">
										<option value="${finYear.yearId}">${finYear.finYear}</option>
									</c:forEach>
								</form:select>
							</div>
						</div>
						<br />

						<div class="row" id="stateDropDownBlock">
							<div class="col-sm-2">
								<label for="state">&nbsp;&nbsp; Select State : </label>
							</div>
							<div class="col-sm-4">
								<form:select class="form-control" id="stateDropDownId"
									onchange="showDemoGraphAndAnnualOption()" path="">
									<option value="0">Select State</option>
								</form:select>
							</div>
						</div>
						<br />

						<div class="row" id="optionChoosingBlock">
							<div class="col-sm-2" >
								<label for="DemoGraphicProfile">&nbsp;&nbsp;Demographic
									Profile : </label>
							</div>
							<div class="col-sm-3">
								<input type="radio" id="demoGraphicId" class="radio"
									name="" onclick="showTableContent('demo')" />
							</div>
							<div class="col-sm-2">
								<label for="DemoGraphicProfile">Annual Action Plan : </label>
							</div>
							<div class="col-sm-3">
								<input type="radio" id="annualActionPlanId" class="radio"
									name="" onclick="showTableContent('annual')" />
							</div>
						</div>
						<div class="body">
							<div id="demoGraphicBlock" style="display: none;">
								Demographic block is under Development</div>
							<div id="annualPlanBlock" style="display: none;">
								Annual Action Plan
							</div>
						</div>
					</form:form>
				</div>
			</div>
		</div>
	</div>
</section>