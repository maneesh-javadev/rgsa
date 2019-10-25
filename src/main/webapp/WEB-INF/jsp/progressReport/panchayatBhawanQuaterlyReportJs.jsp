<script>
var otherTotal=parseInt('${otherSubtotal}');

function isNumber(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
        return false;
    }
    return true;
}

function getSelelctedQtrRprt()
{
	

	document.qprPanchayatBhawan.method = "post";
	document.qprPanchayatBhawan.action = "panchayatBhawanQuaterlyReportOnQtr.html?<csrf:token uri='panchayatBhawanQuaterlyReportOnQtr.html'/>";
	document.qprPanchayatBhawan.submit();
	
	


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
				$("#error_"+id).removeClass("errormsg");
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
	subtotal=subtotal+otherTotal;
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
			$("#error_addReq").removeClass("errormsg show");
		}
	}
	total=subtotal+addReq;
	$("#total").val(total);
	
	
	
	
}

loadElement=function(){

$("#qtrId option[value='${QPR_PANCHAYAT_BHAWAN.qtrId}']").attr("selected", "selected");
$("#activityId option[value='${QPR_PANCHAYAT_BHAWAN.activityId}']").attr("selected", "selected");	
$("#districtId option[value='${QPR_PANCHAYAT_BHAWAN.selectDistrictId}']").attr("selected", "selected");	
validate_expenditureIncurred('${subcomponentwiseQuaterBalance}',null,"expenditureIncurred");
};

loadSubElement=function(gpBhawanStatusId,index){
	$("#gpBhawanStatusId_"+index+" option[value='"+gpBhawanStatusId+"']").attr("selected", "selected");
	
};

function FreezeAndUnfreeze(msg){
	var componentId=3;
	var qprActivityId=$('#qprActivityId').val();
	var quaterId = $('#qtrId').val();
	document.qprPanchayatBhawan.method = "post";
	document.qprPanchayatBhawan.action = "freezeAndUnfreezeReport.html?<csrf:token uri='freezeAndUnfreezeReport.html'/>&componentId="+componentId+"&qprActivityId="+qprActivityId+"&quaterId="+quaterId+"&msg="+msg;
	document.qprPanchayatBhawan.submit();
}

</script>

<!--#stared page return from server with error then call loadElementandShowError  method -->

			<script>
			$(window).load(function () {
				loadElement();
			}); 
			</script>
			<c:if test="${isExistQprPanchayatBhawan eq true}">
			 <c:forEach items="${QPRPANHCAYATBHAWANDETAILS}" var="obj" varStatus="count">
			<script>
			 $(window).load(function () {
				loadSubElement('${obj.gpBhawanStatusId}','${count.index}');
			}); 
			</script>
			 </c:forEach>
			
</c:if>
<!--#end page return from server with error then call loadElementandShowError  method -->