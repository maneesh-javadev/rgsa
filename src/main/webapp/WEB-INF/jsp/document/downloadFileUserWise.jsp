<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
   <%@include file="../taglib/taglib.jsp"%>
   <script  type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/jquery/jquery.min.js"></script>
       <section class="content downloadPage">
           <div class="container-fluid">
               <div class="row clearfix">
                   <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                       <div class="card">
                          <!--  <div class="header">
                               <h2>DOWNLOAD FILES</h2>
                           </div> -->
                           <form:form action="downloadNew.html" method="post" modelAttribute="Cms_model" id="form" autocomplete="off">
                           <div class="body table-responsive customTabs">
	                        	<ul class="nav nav-tabs tab-nav-right" role="tablist" >	                           
	                                 <li role="presentation" class="active tabData0">
	                                	<a href="#tabData0" data-toggle="tab">				                               			
	                               			All Documents
	                                	</a>
	                               	</li>                                          
	                                <li role="presentation" class="tabData1">
	                                	<a href="#tabData1" data-toggle="tab">
	                                		State Wise Documents
	                                	</a>
	                               	</li>                                                                      
	                            </ul>
	                            <div class="tab-content">                              
	                            <div role="tabpanel" class="tab-pane fade" id="tabData0">
	                            <br/>
								<div class="row">
	                        		<div class="col-lg-12">
	                        			 <div class="col-lg-6"> 
	                                        <c:if test="${circularCount ne  0}">                                            
	                         				<div class="col-lg-12">
	                         					<div class="panel panel-success">
	                         						<div class="panel-heading headerColor"><h6 class="panel-title" ><span class="englishLang">Circulars/Letters to States</span></h6></div>
		 												<div class="panel-body">
	 	 												<c:if test="${!empty DOCUMENT_LIST_CENTER}">
	 	 													<div class="table-responsive">
	 	 														<table class="table-bordered table-condensed">
						                                           		 <tr>
	                                                                          <th width="1%"> <span class="englishLang">S.No.</span></th>                                                                               
	                                                                          <th width="20%" align="center"> <span class="englishLang">Title</span></th>
	                                                                          <th width="3%"> <span class="englishLang">Details</span></th>
	                                                                        </tr>	
	 	 															 		<c:set var="index" value="0" scope="page" />  
	                                                                          <c:set var="statec" value="0" scope="page" />  
	                                                                           <c:set var="statecount" value="0" scope="page" />  
	                                                                        <c:forEach items="${DOCUMENT_LIST_CENTER}" var="docineer">
	                                                                           <c:if test="${docineer.typeId eq 2 and docineer.stateCode eq 0 }">
	                                                                           	<c:set var="index" value="${index + 1}" scope="page" />
	                                                                            <tr id="showId">
	                                                                                <td width="1%" class="text-center">${index}.</td>                                                                                      
	                                                                                <td width="20%">${docineer.fileTitle}
	                                                                                <c:choose>
                                                                                   		<c:when test="${docineer.isNew eq true }">
                                                                                   			<img src="${pageContext.request.contextPath}/resources/images/new_red.gif" alt="New">
                                                                                   		</c:when>
                                                                                    </c:choose></td>
	                                                                                <td width="3%" class="text-nowrap">
	                                                                                    <a href="downloadFile.html?fileName=${docineer.fileName}&<csrf:token uri='downloadFile.html'/>"><span class="englishLang">Download</span></a>
	                                                                                    <i class="fa fa-file-pdf-o" aria-hidden="true"></i></a>
	                                                                                </td>
	                                                                            </tr>
	                                                                           </c:if>
	                                                                           </c:forEach>
	                                                                        <c:forEach items="${DOCUMENT_LIST_CENTER}" var="docList" varStatus="countdoc">
	                                                                            <c:if test="${docList.typeId eq 2}">
	                                                                              <%--  <c:set var="index" value="${index + 1}" scope="page" />  --%>
	                                                                           <c:choose>
							                                           		<c:when test="${docList.stateCode eq 0}">
								                                           </c:when>
								                                           <c:otherwise>											                                          
								                                           <div id="lessDiv" >
								                                             <c:if test="${statec ne docList.stateName}">											                                           
								                                           		<tr style="background-color:#e2f6e2;"><td width="1%" >
								                                           			<div class="text-center expandDiv" class="viewall" id="expandDiv${docList.stateCode}${docList.typeId}">
						                                                                  <a title="Click here to View" alt="Click here to View" onclick="expandDiv(${docList.stateCode}${docList.typeId})" id="stateExpandDiv${docList.stateCode}${docList.typeId}">
						                                                                  	<i class="fa fa-plus" aria-hidden="true"></i>
																						  </a>
						                                                             </div>
						                                                             <div class="text-center collapseDiv"  class="showless" id="collapseDiv${docList.stateCode}${docList.typeId}" style="display:none;">
						                                                                <a title="Click here to View"  alt="Click here to View" onclick="collapseDiv(${docList.stateCode}${docList.typeId})" id="stateCollapseDiv${docList.stateCode}${docList.typeId}">
						                                                                	<i class="fa fa-minus" aria-hidden="true"></i>																								
																						</a>
						                                                            </div>
								                                           		</td>
								                                           		<td colspan="2">
								                                           		<a class="customTabLink" title="Click here to View"  alt="Click here to View" >
						                                                                	<b>${docList.stateName}</b>																							
																						</a>
								                                           		
								                                           		
								                                           		</td></tr>																						
								                                           </c:if>
								                                           </div>
																		      <c:set var="statecount" value="${statecount + 1}" scope="page" />                                     
								                                             <tr class="stateDiv${docList.stateCode}${docList.typeId}" style="display:none;">
	                                                                                     <td width="1%"class="text-center">${statecount}.</td>                                                                                      
	                                                                                     <td width="20%">${docList.fileTitle}
	                                                                                     <%-- <c:choose>
                                                                                   		 <c:when test="${docList.isNew eq true }">
                                                                                   			<img src="${pageContext.request.contextPath}/resources/images/new_red.gif" alt="New">
                                                                                   		</c:when> 
                                                                                    </c:choose> --%></td>
	                                                                                     <td width="3%" class="text-nowrap">
	                                                                                         <a href="downloadFile.html?fileName=${docList.fileName}&<csrf:token uri='downloadFile.html'/>"><span class="englishLang">Download</span></a>
	                                                                                         <i class="fa fa-file-pdf-o" aria-hidden="true"></i></a>
	                                                                                     </td>
	                                                                                      <c:set var="statec" value="${docList.stateName}" scope="page" />
	                                                                                 </tr> 
	                                                                                                                                                       
								                                           </c:otherwise>
								                                       </c:choose>											                                                                                                           
	                                                                            </c:if>
	                                                                        </c:forEach>	   	 															
	 	 														</table>
	 	 													</div>
	 	 												</c:if>
		 												</div>
	                         					</div>	
	                         				</div>                    
	                                   		</c:if>
	                                      		<c:if test="${presentationCount ne  0}">   
	                           				<div class="col-lg-12">
	                           					<div class="panel panel-success">
	                           						<div class="panel-heading headerColor"><h6 class="panel-title" ><span class="englishLang">Presentations of MoPR/States</span></h6></div>
	  	 												<div class="panel-body">
	   	 												<c:if test="${!empty DOCUMENT_LIST_CENTER}">
	   	 													<div class="table-responsive">
	   	 														<table class="table-bordered table-condensed">
							                                           		 <tr>
	                                                                               <th width="1%"> <span class="englishLang">S.No.</span></th>                                                                               
	                                                                               <th width="20%" align="center"> <span class="englishLang">Title</span></th>
	                                                                               <th width="3%"> <span class="englishLang">Details</span></th>
	                                                                           </tr>	
	   	 															 		<c:set var="index" value="0" scope="page" />  
	                                                                            <c:set var="statec" value="0" scope="page" /> 
	                                                                            <c:set var="statecount" value="0" scope="page" />
	                                                                           <c:forEach items="${DOCUMENT_LIST_CENTER}" var="centerPre" >
	                                                                           	<c:if test="${centerPre.typeId eq 1 and centerPre.stateCode eq 0}">
	                                                                           		<c:set var="index" value="${index + 1}" scope="page" />
	                                                                           		<tr id="showId">
	                                                                                      <td width="1%" class="text-center">${index}.</td>                                                                                      
	                                                                                      <td width="20%">${centerPre.fileTitle}
	                                                                                      <c:choose>
	                                                                                   		<c:when test="${centerPre.isNew eq true }">
	                                                                                   			<img src="${pageContext.request.contextPath}/resources/images/new_red.gif" alt="New">
	                                                                                   		</c:when>
	                                                                                    </c:choose></td>
	                                                                                      <td width="3%" class="text-nowrap">
	                                                                                          <a href="downloadFile.html?fileName=${centerPre.fileName}&<csrf:token uri='downloadFile.html'/>"><span class="englishLang">Download</span></a>
	                                                                                          <i class="fa fa-file-pdf-o" aria-hidden="true"></i></a>
	                                                                                      </td>
	                                                                                  </tr>
	                                                                           	</c:if>
	                                                                           </c:forEach>
	                                                                          <c:forEach items="${DOCUMENT_LIST_CENTER}" var="docList" varStatus="countdoc">
	                                                                              <c:if test="${docList.typeId eq 1}">
	                                                                                  <%-- <c:set var="index" value="${index + 1}" scope="page" /> --%>
	                                                                                  <c:choose>
										                                           		<c:when test="${docList.stateCode eq 0}">										                                           										                                           		                                                                                                                                                         
											                                           </c:when>
											                                           <c:otherwise>											                                          
											                                           <div id="lessDiv" >
											                                             <c:if test="${statec ne docList.stateName}">											                                           
											                                           		<tr><td width="1%" >
											                                           			<div class="text-center expandDiv" class="viewall" id="expandDiv${docList.stateCode}${docList.typeId}">
									                                                                  <a onclick="expandDiv(${docList.stateCode}${docList.typeId})" id="stateExpandDiv${docList.stateCode}${docList.typeId}">
									                                                                  	<i class="fa fa-plus" aria-hidden="true"></i>
																									  </a>
									                                                             </div>
									                                                             <div class="text-center collapseDiv"  class="showless" id="collapseDiv${docList.stateCode}${docList.typeId}" style="display:none;">
									                                                                <a onclick="collapseDiv(${docList.stateCode}${docList.typeId})" id="stateCollapseDiv${docList.stateCode}${docList.typeId}">
									                                                                	<i class="fa fa-minus" aria-hidden="true"></i>																								
																									</a>
									                                                            </div>
											                                           		</td>
											                                           		<td colspan="2"><b>${docList.stateName}</b></td></tr>																						
											                                           </c:if>
											                                          
											                                           </div>
																					       <c:set var="statecount" value="${statecount + 1}" scope="page" />                                           
											                                             <tr class="stateDiv${docList.stateCode}${docList.typeId}" style="display:none;">
	                                                                                        <td width="1%"class="text-center">${statecount}.</td>                                                                                      
	                                                                                        <td width="20%">${docList.fileTitle}
																							<%-- <c:choose>
		                                                                                   		 <c:when test="${docList.isNew eq true }">
		                                                                                   			<img src="${pageContext.request.contextPath}/resources/images/new_red.gif" alt="New">
		                                                                                   		</c:when>
		                                                                                    </c:choose> --%></td>
	                                                                                        <td width="3%" class="text-nowrap">
	                                                                                            <a href="downloadFile.html?fileName=${docList.fileName}&<csrf:token uri='downloadFile.html'/>"><span class="englishLang">Download</span></a>
	                                                                                            <i class="fa fa-file-pdf-o" aria-hidden="true"></i></a>
	                                                                                        </td>
	                                                                                         <c:set var="statec" value="${docList.stateName}" scope="page" />
	                                                                                    </tr>
	                                                                                                                                                                      
											                                           </c:otherwise>
											                                       </c:choose>                                                                     
	                                                                              </c:if>
	                                                                          </c:forEach>	   	 															
	   	 														</table>
	   	 													</div>
	   	 												</c:if>
	  	 												</div>
	                           					</div>
	                           				</div>
	                           				</c:if>
	                           				<c:if test="${campSche ne 0 }">
	                           				<div class="col-lg-12">
	                           					<div class="panel panel-success">
	                           						<div class="panel-heading headerColor"><h6 class="panel-title" ><span class="englishLang">RGSA Frame work</span></h6></div>
	  	 												<div class="panel-body">
	   	 												<c:if test="${!empty DOCUMENT_LIST_CENTER}">
	   	 													<div class="table-responsive">
	   	 														<table class="table-bordered table-condensed">
	   	 															 		<c:set var="index" value="0" scope="page" />  
	                                                                            <c:set var="statec" value="0" scope="page" /> 
	                                                                             <c:set var="statecount" value="0" scope="page" />                                           
	                                                                          <c:forEach items="${DOCUMENT_LIST_CENTER}" var="docList" varStatus="countdoc">
	                                                                              <c:if test="${docList.typeId eq 5}">
	                                                                                  <c:set var="index" value="${index + 1}" scope="page" />
	                                                                                  <c:if test="${index eq 1}">
										                                           		 <tr>
			                                                                                <th width="1%"> <span class="englishLang">S.No.</span></th>                                                                               
			                                                                                <th width="20%" align="center"> <span class="englishLang">Title</span></th>
			                                                                                <th width="3%"> <span class="englishLang">Details</span></th>
			                                                                            </tr>	
		                                                                            </c:if>
	                                                                                  <c:choose>
										                                           		<c:when test="${docList.stateCode eq 0}">										                                           										                                           		                                                                                                                                                         
		                                                                                    <tr id="showId">
		                                                                                        <td width="1%" class="text-center">${index}.</td>                                                                                      
		                                                                                        <td width="20%">${docList.fileTitle}
																								<%-- <c:choose>
			                                                                                   		<c:when test="${docList.isNew eq true }">
			                                                                                   			<img src="${pageContext.request.contextPath}/resources/images/new_red.gif" alt="New">
			                                                                                   		</c:when>
			                                                                                    </c:choose> --%></td>
		                                                                                        <td width="3%" class="text-nowrap">
		                                                                                            <a href="downloadFile.html?fileName=${docList.fileName}&<csrf:token uri='downloadFile.html'/>"><span class="englishLang">Download</span></a>
		                                                                                            <i class="fa fa-file-pdf-o" aria-hidden="true"></i></a>
		                                                                                        </td>
		                                                                                    </tr>
											                                           </c:when>
											                                           <c:otherwise>											                                          
											                                           <div id="lessDiv" >
											                                             <c:if test="${statec ne docList.stateName}">											                                           
											                                           		<tr><td width="1%" >
											                                           			<div class="text-center expandDiv" class="viewall" id="expandDiv${docList.stateCode}${docList.typeId}">
									                                                                  <a onclick="expandDiv(${docList.stateCode}${docList.typeId})" id="stateExpandDiv${docList.stateCode}${docList.typeId}">
									                                                                  	<i class="fa fa-plus" aria-hidden="true"></i>
																									  </a>
									                                                             </div>
									                                                             <div class="text-center collapseDiv"  class="showless" id="collapseDiv${docList.stateCode}${docList.typeId}" style="display:none;">
									                                                                <a onclick="collapseDiv(${docList.stateCode}${docList.typeId})" id="stateCollapseDiv${docList.stateCode}${docList.typeId}">
									                                                                	<i class="fa fa-minus" aria-hidden="true"></i>																								
																									</a>
									                                                            </div>
											                                           		</td>
											                                           		<td colspan="2"><b>${docList.stateName}</b></td></tr>																						
											                                           </c:if>
											                                          
											                                           </div>
																					     <c:set var="statecount" value="${statecount + 1}" scope="page" />                         
											                                             <tr class="stateDiv${docList.stateCode}${docList.typeId}" style="display:none;">
	                                                                                        <td width="1%"class="text-center">${statecount}.</td>                                                                                      
	                                                                                        <td width="20%">${docList.fileTitle}
																							<%-- <c:choose>
			                                                                                   		<c:when test="${docList.isNew eq true }">
			                                                                                   			<img src="${pageContext.request.contextPath}/resources/images/new_red.gif" alt="New">
			                                                                                   		</c:when>
			                                                                                 </c:choose> --%></td>
	                                                                                        <td width="3%" class="text-nowrap">
	                                                                                            <a href="downloadFile.html?fileName=${docList.fileName}&<csrf:token uri='downloadFile.html'/>"><span class="englishLang">Download</span></a>
	                                                                                            <i class="fa fa-file-pdf-o" aria-hidden="true"></i></a>
	                                                                                        </td>
	                                                                                         <c:set var="statec" value="${docList.stateName}" scope="page" />
	                                                                                    </tr>
	                                                                                                                                                                      
											                                           </c:otherwise>
											                                       </c:choose>                                                                     
	                                                                              </c:if>
	                                                                          </c:forEach>	   	 															
	   	 														</table>
	   	 													</div>
	   	 												</c:if>
	  	 												</div>
	                           					</div>
	                           				</div>
	                           				</c:if>
	                           				<c:if test="${goCount ne 0 }">                           				                           
	                         				<div class="col-lg-12">
	                         					<div class="panel panel-success">
	                         						<div class="panel-heading headerColor"><h6 class="panel-title" ><span class="englishLang">Other material for CB</span></h6></div>
		 												<div class="panel-body">
	 	 												<c:if test="${!empty DOCUMENT_LIST_CENTER}">
	 	 													<div class="table-responsive">
	 	 														<table class="table-bordered table-condensed">
						                                           		 <tr>
	                                                                          <th width="1%"> <span class="englishLang">S.No.</span></th>                                                                               
	                                                                          <th width="20%" align="center"> <span class="englishLang">Title</span></th>
	                                                                          <th width="3%"> <span class="englishLang">Details</span></th>
	                                                                        </tr>	
	 	 															 		<c:set var="index" value="0" scope="page" />  
	                                                                          <c:set var="statec" value="0" scope="page" />  
	                                                                           <c:set var="statecount" value="0" scope="page" />  
	                                                                        <c:forEach items="${DOCUMENT_LIST_CENTER}" var="docineer">
	                                                                           <c:if test="${docineer.typeId eq 3 and docineer.stateCode eq 0 }">
	                                                                           	<c:set var="index" value="${index + 1}" scope="page" />
	                                                                            <tr id="showId">
	                                                                                <td width="1%" class="text-center">${index}.</td>                                                                                      
	                                                                                <td width="20%">${docineer.fileTitle}
	                                                                                <c:choose>
                                                                                   		<c:when test="${docineer.isNew eq true }">
                                                                                   			<img src="${pageContext.request.contextPath}/resources/images/new_red.gif" alt="New">
                                                                                   		</c:when>
                                                                                    </c:choose></td>
	                                                                                <td width="3%" class="text-nowrap">
	                                                                                    <a href="downloadFile.html?fileName=${docineer.fileName}&<csrf:token uri='downloadFile.html'/>"><span class="englishLang">Download</span></a>
	                                                                                    <i class="fa fa-file-pdf-o" aria-hidden="true"></i></a>
	                                                                                </td>
	                                                                            </tr>
	                                                                           </c:if>
	                                                                           </c:forEach>
	                                                                        <c:forEach items="${DOCUMENT_LIST_CENTER}" var="docList" varStatus="countdoc">
	                                                                            <c:if test="${docList.typeId eq 3}">
	                                                                              <%--  <c:set var="index" value="${index + 1}" scope="page" />  --%>
	                                                                           <c:choose>
							                                           		<c:when test="${docList.stateCode eq 0}">
								                                           </c:when>
								                                           <c:otherwise>											                                          
								                                           <div id="lessDiv" >
								                                             <c:if test="${statec ne docList.stateName}">											                                           
								                                           		<tr style="background-color:#e2f6e2;"><td width="1%" >
								                                           			<div class="text-center expandDiv" class="viewall" id="expandDiv${docList.stateCode}${docList.typeId}">
						                                                                  <a title="Click here to View" alt="Click here to View" onclick="expandDiv(${docList.stateCode}${docList.typeId})" id="stateExpandDiv${docList.stateCode}${docList.typeId}">
						                                                                  	<i class="fa fa-plus" aria-hidden="true"></i>
																						  </a>
						                                                             </div>
						                                                             <div class="text-center collapseDiv"  class="showless" id="collapseDiv${docList.stateCode}${docList.typeId}" style="display:none;">
						                                                                <a title="Click here to View"  alt="Click here to View" onclick="collapseDiv(${docList.stateCode}${docList.typeId})" id="stateCollapseDiv${docList.stateCode}${docList.typeId}">
						                                                                	<i class="fa fa-minus" aria-hidden="true"></i>																								
																						</a>
						                                                            </div>
								                                           		</td>
								                                           		<td colspan="2">
								                                           		<a class="customTabLink" title="Click here to View"  alt="Click here to View" >
						                                                                	<b>${docList.stateName}</b>																							
																						</a>
								                                           		
								                                           		
								                                           		</td></tr>																						
								                                           </c:if>
								                                           </div>
																		      <c:set var="statecount" value="${statecount + 1}" scope="page" />                                     
								                                             <tr class="stateDiv${docList.stateCode}${docList.typeId}" style="display:none;">
	                                                                                     <td width="1%"class="text-center">${statecount}.</td>                                                                                      
	                                                                                     <td width="20%">${docList.fileTitle}
	                                                                                    <%--  <c:choose>
                                                                                   		<c:when test="${docList.isNew eq true }">
                                                                                   			<img src="${pageContext.request.contextPath}/resources/images/new_red.gif" alt="New">
                                                                                   		</c:when>
                                                                                    </c:choose> --%></td>
	                                                                                     <td width="3%" class="text-nowrap">
	                                                                                         <a href="downloadFile.html?fileName=${docList.fileName}&<csrf:token uri='downloadFile.html'/>"><span class="englishLang">Download</span></a>
	                                                                                         <i class="fa fa-file-pdf-o" aria-hidden="true"></i></a>
	                                                                                     </td>
	                                                                                      <c:set var="statec" value="${docList.stateName}" scope="page" />
	                                                                                 </tr> 
	                                                                                                                                                       
								                                           </c:otherwise>
								                                       </c:choose>											                                                                                                           
	                                                                            </c:if>
	                                                                        </c:forEach>	   	 															
	 	 														</table>
	 	 													</div>
	 	 												</c:if>
		 												</div>
	                         					</div>	
	                         				</div>
	                           			</c:if>
	                           			</div>                            			
	                           			 <div class="col-lg-6">
	                           			        <c:if test="${campMatCount ne 0 }">      				                           			       
	                           				<div class="col-lg-12">
	                         					<div class="panel panel-success">
	                         						<div class="panel-heading headerColor"><h6 class="panel-title" ><span class="englishLang">Guidelines GPDP and other materials</span></h6></div>
		 												<div class="panel-body">
	 	 												<c:if test="${!empty DOCUMENT_LIST_CENTER}">
	 	 													<div class="table-responsive">
	 	 														<table class="table-bordered table-condensed">
						                                           		 <tr>
	                                                                          <th width="1%"> <span class="englishLang">S.No.</span></th>                                                                               
	                                                                          <th width="20%" align="center"> <span class="englishLang">Title</span></th>
	                                                                          <th width="3%"> <span class="englishLang">Details</span></th>
	                                                                        </tr>	
	 	 															 		<c:set var="index" value="0" scope="page" />  
	                                                                          <c:set var="statec" value="0" scope="page" />  
	                                                                           <c:set var="statecount" value="0" scope="page" />  
	                                                                        <c:forEach items="${DOCUMENT_LIST_CENTER}" var="docineer">
	                                                                           <c:if test="${docineer.typeId eq 4 and docineer.stateCode eq 0 }">
	                                                                           	<c:set var="index" value="${index + 1}" scope="page" />
	                                                                            <tr id="showId">
	                                                                                <td width="1%" class="text-center">${index}.</td>                                                                                      
	                                                                                <td width="20%">${docineer.fileTitle}
	                                                                               <%--  <c:choose>
                                                                                   		<c:when test="${docineer.isNew eq true }">
                                                                                   			<img src="${pageContext.request.contextPath}/resources/images/new_red.gif" alt="New">
                                                                                   		</c:when>
                                                                                    </c:choose> --%></td>
	                                                                               <%--  <td width="3%" class="text-nowrap">
	                                                                                    <a href="downloadFile.html?fileName=${docineer.fileName}&<csrf:token uri='downloadFile.html'/>"><span class="englishLang">Download</span></a>
	                                                                                    <i class="fa fa-file-pdf-o" aria-hidden="true"></i></a>
	                                                                                </td> --%>
	                                                                                 <td width="3%" class="text-nowrap">
	                                                                                         <a href="downloadFile.html?fileName=${docineer.fileName}&<csrf:token uri='downloadFile.html'/>"><span class="englishLang">Download</span></a>
	                                                                                         <i class="fa fa-file-pdf-o" aria-hidden="true"></i></a>
	                                                                                     </td>
	                                                                            </tr>
	                                                                           </c:if>
	                                                                           </c:forEach>
	                                                                        <c:forEach items="${DOCUMENT_LIST_CENTER}" var="docList" varStatus="countdoc">
	                                                                            <c:if test="${docList.typeId eq 4}">
	                                                                              <%--  <c:set var="index" value="${index + 1}" scope="page" />  --%>
	                                                                           <c:choose>
							                                           		<c:when test="${docList.stateCode eq 0}">
								                                           </c:when>
								                                           <c:otherwise>											                                          
								                                           <div id="lessDiv" >
								                                             <c:if test="${statec ne docList.stateName}">											                                           
								                                           		<tr style="background-color:#e2f6e2;"><td width="1%" >
								                                           			<div class="text-center expandDiv" class="viewall" id="expandDiv${docList.stateCode}${docList.typeId}">
						                                                                  <a title="Click here to View" alt="Click here to View" onclick="expandDiv(${docList.stateCode}${docList.typeId})" id="stateExpandDiv${docList.stateCode}${docList.typeId}">
						                                                                  	<i class="fa fa-plus" aria-hidden="true"></i>
																						  </a>
						                                                             </div>
						                                                             <div class="text-center collapseDiv"  class="showless" id="collapseDiv${docList.stateCode}${docList.typeId}" style="display:none;">
						                                                                <a title="Click here to View"  alt="Click here to View" onclick="collapseDiv(${docList.stateCode}${docList.typeId})" id="stateCollapseDiv${docList.stateCode}${docList.typeId}">
						                                                                	<i class="fa fa-minus" aria-hidden="true"></i>																								
																						</a>
						                                                            </div>
								                                           		</td>
								                                           		<td colspan="2">
								                                           		<a class="customTabLink" title="Click here to View"  alt="Click here to View" >
						                                                                	<b>${docList.stateName}</b>																							
																						</a>
								                                           		
								                                           		
								                                           		</td></tr>																						
								                                           </c:if>
								                                           </div>
																		      <c:set var="statecount" value="${statecount + 1}" scope="page" />                                     
								                                             <tr class="stateDiv${docList.stateCode}${docList.typeId}" style="display:none;">
	                                                                                     <td width="1%"class="text-center">${statecount}.</td>                                                                                      
	                                                                                     <td width="20%">${docList.fileTitle}
	                                                                                     <%-- <c:choose>
                                                                                   		<c:when test="${docList.isNew eq true }">
                                                                                   			<img src="${pageContext.request.contextPath}/resources/images/new_red.gif" alt="New">
                                                                                   		</c:when>
                                                                                    </c:choose> --%></td>
	                                                                                     <td width="3%" class="text-nowrap">
	                                                                                         <a href="downloadFile.html?fileName=${docList.fileName}&<csrf:token uri='downloadFile.html'/>"><span class="englishLang">Download</span></a>
	                                                                                         <i class="fa fa-file-pdf-o" aria-hidden="true"></i></a>
	                                                                                     </td>
	                                                                                      <c:set var="statec" value="${docList.stateName}" scope="page" />
	                                                                                 </tr> 
	                                                                                                                                                       
								                                           </c:otherwise>
								                                       </c:choose>											                                                                                                           
	                                                                            </c:if>
	                                                                        </c:forEach>	   	 															
	 	 														</table>
	 	 													</div>
	 	 												</c:if>
		 												</div>
	                         					</div>	
	                         				</div>
	                           				</c:if> 
	                           				<c:if test="${portalInfoCount ne 0}">
	             
	                           				<div class="col-lg-12">
	                         					<div class="panel panel-success">
	                         						<div class="panel-heading headerColor"><h6 class="panel-title" ><span class="englishLang">Meeting minutes</span></h6></div>
		 												<div class="panel-body">
	 	 												<c:if test="${!empty DOCUMENT_LIST_CENTER}">
	 	 													<div class="table-responsive">
	 	 														<table class="table-bordered table-condensed">
						                                           		 <tr>
	                                                                          <th width="1%"> <span class="englishLang">S.No.</span></th>                                                                               
	                                                                          <th width="20%" align="center"> <span class="englishLang">Title</span></th>
	                                                                          <th width="3%"> <span class="englishLang">Details</span></th>
	                                                                        </tr>	
	 	 															 		<c:set var="index" value="0" scope="page" />  
	                                                                          <c:set var="statec" value="0" scope="page" />  
	                                                                           <c:set var="statecount" value="0" scope="page" />  
	                                                                        <c:forEach items="${DOCUMENT_LIST_CENTER}" var="docineer">
	                                                                           <c:if test="${docineer.typeId eq 6 and docineer.stateCode eq 0 }">
	                                                                           	<c:set var="index" value="${index + 1}" scope="page" />
	                                                                            <tr id="showId">
	                                                                                <td width="1%" class="text-center">${index}.</td>                                                                                      
	                                                                                <td width="20%">${docineer.fileTitle}
	                                                                                <c:choose>
                                                                                   		<c:when test="${docineer.isNew eq true }">
                                                                                   			<img src="${pageContext.request.contextPath}/resources/images/new_red.gif" alt="New">
                                                                                   		</c:when>
                                                                                    </c:choose></td>
	                                                                                <td width="3%" class="text-nowrap">
	                                                                                    <a href="downloadFile.html?fileName=${docineer.fileName}&<csrf:token uri='downloadFile.html'/>"><span class="englishLang">Download</span></a>
	                                                                                    <i class="fa fa-file-pdf-o" aria-hidden="true"></i></a>
	                                                                                </td>
	                                                                            </tr>
	                                                                           </c:if>
	                                                                           </c:forEach>
	                                                                        <c:forEach items="${DOCUMENT_LIST_CENTER}" var="docList" varStatus="countdoc">
	                                                                            <c:if test="${docList.typeId eq 6}">
	                                                                              <%--  <c:set var="index" value="${index + 1}" scope="page" />  --%>
	                                                                           <c:choose>
							                                           		<c:when test="${docList.stateCode eq 0}">
								                                           </c:when>
								                                           <c:otherwise>											                                          
								                                           <div id="lessDiv" >
								                                             <c:if test="${statec ne docList.stateName}">											                                           
								                                           		<tr style="background-color:#e2f6e2;"><td width="1%" >
								                                           			<div class="text-center expandDiv" class="viewall" id="expandDiv${docList.stateCode}${docList.typeId}">
						                                                                  <a title="Click here to View" alt="Click here to View" onclick="expandDiv(${docList.stateCode}${docList.typeId})" id="stateExpandDiv${docList.stateCode}${docList.typeId}">
						                                                                  	<i class="fa fa-plus" aria-hidden="true"></i>
																						  </a>
						                                                             </div>
						                                                             <div class="text-center collapseDiv"  class="showless" id="collapseDiv${docList.stateCode}${docList.typeId}" style="display:none;">
						                                                                <a title="Click here to View"  alt="Click here to View" onclick="collapseDiv(${docList.stateCode}${docList.typeId})" id="stateCollapseDiv${docList.stateCode}${docList.typeId}">
						                                                                	<i class="fa fa-minus" aria-hidden="true"></i>																								
																						</a>
						                                                            </div>
								                                           		</td>
								                                           		<td colspan="2">
								                                           		<a class="customTabLink" title="Click here to View"  alt="Click here to View" >
						                                                                	<b>${docList.stateName}</b>																							
																						</a>
								                                           		
								                                           		
								                                           		</td></tr>																						
								                                           </c:if>
								                                           </div>
																		      <c:set var="statecount" value="${statecount + 1}" scope="page" />                                     
								                                             <tr class="stateDiv${docList.stateCode}${docList.typeId}" style="display:none;">
	                                                                                     <td width="1%"class="text-center">${statecount}.</td>                                                                                      
	                                                                                     <td width="20%">${docList.fileTitle}
	                                                                                    <%--  <c:choose>
                                                                                   		<c:when test="${docList.isNew eq true }">
                                                                                   			<img src="${pageContext.request.contextPath}/resources/images/new_red.gif" alt="New">
                                                                                   		</c:when>
                                                                                    </c:choose> --%></td>
	                                                                                     <td width="3%" class="text-nowrap">
	                                                                                         <a href="downloadFile.html?fileName=${docList.fileName}&<csrf:token uri='downloadFile.html'/>"><span class="englishLang">Download</span></a>
	                                                                                         <i class="fa fa-file-pdf-o" aria-hidden="true"></i></a>
	                                                                                     </td>
	                                                                                      <c:set var="statec" value="${docList.stateName}" scope="page" />
	                                                                                 </tr> 
	                                                                                                                                                       
								                                           </c:otherwise>
								                                       </c:choose>											                                                                                                           
	                                                                            </c:if>
	                                                                        </c:forEach>	   	 															
	 	 														</table>
	 	 													</div>
	 	 												</c:if>
		 												</div>
	                         					</div>	
	                         				</div>
	                           				</c:if>
	                           				
                                           <c:if test="${newCount ne 0}">
	             
	                           				<div class="col-lg-12">
	                         					<div class="panel panel-success">
	                         						<div class="panel-heading headerColor"><h6 class="panel-title" ><span class="englishLang">What's new</span></h6></div>
		 												<div class="panel-body">
	 	 												<c:if test="${!empty DOCUMENT_LIST_CENTER}">
	 	 													<div class="table-responsive">
	 	 														<table class="table-bordered table-condensed">
						                                           		 <tr>
	                                                                          <th width="1%"> <span class="englishLang">S.No.</span></th>                                                                               
	                                                                          <th width="20%" align="center"> <span class="englishLang">Title</span></th>
	                                                                          <th width="3%"> <span class="englishLang">Details</span></th>
	                                                                        </tr>	
	 	 															 		<c:set var="index" value="0" scope="page" />  
	                                                                          <c:set var="statec" value="0" scope="page" />  
	                                                                           <c:set var="statecount" value="0" scope="page" />  
	                                                                        <c:forEach items="${DOCUMENT_LIST_CENTER}" var="docineer">
	                                                                           <c:if test="${docineer.typeId eq 7 and docineer.stateCode eq 0 }">
	                                                                           	<c:set var="index" value="${index + 1}" scope="page" />
	                                                                            <tr id="showId">
	                                                                                <td width="1%" class="text-center">${index}.</td>                                                                                      
	                                                                                <td width="20%">${docineer.fileTitle}
	                                                                                <c:choose>
                                                                                   		<c:when test="${docineer.isNew eq true }">
                                                                                   			<img src="${pageContext.request.contextPath}/resources/images/new_red.gif" alt="New">
                                                                                   		</c:when>
                                                                                    </c:choose></td>
	                                                                                <td width="3%" class="text-nowrap">
	                                                                                    <a href="downloadFile.html?fileName=${docineer.fileName}&<csrf:token uri='downloadFile.html'/>"><span class="englishLang">Download</span></a>
	                                                                                    <i class="fa fa-file-pdf-o" aria-hidden="true"></i></a>
	                                                                                </td>
	                                                                            </tr>
	                                                                           </c:if>
	                                                                           </c:forEach>
	                                                                        <c:forEach items="${DOCUMENT_LIST_CENTER}" var="docList" varStatus="countdoc">
	                                                                            <c:if test="${docList.typeId eq 7}">
	                                                                              <%--  <c:set var="index" value="${index + 1}" scope="page" />  --%>
	                                                                           <c:choose>
							                                           		<c:when test="${docList.stateCode eq 0}">
								                                           </c:when>
								                                           <c:otherwise>											                                          
								                                           <div id="lessDiv" >
								                                             <c:if test="${statec ne docList.stateName}">											                                           
								                                           		<tr style="background-color:#e2f6e2;"><td width="1%" >
								                                           			<div class="text-center expandDiv" class="viewall" id="expandDiv${docList.stateCode}${docList.typeId}">
						                                                                  <a title="Click here to View" alt="Click here to View" onclick="expandDiv(${docList.stateCode}${docList.typeId})" id="stateExpandDiv${docList.stateCode}${docList.typeId}">
						                                                                  	<i class="fa fa-plus" aria-hidden="true"></i>
																						  </a>
						                                                             </div>
						                                                             <div class="text-center collapseDiv"  class="showless" id="collapseDiv${docList.stateCode}${docList.typeId}" style="display:none;">
						                                                                <a title="Click here to View"  alt="Click here to View" onclick="collapseDiv(${docList.stateCode}${docList.typeId})" id="stateCollapseDiv${docList.stateCode}${docList.typeId}">
						                                                                	<i class="fa fa-minus" aria-hidden="true"></i>																								
																						</a>
						                                                            </div>
								                                           		</td>
								                                           		<td colspan="2">
								                                           		<a class="customTabLink" title="Click here to View"  alt="Click here to View" >
						                                                                	<b>${docList.stateName}</b>																							
																						</a>
								                                           		
								                                           		
								                                           		</td></tr>																						
								                                           </c:if>
								                                           </div>
																		      <c:set var="statecount" value="${statecount + 1}" scope="page" />                                     
								                                             <tr class="stateDiv${docList.stateCode}${docList.typeId}" style="display:none;">
	                                                                                     <td width="1%"class="text-center">${statecount}.</td>                                                                                      
	                                                                                     <td width="20%">${docList.fileTitle}
	                                                                                    <%--  <c:choose>
                                                                                   		<c:when test="${docList.isNew eq true }">
                                                                                   			<img src="${pageContext.request.contextPath}/resources/images/new_red.gif" alt="New">
                                                                                   		</c:when>
                                                                                    </c:choose> --%></td>
	                                                                                     <td width="3%" class="text-nowrap">
	                                                                                         <a href="downloadFile.html?fileName=${docList.fileName}&<csrf:token uri='downloadFile.html'/>"><span class="englishLang">Download</span></a>
	                                                                                         <i class="fa fa-file-pdf-o" aria-hidden="true"></i></a>
	                                                                                     </td>
	                                                                                      <c:set var="statec" value="${docList.stateName}" scope="page" />
	                                                                                 </tr> 
	                                                                                                                                                       
								                                           </c:otherwise>
								                                       </c:choose>											                                                                                                           
	                                                                            </c:if>
	                                                                        </c:forEach>	   	 															
	 	 														</table>
	 	 													</div>
	 	 												</c:if>
		 												</div>
	                         					</div>	
	                         				</div>
	                           				</c:if>
	                           				
	                           			  </div>  
	                           		</div>
								</div>
	                          </div><!--tab panel close  -->                             
	                            <div role="tabpanel" class="tab-pane fade " id="tabData1">
	                            <br/>
		                       		<div class="col-lg-4">
	                        			<div class="form-group">
		                        			<label for="Select State" class="control-label">
								                <spring:message code="Select State" htmlEscape="true" />
								            </label>
								            <div class="form-line">
									                <form:select path="stateCode" id="stateCodeId" class="form-control" onchange="getDataForState(this.value)">
									                    <option value="0">SELECT</option>
									                    <c:forEach items="${STATE_LIST}" var="statelist">									                        
									                        <c:choose>
					                                           	 <c:when test="${stateCode!=0 && stateCode==statelist.stateCode}">
						                                           	<option value="${statelist.stateCode}" selected="selected"><esapi:encodeForHTML>${statelist.stateNameEnglish}</esapi:encodeForHTML> </option>
						                                         </c:when>
					                                           	<c:otherwise>
					                                           		<option value="${statelist.stateCode}"><esapi:encodeForHTML>${statelist.stateNameEnglish}</esapi:encodeForHTML> </option>
					                                           	</c:otherwise>
					                                       </c:choose>
									                    </c:forEach>
									                </form:select>
									            </div>							         
									        </div>
	                             		</div>
	                             	<!-----------------------------------------------  -->
	                             	<div class="row">	
	                                <div class="stateDivToDisplay" > 
	                        		<div class="col-lg-12">
	                        		<c:choose>
	                        			<c:when test="${empty DOCUMENT_LIST_STATE }">
	                        				<c:if test="${stateCode gt 0}">
			                             		<div class="text-center">
			                             			<b>No Documents Uploaded</b>
			                             		</div>
		                             		</c:if>
	                             		</c:when>
	                             		<c:otherwise>   
	                        			<div class="col-lg-6">
	                                         <c:if test="${circularCountS ne  0}">                                             
	                         				<div class="col-lg-12">
	                         					<div class="panel panel-success">
	                         						<div class="panel-heading headerColor"><h6 class="panel-title" >${data.typeId}<span class="englishLang">Circulars/Letters to States</span></h6></div>
		 												<div class="panel-body">
	 	 												<c:if test="${!empty DOCUMENT_LIST_STATE}">
	 	 													<div class="table-responsive">
	 	 														<table class="table-bordered table-condensed">
						                                           		 <tr>
	                                                                          <th width="1%"> <span class="englishLang">S.No.</span></th>                                                                               
	                                                                          <th width="20%" align="center"> <span class="englishLang">Title</span></th>
	                                                                          <th width="3%"> <span class="englishLang">Details</span></th>
	                                                                        </tr>	 	 															 	
	                                                                           <c:set var="statecount" value="0" scope="page" />
	                                                                        <c:forEach items="${DOCUMENT_LIST_STATE}" var="docList" varStatus="countdoc">
	                                                                         <c:if test="${docList.typeId eq 2}">	                                                                               
																		      <c:set var="statecount" value="${statecount + 1}" scope="page" />                                     
								                                             <tr class="stateDiv${docList.stateCode}${docList.typeId}" >
                                                                                 <td width="1%"class="text-center">${statecount}.</td>                                                                                      
                                                                                 <td width="20%">${docList.fileTitle}
                                                                                 <%-- <c:choose>
                                                                                   		<c:when test="${docList.isNew eq true }">
                                                                                   			<img src="${pageContext.request.contextPath}/resources/images/new_red.gif" alt="New">
                                                                                   		</c:when>
                                                                                    </c:choose> --%></td>
                                                                                 <td width="3%" class="text-nowrap">
                                                                                     <a href="downloadFile.html?fileName=${docList.fileName}&<csrf:token uri='downloadFile.html'/>"><span class="englishLang">Download</span></a>
                                                                                     <i class="fa fa-file-pdf-o" aria-hidden="true"></i></a>
                                                                                 </td>                                                                                
	                                                                           </tr> 						                                                                                                           
	                                                                          </c:if>
	                                                                        </c:forEach>	   	 															
	 	 														</table>
	 	 													</div>
	 	 												</c:if>
		 												</div>
	                         					</div>	
	                         				</div>                    
	                                   		 </c:if> 
	                                      		<c:if test="${presentationCountS ne  0}">   
	                           				<div class="col-lg-12">
	                           					<div class="panel panel-success">
	                           						<div class="panel-heading headerColor"><h6 class="panel-title" ><span class="englishLang">Presentations of MoPR/States</span></h6></div>
	  	 												<div class="panel-body">
	   	 												<c:if test="${!empty DOCUMENT_LIST_STATE}">
	 	 													<div class="table-responsive">
	 	 														<table class="table-bordered table-condensed">
						                                           		 <tr>
	                                                                          <th width="1%"> <span class="englishLang">S.No.</span></th>                                                                               
	                                                                          <th width="20%" align="center"> <span class="englishLang">Title</span></th>
	                                                                          <th width="3%"> <span class="englishLang">Details</span></th>
	                                                                        </tr>	 	 															 	
	                                                                           <c:set var="statecount" value="0" scope="page" />
	                                                                        <c:forEach items="${DOCUMENT_LIST_STATE}" var="docList" varStatus="countdoc">
	                                                                         <c:if test="${docList.typeId eq 1}">	                                                                               
																		      <c:set var="statecount" value="${statecount + 1}" scope="page" />                                     
								                                             <tr class="stateDiv${docList.stateCode}${docList.typeId}" >
                                                                                 <td width="1%"class="text-center">${statecount}.</td>                                                                                      
                                                                                 <td width="20%">${docList.fileTitle}
																				<%-- <c:choose>
                                                                                  		<c:when test="${docList.isNew eq true }">
                                                                                  			<img src="${pageContext.request.contextPath}/resources/images/new_red.gif" alt="New">
                                                                                  		</c:when>
                                                                                   </c:choose> --%></td>
                                                                                 <td width="3%" class="text-nowrap">
                                                                                     <a href="downloadFile.html?fileName=${docList.fileName}&<csrf:token uri='downloadFile.html'/>"><span class="englishLang">Download</span></a>
                                                                                     <i class="fa fa-file-pdf-o" aria-hidden="true"></i></a>
                                                                                 </td>                                                                                
	                                                                           </tr> 						                                                                                                           
	                                                                          </c:if>
	                                                                        </c:forEach>	   	 															
	 	 														</table>
	 	 													</div>
	 	 												</c:if>
	  	 												</div>
	                           					</div>
	                           				</div>
	                           				</c:if>
	                           				<c:if test="${campScheS ne 0 }">
	                           				<div class="col-lg-12">
	                           					<div class="panel panel-success">
	                           						<div class="panel-heading headerColor"><h6 class="panel-title" ><span class="englishLang">RGSA Frame work</span></h6></div>
	  	 												<div class="panel-body">
	   	 												<c:if test="${!empty DOCUMENT_LIST_STATE}">
	 	 													<div class="table-responsive">
	 	 														<table class="table-bordered table-condensed">
						                                           		 <tr>
	                                                                          <th width="1%"> <span class="englishLang">S.No.</span></th>                                                                               
	                                                                          <th width="20%" align="center"> <span class="englishLang">Title</span></th>
	                                                                          <th width="3%"> <span class="englishLang">Details</span></th>
	                                                                        </tr>	 	 															 	
	                                                                           <c:set var="statecount" value="0" scope="page" />
	                                                                        <c:forEach items="${DOCUMENT_LIST_STATE}" var="docList" varStatus="countdoc">
	                                                                         <c:if test="${docList.typeId eq 5}">	                                                                               
																		      <c:set var="statecount" value="${statecount + 1}" scope="page" />                                     
								                                             <tr class="stateDiv${docList.stateCode}${docList.typeId}" >
                                                                                 <td width="1%"class="text-center">${statecount}.</td>                                                                                      
                                                                                 <td width="20%">${docList.fileTitle}
                                                                                 <%-- <c:choose>
                                                                                   		<c:when test="${docList.isNew eq true }">
                                                                                   			<img src="${pageContext.request.contextPath}/resources/images/new_red.gif" alt="New">
                                                                                   		</c:when>
                                                                                    </c:choose> --%></td>
                                                                                 <td width="3%" class="text-nowrap">
                                                                                     <a href="downloadFile.html?fileName=${docList.fileName}&<csrf:token uri='downloadFile.html'/>"><span class="englishLang">Download</span></a>
                                                                                     <i class="fa fa-file-pdf-o" aria-hidden="true"></i></a>
                                                                                 </td>                                                                                
	                                                                           </tr> 						                                                                                                           
	                                                                          </c:if>
	                                                                        </c:forEach>	   	 															
	 	 														</table>
	 	 													</div>
	 	 												</c:if>
	  	 												</div>
	                           					</div>
	                           				</div>
	                           				</c:if> 
	                           				<c:if test="${goCountS ne  0}">                                             
	                         				<div class="col-lg-12">
	                         					<div class="panel panel-success">
	                         						<div class="panel-heading headerColor"><h6 class="panel-title" >${data.typeId}<span class="englishLang">Other material for CB</span></h6></div>
		 												<div class="panel-body">
	 	 												<c:if test="${!empty DOCUMENT_LIST_STATE}">
	 	 													<div class="table-responsive">
	 	 														<table class="table-bordered table-condensed">
						                                           		 <tr>
	                                                                          <th width="1%"> <span class="englishLang">S.No.</span></th>                                                                               
	                                                                          <th width="20%" align="center"> <span class="englishLang">Title</span></th>
	                                                                          <th width="3%"> <span class="englishLang">Details</span></th>
	                                                                        </tr>	 	 															 	
	                                                                           <c:set var="statecount" value="0" scope="page" />
	                                                                        <c:forEach items="${DOCUMENT_LIST_STATE}" var="docList" varStatus="countdoc">
	                                                                         <c:if test="${docList.typeId eq 3}">	                                                                               
																		      <c:set var="statecount" value="${statecount + 1}" scope="page" />                                     
								                                             <tr class="stateDiv${docList.stateCode}${docList.typeId}" >
                                                                                 <td width="1%"class="text-center">${statecount}.</td>                                                                                      
                                                                                 <td width="20%">${docList.fileTitle}
																				<%-- <c:choose>
                                                                                  		<c:when test="${docList.isNew eq true }">
                                                                                  			<img src="${pageContext.request.contextPath}/resources/images/new_red.gif" alt="New">
                                                                                  		</c:when>
                                                                                   </c:choose> --%></td>
                                                                                 <td width="3%" class="text-nowrap">
                                                                                     <a href="downloadFile.html?fileName=${docList.fileName}&<csrf:token uri='downloadFile.html'/>"><span class="englishLang">Download</span></a>
                                                                                     <i class="fa fa-file-pdf-o" aria-hidden="true"></i></a>
                                                                                 </td>                                                                                
	                                                                           </tr> 						                                                                                                           
	                                                                          </c:if>
	                                                                        </c:forEach>	   	 															
	 	 														</table>
	 	 													</div>
	 	 												</c:if>
		 												</div>
	                         					</div>	
	                         				</div>                    
	                                   		 </c:if>
	                           			</div>                            			
	                           			<div class="col-lg-6">
	                           			
	                                   		 <c:if test="${campMatCountS ne  0}">                                             
	                         				<div class="col-lg-12">
	                         					<div class="panel panel-success">
	                         						<div class="panel-heading headerColor"><h6 class="panel-title" >${data.typeId}<span class="englishLang">Guidelines GPDP and other materials</span></h6></div>
		 												<div class="panel-body">
	 	 												<c:if test="${!empty DOCUMENT_LIST_STATE}">
	 	 													<div class="table-responsive">
	 	 														<table class="table-bordered table-condensed">
						                                           		 <tr>
	                                                                          <th width="1%"> <span class="englishLang">S.No.</span></th>                                                                               
	                                                                          <th width="20%" align="center"> <span class="englishLang">Title</span></th>
	                                                                          <th width="3%"> <span class="englishLang">Details</span></th>
	                                                                        </tr>	 	 															 	
	                                                                           <c:set var="statecount" value="0" scope="page" />
	                                                                        <c:forEach items="${DOCUMENT_LIST_STATE}" var="docList" varStatus="countdoc">
	                                                                         <c:if test="${docList.typeId eq 4}">	                                                                               
																		      <c:set var="statecount" value="${statecount + 1}" scope="page" />                                     
								                                             <tr class="stateDiv${docList.stateCode}${docList.typeId}" >
                                                                                 <td width="1%"class="text-center">${statecount}.</td>                                                                                      
                                                                                 <td width="20%">${docList.fileTitle}
                                                                                <%--  <c:choose>
                                                                                  		<c:when test="${docList.isNew eq true }">
                                                                                  			<img src="${pageContext.request.contextPath}/resources/images/new_red.gif" alt="New">
                                                                                  		</c:when>
                                                                                   </c:choose> --%></td>
                                                                                 <td width="3%" class="text-nowrap">
                                                                                     <a href="downloadFile.html?fileName=${docList.fileName}&<csrf:token uri='downloadFile.html'/>"><span class="englishLang">Download</span></a>
                                                                                     <i class="fa fa-file-pdf-o" aria-hidden="true"></i></a>
                                                                                 </td>                                                                                
	                                                                           </tr> 						                                                                                                           
	                                                                          </c:if>
	                                                                        </c:forEach>	   	 															
	 	 														</table>
	 	 													</div>
	 	 												</c:if>
		 												</div>
	                         					</div>	
	                         				</div>                    
	                                   		 </c:if>
	                                   		 <c:if test="${portalInfoCountS ne  0}">                                             
	                         				<div class="col-lg-12">
	                         					<div class="panel panel-success">
	                         						<div class="panel-heading headerColor"><h6 class="panel-title" >${data.typeId}<span class="englishLang">Meeting minutes</span></h6></div>
		 												<div class="panel-body">
	 	 												<c:if test="${!empty DOCUMENT_LIST_STATE}">
	 	 													<div class="table-responsive">
	 	 														<table class="table-bordered table-condensed">
						                                           		 <tr>
	                                                                          <th width="1%"> <span class="englishLang">S.No.</span></th>                                                                               
	                                                                          <th width="20%" align="center"> <span class="englishLang">Title</span></th>
	                                                                          <th width="3%"> <span class="englishLang">Details</span></th>
	                                                                        </tr>	 	 															 	
	                                                                           <c:set var="statecount" value="0" scope="page" />
	                                                                        <c:forEach items="${DOCUMENT_LIST_STATE}" var="docList" varStatus="countdoc">
	                                                                         <c:if test="${docList.typeId eq 6}">	                                                                               
																		      <c:set var="statecount" value="${statecount + 1}" scope="page" />                                     
								                                             <tr class="stateDiv${docList.stateCode}${docList.typeId}" >
                                                                                 <td width="1%"class="text-center">${statecount}.</td>                                                                                      
                                                                                 <td width="20%">${docList.fileTitle}
                                                                                 <%-- <c:choose>
                                                                                   		<c:when test="${docList.isNew eq true }">
                                                                                   			<img src="${pageContext.request.contextPath}/resources/images/new_red.gif" alt="New">
                                                                                   		</c:when>
                                                                                    </c:choose> --%></td>
                                                                                 <td width="3%" class="text-nowrap">
                                                                                     <a href="downloadFile.html?fileName=${docList.fileName}&<csrf:token uri='downloadFile.html'/>"><span class="englishLang">Download</span></a>
                                                                                     <i class="fa fa-file-pdf-o" aria-hidden="true"></i></a>
                                                                                 </td>                                                                                
	                                                                           </tr> 						                                                                                                           
	                                                                          </c:if>
	                                                                        </c:forEach>	   	 															
	 	 														</table>
	 	 													</div>
	 	 												</c:if>
		 												</div>
	                         					</div>	
	                         				</div>                    
	                                   		 </c:if>
	                                   		 <c:if test="${newCountS ne  0}">                                             
	                         				<div class="col-lg-12">
	                         					<div class="panel panel-success">
	                         						<div class="panel-heading headerColor"><h6 class="panel-title" >${data.typeId}<span class="englishLang">What's new</span></h6></div>
		 												<div class="panel-body">
	 	 												<c:if test="${!empty DOCUMENT_LIST_STATE}">
	 	 													<div class="table-responsive">
	 	 														<table class="table-bordered table-condensed">
						                                           		 <tr>
	                                                                          <th width="1%"> <span class="englishLang">S.No.</span></th>                                                                               
	                                                                          <th width="20%" align="center"> <span class="englishLang">Title</span></th>
	                                                                          <th width="3%"> <span class="englishLang">Details</span></th>
	                                                                        </tr>	 	 															 	
	                                                                           <c:set var="statecount" value="0" scope="page" />
	                                                                        <c:forEach items="${DOCUMENT_LIST_STATE}" var="docList" varStatus="countdoc">
	                                                                         <c:if test="${docList.typeId eq 7}">	                                                                               
																		      <c:set var="statecount" value="${statecount + 1}" scope="page" />                                     
								                                             <tr class="stateDiv${docList.stateCode}${docList.typeId}" >
                                                                                 <td width="1%"class="text-center">${statecount}.</td>                                                                                      
                                                                                 <td width="20%">${docList.fileTitle}
                                                                                 <%-- <c:choose>
                                                                                   		<c:when test="${docList.isNew eq true }">
                                                                                   			<img src="${pageContext.request.contextPath}/resources/images/new_red.gif" alt="New">
                                                                                   		</c:when>
                                                                                    </c:choose> --%></td>
                                                                                 <td width="3%" class="text-nowrap">
                                                                                     <a href="downloadFile.html?fileName=${docList.fileName}&<csrf:token uri='downloadFile.html'/>"><span class="englishLang">Download</span></a>
                                                                                     <i class="fa fa-file-pdf-o" aria-hidden="true"></i></a>
                                                                                 </td>                                                                                
	                                                                           </tr> 						                                                                                                           
	                                                                          </c:if>
	                                                                        </c:forEach>	   	 															
	 	 														</table>
	 	 													</div>
	 	 												</c:if>
		 												</div>
	                         					</div>	
	                         				</div>                    
	                                   		 </c:if>
	                           			
	                           			</div>
	                           			</c:otherwise>
	                           			</c:choose>
	                           		</div>
	                           		</div><!-- for show /hide -->
								</div>
								 <%-- <div class="form-group text-right">
                                   <button type="button" onclick="onClose('index.html?<csrf:token uri='index.html'/>')" class="btn btn-warning waves-effect ">CLOSE</button>
                               </div> --%>
								</div>
							<%-- 	</c:if> --%>
	                               	
	                            </div><!--tab close  -->
	                            <br/>    
                              <div class="form-group text-right">
                                   <button type="button" onclick="onClose()" class="btn btn-warning waves-effect ">CLOSE</button>
                               </div> 
                            </div>
                               
                              
                               </form:form>
                           </div>
                       </div>
                   </div>
               </div>
       </section>
       <script>   
       $(document).ready(function() {
    	   var selectedTab='${displayDiv}';
    	
    	   if(selectedTab!=null && selectedTab=='state') {
    		
    		   //$("#tabData1").removeClass("tab-pane fade");
    		   $("#tabData1").addClass("in active");
    		   $("#tabData0").removeClass("in active");
    		   $(".tabData1").addClass("active");
    		   $(".tabData0").removeClass("active");
    		   //$("#tabData0").addClass("tab-pane fade");    		   
    	   }else{
    		   $("#tabData0").addClass("in active");
    		   $("#tabData1").removeClass("in active");
    		   $(".tabData0").addClass("active");
    		   $(".tabData1").removeClass("active");
    		   
    	   }
	
    	   
    	   });
    
       function getDataForState(stateCode){	
    	   form.action="downloadNew1.html?<csrf:token uri='downloadNew1.html'/>";
    	   form.method="get";
    	   form.submit(); 
   		
      }
       
       function onClose(){	
    	   form.action="index.html?<csrf:token uri='index.html'/>";
    	   form.method="get";
    	   form.submit(); 
   		
      }
       
           function expandDiv(id) {
           	$('.stateDiv' + id).show();
           	$('#stateExpandDiv' + id).parent('#expandDiv' + id).hide();           	
           	$('#stateExpandDiv' + id).parent().parent().find('#collapseDiv' + id).show();
           }

           function collapseDiv(id) {
           	$('.stateDiv' + id).hide();
           	$('#stateCollapseDiv' + id).parent('#collapseDiv' + id).hide();
           	$('#stateCollapseDiv' + id).parent().parent().find('#expandDiv' + id).show();                  
           }
       </script>