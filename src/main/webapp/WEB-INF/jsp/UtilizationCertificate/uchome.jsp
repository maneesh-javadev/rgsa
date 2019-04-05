
<%@include file="../taglib/taglib.jsp"%>    
<section class="content">
	<div class="container-fluid" data-ng-controller="qGovProgressCtrl">
		<div class="row row-clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<c:if test="${not empty msg_class}" >
					<div class="alert ${msg_class} alert-dismissible" role="alert">
						<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
						${msg} 
					</div>
				</c:if>
			
				<form:form  method="POST"  class="form-horizontal form-normal" action="getUtilCerPage.html" enctype="multipart/form-data">
				
					<div class="form-group">
						<label for="inputFinYear" class="col-sm-4 control-label">Select Financial Year:</label>
						<div class="col-sm-8">
							<form:select class="form-control" id="inputFinYear" path="selectedYear" onchange="this.form.submit()">
								<c:forEach var="item" items="${command.yearMap}">
									<c:choose>
										<c:when test="${item.getKey() == command.selectedYear}">
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
					
					<div class="form-group">
						<label for="inputInstallmentNumber" class="col-sm-4 control-label">Select Installment:</label>
						<div class="col-sm-8">
							<form:select class="form-control" id="inputInstallmentNumber" path="selectedInstallment" onchange="this.form.submit()">
								<c:forEach var="item" items="${command.installmentMap}">
									<c:choose>
										<c:when test="${item.getKey() == command.selectedInstallment}">
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
					<div class="form-group">
						<c:if test="${!command.processed}">
							<button type="submit" class="btn btn-primary col-sm-offset-4">Get Options for selection</button>
						</c:if>
					</div>
					
				</form:form>
				<c:if test="${command.processed}">
					<div class="btn-group btn-group-justified" role="group" aria-label="...">
					
						<div class="btn-group" role="group">
							<a type="button" class="btn btn-lg btn-success" href="viewUtilCerTpl.html?finYearId=${command.selectedYear}&installmentId=${command.selectedInstallment}" target="_blank">
								<span class="glyphicon glyphicon-download" aria-hidden="true"></span>
								Download Unsigned Certificate
							</a>
						</div>
						<c:if test="${command.hasDownload}">
							<div class="btn-group" role="group">
								<button type="button" class="btn btn-lg btn-danger" data-toggle="modal" data-target="#uploadModal">
									<span class="glyphicon glyphicon-upload" aria-hidden="true"></span>
									${command.hasUpload ? 'Re-' : ''}Upload Signed Certificate
								</button>
							</div>
						</c:if>
						<c:if test="${command.hasUpload}">
							<div class="btn-group" role="group">
								<a type="button" class="btn btn-lg btn-success" href="viewUploadedUtilCertficate.html?finYearId=${command.selectedYear}&installmentId=${command.selectedInstallment}" target="_blank">
									<span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span>
									View Uploaded Certificate
								</a>
							</div>
						</c:if>
					</div>
				</c:if>
			
				
			</div>
			
			
		</div>
	</div>
</section>
<div class="modal fade" id="uploadModal" tabindex="-1" role="dialog" aria-labelledby="uploadModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="uploadModalLabel">Choose the file</h4>
      </div>
      <c:if test="${command.processed}">
	      <form  method="POST"  action="getUtilCerPage.html" enctype="multipart/form-data">
	        <div class="modal-body">
	            <div class="form-group">
	              <input type="hidden" name="selectedYear" value="${command.selectedYear}"/>
	              <input type="hidden" name="selectedInstallment" value="${command.selectedInstallment}"/>
	              <label for="recipient-name" class="control-label">File:</label>
	              <input type="file" name="file" class="form-control" id="recipient-name">
	            </div>
	            <div class="form-group clearfix">
	            </div>
	        </div>
	        <div class="modal-footer">
	          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	          <input type="submit" class="btn btn-primary" value="Upload"/>
	        </div>
	      </form>
      </c:if>
    </div>
  </div>
</div>
