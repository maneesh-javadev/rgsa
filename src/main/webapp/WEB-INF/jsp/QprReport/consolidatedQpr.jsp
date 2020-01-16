<%@include file="../taglib/taglib.jsp" %>

<section class="content">
    <div class="container-fluid">
        <div class="row row-clearfix">

            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">

                <c:if test="${not empty msg_class}" >
                    <div class="alert ${msg_class} alert-dismissible" role="alert">
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            ${msg}
                    </div>
                </c:if>

                <form:form  method="POST"  class="form-horizontal form-normal" action="qprConsolidatedReport.html" enctype="multipart/form-data">

                    <div class="form-group">
                        <label for="inputFinYear" class="col-sm-4 control-label">Select Financial Year:</label>
                        <div class="col-sm-8">
                            <form:select class="form-control" id="inputFinYear" path="yearId" onchange="this.form.submit()">
                                <c:forEach var="item" items="${command.yearMap}">
                                    <c:choose>
                                        <c:when test="${item.getKey() == command.yearId}">
                                            <option value="${item.getKey()}" selected="selected"> ${item.getValue()} </option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="${item.getKey()}"> ${item.getValue()} </option>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </form:select>
                        </div>
                    </div>
                    
                    <c:if test="${userPreference.isMOPR()}">

                        <div class="form-group">
                            <label for="inputInstallmentNumber" class="col-sm-4 control-label">Select Installment:</label>
                            <div class="col-sm-8">
                                <form:select class="form-control" id="inputInstallmentNumber" path="stateCode" onchange="this.form.submit()">
                                    <c:forEach var="item" items="${command.stateMap}">
                                        <c:choose>
                                            <c:when test="${item.getKey() == command.stateCode}">
                                                <option value="${item.getKey()}" selected="selected"> ${item.getValue()} </option>
                                            </c:when>
                                            <c:otherwise>
                                                <option value="${item.getKey()}"> ${item.getValue()} </option>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </form:select>
                            </div>
                        </div>

                    </c:if>

                </form:form>


                <!-- Data Here -->

                <%--

                <div id="annualPlanBlockPrint">
                    <table
                            class="table table-hover table-bordered dashboard-task-infos"
                            id="annualReportTable">

                        <thead style="background-color: #9071bf; color: white;">
                        <tr>
                            <th rowspan="2" width="5%"></th>
                            <th rowspan="2" width="5%">Sr.No</th>
                            <th rowspan="2" width="22%">Components</th>
                            <td align="center"><b> Amount State Proposed</b></td>
                            <td align="center"><b>Amount Ministry Recomended</b></td>
                            <td align="center"><b>Amount CEC Approved</b></td>
                        </tr>
                        </thead>
                        <c:set var="t_fund" value="0"/>
                        <c:set var="t_unit" value="0"/>
                        <tbody>

                        <!-- declaration of variables -->
                        <c:set var="totalNewBuildingStateInstInfra" value="0"/>
                        <c:set var="totalCarryForwardStateInstInfra" value="0"/>

                        <c:set var="totalNewBuildingMoprInstInfra" value="0"/>
                        <c:set var="totalCarryForwardMoprInstInfra" value="0"/>

                        <c:set var="totalNewBuildingCecInstInfra" value="0"/>
                        <c:set var="totalCarryForwardCecInstInfra" value="0"/>

                        <c:set var="totalNewBuildingStatePanchayat" value="0"/>
                        <c:set var="totalCarryForwardStatePacnhayat" value="0"/>

                        <c:set var="totalNewBuildingMoprPanchayat" value="0"/>
                        <c:set var="totalCarryForwardMoprPacnhayat" value="0"/>

                        <c:set var="totalNewBuildingCecPanchayat" value="0"/>
                        <c:set var="totalCarryForwardCecPacnhayat" value="0"/>

                        <!--  -->

                        <c:forEach items="${planComponentsFunds}" var="pc"
                                   varStatus="pcindex">
                            <c:if test="${pc.eType eq 'C'}">
                                <c:set var="moprDiff" value="bg-test"/>
                                <c:if
                                        test="${pc.amountProposed+pc.addtionalRequirement ne pc.amountProposedMOPR+pc.addtionalRequirementMOPR and pc.amountProposedMOPR != null }">
                                    <c:set var="moprDiff" value="bg-warning"/>
                                </c:if>
                                <c:set var="moprDiffUnit" value="bg-test"/>
                                <c:if
                                        test="${pc.noOfUnits ne pc.noOfUnitsMOPR and pc.noOfUnitsMOPR != null }">
                                    <c:set var="moprDiffUnit" value="bg-warning"/>
                                </c:if>
                                <c:set var="cecDiff" value="bg-test"/>
                                <c:if
                                        test="${pc.amountProposedMOPR+pc.addtionalRequirementMOPR ne pc.amountProposedCEC+pc.addtionalRequirementCEC and pc.amountProposedCEC != null }">
                                    <c:set var="cecDiff" value="bg-info"/>
                                </c:if>
                                <c:set var="cecDiffUnit" value="bg-test"/>
                                <c:if
                                        test="${pc.noOfUnitsMOPR ne pc.noOfUnitsCEC and pc.noOfUnitsCEC != null }">
                                    <c:set var="cecDiffUnit" value="bg-info"/>
                                </c:if>
                                <tr class="mainTrId">
                                    <td align="center" id="plusId${pc.componentsId}"><c:if
                                            test="${pc.componentsId ne 11 and pc.componentsId ne 12}">
                                        <div id="expendRow${pc.componentsId}"
                                             class="expendRowAll"
                                             onclick="toggleSubComponent('${pc.componentsId}',true)">
                                            <i class="fa fa-plus-circle" aria-hidden="true"></i>
                                        </div>
                                        <div id="collapseRow${pc.componentsId}"
                                             class="collapseRowAll"
                                             onclick="toggleSubComponent('${pc.componentsId}',false)"
                                             style="display: none;">
                                            <i class="fa fa-minus-circle" aria-hidden="true"></i>
                                        </div>
                                    </c:if></td>
                                    <td><b>${pcindex.count}</b></td>
                                    <td><b>${pc.eName}</b></td>

                                    <td align="center"><c:if
                                            test="${(pc.amountProposed+pc.addtionalRequirement)>0}">
                                        <b><fmt:formatNumber type="number"
                                                             maxFractionDigits="3"
                                                             value="${pc.amountProposed+pc.addtionalRequirement}"/></b>
                                    </c:if></td>
                                    <td align="center" class="${moprDiff}"><c:if
                                            test="${(pc.amountProposedMOPR+pc.addtionalRequirementMOPR)>0}">
                                        <b><fmt:formatNumber type="number"
                                                             maxFractionDigits="3"
                                                             value="${pc.amountProposedMOPR+pc.addtionalRequirementMOPR}"/></b>
                                    </c:if></td>
                                    <td align="center" class="${cecDiff}"><c:if
                                            test="${(pc.amountProposedCEC+pc.addtionalRequirementCEC)>0}">
                                        <b><fmt:formatNumber type="number"
                                                             maxFractionDigits="3"
                                                             value="${pc.amountProposedCEC+pc.addtionalRequirementCEC}"/></b>
                                    </c:if></td>

                                    <c:set var="t_fund"
                                           value="${t_fund+pc.amountProposed+pc.addtionalRequirement}"/>
                                    <c:set var="t_unit" value="${t_unit+pc.noOfUnits}"/>
                                    <c:set var="t_fund_mopr"
                                           value="${t_fund_mopr+pc.amountProposedMOPR+pc.addtionalRequirementMOPR}"/>
                                    <c:set var="t_unit_mopr"
                                           value="${t_unit_mopr+pc.noOfUnitsMOPR}"/>
                                    <c:set var="t_fund_cec"
                                           value="${t_fund_cec+pc.amountProposedCEC+pc.addtionalRequirementCEC}"/>
                                    <c:set var="t_unit_cec"
                                           value="${t_unit_cec+pc.noOfUnitsCEC}"/>
                                </tr>

                                <c:set var="pscindex" value="0"/>

                                <c:forEach items="${planComponentsFunds}" var="psc">
                                    <c:if
                                            test="${psc.eType eq 'S' and pc.componentsId==psc.componentsId }">
                                        <c:set var="pscindex" value="${pscindex+1}"/>
                                        <c:set var="moprDiff" value="bg-test"/>
                                        <c:if
                                                test="${psc.amountProposed gt psc.amountProposedMOPR}">
                                            <c:set var="moprDiff" value="bg-warning"/>
                                        </c:if>
                                        <c:set var="moprDiffUnit" value="bg-test"/>
                                        <c:if
                                                test="${psc.noOfUnits ne psc.noOfUnitsMOPR and psc.noOfUnitsMOPR != null }">
                                            <c:set var="moprDiffUnit" value="bg-warning"/>
                                        </c:if>
                                        <c:set var="cecDiff" value="bg-test"/>
                                        <c:if
                                                test="${psc.amountProposedMOPR+psc.addtionalRequirementMOPR ne psc.amountProposedCEC+psc.addtionalRequirementCEC and psc.amountProposedCEC != null }">
                                            <c:set var="cecDiff" value="bg-info"/>
                                        </c:if>
                                        <c:set var="cecDiffUnit" value="bg-test"/>
                                        <c:if
                                                test="${psc.noOfUnitsMOPR ne psc.noOfUnitsCEC and psc.noOfUnitsCEC != null }">
                                            <c:set var="cecDiffUnit" value="bg-info"/>
                                        </c:if>

                                        <c:if
                                                test="${psc.subcomponentsId eq 8 or psc.subcomponentsId eq 9}">
                                            <c:if test="${psc.amountProposed>0}">
                                                <c:set var="totalNewBuildingStateInstInfra"
                                                       value="${totalNewBuildingStateInstInfra + psc.amountProposed}"/>
                                            </c:if>
                                            <c:if test="${psc.amountProposedMOPR>0}">
                                                <c:set var="totalNewBuildingMoprInstInfra"
                                                       value="${totalNewBuildingMoprInstInfra + psc.amountProposedMOPR}"/>
                                            </c:if>
                                            <c:if test="${psc.amountProposedCEC>0}">
                                                <c:set var="totalNewBuildingCecInstInfra"
                                                       value="${totalNewBuildingCecInstInfra + psc.amountProposedCEC}"/>
                                            </c:if>
                                        </c:if>

                                        <c:if
                                                test="${psc.subcomponentsId eq 23 or psc.subcomponentsId eq 24}">
                                            <c:if test="${psc.amountProposed>0}">
                                                <c:set var="totalCarryForwardStateInstInfra"
                                                       value="${totalCarryForwardStateInstInfra + psc.amountProposed}"/>
                                            </c:if>
                                            <c:if test="${psc.amountProposedMOPR>0}">
                                                <c:set var="totalCarryForwardMoprInstInfra"
                                                       value="${totalCarryForwardMoprInstInfra + psc.amountProposedMOPR}"/>
                                            </c:if>

                                            <c:if test="${psc.amountProposedCEC>0}">
                                                <c:set var="totalCarryForwardCecInstInfra"
                                                       value="${totalCarryForwardCecInstInfra + psc.amountProposedCEC}"/>
                                            </c:if>
                                        </c:if>

                                        <c:if
                                                test="${psc.subcomponentsId eq 12 or psc.subcomponentsId eq 13 or psc.subcomponentsId eq 14}">
                                            <c:if test="${psc.amountProposed>0}">
                                                <c:set var="totalNewBuildingStatePanchayat"
                                                       value="${totalNewBuildingStatePanchayat + psc.amountProposed}"/>
                                            </c:if>
                                            <c:if test="${psc.amountProposedMOPR>0}">
                                                <c:set var="totalNewBuildingMoprPanchayat"
                                                       value="${totalNewBuildingMoprPanchayat + psc.amountProposedMOPR}"/>
                                            </c:if>
                                            <c:if test="${psc.amountProposedCEC>0}">
                                                <c:set var="totalNewBuildingCecPanchayat"
                                                       value="${totalNewBuildingCecPanchayat + psc.amountProposedCEC}"/>
                                            </c:if>
                                        </c:if>

                                        <c:if
                                                test="${psc.subcomponentsId eq 20 or psc.subcomponentsId eq 21 or psc.subcomponentsId eq 22}">
                                            <c:if test="${psc.amountProposed>0}">
                                                <c:set var="totalCarryForwardStatePacnhayat"
                                                       value="${totalCarryForwardStatePacnhayat + psc.amountProposed}"/>
                                            </c:if>
                                            <c:if test="${psc.amountProposedMOPR>0}">
                                                <c:set var="totalCarryForwardMoprPacnhayat"
                                                       value="${totalCarryForwardMoprPacnhayat + psc.amountProposedMOPR}"/>
                                            </c:if>
                                            <c:if test="${psc.amountProposedCEC>0}">
                                                <c:set var="totalCarryForwardCecPacnhayat"
                                                       value="${totalCarryForwardCecPacnhayat + psc.amountProposedCEC}"/>
                                            </c:if>
                                        </c:if>


                                        <c:if
                                                test="${psc.componentsId ne 2 and psc.componentsId ne 3 }">
                                            <tr class="slide${pc.componentsId} expand-all"
                                                style="display: none;">
                                                <td></td>
                                                <td>&#${96+pscindex})</td>

                                                <td>${psc.eName}</td>
                                                <td align="center"><fmt:formatNumber type="number"
                                                                                     maxFractionDigits="3"
                                                                                     value="${psc.amountProposed}"/>
                                                </td>
                                                <td align="center" class="${moprDiff }">
                                                    <fmt:formatNumber
                                                            type="number" maxFractionDigits="3"
                                                            value="${psc.amountProposedMOPR}"/></td>
                                                <c:set var="cecDiff" value="bg-test"/>
                                                <c:if
                                                        test="${psc.amountProposedMOPR gt psc.amountProposedCEC}">
                                                    <c:set var="cecDiff" value="bg-danger"/>
                                                </c:if>

                                                <td align="center" class="${cecDiff}"><fmt:formatNumber
                                                        type="number" maxFractionDigits="3"
                                                        value="${psc.amountProposedCEC}"/></td>
                                            </tr>
                                        </c:if>
                                    </c:if>
                                </c:forEach>

                                <!-- for institutional infra modification -->
                                <c:if test="${pc.componentsId eq 2}">
                                    <tr class="slide${pc.componentsId} expand-all"
                                        style="display: none;">
                                        <td></td>
                                        <td>
                                            <div
                                                    id="newBuildingInstituteInfraExpand${pc.componentsId}"
                                                    onclick="toggleInstInfraAndPanchayatBhawan(${pc.componentsId},'newBuildingInstituteInfra')">
                                                <i class="fa fa-plus-circle" aria-hidden="true"></i>
                                            </div>

                                            <div
                                                    id="newBuildingInstituteInfraCollapse${pc.componentsId}"
                                                    onclick="toggleInstInfraAndPanchayatBhawan(${pc.componentsId},'newBuildingInstituteInfra')"
                                                    style="display: none;">
                                                <i class="fa fa-minus-circle" aria-hidden="true"></i>
                                            </div>
                                        </td>
                                        <td><strong>New Building</strong></td>
                                        <!-- <td></td> -->
                                        <td align="center"><fmt:formatNumber type="number"
                                                                             maxFractionDigits="3"
                                                                             value="${totalNewBuildingStateInstInfra}"/></td>

                                        <td align="center" class="${moprDiff }"><fmt:formatNumber
                                                type="number" maxFractionDigits="3"
                                                value="${totalNewBuildingMoprInstInfra}"/></td>

                                        <td align="center" class="${cecDiff }"><fmt:formatNumber
                                                type="number" maxFractionDigits="3"
                                                value="${totalNewBuildingCecInstInfra}"/></td>

                                    </tr>

                                    <c:forEach items="${planComponentsFunds}" var="innerData">
                                        <c:if
                                                test="${innerData.eType eq 'S' and pc.componentsId eq 2}"></c:if>
                                        <c:if
                                                test="${innerData.subcomponentsId eq 8 or innerData.subcomponentsId eq 9}">
                                            <tr class="newBuildingInstituteInfra"
                                                style="display: none;">
                                                <td></td>
                                                <td></td>
                                                <td>${innerData.eName}</td>
                                                <td align="center"><fmt:formatNumber type="number"
                                                                                     maxFractionDigits="3"
                                                                                     value="${innerData.amountProposed}"/></td>
                                                <td align="center"><fmt:formatNumber type="number"
                                                                                     maxFractionDigits="3"
                                                                                     value="${innerData.amountProposedMOPR}"/></td>
                                                <td align="center"><fmt:formatNumber type="number"
                                                                                     maxFractionDigits="3"
                                                                                     value="${innerData.amountProposedCEC}"/></td>
                                            </tr>
                                        </c:if>
                                    </c:forEach>

                                    <!-- carry forward institutional infra -->

                                    <tr class="slide${pc.componentsId} expand-all"
                                        style="display: none;">
                                        <td></td>
                                        <td>
                                            <div
                                                    id="carryForwardInstituteInfraExpand${pc.componentsId}"
                                                    onclick="toggleInstInfraAndPanchayatBhawan(${pc.componentsId},'carryForwardInstituteInfra')">
                                                <i class="fa fa-plus-circle" aria-hidden="true"></i>
                                            </div>

                                            <div
                                                    id="carryForwardInstituteInfraCollapse${pc.componentsId}"
                                                    onclick="toggleInstInfraAndPanchayatBhawan(${pc.componentsId},'carryForwardInstituteInfra')"
                                                    style="display: none;">
                                                <i class="fa fa-minus-circle" aria-hidden="true"></i>
                                            </div>
                                        </td>
                                        <td><strong>Carry Forward</strong></td>
                                        <!-- 	<td></td> -->
                                        <td align="center"><fmt:formatNumber type="number"
                                                                             maxFractionDigits="3"
                                                                             value="${totalCarryForwardStateInstInfra}"/></td>
                                        <td align="center" class="${moprDiff }"><fmt:formatNumber
                                                type="number" maxFractionDigits="3"
                                                value="${totalCarryForwardMoprInstInfra}"/></td>
                                        <td align="center" class="${cecDiff }"><fmt:formatNumber
                                                type="number" maxFractionDigits="3"
                                                value="${totalCarryForwardCecInstInfra}"/></td>
                                            <%-- <td align="right" style="padding-right: 20px"
                                                class="${cecDiff }"><b><c:out
                                                        value="${totalUnitCarryForwardCecInstInfra}" /></b></td> --!%>
                                    </tr>

                                    <c:forEach items="${planComponentsFunds}" var="innerData">
                                        <c:if
                                                test="${innerData.eType eq 'S' and pc.componentsId eq 2}"></c:if>
                                        <c:if
                                                test="${innerData.subcomponentsId eq 23 or innerData.subcomponentsId eq 24}">
                                            <tr class="carryForwardInstituteInfra"
                                                style="display: none;">
                                                <td></td>
                                                <td></td>
                                                <td>${innerData.eName}</td>
                                                <!-- <td></td> -->
                                                <td align="center"><fmt:formatNumber type="number"
                                                                                     maxFractionDigits="3"
                                                                                     value="${innerData.amountProposed}"/></td>
                                                    <%-- <td align="right" style="padding-right: 20px"><b><c:out
                                                                value="${innerData.noOfUnits}" /></b></td> --!%>
                                                <td align="center"><fmt:formatNumber type="number"
                                                                                     maxFractionDigits="3"
                                                                                     value="${innerData.amountProposedMOPR}"/></td>
                                                    <%-- <td align="right" style="padding-right: 20px"><b><c:out
                                                                value="${innerData.noOfUnitsMOPR}" /></b></td> --!%>
                                                <td align="center"><fmt:formatNumber type="number"
                                                                                     maxFractionDigits="3"
                                                                                     value="${innerData.amountProposedCEC}"/></td>
                                                    <%-- <td align="right" style="padding-right: 20px"><b><c:out
                                                                value="${innerData.noOfUnitsCEC}" /></b></td> --!%>
                                            </tr>
                                        </c:if>
                                    </c:forEach>
                                </c:if>
                                <!-- -->


                                <!-- panchayat bhawan bifurcation in new building and carry forward -->
                                <c:if test="${pc.componentsId eq 3}">
                                    <tr class="slide${pc.componentsId} expand-all"
                                        style="display: none;">
                                        <td></td>
                                        <td>
                                            <div
                                                    id="newBuildingPanchayatBhawanExpand${pc.componentsId}"
                                                    onclick="toggleInstInfraAndPanchayatBhawan(${pc.componentsId},'newBuildingPanchayatBhawan')">
                                                <i class="fa fa-plus-circle" aria-hidden="true"></i>
                                            </div>

                                            <div
                                                    id="newBuildingPanchayatBhawanCollapse${pc.componentsId}"
                                                    onclick="toggleInstInfraAndPanchayatBhawan(${pc.componentsId},'newBuildingPanchayatBhawan')"
                                                    style="display: none;">
                                                <i class="fa fa-minus-circle" aria-hidden="true"></i>
                                            </div>
                                        </td>
                                        <td><strong>New Building</strong></td>
                                        <!-- <td></td> -->
                                        <td align="center"><fmt:formatNumber type="number"
                                                                             maxFractionDigits="3"
                                                                             value="${totalNewBuildingStatePanchayat}"/></td>
                                            <%-- <td align="right" style="padding-right: 20px"><b><c:out
                                                        value="${totalUnitNewBuildingStatePanchayat}" /></b></td> --!%>
                                        <td align="center" class="${moprDiff }"><fmt:formatNumber
                                                type="number" maxFractionDigits="3"
                                                value="${totalNewBuildingMoprPanchayat}"/></td>
                                            <%-- <td align="right" style="padding-right: 20px"><b><c:out
                                                        value="${totalUnitNewBuildingMoprPanchayat}" /></b></td> --!%>
                                        <td align="center" class="${cecDiff }"><fmt:formatNumber
                                                type="number" maxFractionDigits="3"
                                                value="${totalNewBuildingCecPanchayat}"/></td>
                                            <%-- <td align="right" style="padding-right: 20px"
                                                class="${cecDiff }"><b><c:out
                                                        value="${totalUnitNewBuildingCecPanchayat}" /></b></td> --!%>
                                    </tr>

                                    <c:forEach items="${planComponentsFunds}" var="innerData">
                                        <c:if
                                                test="${innerData.eType eq 'S' and pc.componentsId eq 3}"></c:if>
                                        <c:if
                                                test="${innerData.subcomponentsId eq 12 or innerData.subcomponentsId eq 13 or innerData.subcomponentsId eq 14}">
                                            <tr class="newBuildingPanchayatBhawan"
                                                style="display: none;">
                                                <td></td>
                                                <td></td>
                                                <td>${innerData.eName}</td>
                                                <!-- <td></td> -->
                                                <td align="center"><fmt:formatNumber type="number"
                                                                                     maxFractionDigits="3"
                                                                                     value="${innerData.amountProposed}"/></td>
                                                    <%-- <td align="right" style="padding-right: 20px"><b><c:out
                                                                value="${innerData.noOfUnits}" /></b></td> --!%>
                                                <td align="center"><fmt:formatNumber type="number"
                                                                                     maxFractionDigits="3"
                                                                                     value="${innerData.amountProposedMOPR}"/></td>
                                                    <%-- <td align="right" style="padding-right: 20px"><b><c:out
                                                                value="${innerData.noOfUnitsMOPR}" /></b></td> --!%>
                                                <td align="center"><fmt:formatNumber type="number"
                                                                                     maxFractionDigits="3"
                                                                                     value="${innerData.amountProposedCEC}"/></td>
                                                    <%-- <td align="right" style="padding-right: 20px"><b><c:out
                                                                value="${innerData.noOfUnitsCEC}" /></b></td> --!%>
                                            </tr>
                                        </c:if>
                                    </c:forEach>

                                    <!-- carry forward entry -->
                                    <tr class="slide${pc.componentsId} expand-all"
                                        style="display: none;">
                                        <td></td>
                                        <td>
                                            <div
                                                    id="carryForwardPanchayatBhawanExpand${pc.componentsId}"
                                                    onclick="toggleInstInfraAndPanchayatBhawan(${pc.componentsId},'carryForwardPanchayatBhawan')">
                                                <i class="fa fa-plus-circle" aria-hidden="true"></i>
                                            </div>

                                            <div
                                                    id="carryForwardPanchayatBhawanCollapse${pc.componentsId}"
                                                    onclick="toggleInstInfraAndPanchayatBhawan(${pc.componentsId},'carryForwardPanchayatBhawan')"
                                                    style="display: none;">
                                                <i class="fa fa-minus-circle" aria-hidden="true"></i>
                                            </div>
                                        </td>
                                        <td><strong>Carry Forward</strong></td>
                                        <!-- <td></td> -->
                                        <td align="center"><fmt:formatNumber type="number"
                                                                             maxFractionDigits="3"
                                                                             value="${totalCarryForwardStatePacnhayat}"/></td>
                                            <%-- <td align="right" style="padding-right: 20px"><b><c:out
                                                        value="${totalUnitCarryForwardStatePacnhayat}" /></b></td> --!%>
                                        <td align="center" class="${moprDiff }"><fmt:formatNumber
                                                type="number" maxFractionDigits="3"
                                                value="${totalCarryForwardMoprPacnhayat}"/></td>
                                            <%-- <td align="right" style="padding-right: 20px"><b><c:out
                                                        value="${totalUnitCarryForwardMoprPacnhayat}" /></b></td> --!%>
                                        <td align="center" class="${cecDiff }"><fmt:formatNumber
                                                type="number" maxFractionDigits="3"
                                                value="${totalCarryForwardCecPacnhayat}"/></td>
                                            <%-- <td align="right" style="padding-right: 20px"
                                                class="${cecDiff }"><b><c:out
                                                        value="${totalUnitCarryForwardCecPacnhayat}" /></b></td> --!%>
                                    </tr>

                                    <c:forEach items="${planComponentsFunds}" var="innerData">
                                        <c:if
                                                test="${innerData.eType eq 'S' and pc.componentsId eq 3}"></c:if>
                                        <c:if
                                                test="${innerData.subcomponentsId eq 20 or innerData.subcomponentsId eq 21 or innerData.subcomponentsId eq 22}">
                                            <tr class="carryForwardPanchayatBhawan"
                                                style="display: none;">
                                                <td></td>
                                                <td></td>
                                                <td>${innerData.eName}</td>
                                                <!-- <td></td> -->
                                                <td align="center"><fmt:formatNumber type="number"
                                                                                     maxFractionDigits="3"
                                                                                     value="${innerData.amountProposed}"/></td>
                                                    <%-- <td align="right" style="padding-right: 20px"><b><c:out
                                                                value="${innerData.noOfUnits}" /></b></td> --!%>
                                                <td align="center"><fmt:formatNumber type="number"
                                                                                     maxFractionDigits="3"
                                                                                     value="${innerData.amountProposedMOPR}"/></td>
                                                    <%-- <td align="right" style="padding-right: 20px"><b><c:out
                                                                value="${innerData.noOfUnitsMOPR}" /></b></td> --!%>
                                                <td align="center"><fmt:formatNumber type="number"
                                                                                     maxFractionDigits="3"
                                                                                     value="${innerData.amountProposedCEC}"/></td>
                                                    <%-- <td align="right" style="padding-right: 20px"><b><c:out
                                                                value="${innerData.noOfUnitsCEC}" /></b></td> --!%>
                                            </tr>
                                        </c:if>
                                    </c:forEach>
                                    <!-- -->
                                </c:if>
                                <!-- -->


                                <c:set var="moprDiff" value="bg-test"/>
                                <c:if test="${pc.amountProposed gt pc.amountProposedMOPR}">
                                    <c:set var="moprDiff" value="bg-warning"/>
                                </c:if>
                                <c:set var="moprDiffUnit" value="bg-test"/>
                                <c:if
                                        test="${pc.noOfUnits ne pc.noOfUnitsMOPR and pc.noOfUnitsMOPR != null }">
                                    <c:set var="moprDiffUnit" value="bg-warning"/>
                                </c:if>
                                <c:set var="cecDiff" value="bg-test"/>
                                <c:if
                                        test="${pc.amountProposedMOPR+pc.addtionalRequirementMOPR ne pc.amountProposedCEC+pc.addtionalRequirementCEC and pc.amountProposedCEC != null }">
                                    <c:set var="cecDiff" value="bg-info"/>
                                </c:if>
                                <c:set var="cecDiffUnit" value="bg-test"/>
                                <c:if
                                        test="${pc.noOfUnitsMOPR ne pc.noOfUnitsCEC and pc.noOfUnitsCEC != null }">
                                    <c:set var="cecDiffUnit" value="bg-info"/>
                                </c:if>
                                <c:if
                                        test="${pscindex eq 0 and pc.componentsId ne 11 and pc.componentsId ne 12}">
                                    <tr class="slidex${pc.componentsId} expand-all"
                                        style="display: none;">
                                        <td></td>
                                        <td></td>
                                        <td>${pc.eName}</td>
                                        <td align="center"><c:if
                                                test="${pc.amountProposed>0}">
                                            <fmt:formatNumber type="number" maxFractionDigits="3"
                                                              value="${pc.amountProposed}"/>
                                        </c:if></td>
                                        <td align="center" class="${moprDiff}"><c:if
                                                test="${pc.amountProposedMOPR>0}">
                                            <fmt:formatNumber type="number" maxFractionDigits="3"
                                                              value="${pc.amountProposedMOPR}"/>
                                        </c:if></td>
                                        <td align="center" class="${cecDiff}"><c:if
                                                test="${pc.amountProposedCEC>0}">
                                            <fmt:formatNumber type="number" maxFractionDigits="3"
                                                              value="${pc.amountProposedCEC}"/>
                                        </c:if></td>
                                    </tr>
                                </c:if>
                                <c:if
                                        test="${pc.componentsId ne 11 and pc.componentsId ne 12}">
                                    <tr class="slidex${pc.componentsId} expand-all"
                                        style="display: none;">
                                        <td></td>
                                        <td></td>

                                        <td style="color: #0d1d92c9">Additional Requirement</td>
                                        <td><p align="center">
                                            <fmt:formatNumber type="number" maxFractionDigits="3"
                                                              value="${pc.addtionalRequirement}"/>
                                        </p></td>
                                        <td><p align="center">
                                            <fmt:formatNumber type="number" maxFractionDigits="3"
                                                              value="${pc.addtionalRequirementMOPR}"/>
                                        </p></td>
                                        <td><p align="center">
                                            <fmt:formatNumber type="number" maxFractionDigits="3"
                                                              value="${pc.addtionalRequirementCEC}"/>
                                        </p></td>
                                        <!-- <td></td> -->
                                    </tr>
                                </c:if>
                                <c:if test="${pc.componentsId==10}">
                                    <tr class="table_th">
                                        <th colspan="10"></th>
                                    </tr>
                                    <tr class="table_th">
                                        <th></th>
                                        <th></th>
                                        <th>Sub-Total</th>
                                        <th><p align="center">
                                            <c:if test="${t_fund>0}">
                                                <fmt:formatNumber type="number" maxFractionDigits="3"
                                                                  value="${t_fund}"/>
                                            </c:if>
                                        </p></th>
                                        <th><p align="center">
                                            <c:if test="${t_fund_mopr>0}">
                                                <fmt:formatNumber type="number" maxFractionDigits="3"
                                                                  value="${t_fund_mopr}"/>
                                            </c:if>
                                        </p></th>
                                        <th><p align="center">
                                            <c:if test="${t_fund_cec>0}">
                                                <fmt:formatNumber type="number" maxFractionDigits="3"
                                                                  value="${t_fund_cec}"/>
                                            </c:if>
                                        </p></th>
                                    </tr>
                                </c:if>
                            </c:if>
                        </c:forEach>
                        <tr class="table_th">
                            <th colspan="10"></th>
                        </tr>
                        <tr class="table_th">
                            <th></th>
                            <th></th>
                            <th>Total</th>
                            <th><p align="center">
                                <c:if test="${t_fund>0}">
                                    <fmt:formatNumber type="number" maxFractionDigits="3"
                                                      value="${t_fund}"/>
                                </c:if>
                            </p></th>
                            <th><p align="center">
                                <c:if test="${t_fund_mopr>0}">
                                    <fmt:formatNumber type="number" maxFractionDigits="3"
                                                      value="${t_fund_mopr}"/>
                                </c:if>
                            </p></th>
                            <th><p align="center">
                                <c:if test="${t_fund_cec>0}">
                                    <fmt:formatNumber type="number" maxFractionDigits="3"
                                                      value="${t_fund_cec}"/>
                                </c:if>
                            </p></th>
                        </tr>
                        </tbody>
                    </table>
                </div>

                --%>

                <!-- Data Complete -->



            </div>


        </div>
    </div>
</section>
