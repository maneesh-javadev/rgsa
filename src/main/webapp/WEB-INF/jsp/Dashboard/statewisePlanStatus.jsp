<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html ng-app="publicModule">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Statewise Paln Status</title>
	<%@include file="../taglib/taglib.jsp"%>

  	<link rel="stylesheet" href="https://js.arcgis.com/3.22/dijit/themes/claro/claro.css">
  	<link rel="stylesheet" href="https://js.arcgis.com/3.20/esri/css/esri.css">
   <script src="https://js.arcgis.com/3.20/"></script>
  
 		
  		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/bootstrap/css/bootstrap.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/index/css/main.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/core/gis.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/font-awesome/font-awesome-4.2.0/css/font-awesome.min.css">
		<!-- <script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/jquery/jquery-3.1.0.min.js"></script> -->
	<script  type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/jquery/jquery.min.js"></script>
	<script  type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/bootstrap/js/bootstrap.min.js"></script>
  	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/dashboard/statewisePlanStatusController.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/dashboard/statewisePlanStatus.js"></script>
	<!--  <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/dashboard/gisMapStatePlanStatus.js"></script>
	-->
	
</head>
<body>
<header id="header">
			
				<div class="col-xs-1"><a href="index.html" class="logo"><img src="${pageContext.request.contextPath}/resources/index/images/emblem.png" alt="Emblem" class="img-reponsive"></a></div>
				
				<div class="col-lg-8 col-xs-6">
				
				<a href="index.html" class="logo"> <strong>Rashtriya Gram Swaraj Abhiyan <span class="hidden-md hidden-sm hidden-xs">(RGSA)</span></strong><br />Government of India</a></div>
				<nav>
				
				<a href="Home.html?<csrf:token uri='Home.html'/>"><i class="fa fa-home"></i> Home</a>
				<a href="index.html?<csrf:token uri='index.html'/>"><i class="fa fa-undo" aria-hidden="true"> Back</i></a>
				</nav>
</header>
<section class="content" ng-controller="statewisePlanStatusController">
		<div class="container-fluid">
			<div class="row clearfix">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="card">
						<div class="header">
							<h2><center>Statewise Plan Status</center></h2>
						</div>
						<div class="body">
							 <div class="loading" id="loader">
								  <div class="loading-bar"></div>
								  <div class="loading-bar"></div>
								  <div class="loading-bar"></div>
								  <div class="loading-bar"></div>
								</div>
								<div id="map" >
								
								</div>  
								 <div id="legend" style="width: 210px; position: absolute; left: 20px; bottom: 60px; background-color: #F0F0F0; z-index: 4; display: block">
							    	<div>
							         <div id="title" class="title1" style="display: block;padding:2px"></div>
							      </div> 
							   		<div id="thematiclgnd" >
							                    <table id="tableGis " >
							                        <tr id="unfreeze">
							                            <td  width="20" height="23" style="background-color: rgba(204, 38, 60, 0.9);"></td>
							                            <td>&nbsp;&nbsp;&nbsp;&nbsp;<label>Proposal Not Yet Initiated</label></td>
							                        </tr>
							                        
							                        <tr id="PFreeze">
							                            <td width="20" height="23" style="background-color: rgba(229, 214, 95, 0.9);"></td>
							                            <td>&nbsp;&nbsp;&nbsp;&nbsp;<label>Proposal Under Development</label></td>
							                        </tr>
							                        <tr id="Freeze">
							                            <td  width="20" height="23" style="background-color: rgba(0, 204, 0, 0.9);"></td>
							                            <td>&nbsp;&nbsp;&nbsp;&nbsp;<label>Proposal Submitted</label></td>
							                        </tr>
							                       
							                    </table>
							      </div>
    							</div>
    							
    							<!-- Modal content summary#started-->
							      <div class="modal fade" id="summaryAlert" role="dialog">
								    <div class="modal-dialog">
								      <!-- Modal content-->
								      <div class="modal-content">
								        <div class="modal-header">
										  <button type="button" class="close" data-dismiss="modal">&times;</button>
								          <h4 class="modal-title" id="summaryAlertHead"></h4>
								        </div>
								        <div class="modal-body" id="summaryAlertBody">
								         
								        </div>
								        
								      </div>
								      
								    </div>
								  </div>	
								<!-- Modal content summary#end-->
								<!-- Modal content details#started-->
							      <div class="modal fade" id="DetaildAlert" role="dialog">
								    <div class="modal-dialog" style="width:950px;">
								      <!-- Modal content-->
								      <div class="modal-content">
								        <div class="modal-header">
										  <button type="button"  class="close" data-dismiss="modal">&times;</button>
								          <h4 class="modal-title" id="DetaildHead">State wise Plan Details</h4>
								        </div>
								        <div class="modal-body" id="DetaildBody">
								         <iframe id="myIframe" width="910" height="650"></iframe>
								        </div>
								        
								      </div>
								      
								    </div>
								  </div>	
								<!-- Modal content details#end-->
						</div>
					</div>
				</div>
			</div>
		</div>
</section>
		

</body>
</html>