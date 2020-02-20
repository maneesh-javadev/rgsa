 				<%@ page import="java.net.*" %>
						<%
						InetAddress localhost = InetAddress.getLocalHost(); 
						//System.out.println("System IP Address : " + (localhost.getHostAddress())); 
						 String ipAdd=localhost.getHostAddress().substring(8);
						%>

<section id="featured" class="bg">
	<div class="row">
		<div class="col-lg-12">
			<!-- Slider -->
			<div id="main-slider" class="main-slider flexslider">
				<ul class="slides">
					<li>
						<img src="${pageContext.request.contextPath}/resources/index/images/slides/flexslider/slide1.jpg" alt="" class="img-responsive" />
						<!-- <div class="flex-caption">
                    <h3>Title</h3> 
					<p>Sub-title</p> 
                </div>-->
					</li>
					<li>
						<img src="${pageContext.request.contextPath}/resources/index/images/slides/flexslider/slide2.jpg" alt="" class="img-responsive" />
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
					<li>
						<img src="${pageContext.request.contextPath}/resources/index/images/slides/flexslider/slide5.jpg" alt="" class="img-responsive" />
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
			<div class="col-lg-8">
				<h2 class="text-left box-heading">About RGSA</h2>
				<div class="row">
					<div class="col-lg-12 text-justify">
						<p>The Finance Minister, in his budget speech for 2016-17, announced the launch of new restructured scheme of Rashtriya Gram Swaraj Abhiyan (RGSA), for developing and strengthening the capacities of Panchayati Raj Institutions (PRIs) for rural local governance to become more responsive towards local development needs, preparing the participatory plans that leverage technology, efficient and optimum utilization of available resources for realizing sustainable solutions to local problems linked to Sustainable Development Goals (SDGs). The key principles of SDGs, i.e. leaving no one behind, reaching the farthest first and universal coverage, along with gender equality will be embedded in the design of all capacity building interventions including trainings, training modules and materials.</p>
						<p>In his Budget Speech for 2017-18, the Finance Minister announced to undertake a Mission Antyodaya to bring one crore households out of poverty to make 50,000 Gram Panchayats poverty free. Accordingly, convergent action with Mission Antyodaya has been integrated into this scheme.
						 <% out.println(ipAdd); %>
						</p>
					</div>
				</div>
			</div>
			<div class="col-lg-4 text-left">
				<h3 class="text-left box-heading "><i class="fa fa-bullhorn transformTilt fa-blink"></i> <span >What&rsquo;s new</span></h3>
				
				
				
				<div class="list-wrpaaer">
					<ul class="list-aggregate" >
		         <marquee direction="up" behavior="scroll" scrollamount="2" onmouseover="this.stop();" onmouseout="this.start();">
		               <div data-ng-repeat="dd in docs" > 
		               <li>
		                 <p class="text-justify">
		                   <a href="docs.html?fileId={{dd.docId}}" download>{{dd.docTitle}}</a>        
		                 </p>
		               </li>
		          </div>
               
               </marquee>
               
                
				
			</div></div>
		</div></div>
</section>
<section class="rgdashboard">
	<div class="container-fluid"></div>
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
									<a href="#" >
										<p class="underline ">Panchayat Stakeholders Trained</p>	<span class="counter ng-binding"  id="panchyatStakeholderId">0000</span>
									</a>
								</div>
							</div>
						</div>
					</div>
					<div class="col-lg-4">
						<div class="counter_item text-center">
							<div class="sigle_counter_item">
								<a href="#">
									<div class="counter_text lightcyanbg">
										<p class="underline ">Basic Orientation Training to ERs</p>	<span class="counter ng-binding" id="basicOrientationTrainingofERId">0000</span>
									</div>
								</a>
							</div>
						</div>
					</div>
					<div class="col-lg-4">
						<div class="counter_item text-center">
							<div class="sigle_counter_item">
								<div class="counter_text lightbluebg">
									<a href="#">
										<p class="underline ">Refresher Training to ERs</p>	<span class="counter ng-binding" id="refreshertraningtoERId" >0000</span>
									</a>
								</div>
							</div>
						</div>
					</div>
					<div class="col-lg-4">
						<div class="counter_item text-center">
							<div class="sigle_counter_item">
								<a href="#">
									<div class="counter_text yellowbg">
										<p class="underline ">SHG-PRI Convergence
											<br />
											<br />
										</p>	<span class="counter ng-binding" id="shg_pri_convergenceID"  >0000</span>
										<!--<img src="/resources/welcome/images/icons/clock.png" title="icon" class="center-block img-responsive">-->
									</div>
								</a>
							</div>
						</div>
					</div>
					<div class="col-lg-4">
						<div class="counter_item text-center">
							<div class="sigle_counter_item">
								<div class="counter_text lightredbg">
									<a href="#">
										<p class="underline ">Technical support to GPs</p>	<span class="counter ng-binding" id="technicalsupporttoGPsId">0000</span>
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
						</div>--></div>
				</div>
				<div class="col-lg-2">
					<div class="counter_item text-center">
						<div class="sigle_counter_item">
							<div class="counter_text cyanbg  long">
								<p class="underline ">Exposure Visits</p>
								<div class="row">
									<div class="col-sm-12">
										<a href="#">
											<br />	<span class="counter ng-binding" id="withinStateId">0000</span>
											<p>Within State</p>
										</a>
									</div>
								</div>
								<div class="row">
									<div class="col-sm-12">
										<a href="#">
											<br />	<span class="counter ng-binding" id="OutsideStateId" >0000</span>
											<p>Outside State</p>
										</a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-lg-2">
					<div class="counter_item text-center">
						<div class="sigle_counter_item">
							<div class="counter_text bg16 long">
								<p class="underline ">Support for Panchayat Assets</p>
								<div class="row">
									<div class="col-lg-12">
										<a href="#">	<span class="counter ng-binding" id="bhawansConstructedId" >0000</span>
											<p>Bhawans Constructed</p>
										</a>
									</div>
								</div>
								<div class="row">
									<div class="col-lg-12">
										<a href="#">	<span class="counter ng-binding" id="bhawansRepairedId" >0000</span>
											<p>Bhawans Repaired</p>
										</a>
									</div>
								</div>
								<div class="row">
									<div class="col-lg-12">
										<a href="#">	<span class="counter ng-binding" id="CSCsId">0000</span>
											<p>CSCs co-located in Bhawans</p>
										</a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-lg-2">
					<div class="counter_item text-center">
						<div class="sigle_counter_item">
							<div class="counter_text lightorange long">
								<p class="underline ">e- enablement of Panchayats</p>
								<div class="row">
									<div class="col-lg-12">
										<a  onclick="onloadKPI('eSPMUId');" >	<span class="counter ng-binding" data-ng-value="0000" id="eSPMUId">0000</span>
											<p>e- SPMU</p>
										</a>
									</div>
								</div>
								<div class="row">
									<div class="col-lg-12">
										<a href="#">	<span class="counter ng-binding" id="eDPMUId">0000</span>
											<p>e- DPMU</p>
										</a>
									</div>
								</div>
								<div class="row">
									<div class="col-lg-12">
										<a href="kpiHeaderPage.html?<csrf:token uri='kpiHeaderPage.html'/>">	<span class="counter ng-binding" id="eComputerizationId" >0000</span>
											<p>Computerization</p>
										</a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
   
  <!-- Modal -->
  <div class="modal fade" id="eSPMU" role="dialog">
   
  </div>
  
  
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
				<a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev"> <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
					<span class="sr-only">Previous</span>
				</a>
				<a class="right carousel-control" href="#myCarousel" role="button" data-slide="next"> <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
					<span class="sr-only">Next</span>
				</a>
			</div>
		</div>
	</div>
</section>
<br />
<%-- <section class="reportssec">
	<div class="container-fluid">
		<div class="row">
			<h3 class="text-center whitefont" style="margin:0px 0px 5px 0px;padding:0px 0px 10px 0px ;border-bottom:solid 1px #fff;">Reports</h3>
			<div class="col-lg-4 text-center">
				<div class="report-sec">
					<img src="${pageContext.request.contextPath}/resources/index/images/analysis.png" class="img-responsive center-block" style="width:100px;height:auto;">
					<br />
					<h4>Report 1</h4>
				</div>
			</div>
			<div class="col-lg-4 text-center">
				<div class="report-sec">
					<img src="${pageContext.request.contextPath}/resources/index/images/analytics (1).png" class="img-responsive center-block" style="width:100px;height:auto;">
					<br />
					<h4>Report 2</h4>
				</div>
			</div>
			<div class="col-lg-4 text-center">
				<div class="report-sec">
					<img src="${pageContext.request.contextPath}/resources/index/images/growth.png" class="img-responsive center-block" style="width:100px;height:auto;">
					<br />
					<h4>Report 3</h4>
				</div>
			</div>
		</div>
	</div>
	</section>--%>
	<section>
		<div class="container-fluid"></div>
	</section>
	
	
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
		<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/js/utils/captcha.js"></script>
		
		<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/js/kpi/kpiCommon.js"></script>
	

		<script>
		setTimeout(function(){ voteViaAjax(0); }, 100);
		function voteViaAjax(detailId){ 
		   $.ajax({
		   type : "POST",
		   contentType : "application/json",
		   url : "basicOrientationTrainingofER.html?<csrf:token uri='basicOrientationTrainingofER.html'/>&detailId="+detailId,
		   dataType : 'json',
		   cache : false,
		   timeout : 100000,
		   success : function(data) {
			$("#basicOrientationTrainingofERId").html(data[0]);
			$("#refreshertraningtoERId").html(data[1]);
			$("#shg_pri_convergenceID").html(data[2]);
			$("#eSPMUId").html(data[3]);
			$("#eDPMUId").html(data[4]);
			$("#eComputerizationId").html(data[5]);
			$("#bhawansConstructedId").html(data[6]);
			$("#bhawansRepairedId").html(data[7]);
			$("#CSCsId").html(data[8]);
			$("#withinStateId").html(data[9]);
			$("#OutsideStateId").html(data[10]);
			$("#panchyatStakeholderId").html(data[11]);
			$("#technicalsupporttoGPsId").html(data[12]);
		   },
		   error : function(e) {
		    console.log(e);
		   }
		  });
		}
		
		
		function onloadKPI(kpiName){			
			 $.ajax({
				   type : "GET",
				   contentType : "application/json",
				   url : "kpiRajeevPage.html?<csrf:token uri='kpiRajeevPage.html'/>&kpiName="+kpiName,
				   dataType : 'json',
				   cache : false,
				   timeout : 100000,
				   success : function(data) {
					   $.each( data, function(key,valueList){
							  // console.log("key = " + key + " valueList = " + valueList);
								if(key=='eSPMU'){
									  var tableBody='';
									  var total=0;
									   tableBody+= '<thead style="background-color: #eeb2b2">';
									   tableBody+= '<td><b>S.No.<b></td>';
									   tableBody+= '<td><b> Activity Name </b></td>';
									   tableBody+= '<td><b>No. Of Unit Proposed</b></td>';
									   tableBody+= '<td><b>Fund Proposed </b></td>';
									   tableBody+= '<td><b>No. of Days Completed </b></td>';
									   tableBody+= '<td><b>No. of Units Completed </b></td>';
									   tableBody+= '<td><b>Expenditure Incurred </b></td>';
									   tableBody+= '</thead>';
									
										   $("#eSPMU").html(tableBody);
									  }
					   })
				   },
				   error : function(e) {
				    console.log(e);
				   }
				 
			 });
			 }
		</script>
