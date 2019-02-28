<%@include file="../taglib/taglib.jsp"%>
    <section class="content">
        <div class="container-fluid">
            <div class="row clearfix">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="card">
                        <div class="header">
                            <h2>INFORMATION REGARDING FULFILMENT OF ESSENTIAL CONDITIONS</h2> 
                        </div>
                         <form:form action="essentialConditions.html" class="form-inline" modelAttribute="BASIC_INFO_MODEL" method="POST">
                         <form:hidden path="basicInfoDefinationId" value="${BESIC_DEFINATION.basicInfoDefinationId}"/>
                        <div class="body">
                          	<c:set var="sNo" value="1"/>
							 <c:forEach items="${BESIC_DEFINATION.basicInfoDefinationDetails}" var="field" varStatus="count">
	                              <c:choose>
	                              	<c:when test="${field.fieldType eq 'text'}">
	                              		<label for="password">${sNo} . ${field.labelName}</label>
			                               <div class="form-group">
			                                 <div class="row clearfix">
			                                <div class="col-sm-4">
			                                    <div class="form-group form-float">&nbsp;&nbsp;&nbsp;
			                                        <div class="form-line">
			                                            <form:input disabled="true" path="data[${field.basicInfoDefinationDetailsId}_EC]" 
			                                            cssClass="form-control" placeholder="Please click "/> &nbsp;&nbsp;
			                                        </div>
			                                    </div>
			                                </div>
			                                
			                              
			                            </div>
			                           </div>
	                              	</c:when>
	                              	<c:when test="${field.fieldType eq 'checkbox'}">
	                              		<label for="password">${sNo} . ${field.labelName}</label>
			                               <div class="form-group">
			                                 <div class="row clearfix">
			                                
			                                <div class="col-sm-4">
			                                    <div class="form-group form-float">&nbsp;&nbsp;&nbsp;
			                                        <div class="">
			                                            <label for="yes">Yes</label>
			                                            <form:radiobutton disabled="true" path="data[${field.basicInfoDefinationDetailsId}_EC]" value="true" /> &nbsp;&nbsp;&nbsp;
			                                            <label for="yes">No</label>
			                                            <form:radiobutton disabled="true" path="data[${field.basicInfoDefinationDetailsId}_EC]" value="false" /> &nbsp;&nbsp;&nbsp;
			                                        </div>
			                                    </div>
			                                </div>
			                                </div>
			                                </div>
	                              	</c:when>
	                              	<c:when test="${field.fieldType eq 'date'}">
	                              		<label for="password">${sNo} . ${field.labelName}</label>
			                               <div class="form-group">
			                                 <div class="row clearfix">
			                                	<div class="col-sm-4">
			                                    	<div class="form-group form-float">&nbsp;&nbsp;&nbsp;
			                                        	<div class="form-line">
			                                            	<form:input type="date" disabled="true" class="form-control" path="data[${field.basicInfoDefinationDetailsId}_EC]" /> &nbsp;&nbsp;&nbsp;
			                                    		</div>
			                                		</div>
			                            		</div>
			                           		</div>
			                           	</div>
	                              	</c:when>
	                              	<c:when test="${field.fieldType eq 'title'}">
	                             		 <div class="header">
				                            <h2> ${field.labelName}</h2>
				                        </div>
				                        <c:set var="sNo" value="0"/>
	                              	</c:when>
	                              </c:choose>
	                              <c:set var="sNo" value="${sNo+1}"/>
                           </c:forEach> 
                             <div class="form-group text-right">
                                	<button type="button" onclick="onClose('home.html?<csrf:token uri='home.html'/>')"  class="btn bg-orange waves-effect">CLOSE</button>
                               </div>
                        </div>
                        </form:form>
                    </div>
                </div>
            </div>
        </div>
    </section>
