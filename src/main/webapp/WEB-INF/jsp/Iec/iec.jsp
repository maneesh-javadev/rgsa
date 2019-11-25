<%@include file="../taglib/taglib.jsp" %>
<html>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/multiselect/slimselect.min.css" type="text/css"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/multiselect/slimselect.min.js"></script>
<style>
    .form-group .form-control.normalbox {
        border: 1px solid #ccc;
        border-radius: 4px;
        -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
        box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
        -webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
        -o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
        transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
    }
</style>

<script type="text/javascript">
    $(document).ready(function () {
        new SlimSelect({
            select: '.the-multiselect'
        });
    });
    function validateForm() {
    	alert('Amount proposed should not be more than 2% of the total fund of activities proposed.');
        return true;
    }
</script>

<section class="content">

    <div class="container-fluid">
        <div class="row clearfix">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <div class="card">

                    <div class="header">
                        <h2><spring:message code="Label.ProposalForIEC" htmlEscape="true"/></h2>
                    </div>

                    <div class="body">

                        <form:form method="POST" name="IecName" action="iec.html"
                                   id="iecId" modelAttribute="IEC_ACTIVITY" path="iec" onsubmit="return validateForm()">

                            <form:input path="iecId" type="hidden"/>

                            <div class="form-group">
                                <label><spring:message code="Label.NatureOfTheIECActivity" htmlEscape="true"/>:</label>
                                <form:select multiple="true" path="selectedId"
                                             items="${iecActivityComponents}" itemValue="iecId"
                                             itemLabel="natureIecActivity"
                                             class="the-multiselect"
                                             disabled="${ IEC_ACTIVITY.getFreeze() ? 'true' : 'false'}"/>
                            </div>
                            <div class="form-group">
                                <label for="amount_box"><spring:message code="Label.AmountProposed"
                                                                        htmlEscape="true"/>:</label>
                                <form:input type="number"
                                            path="amount"
                                            min="1"
                                            max="99999999"
                                            class="no-scroll normalbox form-control"
                                            placeholder="Total Amount Proposed"
                                            disabled="${ IEC_ACTIVITY.getFreeze() ? 'true' : 'false'}"
                                            id="amount_box"/>
                            </div>
                            <c:if test="${ userPreference.isMOPR() }">
                            <div class="form-group">
                                <label for="is_approved"><spring:message code="Label.IsApproved"
                                                                        htmlEscape="true"/>:</label>
                                <form:checkbox path="isApproved"
                                            class="form-control-check"
                                            disabled="${ IEC_ACTIVITY.getFreeze() ? 'true' : 'false'}"
                                            id="isApprovedId"/>
                            </div>
                            </c:if>
                            <div class="row clearfix">
                            <div class="form-group">
                            <div class="col-sm-2">
                                <label for="remarksId"><spring:message code="Label.Remarks"
                                                                        htmlEscape="true"/>:</label>
                                                                        </div>
                              <div class="col-sm-4">   
                              <div class="form-line">                                       
                                <form:textarea path="remarks" class="form-control"
                                            disabled="${ IEC_ACTIVITY.getFreeze() ? 'true' : 'false'}"
                                            id="remarksId" />
                                            </div></div>
                            </div>
                            </div>
							<c:if
								test="${sessionScope['scopedTarget.userPreference'].planVersion > 1}">
								<div class="row clearfix">
									<div class="col-sm-2">
										<label>Previous Comments : </label>
									</div>
									<div class="col-sm-8 table-responsive">
										<table class="table table-hover">
											<tr>
												<th>State remarks <span style="color: #396721;">&nbsp;<i class="fa fa-circle"></i></span></th>
												<th>MOPR feedback<span style="color: #bc6317;">&nbsp;<i class="fa fa-circle"></i></span></th>
											</tr>
											<c:forEach items="${STATE_PRE_COMMENTS[0]}" var="stateComment" varStatus="index">
												<tr>
												<td style="color: #396721;font-weight: bold;">
													<c:choose>
														<c:when test="${not empty stateComment}">${stateComment}</c:when>
														<c:otherwise>No remarks by state
														</c:otherwise>
													</c:choose>
												</td>
												<td style="color: #bc6317;font-weight: bold;">
													<c:choose>
														<c:when test="${not empty MOPR_PRE_COMMENTS[0][index.index]}">${MOPR_PRE_COMMENTS[0][index.index]}</c:when>
														<c:otherwise>No feedback by MOPR
														</c:otherwise>
													</c:choose>
												</td>
											</tr>											
											</c:forEach>
										</table>
									</div>
								</div>
							</c:if>
							<div class="form-group">
                                <div class="col-md-4">
                                    <c:if test="${ userPreference.isMOPR() }">
                                        <button type="button"
                                                onclick="onClose('viewPlanDetails.html?<csrf:token uri='viewPlanDetails.html'/>&stateCode=${userPreference.getStateCode()}')"
                                                class="btn bg-orange waves-effect">
                                            <i class="fa fa-arrow-left" aria-hidden="true"></i>
                                            <spring:message code="Label.BACK" htmlEscape="true" />
                                        </button>
                                    </c:if>
                                </div>
                                <div class="col-md-offset-2 text-right">
                                
                                    <c:if test="${planUtil.isNotSubmitted() and userPreference.isState() and planUtil.pendingAtMOPR()}"><c:if test="${ !IEC_ACTIVITY.getFreeze() }"><input type="submit" name="action" value="SAVE"
                                                                                       class="btn bg-green waves-effect"/></c:if>
                                    <c:if test="${  IEC_ACTIVITY.getOwnData() }"><input type="submit" name="action"
                                                                                        value="${ IEC_ACTIVITY.getFreeze() ? 'UNFREEZE':'FREEZE'}"
                                                                                        class="btn bg-orange waves-effect"/></c:if></c:if>
                                    <c:if test="${userPreference.isMOPR() and planUtil.pendingAtMOPR()}"><c:if test="${ !IEC_ACTIVITY.getFreeze() }"><input type="submit" name="action" value="SAVE"
                                                                                       class="btn bg-green waves-effect"/></c:if>
                                    <c:if test="${  IEC_ACTIVITY.getOwnData() }"><input type="submit" name="action"
                                                                                        value="${ IEC_ACTIVITY.getFreeze() ? 'UNFREEZE':'FREEZE'}"
                                                                                        class="btn bg-orange waves-effect"/></c:if></c:if> 
                                    <button type="button" onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
                                            class="btn bg-red waves-effect">
                                        <spring:message code="Label.CLOSE" text="Close" htmlEscape="true"/>
                                    </button>
                                </div>
                            </div>
                        </form:form>
                    </div>


                </div>
            </div>
        </div>
    </div>
</section>
</html>
