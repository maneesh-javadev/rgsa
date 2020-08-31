<%@include file="../taglib/taglib.jsp"%>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
<section class="content">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="body">
						<div class="form-group">
							<div align="center"
								class="Alert">
									<i class="fa fa-meh-o fa-lg" aria-hidden="true"></i><span>
										${form_name}  not <font color="red">freeze</font>.</span><br />
							</div>
						</div>
						<div class="text-right">
						<button type="button"
									onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
									class="btn bg-orange waves-effect">CLOSE</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<style>
.Alert {
	font-size: x-large;
	color: red;
	background-color: #fbeeed;
	border-color: #f7d8dd;
	padding-top: 5%;
	padding-bottom: 5%;
}
</style>