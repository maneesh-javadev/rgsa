<%@include file="../taglib/taglib.jsp"%>

<html>
<head>
<script type="text/javascript">

	function freezeAndUnfreezeEocs(obj){
		document.getElementById("dbFileName").value = obj;
		document.extentOfCoverage.method = "post";
		document.extentOfCoverage.action = "freezAndUnfreezEocs.html?<csrf:token uri='freezAndUnfreezEocs.html'/>";
		document.extentOfCoverage.submit();
	}
	
	

		</script>
</head>
<section class="content">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2>Extent of Coverage</h2>
					</div>
					<form:form method="post" name="extentOfCoverage" action="extentOfCoverage.html"
						modelAttribute="EXTENT_OF_COVERAGE_MODEL">
						<input type="hidden" name="<csrf:token-name/>"
							value="<csrf:token-value uri="extentOfCoverage.html" />" />
						<div class="body">
							<div class="table-responsive">
								<table id="tableId" class="table table-bordered">
									<thead>
										<tr>
											<th><div align="center">
													<strong>Training Category</strong>
												</div></th>
											<th><div align="center">
													<strong>No. of ERs Trained</strong>
												</div></th>
											<th><div align="center">
													<strong>No. of Panchayat Secretary Trained
													</strong>
												</div></th>
											<th><div align="center">
													<strong>No. of ERs to be Trained
													</strong>
												</div></th>
											<th><div align="center">
													<strong>No. of Panchayat Secretary to be Trained
													</strong>
												</div></th>
									</tr>
									</thead>
									<tbody id="tbodyId">
									
										<c:set var="count" value="0" scope="page" />
										
										<c:forEach items="${Fetch_Training_category}" var="Training_category"
											varStatus="index">
											
											
											<input type="hidden" name="extentOfCoverageDetails[${count}].trainingCategoryId" value="${Training_category.trainingCategoryId}">
											<form:hidden path="extentOfCoverageDetails[${count}].coverageDetailsId" />
												<tr id="newRowHtml">													<td><div align="center">
															<strong>${Training_category.trainingCategoryName}</strong>
														</div></td>
													<td><form:input type="number" path="extentOfCoverageDetails[${count}].noOfErsTrained"  class="active123 form-control" min="1"   oninvalid="this.setCustomValidity('Entered value greater than 0')" oninput="setCustomValidity('')"/></td>
													<td><form:input path="extentOfCoverageDetails[${count}].noOfPsTrained" type="number" class="active123 form-control" min="1"   oninvalid="this.setCustomValidity('Entered value greater than 0')" oninput="setCustomValidity('')"/></td>
													<td><form:input path="extentOfCoverageDetails[${count}].noOfErsToBeTrained" type="number" class="active123 form-control" min="1"   oninvalid="this.setCustomValidity('Entered value greater than 0')" oninput="setCustomValidity('')" /></td>
													<td><form:input path="extentOfCoverageDetails[${count}].noOfPsToBeTrained" type="number" class="active123 form-control" min="1"   oninvalid="this.setCustomValidity('Entered value greater than 0')" oninput="setCustomValidity('')"/></td>
												</tr>
												<c:set var="count" value="${count + 1}" scope="page"/>
											</c:forEach>
										<%-- </c:forEach> --%>
									</tbody>
								</table>
							</div>

							<div class="text-right">
										<button type="submit" class="btn bg-green waves-effect"
											id="save">SAVE</button>

										<button type="button" onclick='freezeAndUnfreezeEocs("freeze")'
											class="btn bg-green waves-effect" id="freeze">
											FREEZE</button>
										<button type="button" onclick='freezeAndUnfreezeEocs("unfreeze")'
											class="btn bg-green waves-effect" id="unfreeze">
											UNFREEZE</button>

										<button type="button" onclick="onClear(this)"
											class="btn bg-light-blue waves-effect" id="clear">CLEAR</button>
										<button type="button"
											onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
											class="btn bg-orange waves-effect">CLOSE</button>
									<input type="hidden" name="dbFileName" id="dbFileName">
									<input type="hidden" name="coverageId" value="${extentOfCoverage.coverageId}" />
							</div>
						</div>
					</form:form>
				</div>
			</div>
		</div>
	</div>
</section>
<script>
$('document').ready(function(){
	if( '${readOnlyEnabled}' == 'true'){
		$('.active123').prop('readonly',true);
		$('#save').prop('disabled',true);
		$('#clear').prop('disabled',true);
		$('#freeze').hide();
		$('#unfreeze').show();
	}
	else
		{
		$('.active123').prop('readonly' ,false)
		$('#freeze').show();
		$('#unfreeze').hide();
		}
});
</script>