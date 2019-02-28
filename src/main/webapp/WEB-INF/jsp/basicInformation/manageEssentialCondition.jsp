<%@include file="../taglib/taglib.jsp"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/dataTables/css/dataTables.bootstrap.min.css">

	<section class="content">
    	<div class="container-fluid">
			<div class="row clearfix">
                <!-- Table example -->
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <div class="card">
                        <div class="header">
                            <h2>Essential Condition</h2>
                        </div>
                        <div class="body">
                        	<c:if test="${empty BASIC_INFO}">
	                         <div class="form-group text-right">
	                            	<a href="essentialConditions.html?<csrf:token uri='essentialConditions.html'/>" class="btn bg-green waves-effect"> ADD ESSENTIAL CONDITIONS</a>
	                         </div>
	                         </c:if>
                            <div class="table-responsive">
                                <table id="basicInfoTable" class="table table-bordered table-striped table-hover dataTable">
                                    <thead> 
								        <tr>
								          <th rowspan="2" width="5%"><spring:message code="S No." htmlEscape="true" /></th>
								             <th rowspan="2" width="85%"><spring:message code="Fin  Year" htmlEscape="true" /></th>
						                     <th  colspan="2" width="10%"><spring:message code="Action" htmlEscape="true" /></th>
						                    </tr>
						                  <tr>
						                      <th><spring:message code="View" htmlEscape="true" /></th>
						                      <th><spring:message code="Modify" htmlEscape="true" /></th>
						                      <%-- <th><spring:message code="Freez" htmlEscape="true" /></th> --%>
						                  </tr>
						    		</thead> 
                                    <tbody>
	                                        <c:choose>
	                                        	<c:when test="${!empty BASIC_INFO}">
	                                        		<tr>
			                                            <td>1</td>
			                                            <td>${BASIC_INFO.finYear.finYear}</td>
			                                            <td>
			                                            	<span><a href="viewEssentialConditions.html"><i class="fa fa-eye fa-lg view-color" aria-hidden="true"></i></a></span>
			                                            </td>
			                                            <td>
			                                            	<span><a href="updateEssentialConditions.html"><i class="fa fa-pencil-square-o fa-lg edit-color" aria-hidden="true"></i></a></span>
			                                            </td>
			                                            <%-- <td>
			                                            	<span><a href="freezeEssentialConditions.html?basicInfoId=${BASIC_INFO.basicInfoId}"><i class="fa fa-lock fa-lg delete-color" aria-hidden="true"></i></a></span>	
			                                            </td> --%>
			                                        </tr>	
	                                        	</c:when>
	                                        	<c:otherwise>
	                                        		<tr><td class="text-center" colspan="5"><b class="delete-color">
	                                        			<i class="fa fa-smile-o" aria-hidden="true"></i> You Have not added essential Condition</b>
	                                        		</td></tr>
	                                        	</c:otherwise>
	                                        </c:choose>
	                                        
                                    </tbody> 
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- #END# Table example -->
            </div>
		</div>
	</section>
<script  type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/dataTables/js/jquery.dataTables.js"></script>
<script  type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/dataTables/js/dataTables.bootstrap.min.js"></script>
<script>
$(function () {
    $('#js-basic-example').DataTable({
        responsive: true
    });
});
</script>