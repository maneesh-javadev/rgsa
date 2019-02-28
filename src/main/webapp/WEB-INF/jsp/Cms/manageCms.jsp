
<%@include file="../taglib/taglib.jsp"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/dataTables/css/dataTables.bootstrap.min.css">
<script  type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/dataTables/js/jquery.dataTables.js"></script>
<script  type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/dataTables/js/dataTables.bootstrap.min.js"></script>

<script>

$(function () {
    $('.js-basic-example').DataTable({
        responsive: true
    });
});

</script>

    <section class="content">
        <div class="container-fluid">
          
           <div class="row clearfix">
                <!-- Table example -->
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <div class="card">
                        <div class="header">
                            <h2>Manage CMS</h2>
                        </div>
                        <div class="body"> 
   							 <div class="form-group text-right">
	                            	<a href="addCms.html?<csrf:token uri='addCms.html'/>">
	                            	<button type="button" class="btn bg-green waves-effect">Add CMS</button></a>
	                         </div>
                            <ul class="nav nav-tabs tab-nav-right" role="tablist" >
	                            <c:forEach items="${DOCUMENT_TYPE_LIST}" var="docList" varStatus="countdoc">		                            
		                                <c:choose>
                                          <c:when test="${docList.typeId eq 5}">
                                          		<li role="presentation" class="active">
				                                	<a href="#tabData${docList.typeId}" data-toggle="tab">				                               			
				                               			${docList.name}
				                                	</a>
			                                	</li>
                                           </c:when>
                                           <c:otherwise>
                                           		<li role="presentation" >
				                                	<a href="#tabData${docList.typeId}" data-toggle="tab">
				                                		${docList.name}
				                                	</a>
			                                	</li>
                                           </c:otherwise>
		                               </c:choose>
	                             </c:forEach>                            
                            </ul>
                            <div class="tab-content">
                           <c:forEach items="${DOCUMENT_TYPE_LIST}" var="docList" >                            
						 	   <c:choose>
                                    <c:when test="${docList.typeId eq 5}">
                                    	<div role="tabpanel" class="tab-pane fade in active" id="tabData${docList.typeId}">
											<table class="table table-bordered table-striped table-hover js-basic-example dataTable" >
			                                    <thead> 
											        <tr>
											             <th width="1%"rowspan="2" ><spring:message code="Label.Sno" htmlEscape="true" /></th>
											              <th width="10%" rowspan="2"><spring:message code="Label.StateName" htmlEscape="true" /></th>
											              <th width="10%" rowspan="2"><spring:message code="Label.FileType" htmlEscape="true" /></th> 
											             <th width="10%" rowspan="2"><spring:message code="Label.Filetitle" htmlEscape="true" /></th>											             
											             <th width="10%" rowspan="2"><spring:message code="Label.Filename" htmlEscape="true" /></th>								             								         
									                     <th width="10%" ><spring:message code="Label.Action" htmlEscape="true" /></th> 
									                </tr>
									                  <tr>
									                      <th width="10%" ><spring:message code="Label.Update" htmlEscape="true" /></th>
									                  </tr> 
									    		</thead> 
			                                    <tbody>
			                                      <c:set var="index" value="0" scope="page" />
			                                      <c:forEach items="${DOCUMENT_LIST}" var="documentL" varStatus="count">
				                                       <c:if test="${docList.typeId eq documentL.typeId}">											                    	
										               <c:set var="index" value="${index + 1}" scope="page"/>	
					                                     <%--    <tr>
					                                            <td width="1%"><esapi:encodeForHTML>${index}</esapi:encodeForHTML></td>
					                                             <td width="10%"><esapi:encodeForHTML>${documentL.stateName}</esapi:encodeForHTML></td>
					                                            <td width="10%"><esapi:encodeForHTML>${documentL.typeName}</esapi:encodeForHTML></td>
					                                            <td width="10%"><esapi:encodeForHTML>${documentL.fileTitle}</esapi:encodeForHTML></td>					                                        
					                                            <td width="10%"><esapi:encodeForHTML>${documentL.fileName}</esapi:encodeForHTML></td>                                          
					                                            <td>
					                                            	<span>
					                                            	<a href="modifyCms.html?uploadDocumentId=${documentL.uploadDocumentId}&<csrf:token uri='modifyCms.html'/>">
					                                            	<i class="fa fa-pencil-square-o fa-lg edit-color" aria-hidden="true" title="Modify Document"></i></a>
					                                            	</span>
					                                            </td>
					                                        </tr> --%>
					                                         <tr>
					                                            <td><esapi:encodeForHTML>${index}</esapi:encodeForHTML></td>
					                                            <td><esapi:encodeForHTML>${documentL.stateName}</esapi:encodeForHTML></td>
					                                            <td><esapi:encodeForHTML>${documentL.typeName}</esapi:encodeForHTML></td> 
					                                            <td><esapi:encodeForHTML>${documentL.fileTitle}</esapi:encodeForHTML></td>
					                                          <%--   <td><esapi:encodeForHTML>${documentL.fileContentType}</esapi:encodeForHTML></td> --%>
					                                            <td><esapi:encodeForHTML>${documentL.fileName}</esapi:encodeForHTML></td>                                          
					                                            <td>
					                                            	<span>
					                                            	<a href="modifyCms.html?uploadDocumentId=${documentL.uploadDocumentId}&<csrf:token uri='modifyCms.html'/>">
					                                            	<i class="fa fa-pencil-square-o fa-lg edit-color" aria-hidden="true" title="Modify Document"></i></a>
					                                            	</span>
					                                            </td>
					                                        </tr>
				                                        </c:if>
			                                       </c:forEach>	
			                                   </tbody> 
			                                </table>
                                    	</div>
                                    </c:when>
                                    <c:otherwise>
                                    	<div role="tabpanel" class="tab-pane fade" id="tabData${docList.typeId}">
											<table class="table table-bordered table-striped table-hover js-basic-example dataTable" width="100%">
			                                    <thead> 
											        <tr>
											             <th rowspan="2" ><spring:message code="Label.Sno" htmlEscape="true" /></th>
											              <th rowspan="2"><spring:message code="Label.StateName" htmlEscape="true" /></th>
											             <th rowspan="2"><spring:message code="Label.FileType" htmlEscape="true" /></th> 
											             <th rowspan="2"><spring:message code="Label.Filetitle" htmlEscape="true" /></th> 
											             <th rowspan="2"><spring:message code="Label.Filename" htmlEscape="true" /></th>								             								         
									                     <th><spring:message code="Label.Action" htmlEscape="true" /></th> 
									                </tr>
									                  <tr>
									                      <th><spring:message code="Label.Update" htmlEscape="true" /></th>
									                  </tr> 
									    		</thead> 
			                                     <tbody>
			                                      <c:set var="index" value="0" scope="page" />
			                                      <c:forEach items="${DOCUMENT_LIST}" var="documentL" varStatus="count">
				                                       <c:if test="${docList.typeId eq documentL.typeId}">											                    	
										               <c:set var="index" value="${index + 1}" scope="page"/>	
					                                        <tr>
					                                            <td><esapi:encodeForHTML>${index}</esapi:encodeForHTML></td>
					                                            <td><esapi:encodeForHTML>${documentL.stateName}</esapi:encodeForHTML></td>
					                                            <td><esapi:encodeForHTML>${documentL.typeName}</esapi:encodeForHTML></td> 
					                                            <td><esapi:encodeForHTML>${documentL.fileTitle}</esapi:encodeForHTML></td>
					                                          <%--   <td><esapi:encodeForHTML>${documentL.fileContentType}</esapi:encodeForHTML></td> --%>
					                                            <td><esapi:encodeForHTML>${documentL.fileName}</esapi:encodeForHTML></td>                                          
					                                            <td>
					                                            	<span>
					                                            	<a href="modifyCms.html?uploadDocumentId=${documentL.uploadDocumentId}&<csrf:token uri='modifyCms.html'/>">
					                                            	<i class="fa fa-pencil-square-o fa-lg edit-color" aria-hidden="true" title="Modify Document"></i></a>
					                                            	</span>
					                                            </td>
					                                        </tr>
				                                        </c:if>
			                                       </c:forEach>	
			                                   </tbody>  
			                                </table>
                                    	</div>
                                    </c:otherwise>
                                </c:choose>								
							</c:forEach>
							</div>
                        </div>
                    </div>
                </div>
                <!-- #END# Table example -->
            </div>
        </div>
    </section>