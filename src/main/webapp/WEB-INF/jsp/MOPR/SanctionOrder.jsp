<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Insert title here</title>
	<%@include file="../taglib/taglib.jsp"%>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/datepicker/css/bootstrap-datetimepicker.min.css">
	
    <script src="${pageContext.request.contextPath}/resources/plugins/ckeditor/js/ckeditor.js"></script>
    <script src="${pageContext.request.contextPath}/resources/plugins/ckeditor/js/angular.js"></script>
    <script src="${pageContext.request.contextPath}/resources/plugins/ckeditor/js/ng-ckeditor.min.js"></script> 
	
	
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/datepicker/js/bootstrap-datetimepicker.min.js"></script>
	
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/SanctionOrder/sanctionOrderController.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/SanctionOrder/sanctionOrderService.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/SanctionOrder/sanctionOrder.js"></script>
	
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/toastr.min.js"></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/angular/toastr.css">
	<style>
	.input-group {
	 margin-bottom: 0px !important; 
	}
	</style>

</head>
<body ng-app="publicModule">

<section class="content" ng-controller="sanctionOrderController">
		<div class="container-fluid">
			<div class="row clearfix">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="card">
						<div class="header">
							<h2>Sanction Order</h2>
						</div>
						<form modelAttribute="sanctionOrder" name="myForm">
						<div class="body">
							
							<%-- <div class="row">
    							<div class="col-xs-4">
    							<label for="finYear"><c:out value="Select Finanicial Year" /></label>
    							</div>
								<div class="col-xs-4">
									<select  data-ng-model="finYearModel" data-ng-change="fetchState(finYearModel,finYears)"  class="form-control" id="finYear"
											ng-options="item.yearId as item.finYear for item in finYears">
									</select> 
								</div>		
							</div> --%>
							
							
							<div class="row">
    							<div class="col-xs-4">
    							<label for="state"><c:out value="Select State Name" /></label>
    							</div>
								<div class="col-xs-4">
									<select  class="form-control" data-ng-model="stateModel"  ng-options="item.stateCode as item.stateNameEnglish for item in states" >
									 <option  value="">Select State</option>
									</select>
									 
								</div>		
							</div>
							
							<div class="row">
    							<div class="col-xs-4">
    							<label for="state"><c:out value="Select Sanction Order Component " /></label>
    							</div>
								<div class="col-xs-4">
									<select  class="form-control" data-ng-model="soComponentModel"  ng-options="item.soComponentId as item.soComponentName for item in sanctionOrderComponent" >
										 <option  value="">Select Sanction Order Component </option>			
									</select>
								</div>		
							</div>
							
							<%-- <div class="row">
    							<div class="col-xs-4">
    							<label for="fileNo"><c:out value="Enter File No." /></label>
    							</div>
    							<div class="form-group">
								<div class="col-xs-4">
									<div class="form-line">
										<input type="text"  class="form-control" ng-model="fileModel" maxlength="20"  autocomplete="off" 
									 required>
										
									</div>
								</div>	
								</div>	
							</div> --%>
							
							<div class="row">
    							<div class="col-xs-4">
    							<label for="fileNo"><c:out value="Select Date." /></label>
    							</div>
    							<div class="form-group">
								<div class="col-xs-4">
									<div class="form-line">
										<div class="input-group date datepicker" id="bsanctionDate">
										<input type="text"  class="form-control"   id="sanctionDate"  />
										<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
										</div>
										
									</div>
								</div>	
								</div>	
							</div>
							
							
				
				<%-- 		 <div class="row">
    							<div class="col-xs-4">
    							<label for="fileNo"><c:out value="Total Fund Sanction" /></label>
    							</div>
    							<div class="form-group">
								<div class="col-xs-4">
									<div class="form-line">
										<input type="text"  class="form-control" ng-model="totalFundModel" maxlength="20"  autocomplete="off" 
									 required>
										
									</div>
								</div>	
								</div>	
							</div>
							
						<div class="row">
    							<div class="col-xs-4">
    							<label for="fileNo"><c:out value="Partly Release Fund" /></label>
    							</div>
    							<div class="form-group">
								<div class="col-xs-4">
									<div class="form-line">
										<input type="text"  class="form-control" ng-model="relFundModel"  maxlength="20"  autocomplete="off" 
									 required>
										
									</div>
								</div>	
								</div>	
							</div>
							
						 <div class="row">
    							<div class="col-xs-4">
    							<label for="fileNo"><c:out value="DY No." /></label>
    							</div>
    							<div class="form-group">
								<div class="col-xs-4">
									<div class="form-line">
										<input type="text"  class="form-control"  ng-model="dyNoModel" maxlength="20"  autocomplete="off" 
									 required>
										
									</div>
								</div>	
								</div>	
							</div>
							
							<div class="row">
    							<div class="col-xs-12">
							    	<textarea cols="80"  ng-model="content"  rows="10" data-ck-editor>
							    	<%@include file="sancionOrderTemplate.jsp"%>

							    	
							    	
							    	</textarea>
    							
								</div>	
							</div> --%>
							
							 <div class="row">
    							<div class="col-xs-4">
    							<label for="upload file"><c:out value="Upload Sanction Order " /></label>
    							</div>
    							<div class="form-group">
								<div class="col-xs-4">
									<div class="form-line">
										<input type="file"  class="form-control"  file-model = "myFile" maxlength="20"  autocomplete="off" 
									 required>
										
									</div>
								</div>	
								</div>	
							</div>
							
							<div class="form-group text-right">
										<button type="button"  ng-click="uploadFile()" class="btn bg-green waves-effect">
											Save
										</button>
										<!-- <button type="button" class="btn bg-light-blue waves-effect reset">PUBLISH TEMPLATE</button> -->
										<button type="button"
											onclick=" onClose('home.html?<csrf:token uri='home.html'/>')"
											class="btn bg-orange waves-effect">
											<spring:message code="Label.CLOSE" htmlEscape="true" />
										</button>
							</div>
							</div>
						</form>
						
					</div>
				</div>
			</div>
		</div>
</section>
		

</body>
</html>