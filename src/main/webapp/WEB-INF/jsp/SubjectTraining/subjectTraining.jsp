<%@include file="../taglib/taglib.jsp"%>
<section class="content">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2>Add Subjects Of Training</h2>
					</div>
					<form:form method="post" id="trainingSubjectId"
						action="addsubjects.html" modelAttribute="SUBJECT_TRAINING_MODEL">
						<input type="hidden" name="<csrf:token-name/>"
							value="<csrf:token-value uri="addsubjects.html"/>" />
						<div class="body">
							<div class="row clearfix">
								<div class="col-sm-6">
									<label for="selectCategory">Select Training Category</label>
									<div class="form-group">
										<div class="form-line">
											<form:select path="trainingCtgId"
												class="form-control show-tick" data-live-search="true">
												<c:forEach items="${TRAINING_CATEGORIES_LIST}"
													var="TRAINING_CATEGORY">
													<form:option value="${TRAINING_CATEGORY.trainingCtgId}">${TRAINING_CATEGORY.trainingCatName}</form:option>
												</c:forEach>
											</form:select>
										</div>
									</div>
								</div>
								<div class="col-sm-6">
									<label for="trainingSubject">Name of Training Subject</label>
									<div class="form-group">
										<div class="form-line">
											<form:input path="trainingSubject" class="form-control" />
										
										</div>
									</div>
								</div>
							</div>
							<div class="form-group text-right">
								<button type="submit" class="btn bg-green waves-effect">SAVE</button>
							<!-- 	<button type="button" onclick="onClear(this)"
									class="btn bg-light-blue waves-effect">CLEAR</button> -->
								<button type="button"
									onclick="onClose('managesubjects.html?<csrf:token uri='managesubjects.html'/>')"
									class="btn bg-orange waves-effect">CLOSE</button>
							</div>
						</div>
					</form:form>
				</div>
			</div>
		</div>
	</div>
</section>
