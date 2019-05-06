<script>
	
function isNumber(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
        return false;
    }
    return true;
}





function get_quater_wise_data()
{
	document.quarterTrainings.method = "post";
	document.quarterTrainings.action = "trainingProgressReportGETData.html?<csrf:token uri='trainingProgressReportGETData.html'/>";
	document.quarterTrainings.submit();
}


loadElement=function(){
	$("#qtrId option[value='${QPR_TRAINING_DETAILS.qtrId}']").attr("selected", "selected");
	validate_expenditureIncurred('${subcomponentwiseQuaterBalanceList[0].balanceAmount}',null,"expenditureIncurred");
	
	
	
};

loadSubElement=function(instInfraStatusId,index){
	//$("#instInfraStatusId"+index+" option[value='"+instInfraStatusId+"']").attr("selected", "selected");
	
};

function save_data()
{
	document.quarterTrainings.method = "post";
	document.quarterTrainings.action = "savetrainingProgressReport.html?<csrf:token uri='savetrainingProgressReport.html'/>";
	document.quarterTrainings.submit();
}

function validate_data(){
	
}

function validate_expenditureIncurred(balance,obj,objId){
if(obj==null){
temp=("#"+objId+"_0");
if(temp.length>0){
	obj=temp;
}

}	

if(obj!=null){
	id=$( obj ).attr('id');
	idn=id.split("_")[0];
	var i=0;
	var tot=0;
	var l=$('#'+idn+'_'+i).length;

		while(l>0){
		temp=$('#'+idn+'_'+i).val(); 
		vali=temp!=null && temp!=undefined && temp!="" ?parseInt(temp):0;
		
		tot=tot+vali;
		l=$('#'+idn+'_'+i).length;
		i++;
		}

		if(tot>balance){
			$("#error_"+id).text("expenditure Incurred must be less then balance amount");
			$("#error_"+id).addClass('errormsg show');
			$( obj ).val('');
			$(obj).focus();	  
		}else{
			$("#error_"+id).removeClass("errormsg show");
			$("#error_"+id).text("");
			calculcate_total(tot,idn);
		}
}
	
}

function calculcate_total(subtotal,id){
	if(subtotal==null || subtotal==undefined){
		tot=0;
		var i=0;
		var l=$('#'+id+'_'+i).length;

		while(l>0){
			temp=$('#'+id+'_'+i).val(); 
			vali=temp!=null && temp!=undefined && temp!="" ?parseInt(temp):0;
			
			tot=tot+vali;
			l=$('#'+id+'_'+i).length;
			i++;
			}
		subtotal=tot;
		
	}
	
	$("#subtotal").val(subtotal);
	temp= $("#addReq").val();
	addReq=0;
	if(temp!=null && temp!=undefined && temp!=""){
		addReq=parseInt(temp);	
		approvedAddReq=parseInt('${balAddiReq}');
		if( addReq>((subtotal*25)/100))
		{
			$("#addReq").val("");
			$("#error_addReq").text("Additional Requirement must be equal or lesss then 25% of Sub-Total cost");
			$("#error_addReq").addClass('errormsg show');
			addReq=0;
			
		}else if(approvedAddReq<addReq){
			$("#addReq").val("");
			$("#error_addReq").text("Additional Requirement must be less then approved amount");
			$("#error_addReq").addClass('errormsg show');
			addReq=0;
		}else{
			$("#error_addReq").text("");
			$("#error_"+id).removeClass("errormsg show");
		}
	}
	total=subtotal+addReq;
	$("#total").val(total);
	
	
	
	
}
</script>

<!--#stared page return from server with error then call loadElementandShowError  method -->
<c:if test="${installementExist eq true}">
			<script>
			$(window).load(function () {
				loadElement();
			}); 
			</script>
			
			
			 <c:forEach items="${QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails}" var="obj" varStatus="count">
			<script>
			 $(window).load(function () {
				loadSubElement('${obj.instInfraStatusId}','${count.index}');
			}); 
			</script>
			 </c:forEach>
</c:if>
<!--#end page return from server with error then call loadElementandShowError  method -->