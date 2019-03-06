<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<%@include file="../taglib/taglib.jsp"%>
	<script  type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
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
						
						<table class="table table-hover dashboard-task-infos">
		
										<thead>
											<tr>
												<th rowspan="2" width="5%">Sr.No</th>
												<th rowspan="2" width="22%" >Components</th>
												<th rowspan="2" width="13%">View Details</th>
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
														<c:set var="moprDiff" value="bg-danger" />
													</c:if>
													<tr>
														<td><b>${pcindex.count}</b></td>
														<td><b>${pc.eName}</b></td>
														
														<td><b><a href="${pc.link}?menuId=0&<csrf:token uri='${pc.link}'/>"><i class="fa fa-external-link" aria-hidden="true"></i></a></b></td>
														 
														
															<c:choose>
															<c:when test="${pc.componentsId eq 11 or pc.componentsId eq 12}">
																<td align="right"><b>
																		<fmt:formatNumber type = "number"      maxFractionDigits = "3" value = "${pc.amountProposed}" /></b>
																</td>
																<td align="right" style="padding-right:20px"><b><c:out value="${pc.noOfUnits}"/></b> </td>
																<td align="right" class="${moprDiff }">
																		<fmt:formatNumber type = "number"      maxFractionDigits = "3" value = "${pc.amountProposedMOPR}" />		
																</td>
																<td align="right" style="padding-right:20px">${pc.noOfUnitsMOPR}</td>
															</c:when>
															<c:otherwise>
																<td></td>
																<td></td>
																<c:if test="${sessionScope['scopedTarget.userPreference'].userType eq 'S'}">
																<td></td>
																</c:if>
																<td></td>
																<td></td>
															</c:otherwise>
														
														</c:choose>
														
														
														
														<c:if test="${sessionScope['scopedTarget.userPreference'].userType eq 'C'}">
															<c:set var="cecDiff" value="bg-test" />
									  						<c:if test="${pc.amountProposedMOPR gt pc.amountProposedCEC}">
																	<c:set var="cecDiff" value="bg-danger" />
															</c:if> 
															
															<td align="right" class="${cecDiff}">
																<fmt:formatNumber type = "number"      maxFractionDigits = "3" value = "${pc.amountProposedCEC}" />		
															</td>
															<td align="right" style="padding-right:20px">${pc.noOfUnitsCEC}</td>
															<c:set var="t_fund_cec" value="${t_fund_cec+pc.amountProposedCEC}" />
															<c:set var="t_unit_cec" value="${t_unit_cec+pc.noOfUnitsCEC}"/>
														</c:if>
														<c:set var="t_fund" value="${t_fund+pc.amountProposed}" />
														<c:set var="t_unit" value="${t_unit+pc.noOfUnits}"/>
														<c:set var="t_fund_mopr" value="${t_fund_mopr+pc.amountProposedMOPR}" />
														<c:set var="t_unit_mopr" value="${t_unit_mopr+pc.noOfUnitsMOPR}"/>
														
													</tr>
												
												<c:set var="pscindex" value="0"/> 
												<c:set var="s_fund" value="0" />
												<c:set var="s_unit" value="0"/>
												<c:set var="s_fund_mopr" value="0" />
												<c:set var="s_unit_mopr" value="0"/>
												<c:forEach items="${planComponentsFunds}" var="psc" >
													<c:if test="${psc.eType eq 'S' and pc.componentsId==psc.componentsId }">
													<c:set var="pscindex" value="${pscindex+1}"/>
													<c:set var="moprDiff" value="bg-test" />
										  			<c:if test="${psc.amountProposed gt psc.amountProposedMOPR}">
														<c:set var="moprDiff" value="bg-danger" />
													</c:if>
													
														<tr>
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
																			<c:set var="cecDiff" value="bg-danger" />
																	</c:if> 
																	
																	<td align="right" class="${cecDiff}">
																		<fmt:formatNumber type = "number"      maxFractionDigits = "3" value = "${psc.amountProposedCEC}" />		
																	</td>
																	<td align="right" style="padding-right:20px">${psc.noOfUnitsCEC}</td>
																	<c:set var="t_fund_cec" value="${t_fund_cec+psc.amountProposedCEC}" />
																	<c:set var="t_unit_cec" value="${t_unit_cec+psc.noOfUnitsCEC}"/>
																</c:if>
																<c:set var="t_fund" value="${t_fund+psc.amountProposed}" />
																<c:set var="t_unit" value="${t_unit+psc.noOfUnits}"/>
																<c:set var="t_fund_mopr" value="${t_fund_mopr+psc.amountProposedMOPR}" />
																<c:set var="t_unit_mopr" value="${t_unit_mopr+psc.noOfUnitsMOPR}"/>
																<c:set var="s_fund" value="${s_fund+psc.amountProposed}" />
																<c:set var="s_unit" value="${s_unit+psc.noOfUnits}"/>
																<c:set var="s_fund_mopr" value="${s_fund+psc.amountProposedMOPR}" />
																<c:set var="s_unit_mopr" value="${s_unit+psc.noOfUnitsMOPR}"/>
																
															
														</tr>
													</c:if>
												</c:forEach>
												<c:if test="${pc.componentsId ne 11 and pc.componentsId ne 12}">
													<tr >
															<td></td>
															<td style="color: #0d1d92c9">
															
																<b>Total funds=Funds+Additional Requirement 
																<c:set var="t_fund" value="${t_fund+pc.addtionalRequirement}" />
																<c:choose>
																<c:when test="${pscindex eq 0 and pc.amountProposed>0}">
																(<fmt:formatNumber type = "number"      maxFractionDigits = "3" value = "${pc.amountProposed}" />
																<c:out value="+" />
																<fmt:formatNumber type = "number"      maxFractionDigits = "3" value = "${pc.addtionalRequirement}" />)
																
																
																
																</c:when>
																<c:otherwise>
																<c:if test="${s_fund gt 0 }">
																(<fmt:formatNumber type = "number"      maxFractionDigits = "3" value = "${s_fund}" />
																<c:out value="+" />
																<fmt:formatNumber type = "number"      maxFractionDigits = "3" value = "${pc.addtionalRequirement}" />)
																
															
																</c:if>
																</c:otherwise>
																
																</c:choose>
																
																</b>
															</td>
																
																
																<c:if test="${sessionScope['scopedTarget.userPreference'].userType ne 'S'}">
																<td></td>
																</c:if>
																<td><p align="right"><b>
																<c:choose>
																<c:when test="${pscindex eq 0 and pc.amountProposed>0}">
																<fmt:formatNumber type = "number"      maxFractionDigits = "3" value = "${pc.amountProposed+pc.addtionalRequirement}" />
																
																</c:when>
																<c:otherwise>
																<c:if test="${s_fund gt 0 }">
																
																<fmt:formatNumber type = "number"      maxFractionDigits = "3" value = "${s_fund+pc.addtionalRequirement}" />
																</c:if>
																</c:otherwise>
																
																</c:choose>
																
																</b>
																</p>
																</td>
																<!-- <th>+</th>
																<th>4500</th>
																<th>=</th>
																<th>670067</th> -->
																<c:choose>
																<c:when test="${pscindex eq 0}">
																<td align="right" style="padding-right:20px">${pc.noOfUnits}</td>
																
																</c:when>
																<c:otherwise>
																<td style="padding-right:20px"><c:if test="${s_fund>0 }"><p align="right"><b><c:out value="${s_unit}" /></b></p></c:if></td>
																
																</c:otherwise>
																
																</c:choose>
																
																
																
																<td align="right" class="${moprDiff }">
																	<fmt:formatNumber type = "number"      maxFractionDigits = "3" value = "${pc.amountProposedMOPR}" />		
																</td>
																<td align="right" style="padding-right:20px">${pc.noOfUnitsMOPR}</td>
													</tr>
													</c:if>
													
													<c:if test="${pc.componentsId==10}">
													<tr class="table_th"><th colspan="9"></th></tr>
														 <tr >
												<th></th>
												<th>Sub-Total</th>
												<th></th>
												<th ><p align="right">
														<fmt:formatNumber type = "number"      maxFractionDigits = "3" value = "${t_fund}" />
												</p></th>
												<th ><p align="right"><c:out value="${t_unit}" /></p></th>
												<th ><p align="right">
													<fmt:formatNumber type = "number"      maxFractionDigits = "3" value = "${t_fund_mopr}" />
												</p></th>
												<th ><p align="right"><c:out value="${t_unit_mopr}" /></p></th>
												<c:if test="${sessionScope['scopedTarget.userPreference'].userType eq 'C'}">
												<th ><p align="right">
													<fmt:formatNumber type = "number"      maxFractionDigits = "3" value = "${t_fund_cec}" />
												</p></th>
												<th ><p align="right"><c:out value="${t_unit_cec}" /></p></th>
												</c:if>
												
												
											</tr> 
													</c:if>
												
												</c:if>
										</c:forEach>
											<tr class="table_th"><th colspan="9"></th></tr>
											 <tr >
												<th></th>
												<th>Total</th>
												<th></th>
												<th ><p align="right">
														<fmt:formatNumber type = "number"      maxFractionDigits = "3" value = "${t_fund}" />
												</p></th>
												<th ><p align="right"><c:out value="${t_unit}" /></p></th>
												<th ><p align="right">
													<fmt:formatNumber type = "number"      maxFractionDigits = "3" value = "${t_fund_mopr}" />
												</p></th>
												<th ><p align="right"><c:out value="${t_unit_mopr}" /></p></th>
												<c:if test="${sessionScope['scopedTarget.userPreference'].userType eq 'C'}">
												<th ><p align="right">
													<fmt:formatNumber type = "number"      maxFractionDigits = "3" value = "${t_fund_cec}" />
												</p></th>
												<th ><p align="right"><c:out value="${t_unit_cec}" /></p></th>
												</c:if>
												
												
											</tr> 
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
							
						<b></b><div align="right"><a href="ApprovePlanByCec.html?<csrf:token uri='ApprovePlanByCec.html'/>" class="btn btn-success" role="button">APPROVE PLAN</a></div>
						</div>
					</div>
				</div>
			</div>
		</div>
</section>


</body>
</html>