<%@include file="../taglib/taglib.jsp"%>
<script type="text/javascript" 	src="${pageContext.request.contextPath}/DWR/interface/userService.js"></script>  

<script type="text/javascript">



function clearType(stateCode){
	$("#documentTypeId").val(0);
	
}
function fileValidation(){
	var flag=true;	
    var fileInput = document.getElementById('attachId').value;
   
    if(fileInput!=null && fileInput.trim()!=""){
    	
	    var filePath = fileInput;
	    var allowedExtensions = /(\.pdf|\.ppt|\.pptx|\.doc|\.docx|\.jpeg|\.jpg|\.zip)$/i;
	    if(!allowedExtensions.exec(filePath)){
	        alert('Please upload file having extensions .pdf or .ppt only.');
	        fileInput.value = '';
	        flag = false;
	    }
	    return flag;
    }else{    	
    	flag=true;
    	return flag;
    }
}
 
function submitForm(obj){

	var isValid=validateForm();
	if(isValid)
	{
		obj.disabled=true; 
		obj.value='Please Wait .!';
		
		form.action="addCms.html?<csrf:token uri='addCms.html'/>";
		form.method="post";
		form.submit(); 
	}
}

	function validateForm(){	
		var flag=true;	
	
		var documentType=document.getElementById('documentTypeId').value;
		if(documentType==0){
			alert("Please select document type");
			flag = false;
		}
		
		var fileTitle=document.getElementById('fileTitleId').value;
		if(fileTitle==''){
			alert("Please enter File Title");
			flag = false;
		}	
		return flag;
	}
	
</script>
    <section class="content">
        <div class="container-fluid">
             <div class="row clearfix">
                <!-- Table example -->
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <div class="card">
                        <div class="header">
                            <h2>Add CMS</h2>
                        </div>                                               
                        <form:form action="addCms.html" method="post" modelAttribute="Cms_Model" id="form" autocomplete="off" enctype="multipart/form-data">
                         <input type="hidden" name='<csrf:token-name/>' value='<csrf:token-value uri="addCms"/>'/>  
                        	<div class="body">
                        		
					            <c:if test="${StateId eq 0 }">
						            <label for="Select State" class="control-label">
						                <spring:message code="Select State" htmlEscape="true" />
						            </label>
							        <div class="form-group">
							            <div class="form-line">
							                <form:select path="stateCode" id="stateCodeId" class="form-control" onchange="clearType(this.value)">
							                    <option value="0">SELECT</option>
							                    <c:forEach items="${STATE_LIST}" var="statelist">
							                        <option value="${statelist.stateCode}">
							                            <esapi:encodeForHTML>${statelist.stateNameEnglish}</esapi:encodeForHTML>
							                        </option>
							                    </c:forEach>
							                </form:select>
							            </div>
							            <div class="mandatory">
							                <form:errors path="stateCode" htmlEscape="true" />
							            </div>
							        </div>
						        </c:if>
						          
						        <label for="UserType" class="control-label">
					                <spring:message code="Document Type" htmlEscape="true" /><span class="mandatory">*</span>
						        </label>
						        <div class="form-group">
						            <div class="form-line">
						                <form:select path="documentType" id="documentTypeId" class="form-control">
						                    <option value="0">SELECT</option>
						                    <c:forEach items="${DOCUMENT_TYPE_LIST}" var="typelist">
						                        <option value="${typelist.typeId}">
						                            <esapi:encodeForHTML>${typelist.name}</esapi:encodeForHTML>
						                        </option>
						                    </c:forEach>
						                </form:select>
						            </div>
						            <div class="mandatory">
						                <form:errors path="documentType" htmlEscape="true" />
						            </div>
						        </div>
						        <label for="titleId" class="control-label">
					                <spring:message code="File Title" htmlEscape="true" /><span class="mandatory">*</span>
					            </label>
						        <div class="form-group">
						            <div class="form-line">
						                <form:input path="fileTitle" class="form-control" id="fileTitleId" placeholder="File Title" />
						            </div>
						            <div class="mandatory">
						                <form:errors path="fileTitle" htmlEscape="true" />
						            </div>
						        </div>
						        <label for="titleId" class="control-label">
					                <spring:message code="Attach File" htmlEscape="true" />
					            </label>
						        <div class="form-group">
						        	<div class="form-line">
						            	<input type="file" id="attachId" name="attach">
						            </div>
						             <div class="mandatory">
							            <form:errors path="attach" htmlEscape="true" />
							        </div>	
						        </div>
						        <div class="form-group text-right">
						            <button type="button" class="btn bg-green waves-effect" onclick="return submitForm(this);">SAVE</button>
						            
						            <button type="button" onclick="onClose('home.html?<csrf:token uri='home.html'/>')" class="btn bg-orange waves-effect">CLOSE</button>
						        </div>
						    </div>          
                        </form:form>
                    </div>
                </div>
            </div> 
        </div>
    </section>