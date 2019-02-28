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
                    		<esapi:encodeForHTMLAttribute>${sessionScope['scopedTarget.userPreference'].finYear}</esapi:encodeForHTMLAttribute>
                    		
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
   </section>