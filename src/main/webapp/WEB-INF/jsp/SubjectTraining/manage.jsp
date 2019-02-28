<%@include file="../taglib/taglib.jsp"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/dataTables/css/dataTables.bootstrap.min.css">
<script>

$(function () {
    $('#manageSubject').DataTable({
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
                            <h2>Subjects Of Training</h2>
                        </div>
                        <div class="body">
	                         <div class="form-group text-right">
	                            <a href="addsubjects.html?<csrf:token uri='addsubjects.html'/>" class="btn bg-green waves-effect"> ADD NEW SUBJECT</a>
	                         </div>
                            <div class="table-responsive">
                                <table id="manageSubject" class="table table-bordered table-striped table-hover js-basic-example dataTable">
                                    <thead> 
								        <tr>
								          <th rowspan="2" width="5%"><spring:message code="S No." htmlEscape="true" /></th>
								             <th rowspan="2" width="85%"><spring:message code="Subject Name" htmlEscape="true" /></th>
						                     <th  colspan="3" width="10%"><spring:message code="Action" htmlEscape="true" /></th>
						                    </tr>
						                  <tr>
						                      <th><spring:message code="View" htmlEscape="true" /></th>
						                      <th><spring:message code="Modify" htmlEscape="true" /></th>
						                      <th><spring:message code="Delete" htmlEscape="true" /></th>
						                  </tr>
						    		</thead> 
                                    <tbody>
                                    	<c:forEach items="${SUBJECTS}" var="subject" varStatus="count">
                                    		<tr>
                                    			<td>${count.count}</td>	
                                    			<td>${subject.subjectName}</td>
                                    			<td>
                                            	<span><a href="viewsubjects.html?<csrf:token uri='viewsubjects.html'/>&id=${subject.subjectId}"><i class="fa fa-eye fa-lg view-color" aria-hidden="true"></i></a></span>
	                                            </td>
	                                            <td>
	                                            	<span><a href="modifysubjects.html?<csrf:token uri='modifysubjects.html'/>&id=${subject.subjectId}"><i class="fa fa-pencil-square-o fa-lg edit-color" aria-hidden="true"></i></a></span>
	                                            </td>
	                                            <td>
	                                            	<span><a href="deletesubjects.html?<csrf:token uri='deletesubjects.html'/>&id=${subject.subjectId}"><i class="fa fa-trash-o fa-lg delete-color" aria-hidden="true"></i></a></span>	
	                                            </td>
                                    		</tr>
                                    	
                                    	</c:forEach>
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
