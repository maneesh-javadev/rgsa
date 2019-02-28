
<%@include file="../taglib/taglib.jsp"%>
<section class="content">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2>
							<spring:message code="Label.AddSubCategory" htmlEscape="true" />
						</h2>
					</div>
					<form:form method="POST" id="categorySubcategoryId"
						action="categorySubcategory.html"
						modelAttribute="CATEGORY_SUBCATEGORY" path="categorySubcategory">
						<input type="hidden" name="<csrf:token-name/>"
							value="<csrf:token-value uri="categorySubcategory.html"/>" />
						<div class="body">
							<div class="row clearfix">
								<div class="col-sm-6">
									<label for="Select_Category"> <spring:message
											code="Label.SelectCategory" htmlEscape="true" /></label>
									<div class="form-group">
										<div class="form-line">
											<form:select path="parentId">
												<c:forEach items="${CATEGORY_LIST}" var="category">
													<form:option value="">
														<spring:message code="Label.Select" htmlEscape="true" />
													</form:option>
													<form:option value="${category.categoryId}">${category.categoryDescription}</form:option>
												</c:forEach>
											</form:select>
										</div>
									</div>
								</div>
								<div class="col-sm-6">
									<label for="Sub_Category_Description"><spring:message
											code="Label.SubCategoryDescription" htmlEscape="true" /></label>
									<div class="form-group">
										<div class="form-line">
											<form:input path="categoryDescription"
												cssClass="form-control" placeholder="click me please" />
										</div>
									</div>
								</div>
							</div>
							<div class="form-group text-right">
								<button type="submit" class="btn bg-green waves-effect">
									<spring:message code="Label.SAVE" htmlEscape="true" />
								</button>
								<button type="button" onclick="onClear(this)"
									class="btn bg-light-blue waves-effect">
									<spring:message code="Label.CLEAR" htmlEscape="true" />
								</button>
								<button type="button"
									onclick="onClose('manageCategory.html?<csrf:token uri='manageCategory.html'/>')"
									class="btn bg-orange waves-effect">
									<spring:message code="Label.CLOSE" htmlEscape="true" />
								</button>
							</div>
						</div>
					</form:form>
				</div>
			</div>
		</div>
	</div>
</section>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugins/jquery/jquery.validate.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/categorySubcategory/category-subcategory.js"></script>