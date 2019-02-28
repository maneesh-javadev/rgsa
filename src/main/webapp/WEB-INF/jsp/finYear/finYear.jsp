 <%@include file="../taglib/taglib.jsp"%>
<section class="content">
<div class="container-fluid">
<div class="row ">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <div class="card">
                    <div class="header">
                        <h2>Financial year</h2>
                    </div>
                    <form:form method="POST" id="finYearForm" action="home.html" modelAttribute="FACADE_MODEL" >
                    <input type="hidden" name="<csrf:token-name/>" value="<csrf:token-value uri="login.html"/>" />
                    <div class="body">
                          <div class="row clearfix">
                              <div class="col-sm-2">
                              	<label for="Select_Category">Select financial year</label>
                              </div>
                              <div class="col-sm-10">
                                  <div class="form-group">
                                      <div class="form-line">
                                          <form:select path="finYear">
                                          	<form:option value="" ><esapi:encodeForHTML> Select </esapi:encodeForHTML></form:option>	
											<c:forEach items="${FIN_YEARS}" var="finyear">
												<form:option value="${finyear.yearId}" ><esapi:encodeForHTML>${finyear.finYear}</esapi:encodeForHTML></form:option>
											</c:forEach>
										</form:select> 
                                      </div>
                                  </div>
                              </div>
                          </div>
                          <div class="form-group text-right">
                           	<button type="submit" class="btn bg-green waves-effect"><spring:message code="Label.SAVE" htmlEscape="true" /></button>
                           <%-- 	<button type="button" onclick="onClose('index.html?<csrf:token uri='index.html'/>')" class="btn bg-orange waves-effect"><spring:message code="Label.CLOSE" htmlEscape="true" /></button> --%>
                          </div>
                    </div>
                  </form:form>
                </div>
            </div>
        </div>
</div>
</section>
<script  type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/jquery/jquery.validate.js"></script>
