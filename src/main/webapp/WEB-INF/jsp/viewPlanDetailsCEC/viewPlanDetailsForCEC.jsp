<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<%@include file="../taglib/taglib.jsp"%>
	<script  type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
	<script>
toggleSubComponent=function(id,flag){
	$(".slide"+id).slideToggle();
	$(".slidex"+id).slideToggle();
	 if($('#collapseRow'+id).css('display') == 'none'){
     	$("#collapseRow"+id).show();
     	$("#expendRow"+id).hide();
     }else{
     	$("#collapseRow"+id).hide();
     	$("#expendRow"+id).show();
     }
	
};
</script>
</head>
<body>


<section class="content">
		<div class="container-fluid">
			<div class="row clearfix">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="card">
						<div class="header">
							<h2>Plan Forwarded By ${stateName}/MOPR</h2>
						</div>
						<div class="body">
							<c:set var="buttonStatus" value="false" />
							<c:if test="${sessionScope['scopedTarget.userPreference'].planStatus eq 4}">
							<c:set var="buttonStatus" value="true" />
							</c:if>
							<c:choose>
							<c:when test="${sessionScope['scopedTarget.userPreference'].userType eq 'M'}">
							<c:set var="dwidth" value="30%" />
							<c:set var="dsubwidth" value="15%" />
							<c:set var="dcolspan" value="8"/>
							</c:when>
							<c:otherwise>
							<c:set var="dwidth" value="20%" />
							<c:set var="dsubwidth" value="10%" />
							<c:set var="dcolspan" value="10"/>
							</c:otherwise>
						</c:choose>
						<table class="table table-hover dashboard-task-infos">
		
										<thead>
											<tr>
												<th rowspan="2" width="5%"></th>
												<th rowspan="2" width="5%">Sr.No</th>
												<th rowspan="2" width="22%" >Components</th>
												<th rowspan="2" width="13%">
												<c:if test="${buttonStatus}">
												View Details
												</c:if>
												</th>
												<td colspan="2" align="center" width="${dwidth}"><b> Amount State Proposed</b></td>
												<td colspan="2" align="center" width="${dwidth}"><b>Ministry Recomended</b></td>
												<c:if test="${sessionScope['scopedTarget.userPreference'].userType eq 'C'}">
												<td colspan="2" align="center" width="${dwidth}"><b>CEC Approved</b></td>
												</c:if>
												<c:if test="${sessionScope['scopedTarget.userPreference'].userType eq 'S'}">
												<th></th>
												</c:if>
											</tr>
											<tr>
												
												
												<td width="${dsubwidth}" align="right"><b>Amount</b></td>
												<td width="${dsubwidth}" align="right" style="padding-right:20px"><b>No. of Unit</b></td>
												
												<td width="${dsubwidth}" align="right"><b>Amount</b></td>
												<td width="${dsubwidth}" align="right" style="padding-right:20px"><b>No. of Unit</b></td>
												<c:if test="${sessionScope['scopedTarget.userPreference'].userType eq 'C'}">
												<td width="${dsubwidth}" align="right"><b>Amount</b></td>
												<td width="${dsubwidth}" align="right" style="padding-right:20px"><b>No. of Unit</b></td>
												</c:if>
											</tr>
										</thead>
										<c:set var="t_fund" value="0"/>
										<c:set var="t_unit" value="0"/>
										<tbody>
										
										<c:forEach items="${planComponentsFunds}" var="pc" varStatus="pcindex">
										  	<c:if test="${pc.eType eq 'C'}">
										  			<c:set var="moprDiff" value="bg-test" />
										  			<c:if test="${pc.amountProposed gt pc.amountProposedMOPR}">
														<c:set var="moprDiff" value="bg-warning" />
													</c:if>
													<tr>
														<td align="center" id="plusId${pc.componentsId}" >
															<c:if test="${pc.componentsId ne 11 and pc.componentsId ne 12}">
															<div id="expendRow${pc.componentsId}" onclick="toggleSubComponent('${pc.componentsId}',true)"><i class="fa fa-plus-circle" aria-hidden="true"></i></div>
															<div id="collapseRow${pc.componentsId}" onclick="toggleSubComponent('${pc.componentsId}',false)" style="display:none;"><i class="fa fa-minus-circle" aria-hidden="true"></i></div>
															</c:if>
								 						</td>
														<td><b>${pcindex.count}</b></td>
														<td><b>${pc.eName}</b></td>
														<c:if test="${buttonStatus}">
														<td style="padding-left: 40px"><b><a href="${pc.link}?menuId=0&<csrf:token uri='${pc.link}'/>"><i class="fa fa-external-link" aria-hidden="true"></i></a></b></td>
														 </c:if>
														
														<td align="right">
														<c:if test="${(pc.amountProposed+pc.addtionalRequirement)>0}">
															<b><fmt:formatNumber type = "number"      maxFractionDigits = "3" value = "${pc.amountProposed+pc.addtionalRequirement}" /></b>
														</c:if>
														</td>
														<td align="right" style="padding-right:20px"><b><c:out value="${pc.noOfUnits}"/></b> </td>
														
														
														<td align="right" class="${moprDiff}">
														<c:if test="${(pc.amountProposedMOPR+pc.addtionalRequirementMOPR)>0}">
															<b><fmt:formatNumber type = "number"      maxFractionDigits = "3" value = "${pc.amountProposedMOPR+pc.addtionalRequirementMOPR}" /></b>
														</c:if>
														</td>
														<td align="right" style="padding-right:20px"><b><c:out value="${pc.noOfUnitsMOPR}"/></b> </td>
														
														
														
														
														<c:if test="${sessionScope['scopedTarget.userPreference'].userType eq 'C'}">
														<c:set var="cecDiff" value="bg-test" />
									  						<c:if test="${pc.amountProposedMOPR gt pc.amountProposedCEC}">
																	<c:set var="cecDiff" value="bg-warning" />
															</c:if> 
														
														<td align="right" class="${cecDiff}">
														<c:if test="${(pc.amountProposedCEC+pc.addtionalRequirementCEC)>0}">
															<b><fmt:formatNumber type = "number"      maxFractionDigits = "3" value = "${pc.amountProposedCEC+pc.addtionalRequirementCEC}" /></b>
														</c:if>
														</td>
														<td align="right" style="padding-right:20px"><b><c:out value="${pc.noOfUnitsCEC}"/></b> </td>
															
														</c:if>
														<c:set var="t_fund" value="${t_fund+pc.amountProposed+pc.addtionalRequirement}" />
														<c:set var="t_unit" value="${t_unit+pc.noOfUnits}"/>
														<c:set var="t_fund_mopr" value="${t_fund_mopr+pc.amountProposedMOPR+pc.addtionalRequirementMOPR}" />
														<c:set var="t_unit_mopr" value="${t_unit_mopr+pc.noOfUnitsMOPR}"/>
														<c:set var="t_fund_cec" value="${t_fund_cec+pc.amountProposedCEC+pc.addtionalRequirementCEC}" />
														<c:set var="t_unit_cec" value="${t_unit_mopr+pc.noOfUnitsCEC}"/>
														
													</tr>
												
												<c:set var="pscindex" value="0"/> 
												
												<c:forEach items="${planComponentsFunds}" var="psc" >
													<c:if test="${psc.eType eq 'S' and pc.componentsId==psc.componentsId }">
													<c:set var="pscindex" value="${pscindex+1}"/>
													<c:set var="moprDiff" value="bg-test" />
										  			<c:if test="${psc.amountProposed gt psc.amountProposedMOPR}">
														<c:set var="moprDiff" value="bg-warning" />
													</c:if>
													
														<tr class="slide${pc.componentsId}"  style="display: none;">
															<td></td>
															<td >&#${96+pscindex})</td>
															
															<td >${psc.eName}</td>
															<td></td>
																<td align="right">
																	<fmt:formatNumber type = "number"      maxFractionDigits = "3" value = "${psc.amountProposed}" />		
																</td>
																<td align="right" style="padding-right:20px">${psc.noOfUnits}</td>
																<td align="right" class="${moprDiff }">
																	<fmt:formatNumber type = "number"      maxFractionDigits = "3" value = "${psc.amountProposedMOPR}" />		
																</td>
																<td align="right" style="padding-right:20px">${psc.noOfUnitsMOPR}</td>
																<c:if test="${sessionScope['scopedTarget.userPreference'].userType eq 'C'}">
																	<c:set var="cecDiff" value="bg-test" />
											  						<c:if test="${psc.amountProposedMOPR gt psc.amountProposedCEC}">
																			<c:set var="cecDiff" value="bg-warning" />
																	</c:if> 
																	
																	<td align="right" class="${cecDiff}">
																		<fmt:formatNumber type = "number"      maxFractionDigits = "3" value = "${psc.amountProposedCEC}" />		
																	</td>
																	<td align="right" style="padding-right:20px">${psc.noOfUnitsCEC}</td>
																	<c:set var="t_fund_cec" value="${t_fund_cec+psc.amountProposedCEC}" />
																	<c:set var="t_unit_cec" value="${t_unit_cec+psc.noOfUnitsCEC}"/>
																</c:if>
															
																
															
														</tr>
													</c:if>
												</c:forEach>
											<c:if test="${pscindex eq 0 and pc.componentsId ne 11 and pc.componentsId ne 12}">
													<tr class="slidex${pc.componentsId}"  style="display: none;">
															<td></td>
															<td></td>
															<td>${pc.eName}</td>
															<td></td>
															<td align="right">
																<c:if test="${pc.amountProposed>0}">
																<fmt:formatNumber type = "number"      maxFractionDigits = "3" value = "${pc.amountProposed}" />
																</c:if>
															</td>
															<td align="right" style="padding-right:20px">${pc.noOfUnits}</td>
															<td align="right">
																<c:if test="${pc.amountProposedMOPR>0}">
																<fmt:formatNumber type = "number"      maxFractionDigits = "3" value = "${pc.amountProposedMOPR}" />
																</c:if>
															</td>
															<td align="right" style="padding-right:20px">${pc.noOfUnitsMOPR}</td>
															<td align="right">
																<c:if test="${pc.amountProposedCEC>0}">
																<fmt:formatNumber type = "number"      maxFractionDigits = "3" value = "${pc.amountProposedCEC}" />
																</c:if>
															</td>
															<td align="right" style="padding-right:20px">${pc.noOfUnitsCEC}</td>
													</tr>
												</c:if>
												<c:if test="${pc.componentsId ne 11 and pc.componentsId ne 12}">
													<tr class="slidex${pc.componentsId}"  style="display: none;">
															<td></td>
															<td></td>
															
															<td style="color: #0d1d92c9">Additional Requirement </td>
															<td></td>
															<td><p align="right"><fmt:formatNumber type = "number"      maxFractionDigits = "3" value = "${pc.addtionalRequirement}" /></p></td>
															<td></td>
															<td><p align="right"><fmt:formatNumber type = "number"      maxFractionDigits = "3" value = "${pc.addtionalRequirementMOPR}" /></p></td>
															<td></td>
															<c:if test="${sessionScope['scopedTarget.userPreference'].userType eq 'C'}">
															<td><p align="right"><fmt:formatNumber type = "number"      maxFractionDigits = "3" value = "${pc.addtionalRequirementCEC}" /></p></td>
															<td></td>
															</c:if>
														</tr>
													</c:if>
													<c:if test="${pc.componentsId==10}">
													<tr class="table_th"><th colspan="${dcolspan}"></th></tr>
														<tr class="table_th">
															<th></th>
															<th></th>
															<th>Sub-Total</th>
															<th></th>
															<th><p align="right">
															<c:if test="${t_fund>0}">
																<fmt:formatNumber type = "number"      maxFractionDigits = "3" value = "${t_fund}" />
															</c:if>
															</p></th>
															<th><p align="right">
															<c:if test="${t_unit>0}">
															<c:out value="${t_unit}" />
															</c:if>
															</p></th>
															<th><p align="right">
															<c:if test="${t_fund_mopr>0}">
																<fmt:formatNumber type = "number"      maxFractionDigits = "3" value = "${t_fund_mopr}" />
															</c:if>
															</p></th>
															<th><p align="right">
															<c:if test="${t_unit_mopr>0}">
															<c:out value="${t_unit_mopr}" />
															</c:if>
															</p></th>
															<c:if test="${sessionScope['scopedTarget.userPreference'].userType eq 'C'}">
															<th><p align="right">
															<c:if test="${t_fund_cec>0}">
																<fmt:formatNumber type = "number"      maxFractionDigits = "3" value = "${t_fund_cec}" />
															</c:if>
															</p></th>
															<th><p align="right">
															<c:if test="${t_unit_cec>0}">
															<c:out value="${t_unit_cec}" />
															</c:if>
															</p></th>
															</c:if>
															
														</tr>
													</c:if>
												</c:if>
										</c:forEach>
											<tr class="table_th"><th colspan="${dcolspan}"></th></tr>
														<tr class="table_th">
															<th></th>
															<th></th>
															<th>Total</th>
															<th></th>
															<th><p align="right">
															<c:if test="${t_fund>0}">
																<fmt:formatNumber type = "number"      maxFractionDigits = "3" value = "${t_fund}" />
															</c:if>
															</p></th>
															<th><p align="right">
															<c:if test="${t_unit>0}">
															<c:out value="${t_unit}" />
															</c:if>
															</p></th>
															<th><p align="right">
															<c:if test="${t_fund_mopr>0}">
																<fmt:formatNumber type = "number"      maxFractionDigits = "3" value = "${t_fund_mopr}" />
															</c:if>
															</p></th>
															<th><p align="right">
															<c:if test="${t_unit_mopr>0}">
															<c:out value="${t_unit_mopr}" />
															</c:if>
															</p></th>
															<c:if test="${sessionScope['scopedTarget.userPreference'].userType eq 'C'}">
															<th><p align="right">
															<c:if test="${t_fund_cec>0}">
																<fmt:formatNumber type = "number"      maxFractionDigits = "3" value = "${t_fund_cec}" />
															</c:if>
															</p></th>
															<th><p align="right">
															<c:if test="${t_unit_cec>0}">
															<c:out value="${t_unit_cec}" />
															</c:if>
															</p></th>
															</c:if>
															
														</tr>
										</tbody>
										</tbody>
									</table>
						
						
							<%-- <div class="card">
								<div class="sub-header">
										<h4>PESA PLAN</h4>
								</div>
								<div class="table-responsive">
									<table class="table table-bordered">
										<tbody>
											<tr>
												<td><b><a href="pesaPlanForCEC.html?<csrf:token uri='pesaPlanForCEC.html'/>">View Details</a></b></td>
											</tr>v
										</tbody>
									</table>
								</div>
							</div>
							
							<div class="card">
								<div class="sub-header">
										<h4>Administrative & Technical Support to Gram Panchayat</h4>
								</div>
								<div class="table-responsive">
									<table class="table table-bordered">
										<tbody>
											<tr>
												<td><b><a href="adminTechsupportStaffForCEC.html?<csrf:token uri='adminTechsupportStaffForCEC.html'/>">View Details</a></b></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
							<div class="card">
								<div class="sub-header">
										<h4>Innovative Activity</h4>
								</div>
								<div class="table-responsive">
									<table class="table table-bordered">
										<tbody>
											<tr>
												<td><b><a href="innovativeActivityForCEC.html?<csrf:token uri='innovativeActivityForCEC.html'/>">View Details</a></b></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
							<div class="card">
								<div class="sub-header">
										<h4>e-Governance Support Group</h4>
								</div>
								<div class="table-responsive">
									<table class="table table-bordered">
										<tbody>
											<tr>
												<td><b><a href="egovernanceCEC.html?<csrf:token uri='egovernanceCEC.html'/>">View Details</a></b></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div> --%>
							
						<b></b>
						<c:if test="${buttonStatus}">
						<div align="right"><a href="ApprovePlanByCec.html?<csrf:token uri='ApprovePlanByCec.html'/>" class="btn btn-success" role="button">APPROVE PLAN</a></div>
						</c:if>
						</div>
					</div>
				</div>
			</div>
		</div>
</section>


</body>
</html>