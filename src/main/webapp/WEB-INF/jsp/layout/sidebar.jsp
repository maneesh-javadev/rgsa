<%@include file="../taglib/taglib.jsp"%>
<%@ taglib uri="http://esapi/tags-html" prefix="esapi"%>
<section>
       <!-- Left Sidebar -->
       <aside id="leftsidebar" class="sidebar">
           <!-- User Info -->
           <div class="user-info">
               <div class="image">
                   <img src="resources/images/user.png" width="48" height="48" alt="User" />
               </div>
               <div class="info-container">
                   <div class="name" data-toggle="dropdown" 
                   		aria-haspopup="true" aria-expanded="false">Name : ${sessionScope['scopedTarget.userPreference'].userName}
                   	</div>
                    <div class="name" data-toggle="dropdown" aria-haspopup="true" 
                    		aria-expanded="false">Financial Year : 
                    		<esapi:encodeForHTMLAttribute>${sessionScope['scopedTarget.userPreference'].finYear}</esapi:encodeForHTMLAttribute>&nbsp;
                    		<i class="fa fa-pencil-square-o" aria-hidden="true" data-toggle="modal" data-target="#aashish"></i>
				</div>
               </div>
           </div>
           <!-- #User Info -->
           <!-- Menu -->
           <div class="menu">
               <ul class="list">
                   <!-- <li class="header">Menu</li> -->
                   <li class="active">
                       <a href="home.html">
                           <i class="fa fa-home"></i> Home
                       </a>
                   </li>
                   <c:forEach items="${sessionScope['scopedTarget.userPreference'].menus}" var="itm">
						
						<c:choose>
						  <c:when test="${itm.parent eq 0 and !empty itm.formName}">
						  	<li>
		                       <a href="${itm.formName}?menuId=${itm.menuId}&<csrf:token uri='${itm.formName}'/>">
		                           <i class="fa ${itm.icon} "></i>   ${itm.resourceId}
		                       </a>
				            </li>
						  </c:when>
						  <c:otherwise>
						  	<c:choose>
						  	  <c:when test="${itm.parent eq 0}">
						  	  	<li >
								  <a href="javascript:void(0);" class="menu-toggle">
								     <i class="fa ${itm.icon}"></i>   ${itm.resourceId}
								  </a>
								  <ul class="ml-menu">
								  	<c:forEach items="${sessionScope['scopedTarget.userPreference'].menus}" var="itm2" varStatus="status"> 
						       			<c:if test="${itm.menuId eq itm2.parent}">
					               			<li>
					               			<a href="${itm2.formName}?menuId=${itm2.menuId}&<csrf:token uri='${itm2.formName}'/>">
					               				 <i class="fa ${itm2.icon}"></i>  ${itm2.resourceId}
					               			</a>
					               			</li>
						           		</c:if> 
					           		</c:forEach> 
						 		  </ul>
								</li>
						  	   </c:when>
						  	</c:choose> 
						  </c:otherwise>							
						
						</c:choose>
						
						<%-- <li >
						  <a href="javascript:void(0);" class="menu-toggle">
						    <i class="fa fa-table" aria-hidden="true"> ${itm.resourceId}</i>
						  </a>
						  <ul class="ml-menu">
						  	<c:forEach items="${sessionScope['scopedTarget.userPreference'].menus}" var="itm2" varStatus="status"> 
				       			<c:if test="${itm.groupId eq itm2.groupId and itm2.formName  ne null }">
			               			<li>
			               			<a href="${itm2.formName}?<csrf:token uri='${itm2.formName}'/>">${itm2.resourceId}</a>
			               			</li>
				           		</c:if> 
			           		</c:forEach> 
				 		  </ul>
						</li> --%>
				</c:forEach>
               </ul>
           </div>
           <!-- #Menu -->
           <!-- Footer -->
           <div class="legal">
               <div class="copyright">
                   &copy; 2018 <a href="javascript:void(0);">NIC</a>.
               </div>
              <!--  <div class="version">
                   <b>Version: </b> 1.0.4
               </div> -->
           </div>
           <!-- #Footer -->
       </aside>
       <!-- #END# Left Sidebar -->
       <!-- Right Sidebar -->
       <aside id="rightsidebar" class="right-sidebar">
           <ul class="nav nav-tabs tab-nav-right" role="tablist">
               <li role="presentation" class="active"><a href="#skins" data-toggle="tab">SKINS</a></li>
           </ul>
           <div class="tab-content">
               <div role="tabpanel" class="tab-pane fade in active in active" id="skins">
                   <ul class="demo-choose-skin">
                       <li data-theme="red" class="active">
                           <div class="red"></div>
                           <span>Red</span>
                       </li>
                       <li data-theme="pink">
                           <div class="pink"></div>
                           <span>Pink</span>
                       </li>
                       <li data-theme="purple">
                           <div class="purple"></div>
                           <span>Purple</span>
                       </li>
                       <li data-theme="deep-purple">
                           <div class="deep-purple"></div>
                           <span>Deep Purple</span>
                       </li>
                       <li data-theme="indigo">
                           <div class="indigo"></div>
                           <span>Indigo</span>
                       </li>
                       <li data-theme="blue">
                           <div class="blue"></div>
                           <span>Blue</span>
                       </li>
                       <li data-theme="light-blue">
                           <div class="light-blue"></div>
                           <span>Light Blue</span>
                       </li>
                       <li data-theme="cyan">
                           <div class="cyan"></div>
                           <span>Cyan</span>
                       </li>
                       <li data-theme="teal">
                           <div class="teal"></div>
                           <span>Teal</span>
                       </li>
                       <li data-theme="green">
                           <div class="green"></div>
                           <span>Green</span>
                       </li>
                       <li data-theme="light-green">
                           <div class="light-green"></div>
                           <span>Light Green</span>
                       </li>
                       <li data-theme="lime">
                           <div class="lime"></div>
                           <span>Lime</span>
                       </li>
                       <li data-theme="yellow">
                           <div class="yellow"></div>
                           <span>Yellow</span>
                       </li>
                       <li data-theme="amber">
                           <div class="amber"></div>
                           <span>Amber</span>
                       </li>
                       <li data-theme="orange">
                           <div class="orange"></div>
                           <span>Orange</span>
                       </li>
                       <li data-theme="deep-orange">
                           <div class="deep-orange"></div>
                           <span>Deep Orange</span>
                       </li>
                       <li data-theme="brown">
                           <div class="brown"></div>
                           <span>Brown</span>
                       </li>
                       <li data-theme="grey">
                           <div class="grey"></div>
                           <span>Grey</span>
                       </li>
                       <li data-theme="blue-grey">
                           <div class="blue-grey"></div>
                           <span>Blue Grey</span>
                       </li>
                       <li data-theme="black">
                           <div class="black"></div>
                           <span>Black</span>
                       </li>
                   </ul>
               </div>
           </div>
       </aside>
       <!-- #END# Right Sidebar -->
       <div class="body">
		<div class="modal fade" id="aashish" tabindex="-1"
			role="dialog" aria-labelledby="exampleModalCenterTitle"
			aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<div align="center"><h5 class="modal-title" id="exampleModalCenterTitle">Select Financial Year</h5></div>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div class="row clearfix">
							<div class="form-group">
								<div class="col-lg-4">
									&nbsp;&nbsp;<label for="FinYear"><strong>Financial Year :</strong></label>
								</div>
								<div align="center" class="col-lg-4">
									<select class="form-control" id="finYearDropDownId">
										<option value="0">Select quarter</option>
										<c:forEach items="${sessionScope['scopedTarget.userPreference'].finYearList}" var="finYearList">
											<option value="${finYearList.yearId}">${finYearList.finYear}</option>										
										</c:forEach>
										<!-- <option value="1">2018-19</option>
										<option value="2">2019-20</option> -->
									</select>
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer">
					<form:form id="formId" name="changeFinYearForm">
					<div class="text-right">
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">Close</button>
						<button type="button" class="btn btn-primary" onclick="changeFinYear()">Save
							changes</button></div>
							</form:form>
					</div>
				</div>
			</div>
		</div>
		<input type="hidden" id="finYearId" value="" />
	</div>
</section>
<script>
/* function setVal(){
	var finYearId=$('#finYearDropDownId').val()
	$('#finYearId').val(finYearId);
	$('#achorId').action("","demoUrl.html?<csrf:token uri='demoUrl.html'/>&finYearId="+finYearId);
} */

function changeFinYear(){
	var finYearId=$('#finYearDropDownId').val();
	document.changeFinYearForm.method = "post";
	document.changeFinYearForm.action = "demoUrl.html?<csrf:token uri='demoUrl.html'/>&finYearId="+finYearId;
	document.changeFinYearForm.submit();
}
</script>
