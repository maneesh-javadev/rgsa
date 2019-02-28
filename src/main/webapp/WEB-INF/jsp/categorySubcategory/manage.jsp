<%@include file="../taglib/taglib.jsp"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/plugins/dataTables/css/dataTables.bootstrap.min.css">
<script>
	$(function() {
		$('#categoryTable').DataTable({
			responsive : true
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
						<h2>
							<spring:message code="Label.SubCategory" htmlEscape="true" />
						</h2>
					</div>
					<div class="body">
						<div class="form-group text-right">
							<a
								href="categorySubcategory.html?<csrf:token uri='categorySubcategory.html'/>"
								class="btn bg-green waves-effect"> ADD NEW SUB CATEGORY</a>
						</div>
						<div class="table-responsive">
							<table id="categoryTable"
								class="table table-bordered table-striped table-hover js-basic-example dataTable">
								<thead>
									<tr>
										<th rowspan="2" width="5%"><spring:message
												code="CategoryId" htmlEscape="true" /></th>
										<th rowspan="2" width="85%"><spring:message
												code="categoryDescription" htmlEscape="true" /></th>
										<th colspan="3" width="10%"><spring:message code="Action"
												htmlEscape="true" /></th>
									</tr>
									<tr>
										<th><spring:message code="Label.View" htmlEscape="true" /></th>
										<th><spring:message code="Label.Modify" htmlEscape="true" /></th>
										<th><spring:message code="Label.Delete" htmlEscape="true" /></th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${CATEGORYS}" var="category"
										varStatus="count">
										<tr>
											<td>${count.count}</td>
											<td>${category.categoryDescription}</td>
											<td><span><a
													href="viewCategory.html?<csrf:token uri='viewCategory.html'/>&id=${category.categoryId}"><i
														class="fa fa-eye fa-lg view-color" aria-hidden="true"></i></a></span>
											</td>
											<td><span><a
													href="updateCategory.html?<csrf:token uri='updateCategory.html'/>&id=${category.categoryId}"><i
														class="fa fa-pencil-square-o fa-lg edit-color"
														aria-hidden="true"></i></a></span></td>
											<td><span><a
													href="deleteCategory.html?<csrf:token uri='deleteCategory.html'/>&id=${category.categoryId}"><i
														class="fa fa-trash-o fa-lg delete-color"
														aria-hidden="true"></i></a></span></td>
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
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugins/dataTables/js/jquery.dataTables.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugins/dataTables/js/dataTables.bootstrap.min.js"></script>
