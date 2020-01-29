<%@include file="../taglib/taglib.jsp"%> 
<script type="text/javascript">
var countFlag=false;
var count=0;
$( document ).ready(function() {
	
	if($("#data49_gp1").is(':checked')){
		$("#data49_gp_date_div").show();
	}else{
		$("#data49_gp_date_div").hide();
	}
	
	if($("#data49_bp1").is(':checked')){
		$("#data49_bp_date_div").show();
	}else{
		$("#data49_bp_date_div").hide();
	}
	
	if($("#data49_dp1").is(':checked')){
		$("#data49_dp_date_div").show();
	}else{
		$("#data49_dp_date_div").hide();
	}
	
	$("#data37_EC").keypress(function (e) {
	    //if the letter is not digit then display error and don't type anything
	    if (e.which != 8 && e.which != 0 &&   e.which !=46  && (e.which < 48 || e.which > 57)  ) {
	       //display error message
	    	$("#errmsg").html("Digits Only").show().fadeOut("slow");
	              return false;
	   }
	    if((e.which >= 48 || e.which <= 57) && $("#data37_EC").val().indexOf(".")>0){
	    	 if(countFlag==true){
	  	    	count++;
	  	    }
	  	    
	  	    if(count>2){
	  	    	 alert("2 Digits Only after decimal");
	               return false;
	  	    }
	    }else{
	    	count=0;
	    }
	    
		  if(e.which ==46 ){
	    	countFlag=true;
	    }
	  });
	
	
	$("#data38_ECNUM").keypress(function (e) {
	    //if the letter is not digit then display error and don't type anything
	    if (e.which != 8 && e.which != 0 && e.which != 40  && e.which != 41  && e.which != 45 && e.which != 47     && (e.which < 48 || e.which > 57)  && (e.which < 65 || e.which > 90)  && (e.which < 67 || e.which > 122) ) {
	       //display error message
	    	$("#errmsg").html("Digits Only").show().fadeOut("slow");
	              return false;
	   }
	   
	  });
	
	$("#data37_EC").change(function() {
		data37_EC=$_checkEmptyObject_value($("#data37_EC").val());
		if(data37_EC>100){
			alert("Value Should be less then 100");
			$("#data37_EC").val(' ');
		}
	});
	
	
	$("#data49_gp_date,#data49_bp_date,data49_dp_date").on('change', function () {
        var capDate = Date.parse($(this).val());
        var curDate = new Date();
        
        if (capDate> curDate) {
            alert(' date must be less than Current Date');
            $(this).val('');
        }
    });
	
	$("#data49_gp1,#data49_gp2,#data49_bp1,#data49_bp2,#data49_dp1,#data49_dp2").change(function() {
		if($("#data49_gp1").is(':checked')){
			$("#data49_gp_date_div").show();
		}else{
			$("#data49_gp_date_div").hide();
		}
		
		if($("#data49_bp1").is(':checked')){
			$("#data49_bp_date_div").show();
		}else{
			$("#data49_bp_date_div").hide();
		}
		
		if($("#data49_dp1").is(':checked')){
			$("#data49_dp_date_div").show();
		}else{
			$("#data49_dp_date_div").hide();
		}
	});
		
});

var $_checkEmptyObject_value = function(obj) {
	if (jQuery.type(obj) === "undefined" || (obj == null || $.trim(obj).length == 0)) {
		return 0;
	}
	return parseInt(obj);
};

var $_checkEmptyObject = function(obj) {
	if (jQuery.type(obj) === "undefined" || (obj == null || $.trim(obj).length == 0)) {
		return true;
	}
	return false;
};
</script>
    <section class="content">
        <div class="container-fluid">
            <div class="row clearfix">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="card">
                        <div class="header">
                            <h2>INFORMATION REGARDING FULFILMENT OF ESSENTIAL CONDITIONS</h2> 
                        </div> 
                         <form:form action="updateEssentialConditions.html" class="form-inline" modelAttribute="BASIC_INFO_MODEL" method="POST" onsubmit="disablingSave()">
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
			                                            <form:input  path="data[${field.basicInfoDefinationDetailsId}_EC]" 
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
			                               <c:choose>
				                               <c:when test="${field.basicInfoDefinationDetailsId eq 49}">  
			                              			<c:if test="${field.isGP()}"> 
						                                <div class="col-sm-4">
						                                     <div class="form-group form-float">
						                                       <label class="form-label">State advisory Committee</label>
						                                       
						                                       		 <label for="yes">Yes</label>
						                                            <form:radiobutton path="data[${field.basicInfoDefinationDetailsId}_gp]" value="true" /> &nbsp;&nbsp;&nbsp;
						                                            <label for="yes">No</label>
						                                            <form:radiobutton path="data[${field.basicInfoDefinationDetailsId}_gp]" value="false" /> &nbsp;&nbsp;&nbsp;
						                                            
						                                          
						                                    </div>
						                                </div>
					                              </c:if> 
			                                <c:if test="${field.isBP()}">
			                                 	<div class="col-sm-4">
				                                     <div class="form-group form-float">
				                                       <label class="form-label">State Steering Committee</label>
				                                       
				                                       		 <label for="yes">Yes</label>
				                                            <form:radiobutton path="data[${field.basicInfoDefinationDetailsId}_bp]" value="true" /> &nbsp;&nbsp;&nbsp;
				                                            <label for="yes">No</label>
				                                            <form:radiobutton path="data[${field.basicInfoDefinationDetailsId}_bp]" value="false" /> &nbsp;&nbsp;&nbsp;
				                                            
				                                          
				                                    </div>
						                        </div>
			                               </c:if>
			                               <c:if test="${field.isDP()}">
				                                 <div class="col-sm-4">
				                                     <div class="form-group form-float">
				                                       <label class="form-label">State Executive Committee</label>
				                                       
				                                       		 <label for="yes">Yes</label>
				                                            <form:radiobutton path="data[${field.basicInfoDefinationDetailsId}_dp]" value="true" /> &nbsp;&nbsp;&nbsp;
				                                            <label for="yes">No</label>
				                                            <form:radiobutton path="data[${field.basicInfoDefinationDetailsId}_dp]" value="false" /> &nbsp;&nbsp;&nbsp;
				                                            
				                                          
				                                    </div>
				                                </div>
			                                </c:if>
			                                
			                                 			<div class="col-sm-4" >
				                                    		<div class="form-group form-float"  id="data49_gp_date_div" style="display: none;">&nbsp;&nbsp;&nbsp;
				                                    		 <label class="form-label">Date of Formation</label>
				                                       		 <div class="form-line">
				                                       		
				                                            <form:input type="date" class="form-control" max="2050-05-20" path="data[${field.basicInfoDefinationDetailsId}_gp_date]" />
				                                            
				                                            </div>
				                                            </div>
			                                			</div>
			                                 			<div class="col-sm-4" >
				                                    		<div class="form-group form-float" id="data49_bp_date_div" style="display: none;">&nbsp;&nbsp;&nbsp;
				                                    		<label class="form-label">Date of Formation</label>
				                                       		 <div class="form-line" >
				                                       		 
				                                            <form:input type="date" class="form-control" max="2050-05-20" path="data[${field.basicInfoDefinationDetailsId}_bp_date]" />
				                                            
				                                            </div>
				                                            </div>
			                               				 </div>
						                                 <div class="col-sm-4" >
					                                    		<div class="form-group form-float" id="data49_dp_date_div" style="display: none;">&nbsp;&nbsp;&nbsp;
					                                    		<label class="form-label">Date of Formation</label>
					                                       		 <div class="form-line" >
					                                       		 
					                                          	<form:input type="date" class="form-control" max="2050-05-20" path="data[${field.basicInfoDefinationDetailsId}_dp_date]" /> 
					                                            
					                                            </div>
					                                            </div>
						                       			 </div>
			                                
			                               </c:when>
			                               <c:otherwise>
			                                    <div class="col-sm-4">
			                                    <div class="form-group form-float">&nbsp;&nbsp;&nbsp;
			                                        <div class="">
			                                            <label for="yes">Yes</label>
			                                            <form:radiobutton path="data[${field.basicInfoDefinationDetailsId}_EC]" value="true" /> &nbsp;&nbsp;&nbsp;
			                                            <label for="yes">No</label>
			                                            <form:radiobutton path="data[${field.basicInfoDefinationDetailsId}_EC]" value="false" /> &nbsp;&nbsp;&nbsp;
			                                        </div>
			                                    </div>
			                                </div>
			                                </c:otherwise>
			                              </c:choose>
			                                
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
			                                            	<form:input  class="form-control validate" path="data[${field.basicInfoDefinationDetailsId}_ECNUM]" placeholder = "Order Number" maxlength="60"/> &nbsp;&nbsp;&nbsp;
			                                    		</div>
			                                		</div>
			                            		</div>
			                                 
			                                	<div class="col-sm-4">
			                                    	<div class="form-group form-float">&nbsp;&nbsp;&nbsp;
			                                        	<div class="form-line">
			                                            	<form:input type="date" class="form-control" path="data[${field.basicInfoDefinationDetailsId}_ECDATE]" /> &nbsp;&nbsp;&nbsp;
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
                             		<button type="submit" class="btn bg-green waves-effect save-button">SAVE</button>
                                	 
                                	<button type="button" onclick="onClose('home.html?<csrf:token uri='home.html'/>')"  class="btn bg-orange waves-effect">CLOSE</button>
                               </div>
                        </div>
                        </form:form>
                    </div>
                </div>
            </div>
        </div>
    </section>
