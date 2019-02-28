<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="../taglib/taglib.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

 <script type="text/javascript">


 
$( document ).ready(function() {
	$(".validate").keypress(function (e) {
	    //if the letter is not digit then display error and don't type anything
	    if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
	       //display error message
	       $("#errmsg").html("Digits Only").show().fadeOut("slow");
	              return false;
	   }
	  });
});

/* 
function ValidateEmail() 
{
 if (/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(myForm.emailAddr.value))
  {
    return (true)
  }
    alert("You have entered an invalid email address!")
    return (false)
}
 */



</script>

</head>

<body>
	<section class="content">
		<div class="container-fluid" >
			<div class="block-header">
				<h2></h2>
			</div>
				<input type="hidden" name="<csrf:token-name/>"
					value="<csrf:token-value uri="changepassword.html"/>" />
				
				<div class="row clearfix">
					<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
						<div class="card">
							<div class="header">
							<h2>Nodal Officer Details</h2>
							
							</div>
							<form action="nodalOfficerDetailsSave.html" modelAttribute="SAVE_NODAL_DETAILS" method="POST" id ="myForm">
							<input type="hidden" name="<csrf:token-name/>" value="<csrf:token-value uri="nodalOfficerDetailsSave.html"/>" />
								
							<div class="panel-group" id="accordion">
							<input type="hidden" name="nodalOfficerId" value="${nodalOfficerDetails.nodalOfficerId}">
                             
                                  <div class="panel-heading">
                                      <h4 class="panel-title">
                                        
                                            State  Nodal Officer 
                                               </h4>
                                     </div>
                                     <div class="panel-body">
                                    <div class="body">
                                    <div class="col-md-4">
									<label for="old_password">Nodal Officer Name</label>
									</div>
									<div class="form-group">
									<div class="col-md-6">
										<div class="form-line">
										
												<input type="text"  class="form-control" name="nodalOfficerName" maxlength="100" oninvalid="this.setCustomValidity('Enter Nodal Officer Name  ')" oninput="setCustomValidity('')" value="${nodalOfficerDetails.nodalOfficerName}" required>
										</div>
										</div>
									</div>
									<div class="col-md-4">
									<label for="new_password">Designation</label></div>
									<div class="form-group">
									<div class="col-md-6">
										<div class="form-line">
											<input type="text" class="form-control" name="nodalOfficerDesignation" maxlength="50" oninvalid="this.setCustomValidity('Enter Nodal Officer Designation  ')" oninput="setCustomValidity('')" value="${nodalOfficerDetails.nodalOfficerDesignation}" required>
										</div>
										</div>
									</div>
									<div class="col-md-4">
									<label for="password2">Email-Id</label>
									</div>
									<div class="form-group">
									<div class="col-md-6">
										<div class="form-line">
											<input type="text" class="form-control" maxlength="50" required pattern="[^@]+@[^@]+\.[a-zA-Z]{2,6}"  name="nodalOfficerEmailId" value="${nodalOfficerDetails.nodalOfficerEmailId}" required>
										</div>
										</div>
									</div>
									<div class="col-md-4">
									<label for="password2">Mobile Number</label>
									</div>
									<div class="form-group">
									<div class="col-md-6">
										<div class="form-line">
											<input type="text" class="form-control validate" oninvalid="this.setCustomValidity('EnterMobile Number ')" oninput="setCustomValidity('')" name="nodalOfficerMobileNumber" maxlength="10" value="${nodalOfficerDetails.nodalOfficerMobileNumber}" required>
										</div>
										</div>
									</div>
									</div>
                                  </div>
                                 </div>
                             
							
							<!-- <div class="panel panel-default"> -->
                                <div class="panel-heading">
                                     <h4 class="panel-title">
                                        PMU  Nodal Officer
                                     </h4>
                                </div>
                                   
                                    
                                      <div class="panel-body">
                                         <div class="body">
									<div class="col-md-4">
									<label for="new_password">Designation</label>
									</div>
									<div class="form-group">
									<div class="col-md-6">
										<div class="form-line">
											<input type="text" class="form-control" maxlength="100" oninvalid="this.setCustomValidity('Enter Designation  ')" oninput="setCustomValidity('')" name="pmuDesignation" value="${nodalOfficerDetails.pmuDesignation}" required>
										</div>
										</div>
									</div>
									<div class="col-md-4">
									<label for="password2">Email-Id</label>
									</div>
									<div class="form-group">
									<div class="col-md-6">
										<div class="form-line">
											<input type="text" class="form-control" maxlength="50" required pattern="[^@]+@[^@]+\.[a-zA-Z]{2,6}" name="pmuEmailId" value="${nodalOfficerDetails.pmuEmailId}" required>
										</div>
										</div>
									</div>
									<div class="col-md-4">
									<label for="password2">Mobile Number</label>
									</div>
									<div class="form-group">
									<div class="col-md-6">
										<div class="form-line">
											<input type="text" class="form-control validate"  oninvalid="this.setCustomValidity('Enter Mobile Number ')" oninput="setCustomValidity('')" name="pmuMobileNumber" maxlength="10" value="${nodalOfficerDetails.pmuMobileNumber}" required>
										</div>
										</div>
									</div>
									</div>
									</div>
     
  
 
  
				  <!-- <div class="panel panel-default"> -->
                       <div class="panel-heading">
                          <h4 class="panel-title">
                           DAC  Nodal Officer 
                          </h4>
                         </div>
                    
                         <div class="panel-body">
      
                             <div class="body">
								<div class="col-md-4">
									<label for="new_password">Designation</label>
									</div>
									<div class="form-group">
									<div class="col-md-6">
										<div class="form-line">
											<input type="text" class="form-control" maxlength="100" name="dacDesignation"  oninvalid="this.setCustomValidity('Enter Designation  ')" oninput="setCustomValidity('')" value="${nodalOfficerDetails.dacDesignation}" required>
										</div>
										</div>
									</div>
									<div class="col-md-4">
									<label for="password2">Email-Id</label>
									</div>
									<div class="form-group">
									<div class="col-md-6">
										<div class="form-line">
											<input type="text" class="form-control" maxlength="50" required pattern="[^@]+@[^@]+\.[a-zA-Z]{2,6}"  name="dacEmailId" value="${nodalOfficerDetails.dacEmailId}" required>
										</div>
										</div>
									</div>
									<div class="col-md-4">
									<label for="password2">Mobile Number</label>
									</div>
									<div class="form-group">
									<div class="col-md-6">
										<div class="form-line">
											<input type="text" class="form-control validate"  oninvalid="this.setCustomValidity('Enter Mobile Number ')" oninput="setCustomValidity('')"  maxlength="10" name="dacMobileNumber" value="${nodalOfficerDetails.dacMobileNumber}" required>
										</div>
										</div>
									</div>
									</div>
                                     </div>
                                 
                                </div>
                               </div>
								 
								
								
								 		<div class="form-group text-right">
										<button type="submit" class="btn bg-green waves-effect">
											Save
										</button>
										<button type="button" onclick="" class="btn bg-light-blue waves-effect reset">CLEAR</button>
										<button type="button"
											onclick=" onClose('home.html?<csrf:token uri='home.html'/>')"
											class="btn bg-orange waves-effect">
											<spring:message code="Label.CLOSE" htmlEscape="true" />
										</button>
									</div>
								
							</form>
							</div>
								
								
		</section>
	</body>
</html>
<script>
	$('document').ready(function(){
		$(".reset").bind("click", function() {
		  $("input[type=text]").val('');
		});
		
	});
</script>
