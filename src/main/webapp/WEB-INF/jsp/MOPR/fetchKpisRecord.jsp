<html>
<%@include file="../taglib/taglib.jsp"%>

<head>
<style>

.margin_left{
margin-left: 5px;
}

.margin_top{
margin-top: 10px;
}

.margin_top_2x{
margin-top: 40px;
}

</style>
</head>

<body>

	<section class="content" >
		<div class="container-fluid">
			<div class="row clearfix">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="card">
						<div class="header">
							<h2>Kips State Wise Record
							<!-- <span class="glyphicon glyphicon-download-alt" onclick="fnExcelReport('mytable')"></span>
						 <span class="glyphicon glyphicon-print" onclick="exportToPdf('home_with_icon_title')"></span> -->
							</h2>
							
						</div>


						<form:form method="post" name="viewKpisRecord" action="fetchKpisRecordFormPost.html" modelAttribute="FETCH_KPIS_RECORD_MODEL">
						<input type="hidden" name="<csrf:token-name/>"value="<csrf:token-value uri="fetchKpisRecordFormPost.html"/>" />		                  
								                  
					  <div id="finyear"  class="form-group">
					  <div class="row margin_top_2x">
					   <div class="col-sm-2"></div>
					   <label  class="col-sm-3 control-label" for="financialYear">Select Financial Year<font color="red">*</font></label>	
						 <div class="col-sm-5">
						  <select id="year" name="yr" class="col-sm-5 ">
                          <option value="-1">Select</option>
                          <option value="2018">2018</option>
                          <option value="2019">2019</option>
                          <option value="2020">2020</option>
                         
                          </select>
                          </div>
                        </div>  
                        <br>
                         <div class="row margin_top">
                         <div class="col-sm-2"></div>
					     <label class="col-sm-3 control-label" for="installmentno">Select Half Year Duration <font color="red">*</font></label>	
						 <div class="col-sm-5">
						  <select id="installmentno" name="halfYear" class="col-sm-5">
                          <option value="1">First Half</option>
                          <option value="2">Second Half</option>
                          </select>
                          </div>
                          </div>
                          </div>
                         <br>
                         <br>
                         <br>
                         
                        <hr> 
                        
                        <div class="row">
                 <div class="col-sm-4"></div>  
                 <div class="col-sm-6"></div>     
                 <div class="text-left" class="col-sm-2">
			     <button type="submit" class="btn btn-primary">Get Data</button> 
			     <button type="button" onclick="onClose('home.html?<csrf:token uri='home.html'/>')" class="btn bg-red waves-effect">
									<spring:message code="Label.CLOSE" htmlEscape="true" />
								</button>
				</div>
				</div>
                <br> 
                         
               	</form:form>   
              
					
					</div>
					</div>
					</div>
					</div>
					</section>
					

</body>
</html>