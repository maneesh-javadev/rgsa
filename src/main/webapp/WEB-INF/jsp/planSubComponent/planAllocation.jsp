<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="../taglib/taglib.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<c:choose>
	<c:when test="${!PLAN_ALLOCATION.sanctionOrderExist}">
		
		<script>
		$(document).ready(function() {
			$('#errorMessage').addClass('show');
			$('#errorMessage').html('Sanction Order details not freeze or Plan not Approved.');
		});
		</script>
		
	</c:when>
	<c:when test="${isPlanAllocationNotExist}">
		
		<script>
		$(document).ready(function() {
			$('#errorMessage').addClass('show');
			$('#errorMessage').html('Freeze plan allocation before quterly form ');
		});
		</script>
		
	</c:when>
	
</c:choose>
<script>
var relAmount=parseInt('${PLAN_ALLOCATION.totalAmount}');

$(document).ready(function() {
	$("input[type='text']").keypress(function (e) {
	    //if the letter is not digit then display error and don't type anything
	    if (e.which != 8 && e.which != 0 &&   e.which !=46  && (e.which < 48 || e.which > 57)  ) {
	       //display error message
	    	$("#errmsg").html("Digits Only").show().fadeOut("slow");
	              return false;
	   }
	    if($(this).val().length==0 && e.which ==46){
	    	alert("first Digit only number");
	    	return false;
	    }
	    if((e.which >= 48 || e.which <= 57) && $(this).val().indexOf(".")>0){
	    	 if(countFlag==true){
	  	    	count++;
	  	    }
	  	    
	  	    if(count>3){
	  	    	 alert("3 Digits Only after decimal");
	               return false;
	  	    }
	    }else{
	    	count=0;
	    }
	    
		  if(e.which ==46 ){
	    	countFlag=true;
	    }
	  });
}); 

var $_checkEmptyObject_value = function(obj) {
	if (jQuery.type(obj) === "undefined" || (obj == null || $.trim(obj).length == 0)) {
		return 0;
	}
	return parseInt(obj);
};

validateSave=function(){
	totalAmount=0;
	$("input[type='text']").each(function () {  
		totalAmount=totalAmount+$_checkEmptyObject_value($(this).val());
       
    }) 
    return (relAmount>=totalAmount); 
}
 validate=function(){
	totalAmount=0;
	$("input[type='text']").each(function () {  
		totalAmount=totalAmount+$_checkEmptyObject_value($(this).val());
       
    }) 
    return (relAmount==totalAmount);  
}

setStatus=function(status){
	$("#status").val(status);
	if(status=="F" && !validate()){
		alert("Please allocate fund equal to release fund of installment");
	}if((status=="S" || status=="M") && !validateSave()){
		alert("Please allocate fund not greater then release fund of installment ");
	}else{
		callActionUrl();
	}
}

callActionUrl=function(){
 	$( 'form[id=planAllocationForm]' ).submit();
};
</script>

</head>
<body>


<section class="content"> 
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2>Plan Allocation </h2>
					</div>
					<div class="body">
					<form:form method="post" action="savePlanAllocation.html" modelAttribute="PLAN_ALLOCATION" id="planAllocationForm">
					<input type="hidden" name="<csrf:token-name/>"	value="<csrf:token-value uri="savePlanAllocation.html"/>" />
					<form:hidden path="planCode" />
					<form:hidden path="installmentNo" />
					<form:hidden path="status" />
						<div class="form-group">
									<span class="errormessage" id="errorMessage"></span><br/>
						</div>
						<table class="table table-bordered">
							<thead>
								<tr>
									<th>
										<div align="center">
											<strong>SI.No.</strong>
										</div>
									</th>
									<th>
										<div align="center">
											<strong>Component</strong>
										</div>
									</th>
									<th>
										<div align="center">
											<strong>Amount Allocation(${PLAN_ALLOCATION.totalAmount})</strong>
										</div>
									</th>
								</tr>
							</thead>
							<tbody>
							<c:set var="pAllocationIndex" value="0" />
							<c:forEach items="${PLAN_ALLOCATION_LIST}" var="pc" varStatus="pcindex">
							<c:if test="${pc.eType eq 'C'}">
									<tr>
										<td><b>${pcindex.count}</b></td>
										<td><b>${pc.eName}</b></td>
										<td><div align="center">
										 <c:if test="${pc.noOfUnits < 1}">
										        <c:choose>
													<c:when test="${PLAN_ALLOCATION.status eq 'F'}">
														<spring:bind path="PLAN_ALLOCATION.stateAllocationList[${pAllocationIndex}].fundsAllocated">
															<form:hidden path="${status.expression}" value="${status.value}"  />
													 		<c:out value="${status.value}" />
													 	</spring:bind>
														
													</c:when>
													<c:otherwise>
														<spring:bind path="PLAN_ALLOCATION.stateAllocationList[${pAllocationIndex}].fundsAllocated" >
													 		<form:input path="${status.expression}" disabled="${!PLAN_ALLOCATION.sanctionOrderExist}" maxlength="13" />
													 	</spring:bind>
													</c:otherwise>
												</c:choose>
													
													   <spring:bind path="PLAN_ALLOCATION.stateAllocationList[${pAllocationIndex}].componentId" >
													 	<form:hidden path="${status.expression}" value="${pc.componentsId}"  />
													 </spring:bind> 
													 <spring:bind path="PLAN_ALLOCATION.stateAllocationList[${pAllocationIndex}].subcomponentId" >
													 	<form:hidden path="${status.expression}" value="${pc.subcomponentsId}"  />
													 </spring:bind> 
													<spring:bind path="PLAN_ALLOCATION.stateAllocationList[${pAllocationIndex}].srNo" >
													 	<form:hidden path="${status.expression}" value="${status.value}"  />
													</spring:bind>
													 
													 <c:set var="pAllocationIndex" value="${pAllocationIndex+1}" />
										</c:if> 
										</div>
										</td>
									</tr>
										
										<c:set var="pscindex" value="0"/>
										<c:forEach items="${PLAN_ALLOCATION_LIST}" var="psc" >
											<c:if test="${psc.eType eq 'S' and pc.componentsId==psc.componentsId }">
											<c:set var="pscindex" value="${pscindex+1}"/>
										<tr>
											<td>
												&#${96+pscindex}
											</td>
											<td>
													 ${psc.eName}
											</td>
											<td>
												<div align="center">
												<c:choose>
													<c:when test="${PLAN_ALLOCATION.status eq 'F'}">
														<spring:bind path="PLAN_ALLOCATION.stateAllocationList[${pAllocationIndex}].fundsAllocated">
															<form:hidden path="${status.expression}" value="${status.value}"  />
													 		<c:out value="${status.value}" />
													 	</spring:bind>
														
													</c:when>
													<c:otherwise>
														<spring:bind path="PLAN_ALLOCATION.stateAllocationList[${pAllocationIndex}].fundsAllocated" >
													 		<form:input path="${status.expression}" disabled="${!PLAN_ALLOCATION.sanctionOrderExist}" maxlength="13" />
													 	</spring:bind>
													</c:otherwise>
												</c:choose>
													
													   <spring:bind path="PLAN_ALLOCATION.stateAllocationList[${pAllocationIndex}].componentId" >
													 	<form:hidden path="${status.expression}" value="${psc.componentsId}"  />
													 </spring:bind> 
													 <spring:bind path="PLAN_ALLOCATION.stateAllocationList[${pAllocationIndex}].subcomponentId" >
													 	<form:hidden path="${status.expression}" value="${psc.subcomponentsId}"  />
													 </spring:bind> 
													<spring:bind path="PLAN_ALLOCATION.stateAllocationList[${pAllocationIndex}].srNo" >
													 	<form:hidden path="${status.expression}" value="${status.value}"  />
													</spring:bind>
													
												</div>
											</td>
										</tr>
										<c:set var="pAllocationIndex" value="${pAllocationIndex+1}" />
										</c:if>
									</c:forEach>
									</c:if>
								</c:forEach>
							</tbody>

						</table>
						<div class="text-right">
						<c:if test="${PLAN_ALLOCATION.sanctionOrderExist}">
							
						 	
							<c:choose>
								<c:when test="${PLAN_ALLOCATION.status eq 'F'}">
									<button  type="button" class="btn bg-green waves-effect" onclick="setStatus('U')">Unfreeze</button>
								</c:when>
								<c:otherwise>
										<c:choose>
											<c:when test="${empty PLAN_ALLOCATION.status}">
												<button  type="button" class="btn bg-green waves-effect" onclick="setStatus('S')">SAVE</button>
											</c:when>
											<c:otherwise>
												<button  type="button" class="btn bg-green waves-effect" onclick="setStatus('M')">Update </button>
											</c:otherwise>
										</c:choose>
								<button  type="button" class="btn bg-green waves-effect" onclick="setStatus('F')">Freeze</button>
								</c:otherwise>
							</c:choose>
							
						</c:if>
							<!-- <button type="button"  ng-click="claerAll()" class="btn bg-light-blue waves-effect">CLEAR</button> -->
							<button type="button" onclick="onClose('home.html?<csrf:token uri='home.html'/>')"class="btn bg-orange waves-effect">CLOSE</button>
						</div>
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<script  type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/dataTables/js/jquery.dataTables.js"></script>
<script  type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/dataTables/js/dataTables.bootstrap.min.js"></script>
<script>
$(function () {
    $('#js-basic-example').DataTable({
        responsive: true
    });
});
</script>
</body>
</html>