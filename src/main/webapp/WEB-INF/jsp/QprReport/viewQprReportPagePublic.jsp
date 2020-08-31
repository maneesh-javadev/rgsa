<html>
<head>
<%@include file="../taglib/taglib.jsp"%>
<%@include file="viewQprReportPagePublicJs.jsp"%>

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
					<select class="form-control" id="inputFinYear" onchange="diabledQuarterFn(this)"  >
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
					
					<div id="hideShow">
					 <div class="col-md-3">
											<label class="control-label" > Please enter Capatcha: </label>
								<input cssStyle="color:black;" id="captchaAnswer"  placeholder="Captcha Answer" class="form-control"  autocomplete="off" required="required"/>
								
							<div class="col-sm-2">  
									<img src="captchaImage" width="208px" id="img_Capatcha" /></div>
									<div class="col-sm-10">
									 <i class="fa fa-2x fa-refresh pull-right capcha_ref_pos" onclick="refreshCaptcha()"></i>
								
									
							</div>
							</div>
					
						<div class="col-md-3" style="margin-top:2%">
							<button type="button" onclick="ajaxCallFunction();" class="btn btn-primary"><span class="glyphicon glyphicon-search"></span>&nbsp; Search</button>
							<!-- <button type="button" onclick="exportToPdf('tableExp');" class="btn btn-primary"><span class="glyphicon glyphicon-print"></span>&nbsp; Print</button> -->
						</div>
					
					</div>
					
					<div class="col-md-2"  id="printButtonDiv" style="display:none;margin-top: 27px;margin-left: 38px;">
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
		     <a data-toggle="collapse" data-parent="" href="#collapse4">
		      <h4 class="panel-title">
		       	e-Governance Support Group
		      </h4></a>
		    </div>
		    <div id="collapse4" class="panel-collapse collapse">
		      <div class="panel-body">
		      	<table class="table table-bordered" id="egov_SupportGrpId"></table>
		      </div>
		    </div>
		  </div>
		  
		  
		  
		  <div class="panel panel-default">
		    <div class="panel-heading">
		     <a data-toggle="collapse" data-parent="" href="#collapse5">
		      <h4 class="panel-title">
		       	PESA Plan
		      </h4></a>
		    </div>
		    <div id="collapse5" class="panel-collapse collapse">
		      <div class="panel-body">
		      	<table class="table table-bordered" id="pesa_PlanId"></table>
		      </div>
		    </div>
		  </div>


		<div class="panel panel-default">
				    <div class="panel-heading">
				     <a data-toggle="collapse" data-parent="" href="#collapse6">
				      <h4 class="panel-title">
				      	Distance learning Facility through SATCOM/IP based virtual Class room/similar technology
				      </h4></a>
				    </div>
				    <div id="collapse6" class="panel-collapse collapse">
				      <div class="panel-body">
				      	<table class="table table-bordered" id="satcomipid"></table>
				      </div>
				    </div>
				  </div>

				<div class="panel panel-default">
				    <div class="panel-heading">
				     <a data-toggle="collapse" data-parent="" href="#collapse7">
				      <h4 class="panel-title">
				      	Income Enhancement Quaterly Report
				      </h4></a>
				    </div>
				    <div id="collapse7" class="panel-collapse collapse">
				      <div class="panel-body">
				      	<table class="table table-bordered" id="IncomeEnhancementId"></table>
				      </div>
				    </div>
				  </div>


			<div class="panel panel-default">
		    <div class="panel-heading">
		     <a data-toggle="collapse" data-parent="" href="#collapse8">
		      <h4 class="panel-title">
		      	 Proposal for Information, Education, Communication (IEC) Progress Report
		      </h4></a>
		    </div>
		    <div id="collapse8" class="panel-collapse collapse">
		      <div class="panel-body">
		      	<table class="table table-bordered" id="iecProgressReportId"></table>
		      </div>
		    </div>
		  </div>
		  
		  <div class="panel panel-default">
		    <div class="panel-heading">
		     <a data-toggle="collapse" data-parent="" href="#collapse9">
		      <h4 class="panel-title">
		      	 PMU Progress Report
		      </h4></a>
		    </div>
		    <div id="collapse9" class="panel-collapse collapse">
		      <div class="panel-body">
		      	<table class="table table-bordered" id="pmuProgressReportId"></table>
		      </div>
		    </div>
		  </div>
		  
		  <div class="panel panel-default">
		    <div class="panel-heading">
		     <a data-toggle="collapse" data-parent="" href="#collapse10">
		      <h4 class="panel-title">
		      	 Administrative And Technical Support to Gram Panchayat
		      </h4></a>
		    </div>
		    <div id="collapse10" class="panel-collapse collapse">
		      <div class="panel-body">
		      	<table class="table table-bordered" id="adminAndTechSupportReportId"></table>
		      </div>
		    </div>
		  </div>
		  
		  
		  <div class="panel panel-default">
		    <div class="panel-heading">
		     <a data-toggle="collapse" data-parent="" href="#collapse11">
		      <h4 class="panel-title">
		      	 Panchayat Bhawan Progress Report
		      </h4></a>
		    </div>
		    <div id="collapse11" class="panel-collapse collapse">
		      <div class="panel-body">
		      	<table class="table table-bordered" id="panchyatbhawanProgressReportId"></table>
		      </div>
		    </div>
		  </div>
		  
		  
		  <div class="panel panel-default">
		    <div class="panel-heading">
		     <a data-toggle="collapse" data-parent="" href="#collapse12">
		      <h4 class="panel-title">
		       e-Enablement Quarter Progress Report
		      </h4></a>
		    </div>
		    <div id="collapse12" class="panel-collapse collapse">
		      <div class="panel-body">
		      	<table class="table table-bordered" id="eEnablementId"></table>
		      </div>
		    </div>
		  </div>
		  
		   <div class="panel panel-default">
		    <div class="panel-heading">
		     <a data-toggle="collapse" data-parent="" href="#collapse13">
		      <h4 class="panel-title">
		       Institutional Infrastructure
		      </h4></a>
		    </div>
		    <div id="collapse13" class="panel-collapse collapse">
		      <div class="panel-body">
		      	<table class="table table-bordered" id="InstitutionalInfrastructureId"></table>
		      </div>
		    </div>
		  </div>
		  
		   <div class="panel panel-default">
		    <div class="panel-heading">
		     <a data-toggle="collapse" data-parent="" href="#collapse14">
		      <h4 class="panel-title">
		       Innovative Activity Quaterly Report
		      </h4></a>
		    </div>
		    <div id="collapse14" class="panel-collapse collapse">
		      <div class="panel-body">
		      	<table class="table table-bordered" id="InnovativeActiveId"></table>
		      </div>
		    </div>
		  </div>
		  
		  <div class="panel panel-default">
		    <div class="panel-heading">
		     <a data-toggle="collapse" data-parent="" href="#collapse15">
		      <h4 class="panel-title">
		       Admin And Financial Data Cell Quaterly Report 
		      </h4></a>
		    </div>
		    <div id="collapse15" class="panel-collapse collapse">
		      <div class="panel-body">
		      	<table class="table table-bordered" id="adminFinancialId"></table>
		      </div>
		    </div>
		  </div>
		  

</div> 


								</div>	 
 			 
								<div class="text-left" id="backButtonId" style="display:none">
										<button type="button"
												onclick="onClose('qprReportInstallmentWiseForPublic.html?<csrf:token uri='qprReportInstallmentWiseForPublic.html'/>')"
												class="btn bg-orange waves-effect">
												<i class="fa fa-arrow-left" aria-hidden="true"></i>
												<spring:message code="Label.BACK" htmlEscape="true" />
											</button>
											
											<button type="button"
											onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
											class="btn bg-red waves-effect">
											<spring:message code="Label.CLOSE" htmlEscape="true" />
										</button>
										</div>	
	 
						 
					</div>
				</div>
			</div>
		</div>
	</div>
 </section>
</html>
