
<%@include file="../taglib/taglib.jsp"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/dataTables/css/dataTables.bootstrap.min.css">
<script  type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/dataTables/js/jquery.dataTables.js"></script>
<script  type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/dataTables/js/dataTables.bootstrap.min.js"></script>
<script type="text/javascript" 	src="${pageContext.request.contextPath}/DWR/interface/lgdService.js"></script>
<script>
var locatedAtLevel = '${locatedAtLevel}';
var stateCode = '${stateCode}';
var entityCode = '${entityCode}';
$( document ).ready(function() {
	if(stateCode == 11 || stateCode == 14 || stateCode == 31 || stateCode == 30 || stateCode == 25 || stateCode == 26){
	if(locatedAtLevel == 0){
		$("#dpDiv").removeClass('hidden').addClass('show');
		getDistrict(stateCode);
	}
	if(locatedAtLevel == 1 || locatedAtLevel == 100){
		$("#gpDiv").removeClass('hidden').addClass('show');
		getGPData(entityCode)
	}
	
	/* if(locatedAtLevel == 2){
		$("#gpDiv").removeClass('hidden').addClass('show');
		getGPData(entityCode)
	} */
	}
	else if(stateCode == 18 || stateCode == 16){
		$("#tierDiv").removeClass('hidden').addClass('show');
		
		
	}
	else if(stateCode == 34){
		if(locatedAtLevel == 0){
			$("#bpDiv").removeClass('hidden').addClass('show');
			getDistrict(stateCode);
		}	
	}
	else if(stateCode == 17 || stateCode == 15 || stateCode ==13 ){
		if(locatedAtLevel == 0  && stateCode != 0){
			$("#dpDiv").removeClass('hidden').addClass('show');
			getDistrict(stateCode);
		}
		if((locatedAtLevel == 1 || locatedAtLevel == 100) && stateCode != 0){
			$("#bpDiv").removeClass('hidden').addClass('show');
			getBlock(entityCode);
		}
		if((locatedAtLevel == 2 || locatedAtLevel == 101) && stateCode != 0){
			$("#gpDiv").removeClass('hidden').addClass('show');
			getGPData(entityCode)
		}
		
	}
	else{
		if(locatedAtLevel == 0  && stateCode != 0){
			$("#dpDiv").removeClass('hidden').addClass('show');
			getDistrict(stateCode);
		}
		if((locatedAtLevel == 1 || locatedAtLevel == 100) && stateCode != 0){
			$("#bpDiv").removeClass('hidden').addClass('show');
			getBlock(entityCode);
		}
		
		if((locatedAtLevel == 2 || locatedAtLevel == 101) && stateCode != 0){
			$("#gpDiv").removeClass('hidden').addClass('show');
			getGPData(entityCode)
		}
	}
	
	
});
 
 /* added by Ajit */
 
function getDistrict(stateCode){
     if(stateCode == 34){
		
			lgdService.findLocalBodyByStateCodeAndTypeCode(parseInt(stateCode),2,{
				callback:function(data) {			  
					if(data!=null) {
								 
			            dwr.util.addOptions('bpCode', data,'localBodyCode','localBodyNameEnglish');						
					}else
					  {
					  	 alert("BP Not Found !");
					  }
				}
		       ,preHook:function() {$(".process").fadeIn(500); },
				postHook:function() { $(".process").fadeOut();},
				timeout:50000,
				async:false,
				errorHandler:function(message) { alert("Oops: " + message);} 
			});
     }
     else if(stateCode == 17 || stateCode == 15 || stateCode == 13){
    	 lgdService.findEntityDataByStateCode(parseInt(stateCode),{
				callback:function(data) {			  
					if(data!=null) {
								 
			            dwr.util.addOptions('dpCode', data,'entityCode','entityNameEnglish');						
					}else
					  {
					  	 alert("BP Not Found !");
					  }
				}
		       ,preHook:function() {$(".process").fadeIn(500); },
				postHook:function() { $(".process").fadeOut();},
				timeout:50000,
				async:false,
				errorHandler:function(message) { alert("Oops: " + message);} 
			});
    	 
     }
    /*  else if(stateCode == 17){
    	 lgdService.findVillageByStateCode(parseInt(stateCode),{
				callback:function(data) {			  
					if(data!=null) {
								 
			            dwr.util.addOptions('gpCode', data,'entityCode','entityNameEnglish');						
					}else
					  {
					  	 alert("BP Not Found !");
					  }
				}
		       ,preHook:function() {$(".process").fadeIn(500); },
				postHook:function() { $(".process").fadeOut();},
				timeout:50000,
				async:false,
				errorHandler:function(message) { alert("Oops: " + message);} 
			});
    	 
     }
     else if(stateCode == 15){
    	 lgdService.findLBdetailByStateAndTypeCode(parseInt(stateCode),11,{
				callback:function(data) {			  
					if(data!=null) {
								 
			            dwr.util.addOptions('gpCode', data,'localBodyCode','localBodyNameEnglish');						
					}else
					  {
					  	 alert("BP Not Found !");
					  }
				}
		       ,preHook:function() {$(".process").fadeIn(500); },
				postHook:function() { $(".process").fadeOut();},
				timeout:50000,
				async:false,
				errorHandler:function(message) { alert("Oops: " + message);} 
			});
    	 
     }
     else if(stateCode == 13){
    	 lgdService.findLBdetailByStateAndTypeCode(parseInt(stateCode),12,{
				callback:function(data) {			  
					if(data!=null) {
								 
			            dwr.util.addOptions('gpCode', data,'localBodyCode','localBodyNameEnglish');						
					}else
					  {
					  	 alert("BP Not Found !");
					  }
				}
		       ,preHook:function() {$(".process").fadeIn(500); },
				postHook:function() { $(".process").fadeOut();},
				timeout:50000,
				async:false,
				errorHandler:function(message) { alert("Oops: " + message);} 
			});
    	 
     } */
     else{
    	 lgdService.findLocalBodyByStateCodeAndTypeCode(parseInt(stateCode),1,{
				callback:function(data) {			  
					if(data!=null) {								 
			            dwr.util.addOptions('dpCode', data,'localBodyCode','localBodyNameEnglish');						
					}else
					  {
					  	 alert("DP Not Found !");
					  }
				}
		       ,preHook:function() {$(".process").fadeIn(500); },
				postHook:function() { $(".process").fadeOut();},
				timeout:50000,
				async:false,
				errorHandler:function(message) { alert("Oops: " + message);} 
			});
    	
     }

}
function getBlock(code){
	if(stateCode == 17 || stateCode == 15 || stateCode == 13){
		 lgdService.findBlockByDistrictCode(parseInt(code),{
				callback:function(data) {			  
					if(data!=null) {		 
			            dwr.util.addOptions('bpCode', data,'entityCode','entityNameEnglish');						
					}else
					  {
					  	 alert("Block Not Found !");
					  }
				}
		       ,preHook:function() {$(".process").fadeIn(500); },
				postHook:function() { $(".process").fadeOut();},
				timeout:50000,
				async:false,
				errorHandler:function(message) { alert("Oops: " + message);} 
			});	
	 }
else{
  if(locatedAtLevel == 100){
	 lgdService.findBlockByDistrictCode(parseInt(code),{
		callback:function(data) {			  
			if(data!=null) {		 
	            dwr.util.addOptions('bpCode', data,'entityCode','entityNameEnglish');						
			}else
			  {
			  	 alert("BP Not Found !");
			  }
		}
       ,preHook:function() {$(".process").fadeIn(500); },
		postHook:function() { $(".process").fadeOut();},
		timeout:50000,
		async:false,
		errorHandler:function(message) { alert("Oops: " + message);} 
	});	
 }
 else{ 
	 lgdService.findParentLocalBodyCode(parseInt(code),{
			callback:function(data) {			  
				if(data!=null) {		 
		            dwr.util.addOptions('bpCode', data,'localBodyCode','localBodyNameEnglish');						
				}else
				  {
				  	 alert("BP Not Found !");
				  }
			}
	       ,preHook:function() {$(".process").fadeIn(500); },
			postHook:function() { $(".process").fadeOut();},
			timeout:50000,
			async:false,
			errorHandler:function(message) { alert("Oops: " + message);} 
		});	
	 }
 }
 } 

function getGPData(code){
	if(stateCode == 17){
		 lgdService.findVillageByBlockCode(parseInt(code),{
				callback:function(data) {			  
					if(data!=null) {		 
			            dwr.util.addOptions('gpCode', data,'entityCode','entityNameEnglish');						
					}else
					  {
					  	 alert("GP Not Found !");
					  }
				}
		       ,preHook:function() {$(".process").fadeIn(500); },
				postHook:function() { $(".process").fadeOut();},
				timeout:50000,
				async:false,
				errorHandler:function(message) { alert("Oops: " + message);} 
			}); 
	 }
	else if(stateCode == 15 || stateCode == 13){
		lgdService.findGramPanchayatByChildEntityCode(parseInt(code),{
			callback:function(data) {			  
				if(data!=null) {		 
		            dwr.util.addOptions('gpCode', data,'entityCode','entityNameEnglish');						
				}else
				  {
				  	 alert("GP Not Found !");
				  }
			}
	       ,preHook:function() {$(".process").fadeIn(500); },
			postHook:function() { $(".process").fadeOut();},
			timeout:50000,
			async:false,
			errorHandler:function(message) { alert("Oops: " + message);} 
		});
	}
   else{
	if(locatedAtLevel == 100 || locatedAtLevel == 101){
	lgdService.findGramPanchayatByChildEntityCode(parseInt(code),{
		callback:function(data) {			  
			if(data!=null) {		 
	            dwr.util.addOptions('gpCode', data,'entityCode','entityNameEnglish');						
			}else
			  {
			  	 alert("GP Not Found !");
			  }
		}
       ,preHook:function() {$(".process").fadeIn(500); },
		postHook:function() { $(".process").fadeOut();},
		timeout:50000,
		async:false,
		errorHandler:function(message) { alert("Oops: " + message);} 
	});
	}
	else{
		lgdService.findParentLocalBodyCode(parseInt(code),{
			callback:function(data) {			  
				if(data!=null) {		 
		            dwr.util.addOptions('gpCode', data,'localBodyCode','localBodyNameEnglish');						
				}else
				  {
				  	 alert("GP Not Found !");
				  }
			}
	       ,preHook:function() {$(".process").fadeIn(500); },
			postHook:function() { $(".process").fadeOut();},
			timeout:50000,
			async:false,
			errorHandler:function(message) { alert("Oops: " + message);} 
		});
	}
		
	}
}

function getTlbData(obj){
	lgdService.findTierSetupByStateCategory(parseInt(stateCode),'T',{
		callback:function(data) {			  
			if(data!=null) {		 
	            dwr.util.addOptions('tlbCode', data,'localBodyTypeCode','localbodytypename');						
			}else
			  {
			  	 alert("GP Not Found !");
			  }
		}
       ,preHook:function() {$(".process").fadeIn(500); },
		postHook:function() { $(".process").fadeOut();},
		timeout:50000,
		async:false,
		errorHandler:function(message) { alert("Oops: " + message);} 
	});
	
}

function getLocalBodyType(obj){
	lgdService.findLBdetailByStateAndTypeCode(parseInt(stateCode),parseInt(obj),{
		callback:function(data) {			  
			if(data!=null) {
						 
	            dwr.util.addOptions('gpCode', data,'localBodyCode','localBodyNameEnglish');						
			}else
			  {
			  	 alert("BP Not Found !");
			  }
		}
       ,preHook:function() {$(".process").fadeIn(500); },
		postHook:function() { $(".process").fadeOut();},
		timeout:50000,
		async:false,
		errorHandler:function(message) { alert("Oops: " + message);} 
	});
}

function showHide(obj){
/* 	var gp = $('#bpCode').val(0);
	var gp = $('#gpCode').val(0); */
	$("#gpCode option").remove();
	$("#gpCode").append("<option value='0'>SELECT</option>");
	$("#bpCode option").remove();
	$("#bpCode").append("<option value='0'>SELECT</option>");
	$("#gpDiv").removeClass('show').addClass('hidden');
	if(stateCode == 11 || stateCode == 14 || stateCode == 31 || stateCode == 30 || stateCode == 25 || stateCode == 26){
		$("#gpDiv").removeClass('hidden').addClass('show');
		getGPData(obj);
 }
	else{
		$("#bpDiv").removeClass('hidden').addClass('show');
		getBlock(obj);
	}
}
function showHide1(obj){
	/* var gp = $('#gpCode').val(0); */
	$("#gpCode option").remove();
	$("#gpCode").append("<option value='0'>SELECT</option>");
	$("#gpDiv").removeClass('hidden').addClass('show');
	getGPData(obj);
	
 }
function showHide3(obj){
	/* var tier = obj.value; */
	if(obj == "P"){
		$("#tlbCode option").remove();
		$("#tlbCode").append("<option value='0'>SELECT</option>");
		$("#tlbDiv").removeClass('show').addClass('hidden');
		$("#gpCode option").remove();
		$("#gpCode").append("<option value='0'>SELECT</option>");
		$("#gpDiv").removeClass('show').addClass('hidden');
		if(stateCode == 11 || stateCode == 14 || stateCode == 31 || stateCode == 30 || stateCode == 25 || stateCode == 26){
			if(locatedAtLevel == 0){
				$("#dpDiv").removeClass('hidden').addClass('show');
				getDistrict(stateCode);
			}
			if(locatedAtLevel == 1 || locatedAtLevel == 100){
				$("#gpDiv").removeClass('hidden').addClass('show');
				getGPData(entityCode)
			}
			}
		else{
			if(locatedAtLevel == 0  && stateCode != 0){
				$("#dpDiv").removeClass('hidden').addClass('show');
				getDistrict(stateCode);
			}
			if((locatedAtLevel == 1 || locatedAtLevel == 100) && stateCode != 0){
				$("#bpDiv").removeClass('hidden').addClass('show');
				getBlock(entityCode);
			}
			
			if((locatedAtLevel == 2 || locatedAtLevel == 101) && stateCode != 0){
				$("#gpDiv").removeClass('hidden').addClass('show');
				getGPData(entityCode)
			}
		}
		
	}
	else{
		$("#gpDiv").removeClass('show').addClass('hidden');
		$("#dpDiv").removeClass('show').addClass('hidden');
		$("#bpDiv").removeClass('show').addClass('hidden');
		$("#bpCode option").remove();
		$("#bpCode").append("<option value='0'>-- Please select --</option>");
		$("#dpCode option").remove();
		$("#dpCode").append("<option value='0'>SELECT</option>");
		$("#gpCode option").remove();
		$("#gpCode").append("<option value='0'>SELECT</option>");
		$("#tlbDiv").removeClass('hidden').addClass('show');
		getTlbData(obj);
	}
	
}

function showHide2(obj){
	$("#gpCode option").remove();
	$("#gpCode").append("<option value='0'>SELECT</option>");
	$("#gpDiv").removeClass('hidden').addClass('show');
	getLocalBodyType(obj);
}
 
 
 /* end */

function ValidateFileUpload(){
	 
	var gp = $('#gpCode').val();
	if(locatedAtLevel != 3 && locatedAtLevel != 11 && locatedAtLevel != 12 && locatedAtLevel != 102){
	if(gp == null || gp == 0){
		swal({
	        title: "Please Select Village/Gram Panchayat.",
	        type: "warning",
	        confirmButtonColor: "#FF9800",
	        confirmButtonText: "Ok",
	        closeOnCancel: true
	    });
		return false;
	}
	}
	if(!$("input:radio[name='uploadType']").is(":checked")) {
		swal({
	        title: "Please Select Upload image type.",
	        type: "warning",
	        confirmButtonColor: "#FF9800",
	        confirmButtonText: "Ok",
	        closeOnCancel: true
	    });
		return false;
	}else{
		var i=0;
		$(".imgg").each(function() {
	        var FileUploadPath =$(this).val();
			var Extension = FileUploadPath.substring(FileUploadPath.lastIndexOf('.') + 1).toLowerCase();
	
			if ( Extension == "png" || Extension == "jpeg" || Extension == "jpg") {
				i++;	
				if(FileUploadPath.files[0].size>5242880) {
					swal({
				        title: "Image size must not be more than 5 MB.",
				        type: "warning",
				        confirmButtonColor: "#FF9800",
				        confirmButtonText: "Ok",
				        closeOnCancel: true
				    });
					$(this).val('');
					return false;
				}
			
	        }else {
					swal({
				        title: "Photo only allows file types of  PNG, JPG,and JPEG .",
				        type: "warning",
				        confirmButtonColor: "#FF9800",
				        confirmButtonText: "Ok",
				        closeOnCancel: true
				    });
					$(this).val('');
					return false;
		        }
		});
		if(i==0){
			swal({
		        title: "Please Select atleast 1 Image.",
		        type: "warning",
		        confirmButtonColor: "#FF9800",
		        confirmButtonText: "Ok",
		        closeOnCancel: true
		    });
			return false;
		}
	}
	return true;
}
function clone(){
	var i=$(".imgg").length;
	i++;
	 if($(".imgg").length<5){
		 var html=$('#imageRow').html();
		 html2=html.replace("plus","minus")
		 html2=html2.replace("btn waves-effect bg-primary","btn bg-danger");
		 html2=html2.replace("clone()","remove("+i+")");
		 
		 $('#multiImage').append("<div class='row' id=im"+i+">"+html2+"</div>");
	 }
	
	
}
function remove(id){
	var rm='im'+id;
	$('#'+rm).remove();
	
}
function validateImage(image){
	 var FileUploadPath = image.value;
	 if(FileUploadPath!=""){
		var Extension = FileUploadPath.substring(FileUploadPath.lastIndexOf('.') + 1).toLowerCase();

		if ( Extension == "png" || Extension == "jpeg" || Extension == "jpg") {
			if(image.files[0].size>5242880) {
				swal({
			        title: "Image size must not be more than 5 MB.",
			        type: "warning",
			        confirmButtonColor: "#FF9800",
			        confirmButtonText: "Ok",
			        closeOnCancel: true
			    });
				image.value="";
				return false;
			}
    	 }else {
				swal({
			        title: "Photo only allows file types of  PNG, JPG,and JPEG .",
			        type: "warning",
			        confirmButtonColor: "#FF9800",
			        confirmButtonText: "Ok",
			        closeOnCancel: true
			    });
				image.value="";
				return false;
	        }
	 }
}


</script>

    <section class="content">
        <div class="container-fluid">
          
           <div class="row clearfix">
                <!-- Table example -->
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <div class="card">
                        <div class="header">
                            <h2>Upload Image</h2>
                        </div>
                        <div class="body">
                         <form:form modelAttribute="UPLOAD" method="post" class="form-horizontal" action="uploadImage.html" enctype="multipart/form-data">
                        
                        <input type="hidden" name='<csrf:token-name/>' value='<csrf:token-value uri="uploadImage.html"/>' />
                        <%-- <c:if test="${locatedAtLevel==0}"> --%>
                        
                    <%--      <div class="row hidden" id ="tierDiv">
							    <div class="col-lg-2 hidden-xs hidden-sm hidden-md"></div>
									<div class="col-lg-2 col-xs-8">
									<label for="State"><spring:message code="Select Tier Levels" htmlEscape="true" /></label>
									</div>
									<div class="col-lg-4 col-xs-8">
				                        <form:select path="" id="tierCode" class="form-control" onchange="showHide3(this.value)">	
	                                    <option value="0">SELECT</option>
	                                    <option value="P">RLB</option>
	                                    <option value="T">TLB</option>	                                	                                  
	                                    </form:select>
									</div>
						<div class="col-lg-2 hidden-xs hidden-sm hidden-md"></div>
						    </div> 
						     <div class="row hidden" id ="tlbDiv">
							    <div class="col-lg-2 hidden-xs hidden-sm hidden-md"></div>
									<div class="col-lg-2 col-xs-8">
									<label for="State"><spring:message code="TLB Levels" htmlEscape="true" /></label>
									</div>
									<div class="col-lg-4 col-xs-8">
				                        <form:select path="" id="tlbCode" class="form-control" onchange="showHide2(this.value)">	
	                                    <option value="0">SELECT</option>                               	                                  
	                                    </form:select>
									</div>
						<div class="col-lg-2 hidden-xs hidden-sm hidden-md"></div>
						    </div>
						    
                        <div class="row hidden" id="dpDiv">
							    <div class="col-lg-2 hidden-xs hidden-sm hidden-md"></div>
									<div class="col-lg-2 col-xs-8">
									<c:choose>
                                        <c:when test="${stateCode == 17 || stateCode == 15 || stateCode == 13}">
                                        <label for="State"><spring:message code="District" htmlEscape="true" /></label>
                                        </c:when>
                                        <c:otherwise>
                                        <label for="State"><spring:message code="District Panchayat" htmlEscape="true" /></label>
                                         </c:otherwise>
                                    </c:choose>
									
									</div>
									<div class="col-lg-4 col-xs-8">
				                        <form:select path="dpCode" id="dpCode" class="form-control" onchange="showHide(this.value)">	
	                                    <option value="0">SELECT</option>		
	                                    <c:forEach items="${DP_LIST}" var="data">
	                                    <option value="${data.localBodyCode}"><esapi:encodeForHTML>${data.localBodyNameEnglish}</esapi:encodeForHTML> </option>      
	                                    </c:forEach>
	                                    </form:select>
									</div>
						<div class="col-lg-2 hidden-xs hidden-sm hidden-md"></div>
						    </div>
						    </c:if>
						    <c:if test="${locatedAtLevel==2}">
						    <div class="row hidden" id="bpDiv">
							    <div class="col-lg-2 hidden-xs hidden-sm hidden-md"></div>
									<div class="col-lg-2 col-xs-8">
									<c:choose>
                                        <c:when test="${stateCode == 17 || stateCode == 15 || stateCode == 13}">
                                        <label for="State"><spring:message code="Block" htmlEscape="true" /></label>
                                        </c:when>
                                        <c:otherwise>
                                        <label for="State"><spring:message code="Block Panchayat" htmlEscape="true" /></label>
                                         </c:otherwise>
                                    </c:choose>
									
									</div>
									<div class="col-lg-4 col-xs-8">
				                        <form:select path="bpCode" id="bpCode" class="form-control" onchange="showHide1(this.value)">	
	                                    <option value="0">SELECT</option>	
	                                    <c:forEach items="${LIST}" var="data">
	                                        <option value="${data.localBodyCode}"><esapi:encodeForHTML>${data.localBodyNameEnglish}</esapi:encodeForHTML> </option>      
	                                    </c:forEach>	                                	                                  
	                                    </form:select>
									</div>
						<div class="col-lg-2 hidden-xs hidden-sm hidden-md"></div>
						    </div>
						    </c:if>
						    <c:if test="${locatedAtLevel==3}">
						     <div class="row hidden" id="gpDiv">
							    <div class="col-lg-2 hidden-xs hidden-sm hidden-md"></div>
									<div class="col-lg-2 col-xs-8">
									<c:if test="${stateCode==17}">
									<label for="State"><spring:message code="Village" htmlEscape="true" /></label>
									</c:if>
									<c:if test="${stateCode==13}">
									<label for="State"><spring:message code="Village Development Board" htmlEscape="true" /></label>
									</c:if>
									<c:if test="${stateCode==15}">
									<label for="State"><spring:message code="Village Council" htmlEscape="true" /></label>
									</c:if>
									<c:if test="${stateCode==16 || stateCode == 18}">
									<label for="State"><spring:message code="Select Localbody Type / Gram Panchayat" htmlEscape="true" /></label>
									</c:if>
									<c:if test="${stateCode != 13 && stateCode != 15 && stateCode != 17 && stateCode != 16 && stateCode != 18 }">
									<label for="State"><spring:message code="Gram Panchayat" htmlEscape="true" /></label>
									</c:if>
									</div>
									<div class="col-lg-4 col-xs-8">
				                        <form:select path="gpCode" id="gpCode" class="form-control">	
	                                    <option value="0">SELECT</option>
	                                    <c:forEach items="${LIST}" var="data">
	                                        <option value="${data.localBodyCode}"><esapi:encodeForHTML>${data.localBodyNameEnglish}</esapi:encodeForHTML> </option>      
	                                    </c:forEach>			                                  
	                                    </form:select>
									</div>
						<div class="col-lg-2 hidden-xs hidden-sm hidden-md"></div>
						    </div> --%>
						    <%-- </c:if> --%>
                         
						  
						  <div class="row">
							    <div class="col-lg-2 hidden-xs hidden-sm hidden-md"></div>
									<div class="col-lg-2 col-xs-8">
									<label for="State"><spring:message code="Select State" htmlEscape="true" /></label>
									</div>
									<div class="col-lg-4 col-xs-8">
				                        <form:select path="stateCode" id="stateCode" class="form-control" onchange="showHide3(this.value)">	
	                                   
	                                   
	                                    <option value="0">SELECT</option>
	                                   <c:forEach items="${STATE}"  var ="state">
		                                    <option value="${state.stateCode}">${state.stateNameEnglish}</option>
	                                    </c:forEach>                       	                                  
	                                    </form:select>
									</div>
									
									
						<div class="col-lg-2 hidden-xs hidden-sm hidden-md"></div>
						    </div> 
						    
						     <div class="row">
								<div class="form-group">
							
			                    <div class="col-lg-4 col-xs-12 notification-radio">
									<input type="radio" name="uploadType" value="W" checked> Photo of Training/Workshop
			                    </div>
			                    
			                     <div class="col-lg-4 col-xs-12 notification-radio">
									<input type="radio" name="uploadType" value="R"> Photo of RGSA components<br>
			                    
			                    </div>
			                    
			                    
			                 </div>   
								 <div class="mandatory"><form:errors path="uploadType" htmlEscape="true"/></div>
						  </div> 
						  <div class="row">
							  	
									<div class="col-lg-4 col-xs-12">
									 	<label for="">Photo</label>	
	                                </div>
	                                <div class="col-lg-3 col-xs-12">
									 	<label for="">Remarks</label>		
	                                </div>
	                                 <div class="col-lg-3 col-xs-12">
									 	<label for="">Testimonial</label>	
	                                </div>
	                                  <div class="col-lg-2 col-xs-12" id="btnn">
									 	
	                                  </div>
	                               
							  </div>
						  <div id="multiImage">
							  <div class="row" id="imageRow">
							  	
									<div class="col-lg-4 col-xs-12">
									 	<input type="file" id=pibImageId0 name="pibImageId" class="btn bg-green waves-effect imgg" onchange="validateImage(this)"/>	
	                                </div>
	                                <div class="col-lg-3 col-xs-12">
									 	<input type="text" id=webRemarks name="webRemarks" placeholder="Remark" class="form-control"/>	
	                                </div>
	                                 <div class="col-lg-3 col-xs-12">
									 	<input type="text" id="webTestimonials" name="webTestimonials"  placeholder="Testimonial" class="form-control"/>	
	                                </div>
	                                  <div class="col-lg-2 col-xs-12" id="btnn">
									 	<button type='button' class='btn waves-effect bg-primary' id='add' onclick='clone()'><i class="fa fa-plus"></i></button>	
	                                  </div>
	                               
							  </div>
						  </div>
						  
						  <div class="form-group text-right">
                            	<button type="submit"  class="btn bg-green waves-effect">SAVE</button>
                            	<button type="button" onclick="onClear(this)" class="btn bg-light-blue waves-effect">CLEAR</button>
                               	<button type="button" onclick="onClose('home.html?<csrf:token uri='home.html'/>')"  
                               	class="btn bg-orange waves-effect">CLOSE</button>
                         </div>
						  
						
						  
						  </form:form>
	                        
                        </div>
                    </div>
                </div>
                <!-- #END# Table example -->
            </div>
        </div>
    </section>