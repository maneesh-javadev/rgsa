

<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<header>
<div class="top">
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-3 col-xs-12">
				<ul class="social-network">
					<li>
						<a href="#" data-placement="top" title="" data-original-title="Facebook" style="color:#3b5998;">
							<i class="fa fa-facebook"></i>
						</a>
					</li>
					<li>
						<a href="#" data-placement="top" title="" data-original-title="Twitter"  style="color: #38A1F3" >
							<i class="fa fa-twitter"></i>
						</a>
					</li>
					<li>
						<a href="#" data-placement="top" title="" data-original-title="Youtube" style="color: red" >
							<i class="fa fa-youtube"></i>
						</a>
					</li>
					<li>
						<a href="#" data-placement="top" title="" data-original-title="Pinterest" style="color: red" >
							<i class="fa fa-pinterest"></i>
						</a>
					</li>
					<li>
						<a href="#" data-placement="top" title="" data-original-title="Google plus" style="color: #DB4437" >
							<i class="fa fa-google-plus"></i>
						</a>
					</li>
				</ul>
			</div>
			<div class="col-lg-9 col-xs-12 pull-right">
				<div class="navbar">
					<div class="navbar-header">
						<!--  <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse"><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span></button>-->
					</div>
					<div class="navbar-collapse">
						<!-- <ul class="nav navbar-nav"></ul>-->
						<ul class="nav navbar-nav navbar-right">
							<li>
								<a href="index.html#content">&nbsp;&nbsp;Skip to Main Content</a>
							</li>
							<li class="dropdown">
								<a href="#language" class="dropdown-toggle" data-toggle="dropdown">
									<span class="fa fa-cog"></span>&nbsp;&nbsp;Theme
									<span class="caret"></span>
								</a>
								<ul class="dropdown-menu">
									<li>
										<a href="#" onClick="javascript:changeTheme('b')">Brown</a>
									</li>
									<li>
										<a href="#" onClick="javascript:changeTheme('v')">Voilet</a>
									</li>
								</ul>
							</li>
							<li class="dropdown">
								<a href="#language" class="dropdown-toggle" data-toggle="dropdown">
									<span class="fa fa-language"></span>&nbsp;&nbsp;Language 
									<span class="caret"></span>
								</a>
								<ul class="dropdown-menu">
									<li>
										<a href="#" onClick="javascript:changeLanguage('hi')">हिंदी</a>
									</li>
									<li>
										<a href="#" onClick="javascript:changeLanguage('en')">English</a>
									</li>
								</ul>
							</li>
							<li class="active">
								<a data-toggle="modal" data-target="#login">
									<span class="glyphicon glyphicon-log-in"></span>&nbsp;&nbsp;Login
								</a>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/resources/dashboard/index.html" target="_blank" style="  color: red; font-weight: bold;">
									<span class="fa fa-globe"></span>&nbsp;&nbsp;Dashboard
								</a>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="container-fluid logoband">
	<div class="row">
		<div class="col-sm-1 col-xs-3">
			<a class="navbar-brand" href="index.html">
				<img src="${pageContext.request.contextPath}/resources/index/images/emblem-dark.png" alt="" class="img-responsive"/>
			</a>
		</div>
		<div class="col-lg-7 col-sm-7 col-xs-9">
			<div class="logo">
				<a href="index.html">
					<span>
						<strong>Rashtriya Gram Swaraj Abhiyan</strong>
					</span>
					<br>Government of India | Ministry of Panchayati Raj
					</a>
			</div>
		</div>
		<div class="col-lg-2 col-sm-2 col-xs-6  overlineMobile">
			<img src="${pageContext.request.contextPath}/resources/index/images/gandhiji-img.jpg" alt="Gandhiji" class="img-responsive marginTop5 center-block">
		</div>
		<div class="col-lg-2 col-sm-2 col-xs-6  overlineMobile">
		<img src="${pageContext.request.contextPath}/resources/index/images/gandhi.png" alt="150 years of Celebrating the Mahatma" title="150 years of Celebrating the Mahatma" class="img-responsive marginTop5 center-block">
		</div>
	</div>
</div>
</header>
		<!-- end header -->
		<!-- Modal Login -->
		<form:form class="form" role="form" method="post"  action="login.html"  modelAttribute="FACADE_MODEL"   id="loginForm">
			<input type="hidden" name="
				<csrf:token-name/>" value="<csrf:token-value uri='login.htm'/>" />
				<div class="modal fade" id="login" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal">&times;</button>
								<h4 class="modal-title" id="myModalLabel">Login</h4>
							</div>
							<div class="modal-body">
								<div class="form-group">
									<span class="errormessage" id="errorMessage"></span><br/>
								</div>
							
								<div class="form-group has-feedback">
									<label class="control-label">User Id</label>
									<form:input cssStyle="color:black;" path="loginId" id="userName" placeholder="Username"  autocomplete="off" htmlEscape="true"  class="form-control" required="required"/>
									<span class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true"></span>
								</div>
								
								<div class="form-group has-feedback">
									<label class="control-label">Password</label>
									<form:password cssStyle="color:black;" path="password" id="userPassword"  placeholder="Password" autocomplete="off" htmlEscape="true"  class="form-control" required="required"/>
									<span class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true"></span>
								</div>
								<div class="form-group">
									<img src="captchaImage" width="200px" id="img_Capatcha" />
									<a href="#" onclick="javascript:refreshCaptcha()" class="pull-right">
										<i class="fa fa-refresh"></i>
									</a>
								</div>
								<div class="form-group has-feedback">
									<label class="control-label">Captcha Answer</label>
									<form:input cssStyle="color:black;" id="captchaAnswer" path="captchaAnswer" placeholder="Captcha Answer" class="form-control"  htmlEscape="true" autocomplete="off" required="required"/>
									<span class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true"></span>
								
								</div>
								<div class="form-group">
									<span class="errormessage" id="errorMessageCapcha"></span><br/>
								</div>
								<button type="submit" onclick="validateUser(this)" class="btn btn-primary center-block">Login</button>
								<!-- <input type="checkbox" value="rememberme" id="rememberme">Remember me <br/><br/><a href="#">Forgot your password?</a> -->
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
							</div>
						</div>
					</div>
				</div>
				<!-- end become a member modal -->
			</form:form>
			<!-- end login form -->
		<section id="featured" class="bg">
			<div class="row">
				<nav class="navbar navbar-default">
					<div class="navbar-header">
						<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar-collapse-1">
							<span class="sr-only">Toggle navigation</span> <span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span>
						</button>
					</div>
					<div class="collapse navbar-collapse" id="navbar-collapse-1">
						<ul class="nav navbar-nav navbar-left">
							<li class="active"><a href="index.html"><i class="fa fa-home fa-onehalf"></i></a></li>
							<li><a target="_parent" href="index.html?<csrf:token uri='index.html'/>" >Home</a></li>
							<li><a target="_parent" href="aboutRGSA.html?<csrf:token uri='aboutRGSA.html'/>" >RGSA Framework</a></li>
							<li><a target="_parent" href="aboutGPDP.html?<csrf:token uri='aboutGPDP.html'/>" >GPDP Guildlines</a></li>
							<li><a target="_parent" href="downloadNew.html?<csrf:token uri='downloadNew.html'/>" >Downloads </a></li>
							<li><a target="_parent"   href="manageCms.html?<csrf:token uri='manageCms.html'/>">Gallery</a></li>
							<li><a href="#" data-toggle="modal" data-target="#contactsUs">Contact Us</a></li></ul>
					</div>
				</nav>

			</div>
			
		</section>	
			