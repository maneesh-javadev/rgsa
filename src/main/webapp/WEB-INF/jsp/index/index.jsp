<%@include file="../taglib/taglib.jsp"%>
<html lang="en">
<head>
<meta charset="utf-8">
<title>RASHTRIYA GRAM SWARAJ ABHIYAN-Government of India</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta name="description" content="Bootstrap 3 template for corporate business" />
<!-- css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/index/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/font-awesome/font-awesome-4.2.0/css/font-awesome.min.css">

<link href="${pageContext.request.contextPath}/resources/plugins/flexslider/flexslider.css" rel="stylesheet" media="screen" />	

<style>
@font-face {
font-family:'jackfrost';
src:url('fonts/jackfrost.otf') format('opentype');
}
</style>
	
</head>
<body  data-ng-app="indexModule" data-ng-controller="indexController" style="overflow-x:hidden;">

<!-- Add all page content inside this div if you want the side nav to push page content to the right (not used if you only want the sidenav to sit on top of the page -->
<div id="main">
<div id="wrapper">
	<!-- start header -->
	<header>
			<div class="top">
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-3 col-xs-12">
							<ul class="social-network">
						<li><a href="#" data-placement="top" title="" data-original-title="Facebook" style="color:#3b5998;"><i class="fa fa-facebook"></i></a></li>
						<li><a href="#" data-placement="top" title="" data-original-title="Twitter"  style="color: #38A1F3" ><i class="fa fa-twitter"></i></a></li>
						<li><a href="#" data-placement="top" title="" data-original-title="Youtube" style="color: red" ><i class="fa fa-youtube"></i></a></li>
						<li><a href="#" data-placement="top" title="" data-original-title="Pinterest" style="color: red" ><i class="fa fa-pinterest"></i></a></li>
						<li><a href="#" data-placement="top" title="" data-original-title="Google plus" style="color: #DB4437" ><i class="fa fa-google-plus"></i></a></li>
					</ul>
						</div>
						<div class="col-lg-9 col-xs-12 pull-right">
					<div class="navbar">
          
                <div class="navbar-header">
                  <!--  <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>-->
                    
                </div>
                <div class="navbar-collapse">
                   <!-- <ul class="nav navbar-nav">
                        
                    </ul>-->
                    <ul class="nav navbar-nav navbar-right">
					<li>
							<a href="index.html#content">&nbsp;&nbsp;Skip to Main Content</a>
                            			
						
						</li>
						<li class="dropdown"><a href="#language" class="dropdown-toggle" data-toggle="dropdown"><span class="fa fa-cog"></span>&nbsp;&nbsp;Theme<span class="caret"></span></a>
					   <ul class="dropdown-menu"><li><a href="#" onClick="javascript:changeTheme('b')">Brown</a></li><li><a href="#" onClick="javascript:changeTheme('v')">Voilet</a></li></ul></li>
                       <li class="dropdown"><a href="#language" class="dropdown-toggle" data-toggle="dropdown"><span class="fa fa-language"></span>&nbsp;&nbsp;Language <span class="caret"></span></a>
					   <ul class="dropdown-menu"><li><a href="#" onClick="javascript:changeLanguage('hi')">हिंदी</a></li><li><a href="#" onClick="javascript:changeLanguage('en')">English</a></li></ul></li>
                      <li class="active"><a data-toggle="modal" data-target="#login"><span class="glyphicon glyphicon-log-in"></span>&nbsp;&nbsp;Login</a></li>
					  <li><a href="${pageContext.request.contextPath}/resources/dashboard/index.htm" target="_blank" style="  color: red; font-weight: bold;"><span class="fa fa-globe"></span>&nbsp;&nbsp;Dashboard</a></li>
                    </ul>
                </div>
            
        </div>
				</div>
					</div>
				</div>
			</div>	
           
            <div class="container-fluid logoband">
            <div class="row">
                   <div class="col-sm-1 col-xs-3"> <a class="navbar-brand" href="index.html"><img src="${pageContext.request.contextPath}/resources/index/images/emblem-dark.png" alt="" class="img-responsive"/></a></div>
                   <div class="col-lg-7 col-sm-7 col-xs-9">
                   <div class="logo"><a href="index.html"><span><strong>Rashtriya Gram Swaraj Abhiyan</strong></span><br>Government of India | Ministry of Panchayati Raj</a></div>
                   </div>
				   <div class="col-lg-2 col-sm-2 col-xs-6  overlineMobile">
                    <img src="${pageContext.request.contextPath}/resources/index/images/gandhiji-img.jpg" alt="Gandhiji" class="img-responsive marginTop5 center-block"> </div>
                    <div class="col-lg-2 col-sm-2 col-xs-6  overlineMobile">
                    <img src="${pageContext.request.contextPath}/resources/index/images/gandhi.png" alt="150 years of Celebrating the Mahatma" title="150 years of Celebrating the Mahatma" class="img-responsive marginTop5 center-block"> </div>
             </div>
            </div>
		<!--	menu-->
        <!--<div class="navbar navbar-default navbar-static-top">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    
                </div>
                <div class="navbar-collapse collapse ">
                    <ul class="nav navbar-nav">
                        <li class=" active">
							<a href="index.html" class="dropdown-toggle " data-toggle="dropdown" data-hover="dropdown" data-delay="0" data-close-others="false">Home</a>
                            			
						
						</li>
                        <li><a href="#videos">Page 1</a></li>
                        <li><a href="#documents">Page 2</a></li>
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                      <li><a data-toggle="modal" data-target="#login"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
                    </ul>
                </div>
            </div>
        </div>-->
	</header>
    
	<!-- end header -->
    
        
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
							<li><a href="#">Home</a></li>
							<li><a href="#">RGSA Framework</a></li>
							<li><a href="#">GPDP Guidelines</a></li>
							<li><a href="#">Reports</a></li>
							<li><a href="downloadNew.html?<csrf:token uri='downloadNew.html'/>">Downloads </a></li>
							<li><a href="#">Gallery</a></li>
							<li><a href="#" data-toggle="modal" data-target="#contactsUs">Contact Us</a></li>
						</ul>
					</div>
				</nav>

			</div>
			
		</section>	
			
			
		<section id="featured" class="bg">
		<div class="row">
			<div class="col-lg-12">
	<!-- Slider -->
        <div id="main-slider" class="main-slider flexslider">
            <ul class="slides">
              <li>
                <img src="${pageContext.request.contextPath}/resources/index/images/slides/flexslider/slide1.jpg" alt="" class="img-responsive"/>
               <!-- <div class="flex-caption">
                    <h3>Title</h3> 
					<p>Sub-title</p> 
                </div>-->
              </li>
              <li>
                <img src="${pageContext.request.contextPath}/resources/index/images/slides/flexslider/slide2.jpg" alt=""  class="img-responsive"/>
               <!-- <div class="flex-caption">
                    <h3>Title</h3> 
					<p>Sub-title</p> 
                </div>-->
              </li>
              <li>
                <img src="${pageContext.request.contextPath}/resources/index/images/slides/flexslider/slide3.jpg" alt="" class="img-responsive" />
               <!-- <div class="flex-caption">
                    <h3>Title</h3> 
					<p>Sub-title</p> 
                </div>-->
              </li>
			  <li>
                <img src="${pageContext.request.contextPath}/resources/index/images/slides/flexslider/slide4.jpg" alt="" class="img-responsive" />
               <!-- <div class="flex-caption">
                    <h3>Title</h3> 
					<p>Sub-title</p> 
                </div>-->
              </li>
            </ul>
        </div>
	<!-- end slider -->
			</div>
		</div>
 <!--</div>-->
	</section>
	      
  <section id="content">
		<div class="container-fluid">
		<div class="row">
			<div class="col-lg-8"><h2 class="text-left box-heading">About RGSA</h2>
		<div class="row">
		<div class="col-lg-12 text-justify">
		<p>The Finance Minister, in his budget speech for 2016-17, announced the launch of new restructured scheme of Rashtriya Gram Swaraj Abhiyan (RGSA), for developing and strengthening the capacities of Panchayati Raj Institutions (PRIs) for rural local governance to become more responsive towards local development needs, preparing the participatory plans that leverage technology, efficient and optimum utilization of available resources for realizing sustainable solutions to local problems linked to Sustainable Development Goals (SDGs). The key principles of SDGs, i.e. leaving no one behind, reaching the farthest first and universal coverage, along with gender equality will be embedded in the design of all capacity building interventions including trainings, training modules and materials.</p><p>In his Budget Speech for 2017-18, the Finance Minister announced to undertake a Mission Antyodaya to bring one crore households out of poverty to make 50,000 Gram Panchayats poverty free. Accordingly, convergent action with Mission Antyodaya has been integrated into this scheme.</p>
		
		</div>
		</div></div>
			<div class="col-lg-4 text-left">
			<h3 class="text-left box-heading "><i class="fa fa-bullhorn transformTilt fa-blink"></i> <span >What&rsquo;s new</span></h3>
		<div class="list-wrpaaer"> 
	<ul class="list-aggregate" id="marquee-vertical" style="position: absolute; top: 0px; left: 0px; height: 1000%;list-style: none;margin-left: -30px;"  >
               <div data-ng-repeat="dd in docs">
               <li>
                 <p class="text-justify">
                   <a href="docs.html?fileId={{dd.docId}}" download>{{dd.docTitle}}</a>        
                 </p>
               </li>
           </div>
               
               </ul>
          </div>
			
			</div>
		</div>
	</section>
  <section class="rgdashboard">	
		<div class="container-fluid">
		 
		</div>
       
	<!-- parallax  -->
	<div id="parallax1" class="parallax text-light text-center marginbot20" data-stellar-background-ratio="0.5" style="background-position: 50% -68.7578px;">	
           <div class="container-fluid">
		   <div class="row">
	   <h3 class="text-center whitefont" style="margin:0px 0px 5px 0px;padding:0px 0px 10px 0px ;border-bottom:solid 1px #fff;">Our Achievements</h3>
<br />	
		   <div class="col-lg-6">
		  
				   		<div class="col-lg-4">
						<div class="counter_item text-center">
							<div class="sigle_counter_item">
								<div class="counter_text pinkbg">
									<a href="#"><p class="underline uppercase">Panchayat Stakeholders Trained</p>
										<span class="counter ng-binding" data-ng-bind="facilitatorAppointCount">0000</span>
									</a> 
								</div>
							</div>
						</div>
					</div>
					<div class="col-lg-4">
						<div class="counter_item text-center">
							<div class="sigle_counter_item">
								<a href="#">
									<div class="counter_text lightcyanbg"><p class="underline uppercase">
											Basic Orientation Trainings to ERs
										</p>
										<span class="counter ng-binding" data-ng-bind="nodalLDCount">0000</span>
									</div>
								</a>
							</div>
						</div>
					</div>
				   <div class="col-lg-4">
						<div class="counter_item text-center">
							<div class="sigle_counter_item">
								<div class="counter_text lightbluebg">
									<a href="#"><p class="underline uppercase">Refresher Trainings to ERs</p>
										<span class="counter ng-binding" data-ng-bind="frontLineWorkerCount">0000</span>
										
									</a>
								</div>
							</div>
						</div>
					</div>
				   <div class="col-lg-4">
						<div class="counter_item text-center">
							<div class="sigle_counter_item">
								<a href="#">
									<div class="counter_text yellowbg">	<p class="underline uppercase">SHG-PRI Convergence<br /><br /></p>
										<span class="counter ng-binding" data-ng-bind="gsScheduleCount">0000</span>
										<!--<img src="/resources/welcome/images/icons/clock.png" title="icon" class="center-block img-responsive">-->
									</div>
								</a>
							</div>
						</div>
					</div>
					<div class="col-lg-4">
						<div class="counter_item text-center">
							<div class="sigle_counter_item">
								
									<div class="counter_text lightredbg"><a href="#">	<p class="underline uppercase">
											Technical support to GPs
										</p>
										<span class="counter ng-binding" data-ng-bind="nodalLDCount">0000</span>
									</a>
									</div>
								
							</div>
						</div>
					</div>
					 <div class="col-lg-4">
						<!--<div class="counter_item text-center">
							<div class="sigle_counter_item">
								<div class="counter_text whitebg">
									<h3 class="basecolor">Our Achievements</h3> 
								</div>
							</div>
						</div>-->
					</div>
				   </div>
				   <div class="col-lg-2">
				   		<div class="counter_item text-center">
							<div class="sigle_counter_item">
								<div class="counter_text cyanbg  long"><p class="underline uppercase">Exposure Visits</p>
									<div class="row"><div class="col-sm-12"><a href="#"><br />
										<span class="counter ng-binding" data-ng-bind="facilitatorAppointCount">0000</span>
										<p>Within State</p>
									</a> </div></div><div class="row">
									<div class="col-sm-12"><a href="#"><br />
										<span class="counter ng-binding" data-ng-bind="facilitatorAppointCount">0000</span>
										<p>Outside State</p>
									</a></div></div>
									
									
								</div>
							</div>
						</div>
				   
				   </div>
				   
				   
				   <div class="col-lg-2">
				   		<div class="counter_item text-center">
							<div class="sigle_counter_item">
								<div class="counter_text bg16 long"><p class="underline uppercase">Support for Panchayat Assets</p>
								<div class="row"><div class="col-lg-12"><a href="#">
										<span class="counter ng-binding" data-ng-bind="frontLineWorkerCount">0000</span>
										<p>Bhawans Constructed</p>
									</a></div></div>
								<div class="row"><div class="col-lg-12"><a href="#">
										<span class="counter ng-binding" data-ng-bind="frontLineWorkerCount">0000</span>
										<p>Bhawans Repaired</p>
									</a></div></div>
								<div class="row"><div class="col-lg-12"><a href="#">
										<span class="counter ng-binding" data-ng-bind="frontLineWorkerCount">0000</span>
										<p>CSCs co-located in Bhawans</p>
									</a></div></div>
									
								</div>
							</div>
						</div>
				   
				   </div>
				   
				   
				   <div class="col-lg-2">
				   		<div class="counter_item text-center">
							<div class="sigle_counter_item">
								<div class="counter_text lightorange long"><p class="underline uppercase"> e- enablement of Panchayats</p>
								<div class="row"><div class="col-lg-12"><a href="#">
										<span class="counter ng-binding" data-ng-bind="frontLineWorkerCount">0000</span>
										<p>e- SPMU</p>
									</a></div></div>
							<div class="row">	<div class="col-lg-12"><a href="#">
										<span class="counter ng-binding" data-ng-bind="frontLineWorkerCount">0000</span>
										<p>e- DPMU</p>
									</a></div></div>
								<div class="row"><div class="col-lg-12"><a href="#">
										<span class="counter ng-binding" data-ng-bind="frontLineWorkerCount">0000</span>
										<p>Computerization</p>
									</a></div></div>
									
								</div>
							</div>
						</div>
				   
				   </div>
				   
		   
		   </div>
		   
				
            </div>
	</div>	 
	
	</section>
	<!--  open below div for Latest Uploaded content -->	
<section class="gallerysec">		
<div class="container-fluid">
<h3 class="text-center" style="margin:0px 0px 10px 0px;padding:0px 0px 10px 0px ;border-bottom:solid 1px #000;">Photo/ Video/ Information Gallery <span class="text-right inlineBlock floatRight">
					<button class="btn btn-warning filter-button" data-filter="all">
						All
					</button>
					<button class="btn btn-info filter-button" data-filter="eventPic" >
						<i class="fa fa-picture-o fa-1x" aria-hidden="true"></i>
						Photos
					</button>
					<button class="btn btn-primary filter-button" data-filter="eventVideos">
						<i class="fa fa-video-camera fa-1x" aria-hidden="true"></i>
						Videos
					</button>
				</span></h3>

<br />
    <div id="myCarouselWrapper" class="container-fluid">
    	 <div id="myCarousel" class="carousel carousel1 slide">
  <div class="carousel-inner" role="listbox">
  
  
  <div class="item item1 active" data-ng-repeat="d in details" ng-init="xx=$index">
      <div class="item-item col-md-2 col-sm-2 filter eventPic" >
      	<a href="#lightboxGallery" >
      	<img src="file/image/{{d.fileId}}" class="img-responsive">
      		
      	</a>
      </div>
     
    </div>
  <%--   
    <div class="item item1 active">
      <div class="item-item col-md-2 col-sm-2 filter eventPic"><a href="#lightboxGallery" data-toggle="modal"><img src="${pageContext.request.contextPath}/resources/index/images/sample_img.jpg" class="img-responsive"></a>
      </div><div class="item-item col-md-2 col-sm-2 filter eventPic"><a href="#lightboxGallery" data-toggle="modal"><img src="${pageContext.request.contextPath}/resources/index/images/sample_img.jpg" class="img-responsive"></a>
      </div><div class="item-item col-md-2 col-sm-2 filter eventPic"><a href="#lightboxGallery" data-toggle="modal"><img src="${pageContext.request.contextPath}/resources/index/images/sample_img.jpg" class="img-responsive"></a>
      </div>
    </div>
    <div class="item item1">
      <div class="item-item col-md-2 col-sm-2 filter eventVideo"><a href="#lightboxGallery" data-toggle="modal"><iframe class="customframeSize" src="https://www.youtube.com/embed/5bEGFEl_WTA" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen="" style="height: 180px;width: 100%;"></iframe></a>
       </div><div class="item-item col-md-2 col-sm-2 filter eventPic"><a href="#lightboxGallery" data-toggle="modal"><img src="${pageContext.request.contextPath}/resources/index/images/sample_img.jpg" class="img-responsive"></a>
      </div><div class="item-item col-md-2 col-sm-2 filter eventPic"><a href="#lightboxGallery" data-toggle="modal"><img src="${pageContext.request.contextPath}/resources/index/images/sample_img.jpg" class="img-responsive"></a>
      </div>
    </div>
    <div class="item item1">
      <div class="item-item col-md-2 col-sm-2 filter eventPic"><a href="#lightboxGallery" data-toggle="modal"><img src="${pageContext.request.contextPath}/resources/index/images/sample_img.jpg" class="img-responsive"></a>
      </div>
    </div>
    <div class="item item1">
      <div class="item-item col-md-2 col-sm-2 filter eventPic"><a href="#lightboxGallery" data-toggle="modal"><img src="${pageContext.request.contextPath}/resources/index/images/sample_img.jpg" class="img-responsive"></a>
      </div>
    </div>
    <div class="item item1">
      <div class="item-item col-md-2 col-sm-2 filter eventVideos"><a href="#lightboxGallery" data-toggle="modal"><iframe class="customframeSize" src="https://www.youtube.com/embed/W3tN3ot6b24" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen="" style="height: 180px;width: 100%;"></iframe></a>
      </div>
    </div>
    <div class="item item1">
      <div class="item-item col-md-2 col-sm-2 filter eventPic"><a href="#lightboxGallery" data-toggle="modal"><img src="${pageContext.request.contextPath}/resources/index/images/sample_img.jpg" class="img-responsive"></a>
      </div>
    </div>
     <div class="item item1">
      <div class="item-item col-md-2 col-sm-2 filter eventPic"><a href="#lightboxGallery" data-toggle="modal"><img src="${pageContext.request.contextPath}/resources/index/images/sample_img.jpg" class="img-responsive"></a>
      </div>
    </div>
     <div class="item item1">
      <div class="item-item col-md-2 col-sm-2 filter eventVideo"><a href="#lightboxGallery" data-toggle="modal"><iframe class="customframeSize" src="https://www.youtube.com/embed/PTe2uWIISmg" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen="" style="height: 180px;width: 100%;"></iframe></a> 
      </div>
    </div>
    
     --%>
    
    
  </div>

  <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
    <span class="sr-only">Next</span>
  </a>
</div>   

</div>
</div>
</section><br />
<%-- <section class="reportssec">
    
		<div class="container-fluid">
   
        
<div class="row">
<h3 class="text-center whitefont" style="margin:0px 0px 5px 0px;padding:0px 0px 10px 0px ;border-bottom:solid 1px #fff;">Reports</h3>
	<div class="col-lg-4 text-center"><div class="report-sec"><img src="${pageContext.request.contextPath}/resources/index/images/analysis.png" class="img-responsive center-block" style="width:100px;height:auto;"><br /><h4>Report 1</h4></div></div>
	<div class="col-lg-4 text-center"><div class="report-sec"><img src="${pageContext.request.contextPath}/resources/index/images/analytics (1).png" class="img-responsive center-block" style="width:100px;height:auto;"><br /><h4>Report 2</h4></div></div>
	<div class="col-lg-4 text-center"><div class="report-sec"><img src="${pageContext.request.contextPath}/resources/index/images/growth.png" class="img-responsive center-block" style="width:100px;height:auto;"><br /><h4>Report 3</h4></div></div>

</div>    
    </div>
            	
	
	</section> --%>
	<section>
	<div class="container-fluid">
	
	</div>
	</section>
	
	<footer> <div class="container-fluid">
	
	
	<div class="row">
						<div class="col-lg-12">
							<h4 class="text-center box-heading">
								<p class="whitefont"><i class="fa fa-download"></i>  Useful Applications / Links</p>
							</h4>
							<hr />
						</div>
					</div>
					
					<div class="row  appRow">
						<div class="col-lg-2 col-md-2 col-sm-6 col-xs-6 text-center appBlock">
							<div class="col-xs-12 paddingRightZero">
								<a href="http://www.planningonline.gov.in/HomeAction.do?method=getLoginForm" target="_blank" title="PLANPLUS [Go to External Link]"> <img title="PLANPLUS [Go to External Link]" alt="PlanPlus" class="img-responsive center-block appImg yellowBorder" src="${pageContext.request.contextPath}/resources/index/images/planplus_square.png">
								</a>
							</div>
						</div>
						<div class="col-lg-2 col-md-2 col-sm-6 col-xs-6 text-center appBlock relativePosition">
							<div class="col-xs-12 paddingRightZero ">
								<a href="http://reportingonline.gov.in/" target="_blank" title="ActionSoft -ReportingOnline.gov.in"> <img title="ActionSoft -ReportingOnline.gov.in [Go to External Link]" alt="ActionSoft -ReportingOnline.gov.in [Go to External Link]" class="img-responsive center-block appImg yellowBorder" src="${pageContext.request.contextPath}/resources/index/images/actionsoft.jpg">
								</a><br> <a href="https://play.google.com/store/apps/details?id=nic.mactionsoft_live" target="_blank"> <img title="Download mActionSoft App - Google Play" alt="Download mActionSoft App - Google Play" class="gplay img-responsive center-block absoluteGPlay" src="${pageContext.request.contextPath}/resources/index/images/google-play.png">
								</a>
							</div>
						</div>
						<div class="col-lg-2 col-md-2 col-sm-6 col-xs-6 text-center appBlock">
							<div class="col-xs-12 paddingRightZero">
								<a href="https://accountingonline.gov.in" target="_blank" title="PRIASoft [Go to External Link]"> <img title="PRIASoft [Go to External Link]" alt="PRIASoft [Go to External Link]" class="img-responsive center-block appImg yellowBorder " src="${pageContext.request.contextPath}/resources/index/images/priasoft.jpg">
								</a>
							</div>
						</div>

						<div class="col-lg-2 col-md-2 col-sm-6 col-xs-6 text-center appBlock relativePosition">
							<div class="col-xs-12 paddingRightZero ">
								<a href="https://play.google.com/store/apps/details?id=nic.in.ppc.gpdp" target="_blank"> <img title="Download GPDP App - Google Play" alt="Download GPDP App - Google Play" class="img-responsive center-block appImg" src="${pageContext.request.contextPath}/resources/index/images/gpdp_app.png">
								</a> <br> <a href="https://play.google.com/store/apps/details?id=nic.in.ppc.gpdp" target="_blank"> <img title="Download GPDP App - Google Play" alt="Download GPDP App - Google Play" class="gplay img-responsive center-block absoluteGPlay" src="${pageContext.request.contextPath}/resources/index/images/google-play.png">
								</a>

							</div>
						</div>
						<div class="col-lg-2 col-md-2 col-sm-6 col-xs-6 text-center appBlock relativePosition">
							<div class="col-xs-12 paddingRightZero">
								<a href="https://missionantyodaya.nic.in/homePage.html" target="_blank"> <img title="MISSION ANTYODAYA [Go to External Link]" alt="MISSION ANTYODAYA [Go to External Link]" class="img-responsive center-block appImg yellowBorder" src="${pageContext.request.contextPath}/resources/index/images/mission-logo.jpg">
								</a> <br> <a href="https://play.google.com/store/apps/details?id=in.nic.mission_antyodaya.gp" target="_blank"> <img title="Download Mission Antyodaya App - Google Play" alt="Download Mission Antyodaya App - Google Play" class="gplay img-responsive center-block absoluteGPlay" src="${pageContext.request.contextPath}/resources/index/images/google-play.png">
								</a>
							</div>

						</div>

						<div class="col-lg-2 col-md-2 col-sm-6 col-xs-6 text-center appBlock">
							<div class="col-xs-12 paddingRightZero">
								<a href="http://www.panchayat.gov.in/" target="_blank" title="Ministry of Panchayati Raj [Go to External Link]"> <img title="Ministry of Panchayati Raj [Go to External Link]" alt="Ministry of Panchayati Raj [Go to External Link]" class="img-responsive center-block appImg yellowBorder" src="${pageContext.request.contextPath}/resources/index/images/mopr.jpg">
								</a>
							</div>
						</div>
						<div class="col-lg-2 col-md-2 col-sm-6 col-xs-6 text-center appBlock">
							<div class="col-xs-12 paddingRightZero">
								<a href="http://rural.nic.in" target="_blank" title="Ministry of Rural Development [Go to External Link]">
									<img title="Ministry of Rural Development [Go to External Link]" alt="Ministry of Rural Development [Go to External Link]" class="img-responsive center-block appImg yellowBorder" src="${pageContext.request.contextPath}/resources/index/images/mord.jpg">
								</a>
							</div>
						</div>




					</div>
					
	<div id="sub-footer">
  							<div class="clearfix"></div>
  							<hr>
  							<div class="row">
                            	<div class="col-lg-12">
                            	
                                  <p class="text-left">Content on this website is updated by field level agencies and managed by the
                                   <a href="http://www.panchayat.gov.in/" target="_blank"> Ministry of Panchayati Raj (MoPR)</a>, 
                                   Government of India<br> Site is technically designed, hosted and maintained by
                                    <a href="http://www.nic.in/" target="_blank">National Informatics Centre (NIC)</a><br />
                                     <span class="font11">Total visitors till now</span> : <span class="count whitefont customCounter font11">${visitorCount }</span></p>
								  
					
				
                                </div>    
                            </div>
							</div>
		
	</div>
	</footer>
</div>
</div>


<a href="#" class="scrollup"><i class="fa fa-angle-up active"></i></a>


 
<!-- Placed at the end of the document so the pages load faster -->
<script  type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/jquery/jquery.min.js"></script>
<script  type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/bootstrap/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/plugins/flexslider/jquery.flexslider-min.js"></script> 
<script src="${pageContext.request.contextPath}/resources/plugins/flexslider/flexslider.config.js"></script>

<script >
$(document).ready(function() {
  $('#media').carousel({
    pause: true,
    interval: false,
  });
});	
</script>
<!--FOR LATEST UPPLOADED SECTION-->
<script>
$('#myCarousel').carousel({
  interval: 4000
});

$('.carousel1 .item1').each(function(){
  var next = $(this).next();
  if (!next.length) {
    next = $(this).siblings(':first');
  }
  next.children(':first-child').clone().appendTo($(this));

  for (var i=0;i<2;i++) {
    next=next.next();
    if (!next.length) {
      next = $(this).siblings(':first');
    }

    next.children(':first-child').clone().appendTo($(this));
  }
});
</script>
<script>
// for language change
function changeLanguage(id){
	alert(id);
	window.location.href="index.html?language="+id;
}
</script>
<script>
$(document).ready(function(){

$("div.bhoechie-tab-menu>div.list-group>a").click(function(e) {
        e.preventDefault();
        $(this).siblings('a.active').removeClass("active");
        $(this).addClass("active");
        var index = $(this).index();
        $("div.bhoechie-tab>div.bhoechie-tab-content").removeClass("active");
        $("div.bhoechie-tab>div.bhoechie-tab-content").eq(index).addClass("active");
    });

////

    $(".filter-button").click(function(){
        var value = $(this).attr('data-filter');
        
        if(value == "all")
        {
            //$('.filter').removeClass('hidden');
            $('.filter').show('1000');
        }
        else
        {
//            $('.filter[filter-item="'+value+'"]').removeClass('hidden');
//            $(".filter").not('.filter[filter-item="'+value+'"]').addClass('hidden');
            $(".filter").not('.'+value).hide('3000');
            $('.filter').filter('.'+value).show('3000');
            
        }
    });
    
    if ($(".filter-button").removeClass("active")) {
$(this).removeClass("active");
}
$(this).addClass("active");

});
</script>
<script>
function allPolicies(id) {
			var a = "Menu";
			var newMenuA = a + "A" + id;
			var newMenuC = a + "C" + id;
			//alert(newMenuA);
			//alert(newMenuC);
			$("[id^='Menu']").removeClass("active");
			$("#" + newMenuA).addClass("active");
			$("#" + newMenuC).addClass("active");

}
</script>
</body>
</html>

<div class="modal fade and carousel slide" id="lightboxGallery">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-body">
          <ol class="carousel-indicators">
            <li data-target="#lightboxGallery" data-slide-to="0" class="active"></li>
            <li data-target="#lightboxGallery" data-slide-to="1"></li>
            <li data-target="#lightboxGallery" data-slide-to="2"></li>
          </ol>
          <div class="carousel-inner" >
          <div data-ng-repeat="d in details"  ng-init="xy=$index">
        
          	<div class="item active" >
              <img src="file/image/{{d.fileId}}" alt="First slide">
            </div>
          
         
          	
          
           </div>
         <%--  <div class="mySlides" data-ng-repeat="d in details">
					<img src="file/image/{{d.fileId}}"
						class="imageSlider img-responsive">
				</div>
          
            <div class="item active">
              <img src="${pageContext.request.contextPath}/resources/index/images/sample_img.jpg" alt="First slide">
            </div>
            <div class="item">
              <img src="${pageContext.request.contextPath}/resources/index/images/sample_img.jpg"alt="Second slide">
            </div>
            <div class="item">
              <img src="${pageContext.request.contextPath}/resources/index/images/sample_img.jpg" alt="Third slide">
              <div class="carousel-caption"><p>even with captions...</p></div>
            </div> --%>
            
            
          </div><!-- /.carousel-inner -->
          <a class="left carousel-control" href="#lightboxGallery" role="button" data-slide="prev">
            <span class="glyphicon glyphicon-chevron-left"></span>
          </a>
          <a class="right carousel-control" href="#lightboxGallery" role="button" data-slide="next">
            <span class="glyphicon glyphicon-chevron-right"></span>
          </a>
        </div><!-- /.modal-body -->
      </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
  </div><!-- /.modal -->
  
  
  <!--all menu content-->
  <div id="contactsUs" class="modal fade" role="dialog">
	<div class="modal-dialog">
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<!-- <button type="button" class="close" data-dismiss="modal">&times;</button> -->
				<h4 class="modal-title">Contact us</h4>
			</div>
			<div class="modal-body">
				<div class="container-fluid">

				<div class="row main-contentBody ">
					<h5 class="text-center">
						If you need any further information or Assistance, Please feel free to contact us
					</h5>
					<div class="text-center">
						<h5>
							<i class="fa fa-envelope fa-1x" aria-hidden="true"></i> <a href="mailto:emailid">EMAILID[at]rgsa[dot]gov[dot]in</a>
						</h5>
						<h5>
							<i class="fa fa-phone-square fa-1x" aria-hidden="true"></i> <span class="englishLang">Helpdesk</span>: 011-00000000, 011-00000000
						</h5>
					</div>
				</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>

	</div>
</div>

<!-- Modal Login -->
        <form:form class="form" role="form" method="post"  action="login.html"  modelAttribute="FACADE_MODEL"   id="loginForm">
		<input type="hidden" name="<csrf:token-name/>" value="<csrf:token-value uri="login.htm"/>" />
        <div class="modal fade" id="login" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
               <button type="button" class="close" data-dismiss="modal">&times;</button>
               <h4 class="modal-title" id="myModalLabel">Login</h4>
              </div>
              
              <div class="modal-body">
                <div class="form-group has-feedback">
                  <label class="control-label">User Id</label>
               <form:input cssStyle="color:black;" path="loginId" id="userName"  value="BIHAR"
								placeholder="Username" 
								autocomplete="off" htmlEscape="true" 
								class="form-control" required="required"/>
                  <span class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true"></span>
                </div>
                
                <div class="form-group has-feedback">
                  <label class="control-label">Password</label>
                  <form:password cssStyle="color:black;" path="password" id="userPassword" value="BIHAR"  placeholder="Password" 
					   autocomplete="off" htmlEscape="true"  class="form-control" required="required"/>
                  <span class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true"></span>
                </div>
                <div class="form-group">
                      <img src="captchaImage" width="200px" id="img_Capatcha" />	
                      <a href="#" onclick="javascript:refreshCaptcha()" class="pull-right">
                      <i class="fa fa-refresh"></i></a>
                </div>
                <div class="form-group has-feedback">
                  <label class="control-label">Captcha Answer</label>
                  <form:input cssStyle="color:black;" id="captchaAnswer" path="captchaAnswer" placeholder="Captcha Answer" value="" class="form-control"  htmlEscape="true" autocomplete="off" required="required"/>
                  <span class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true"></span>
                </div>
                
                <button type="submit" onclick="validateUser(this)" class="btn btn-primary">Login</button>
                <!-- <input type="checkbox" value="rememberme" id="rememberme">Remember me <br/><br/>
                
                <a href="#">Forgot your password?</a> -->
                
              </div>
              
              <div class="modal-footer">              
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
              </div>
              
            </div>
          </div>
        </div><!-- end become a member modal -->
        </form:form> <!-- end login form -->

<script>
(function($, window, document, undefined){
    var pluginName = "marquee",
    defaults = {
       enable : true,  
       direction: 'vertical',  
       itemSelecter : 'li',  
       delay: 3000,  
	   speed: 1,  
       timing: 1, 
       mouse: true 
    };
    function Widget(element, options) {
        this.element = element;
        this.settings = $.extend({}, defaults, options);
        this._defaults = defaults;
        this._name = pluginName;
        this.version = 'v1.0';
        this.$element = $(this.element);
        this.$wrapper = this.$element.parent();
        this.$items = this.$element.children(this.settings.itemSelecter);
        this.next = 0;
        this.timeoutHandle;
        this.intervalHandle
        if(!this.settings.enable)return; 
        this.init();
    }
    Widget.prototype = {
       init:function(){
            var that = this;
            var totalSize = 0;
            $.each(this.$items, function(index, element){
                totalSize += that.isHorizontal() 
                            ? parseInt($(element).outerWidth())
                            : parseInt($(element).outerHeight());
            }); 
            var elmentTotalSize = this.isHorizontal()
               ? this.$element.outerWidth
               : this.$element.outerHeight;
            if(totalSize < elmentTotalSize)return;
            this.$wrapper.css({
                position : 'relative',
                overflow : 'hidden',
				
            });
            this.$element.css({
                 position : 'absolute',
                 top : 0,
                 left: 0
            });
            this.$element.css(this.isHorizontal() ? 'width' : 'height', '1000%');
            this.cloneAllItems();
            if(this.settings.mouse)
            this.addHoverEvent(this);
            this.timer(this);
       },
        timer : function(that){
            this.timeoutHandle = setTimeout(function(){that.play(that)}, this.settings.delay);
        },
        play : function(that){
           this.clearTimeout();
            var target = 0;
            for(var i = 0; i <= this.next; i++){
                 
                 target -= this.isHorizontal()
                    ? parseInt($(this.$items.get(this.next)).outerWidth())
                    : parseInt($(this.$items.get(this.next)).outerHeight());
            }
            this.intervalHandle = setInterval(function(){that.animate(target)},this.settings.timing);
        },
        animate : function(target){
            var mark = this.isHorizontal() ? 'left' : 'top';
            var present =  parseInt(this.$element.css(mark));
            if(present > target)
            {
                if(present - this.settings.speed <= target)
                {
                     this.$element.css(mark, target);
                }else
                     this.$element.css(mark, present - this.settings.speed);
            }else{
                this.clearInterval();

                if(this.next + 1 < this.$items.length){
                     
                     this.next++;
                }else{
                    this.next = 0;
                    this.$element.css(mark,0);
                }
                this.timer(this);
            }
        },
        isHorizontal : function(){

            return this.settings.direction == 'horizontal';
        },
       cloneAllItems: function(){

            this.$element.append(this.$items.clone());
        },
        clearTimeout : function(){
            clearTimeout(this.timeoutHandle);
        },
      clearInterval : function(){
            
            clearInterval(this.intervalHandle);
        },
        addHoverEvent : function(that){
            this.$wrapper
              .mouseenter(function(){
                   that.clearInterval()
                   that.clearTimeout();
              })
              .mouseleave(function(){
                   that.play(that);
              });
        }
    }
    $.fn[pluginName] = function(options) {
        return this.each(function() {
            if (!$.data(this, "plugin_" + pluginName)) {
                $.data(this, "plugin_" + pluginName, new Widget(this, options));
            }
        });
    };
})(jQuery, window, document);

</script>
<script type="text/javascript">
  
  $(function(){


  $('#marquee-vertical').marquee();  
  $('#marquee-horizontal').marquee({direction:'horizontal', delay:0, timing:50});  

});
  
  

</script>

<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/plugins/angular/angular.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/plugins/angular/angular-route.min.js"></script>
		
		<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/js/index/index-controller.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/js/index/index-service.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/js/index/index-model.js"></script>