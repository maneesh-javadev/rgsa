<script>
	
function isNumber(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
        return false;
    }
    return true;
}

/* $( document ).ready(function() {
  
var rowCount = $('#tbodyIdNdprc tr').length-2;
var NBdprc = $('#tbodyIdNdprc tr').length-2;

for (var i = 0; i < rowCount; i++) {
	
	$("#instInfraStatusId"+i).val($("#instInfraStatusIdSel"+i).val());
	alert($("#instInfraStatusId"+i).val());

}
for (var i = 0; i < NBdprc; i++) {
	
	$("#instInfraStatusIdNdprc"+i).val($("#instInfraStatusIdSel"+i).val());
	

}



}); */

function get_quater_wise_data()
{
	document.qprInstitutionalInfrastructure.method = "post";
	document.qprInstitutionalInfrastructure.action = "fetchDetailsForInstitutionalInfraProgressReport.html?<csrf:token uri='fetchDetailsForInstitutionalInfraProgressReport.html'/>";
	document.qprInstitutionalInfrastructure.submit();
}


loadElement=function(){
	//var quaterId = '${QPR_INSTITUTIONALINFRAQUATERLY.qtrId}'
	//alert('${QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[0].qprInstInfraDetailsId}');
	//alert('${QPR_INSTITUTIONALINFRAQUATERLY.qprInstitutionalInfraDetails[0].expenditureIncurred}');
	$("#qtrId option[value='${QPR_INSTITUTIONALINFRAQUATERLY.qtrId}']").attr("selected", "selected");
	validate_expenditureIncurred('${subcomponentwiseQuaterBalanceList[0].balanceAmount}',null,"nbs");
	validate_expenditureIncurred('${subcomponentwiseQuaterBalanceList[1].balanceAmount}',null,"nbd");
	validate_expenditureIncurred('${subcomponentwiseQuaterBalanceList[2].balanceAmount}',null,"cfs");
	validate_expenditureIncurred('${subcomponentwiseQuaterBalanceList[3].balanceAmount}',null,"cfd");
	
	
	
};

loadSubElement=function(instInfraStatusId,index){
/* 	$("#instInfraStatusId"+index+" option[value='"+instInfraStatusId+"']").attr("selected", "selected");
 */
 alert($("#instInfraStatusId"+index).val());
 
 
};

function save_data()
{
	document.qprInstitutionalInfrastructure.method = "post";
	document.qprInstitutionalInfrastructure.action = "saveInstitutionalInfraProgressReport.html?<csrf:token uri='saveInstitutionalInfraProgressReport.html'/>";
	document.qprInstitutionalInfrastructure.submit();
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
	
	$("#"+id+"_subtotal").val(subtotal);
	temp= $("#"+id+"_addReq").val();
	addReq=0;
	if(temp!=null && temp!=undefined && temp!=""){
		addReq=parseInt(temp);	
		approvedAddReq=id=="nbs"?parseInt('${balAddiReqSPRC}'):parseInt('${balAddiReqDPRC}');
		/* if( addReq>((subtotal*25)/100))
		{
			$("#"+id+"_addReq").val("");
			$("#error_"+id+"_addReq").text("Additional Requirement must be equal or lesss then 25% of Sub-Total cost");
			$("#error_"+id+"_addReq").addClass('errormsg show');
			addReq=0;
			
		}else */ if(approvedAddReq<addReq){
			$("#"+id+"_addReq").val("");
			$("#error_"+id+"_addReq").text("Additional Requirement must be less then approved amount");
			$("#error_"+id+"_addReq").addClass('errormsg show');
			addReq=0;
		}else{
			$("#error_"+id+"_addReq").text("");
			$("#error_"+id).removeClass("errormsg show");
		}
	}
	total=subtotal+addReq;
	$("#"+id+"_total").val(total);
	
	nbst=$("#nbs_total").val()!=null && $("#nbs_total").val()!=undefined  && $("#nbs_total").val()!=""?parseInt($("#nbs_total").val()):0 ;
	nbdt=$("#nbd_total").val()!=null && $("#nbd_total").val()!=undefined  && $("#nbd_total").val()!=""?parseInt($("#nbd_total").val()):0 ;
	cfst=$("#cfs_total").val()!=null && $("#cfs_total").val()!=undefined  && $("#cfs_total").val()!=""?parseInt($("#cfs_total").val()):0 ;
	cfdt=$("#cfd_total").val()!=null && $("#cfd_total").val()!=undefined  && $("#cfd_total").val()!=""?parseInt($("#cfd_total").val()):0 ;
	$("#grandTotal").val(nbst+nbdt+cfst+cfdt);
	
	
}

function FreezeAndUnfreeze(msg){
	var componentId=2;
	var qprActivityId=$('#qprActivityId').val();
	var quaterId = $('#qtrId').val();
	document.qprInstitutionalInfrastructure.method = "post";
	document.qprInstitutionalInfrastructure.action = "freezeAndUnfreezeReport.html?<csrf:token uri='freezeAndUnfreezeReport.html'/>&componentId="+componentId+"&qprActivityId="+qprActivityId+"&quaterId="+quaterId+"&msg="+msg;
	document.qprInstitutionalInfrastructure.submit();
}
</script>

<!--#stared page return from server with error then call loadElementandShowError  method -->
<c:if test="${quaterIdExist eq true}">
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