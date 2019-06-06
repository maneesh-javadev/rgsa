<%@include file="../taglib/taglib.jsp"%>
<section class="content">
	<div class="container-fluid">
		<div class="block-header">
			<h2></h2>
		</div>
		<form:form method="post" id="changepasswordId"
			action="changepassword.html" modelAttribute="CHANGE_PASSWORD_MODEL">
			<input type="hidden" name="<csrf:token-name/>"
				value="<csrf:token-value uri="changepassword.html"/>" />
			
			<div class="row clearfix">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="card">
						<div class="header">
						<h2><spring:message code="Label.ResetPassword" htmlEscape="true" /></h2>
						
						</div>
						<div class="body">

							<label for="old_password"><spring:message code="Label.OldPassword" htmlEscape="true" /></label>
							<div class="form-group">
								<div class="form-line">
									<form:password id="old_passwordId" path="oldPassword"
										class="form-control" placeholder="Enter your old password" />
								</div>
							</div>

							<label for="new_password"><spring:message code="Label.NewPassword" htmlEscape="true" /></label>
							<div class="form-group">
								<div class="form-line">
									<form:password path="newPassword" id="newPasswordId"
										class="form-control" placeholder="Enter your new password" onchange="resetConfirmPassword()" />
								</div>
							</div>
							<label for="password2"><spring:message code="Label.ReEnterPassword" htmlEscape="true" /></label>
							<div class="form-group">
								<div class="form-line">
									<form:password path="confirmPassword" class="form-control" id="confirmPasswordId"
										placeholder="Re-enter your password" onchange="confirmNewPassword()" />
								</div>
							</div>
							<div class="form-group text-right">
								<button type="submit" class="btn bg-green waves-effect">
									<spring:message code="Label.UPDATE" htmlEscape="true" />
								</button>
								<button type="button" onclick="onClear(this)"
									class="btn bg-light-blue waves-effect">
									<spring:message code="Label.CLEAR" htmlEscape="true" />
								</button>
								<button type="button"
									onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
									class="btn bg-orange waves-effect">
									<spring:message code="Label.CLOSE" htmlEscape="true" />
								</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</form:form>
	</div>
</section>

<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugins/jquery/jquery.validate.js"></script>	
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/changePassword/change-Password.js"></script>	