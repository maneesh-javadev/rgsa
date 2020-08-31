<html >
<%@include file="../taglib/taglib.jsp"%>
<head>
<style>
.table_kpi {
    width: 94%;
    max-width: 100%;
    margin-bottom: 20px;
    margin-left: 20px;
    margin-right: 20px;
        font-size: smaller;
}

.margin_left{
margin-left: 5px;
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


					
						<form:form  name="showKpisRecord" action=""  modelAttribute="FETCH_KPIS_RECORD_MODEL">
						<input type="hidden" name="<csrf:token-name/>"value="<csrf:token-value uri="fetchKpisRecordFormPost"/>" />	
						
						<table class="table table-hover dashboard-task-infos table_kpi" id="example"  width="80%" >
									
											<tr>
											    <th>S.No.</th>
												<th>Master Code</th>
												<th>State Code</th>
												<th>State Name</th>
												<th>Sector Code</th>
												<th>Dept Code</th>
												<th>Project Code</th>
												<th>No. of Trainings to ERs</th>
												<th>Panchayat bhawans constructed</th>
												<th>panchayat bhawans repaired</th>
												<th>CSCs co-located</th>
												<th>HR support at SPRC and DPRC</th>
												<th>Data Port Mode</th>
												<th>Mode Desc</th>
												<th>Level of Data</th>
												<th>Year</th>
												<th>Month</th>
												<th>Data Dt</th>
											</tr>
									
									  
										<c:forEach   items="${kpisRecords}" varStatus="rowstatus" var="obj">
												<tr>
												 <td><c:out value="${rowstatus.count}"/></td>
												 <td><c:out value="${obj.mCode}"/></td>
												 <td><c:out value="${obj.stateCode}"/></td>
												 <td><c:out value="${obj.stateNameEnglish}"/></td>
												 <td><c:out value="${obj.sectorCode}"/></td>
												 <td><c:out value="${obj.deptCode}"/></td>
												 <td><c:out value="${obj.projectCode}"/></td>
												 <td><c:out value="${obj.cnt1}"/></td>
												 <td><c:out value="${obj.cnt2}"/></td>
												 <td><c:out value="${obj.cnt3}"/></td>
												 <td><c:out value="${obj.cnt4}"/></td>
												 <td><c:out value="${obj.cnt5}"/></td>
												 <td><c:out value="${obj.dataportMode}"/></td>
												 <td><c:out value="${obj.modeDesc}"/></td>
												 <td><c:out value="${obj.dataLvlCode}"/></td>
												 <td><c:out value="${obj.yr}"/></td>
												 <td><c:out value="${obj.mnth}"/></td>
												 <td>
												 	<fmt:formatDate var="ObjDatecr" value="${obj.dataDt}" pattern="dd/MM/yyyy" />
												 	<c:out value="${ObjDatecr}"/>
												 </td>
												
												</tr>
												
											</c:forEach>
									
									</table>	
                         
                                <br>
                            <hr>
                  <div class="row">
                 <div class="col-sm-4"></div>  
                 <div class="col-sm-5"></div>     
                <div class="text-left" >
				 <button type="button" class="btn bg-primary col-sm-1 margin_left">Push Data</button>
				 <button type="button" onclick="onClose('fetchKpisRecordForm.html?<csrf:token uri='fetchKpisRecordForm.html'/>')" class="btn bg-primary waves-effect margin_left">
									BACK
								</button>
				 <button type="button" onclick="onClose('home.html?<csrf:token uri='home.html'/>')" class="btn bg-red waves-effect margin_left">
									<spring:message code="Label.CLOSE" htmlEscape="true" />
								</button>
				</div>
				</div>
                <br> 
						
						
						
						
							                  
						  
                <br> 
                           			                  
			 </form:form>   
	  
					</div>
					</div>
  			 </div>
 		</div>
		</section>
		
		</body>
					
</html>


