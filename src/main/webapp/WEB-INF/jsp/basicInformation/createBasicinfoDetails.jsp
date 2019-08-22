<%@include file="../taglib/taglib.jsp"%>	
<c:set var="districtEnable" value="false"/>
<c:set var="blockEnable" value="false"/>
<c:set var="gpEnable" value="false"/>
<c:if test="${STATE_CODE ne 13 and STATE_CODE ne 15 and STATE_CODE ne 17 and STATE_CODE ne 34}">
<c:set var="districtEnable" value="true" />
</c:if>
<c:if test="${STATE_CODE ne 13 and STATE_CODE ne 15 and STATE_CODE ne 17}">
<c:set var="gpEnable" value="true" />
</c:if>
<c:if test="${STATE_CODE ne 11 and STATE_CODE ne 14 and STATE_CODE ne 25 and STATE_CODE ne 26 and STATE_CODE ne 30 and STATE_CODE ne 31 and STATE_CODE ne 13 and STATE_CODE ne 15 and STATE_CODE ne 17}">
<c:set var="blockEnable" value="true" />
</c:if>

<html>
<head>

<style type="text/css">

#errmsg
{
color: red;
}


.input-sm {
  width: 50px !important;
  }
</style>

<script type="text/javascript"> 

var focusArea=[];

function removeDisabledAttr(){
	flag=validateMandate()
	$("#basicInfo :input").prop("disabled", false);
	return flag
}


function validateMandate(){
	var flag=true;
	data34_gp_count=$_checkEmptyObject_value($("#data34_gp_count").val());
	data34_bp_count=$_checkEmptyObject_value($("#data34_bp_count").val());
	data34_dp_count=$_checkEmptyObject_value($("#data34_dp_count").val());
	if($("#data34_gp1").is(':checked') && data34_gp_count<=0){
		flag=false;
		alert("please fill mandatory field");
	}else if($("#data34_bp1").is(':checked') && data34_bp_count<=0){
		flag=false;
		alert("please fill mandatory field");
	}
	else if($("#data34_dp1").is(':checked') && data34_dp_count<=0){
		flag=false;
		alert("please fill mandatory field");
	}
	
	return flag;
}
function setValues(){
	var tot10=0;
	var tot30=0;
	var tot11=0;
	var tot31=0;
	var tot12=0;
	var tot32=0;
	for(var i=0;i<=2;i++){
		for(var j=0;j<=3;j++){
			var type="";
			var gender="";
			var memberType="";
			if(i==0){type="GP";}if(i==1){type="BP";}if(i==2){type="DP";}if(j==0 || j==1){gender="MALE";}if(j==2 || j==3){gender="FEMALE";}if(j==0 || j==2){memberType="Sarpanch";}
			if(j==1 || j==3){
				memberType="Members";
			}
			t1=0;
			t2=0;
			t3=0;
			temp=$("#Elected"+type+"_"+gender+"_"+memberType+"_SC").val();
			//alert("sc:"+temp);
			if(!$_checkEmptyObject(temp)){
				t1=parseInt(temp);
				$("#erSC"+j+i).val(t1);
				//alert("sc in:"+temp);
			}
			temp=$("#Elected"+type+"_"+gender+"_"+memberType+"_ST").val();
			if(!$_checkEmptyObject(temp)){
				t2=parseInt(temp);
				$("#erST"+j+i).val(t2);
			}
			temp=$("#Elected"+type+"_"+gender+"_"+memberType+"_GEN").val();
			if(!$_checkEmptyObject(temp)){
				t3=parseInt(temp);
				$("#erGEN"+j+i).val(t3);
			}
			
			if(i==0 && (j==0 || j==1)){
				tot10=tot10+t1+t2+t3;
			}
			if(i==0 && (j==2 || j==3)){
				tot30=tot30+t1+t2+t3;
			}
			
			if(i==1 && (j==0 || j==1)){
				tot11=tot11+t1+t2+t3;
			}
			if(i==1 && (j==2 || j==3)){
				tot31=tot31+t1+t2+t3;
			}
			
			if(i==2 && (j==0 || j==1)){
				tot12=tot12+t1+t2+t3;
			}
			if(i==2 && (j==2 || j==3)){
				tot32=tot32+t1+t2+t3;
			}
			
			$("#total10").val(tot10);
			$("#total30").val(tot30);
			$("#total11").val(tot11);
			$("#total31").val(tot31);
			$("#total12").val(tot12);
			$("#total32").val(tot32);
			/* temp=$("#Elected"+type+"_"+gender+"_"+memberType+"_Minority").val();
			if(!$_checkEmptyObject(temp)){
				$("#erMinority"+i+j).val(temp);
			} */
			
		}
	}
}

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


function setElectedRepData(){
	for(var i=0;i<=2;i++){
		for(var j=0;j<=3;j++){
			var type="";
			var gender="";
			var memberType="";
			if(i==0){type="GP";}if(i==1){type="BP";}if(i==2){type="DP";}if(j==0 || j==1){gender="MALE";}if(j==2 || j==3){gender="FEMALE";}if(j==0 || j==2){memberType="Sarpanch";}
			if(j==1 || j==3){
				memberType="Members";
			}
			//alert("type"+type+"@gender"+gender+"@memberType"+memberType+"@i:"+i+"@j"+j);
			temp=$("#erSC"+j+i).val();
			if(!$_checkEmptyObject(temp)){
				t1=parseInt(temp);
				$("#Elected"+type+"_"+gender+"_"+memberType+"_SC").val(t1);
			}
			temp=$("#erST"+j+i).val();
			if(!$_checkEmptyObject(temp)){
				t2=parseInt(temp);
				$("#Elected"+type+"_"+gender+"_"+memberType+"_ST").val(t2);
			}
			temp=$("#erGEN"+j+i).val();
			if(!$_checkEmptyObject(temp)){
				t3=parseInt(temp);
				$("#Elected"+type+"_"+gender+"_"+memberType+"_GEN").val(t3);
			}
			
			
			
			//$("#Elected"+type+"_"+gender+"_"+memberType+"_Minority").val($("#erMinority"+i+j).val());
		}
	}
	$("#myModal").modal('hide');
}



function setFocusArea(){
	focusArea=[];
	$.each($("input[name='selectFocusArea']:checked"), function(){            
		focusArea.push($(this).val());
    });
	$("#dataFA").val(focusArea.toString());
	
	$("#subjectArea").modal('hide');
}

$( document ).ready(function() {
	
	
	if($("#data34_gp1").is(':checked')){
		$("#data34_gp_count_div").show();
	}else{
		$("#data34_gp_count_div").hide();
	}
	
	if($("#data34_bp1").is(':checked')){
		$("#data34_bp_count_div").show();
	}else{
		$("#data34_bp_count_div").hide();
	}
	
	if($("#data34_dp1").is(':checked')){
		$("#data34_dp_count_div").show();
	}else{
		$("#data34_dp_count_div").hide();
	}
	
	var dataFA_List=$("#dataFA").val();
	//alert(dataFA_List);
	$.each($("input[name='selectFocusArea']"), function(){            
		//alert($(this).val());
		obj1=$(this);
		 $.each(dataFA_List.split(","), function(key, obj) {
			 if(obj==$(obj1).val()){
				 $(obj1).prop('checked', true);
			 }
		  }); 
		
		//focusArea.push($(this).val());
    });
	
	
	
	var stateCode=$("#stateCode").val();
	$('.validate').find('input:number').val('');
	$("#data4_state").attr("disabled",true);
	$("#data21_state").attr("disabled",true);
	
	
	/* $("#data14_gp").attr("disabled",true);
	$("#data14_bp").attr("disabled",true);
	$("#data14_dp").attr("disabled",true); */
	
	$("#data12_state").attr("disabled",true);
	
	if($("#data2_state").val() != ""){
		total_population=$_checkEmptyObject_value($("#data2_state").val());
		var sc_percent=0;
		var st_percent=0;
		var women_percent=0;
		var ruler_percent=0;
		if(total_population>0){
			population_5=$_checkEmptyObject_value($("#population_5").val());
			population_3=$_checkEmptyObject_value($("#population_3").val());
			if(population_3>0){
				ruler_percent= (population_3/total_population) * 100;
			}
			if(population_5>0){
				 sc_percent= (population_5/population_3) * 100;
			}
			
			population_6=$_checkEmptyObject_value($("#population_6").val());
			if(population_5>0){
				st_percent= (population_6/population_3) * 100;
			}
			
			population_6=$_checkEmptyObject_value($("#population_6").val());
			if(population_5>0){
				st_percent= (population_6/population_3) * 100;
			}
			
			population_20=$_checkEmptyObject_value($("#population_20").val());
			if(population_20>0){
				women_percent= (population_20/population_3) * 100;
			}
			
			/* population_3=$_checkEmptyObject_value($("#population_3").val());
			if(population_3>0){
				ruler_percent= (population_3/total_population) * 100;
			} */
			
			$("#percentage_3").val(ruler_percent.toFixed(2));
			$("#percentage_5").val(sc_percent.toFixed(2));
			$("#percentage_6").val(st_percent.toFixed(2));
			$("#percentage_20").val(women_percent.toFixed(2));
		}
		
	}/* else{
		alert('Fill total population of state first.');
		$('#data2_state').focus();
	} */
	
	$("#data16_gp,#data16_bp").attr("disabled",true);
	
	if($.parseJSON('${blockEnable}')){
		
		data9_gp=$_checkEmptyObject_value($("#data9_gp").val());
		data9_bp=$_checkEmptyObject_value($("#data9_bp").val());
		data9_dp=$_checkEmptyObject_value($("#data9_dp").val());
		 var AVG_GP =0;
		 var AVG_BP = 0;
		
				if(data9_bp>0 && data9_gp>0){
				  	AVG_GP=data9_gp/data9_bp;
				}
				if(data9_bp>0 && data9_dp>0){
					AVG_BP=data9_bp/data9_dp
				}
			
			}else{
				if(data9_gp>0 && data9_dp>0){
					AVG_GP = data9_gp/data9_dp;
				}
			 
			     AVG_BP =0;
			} 

	
			if(!$_checkEmptyObject(AVG_GP)){
				var avg=AVG_GP.toFixed(2);
				$("#data16_gp").val(avg);
			}
			if(!$_checkEmptyObject(AVG_BP)){
				var avgBp=AVG_BP.toFixed(2);
				$("#data16_bp").val(avgBp);
			}
	
	$("#data3_state").change(function() {
			if(parseInt($("#data2_state").val())<parseInt($("#data3_state").val())){
				alert("Value Should be less than Total Population of State");
				$("#data3_state").val(' ');
			}
			else{
				if($("#data2_state").val() != '' && $("#data3_state").val() != '')
					var value = (($("#data3_state").val() / $("#data2_state").val())*100).toFixed(2);
				$("#data4_state").val(value);
			}
		}
	);
	$("#data5_state,#data6_state,#data20_state,#data9_bp,#data14_gp,#data14_bp,#data14_dp,#data15_gp,#data15_bp,#data9_dp,#data7_state,#data8_state,#data13_gp,#data13_bp,#data13_dp,#data10_state,#data11_state,#data27_gp,#data27_bp,#data45_bp,#data45_gp,#data45_state,#data30_gp,#data30_bp,#data31_gp,#data31_bp,#data32_bp,#data32_gp,#data33_gp,#data9_gp,#data48_bp,#data48_gp,#data11_dp,#data11_bp,#data11_gp,#data34_gp1,#data34_gp2,#data34_bp1,#data34_bp2,#data34_dp1,#data34_dp2,#data34_dp_count,#data34_bp_count,#data34_gp_count").change(function() {
		temp=$_checkEmptyObject_value($("#data5_state").val());
		if(temp>100){
			alert("Value Should be less than 100");
			$("#data5_state").val(' ');
		}
		
		temp=$_checkEmptyObject_value($("#data6_state").val());
		if(temp>100){
			alert("Value Should be less than 100");
			$("#data6_state").val(' ');
		}
		
		temp=$_checkEmptyObject_value($("#data20_state").val());
		if(temp>100){
			alert("Value Should be less than 100");
			$("#data20_state").val(' ');
		}
		
		/* data9_gp=$_checkEmptyObject_value($("#data9_gp").val());
		data9_bp=$_checkEmptyObject_value($("#data9_bp").val());
		if(data9_gp!=0 && data9_gp<data9_bp){
			alert("Value Should be less than Gram Panchayat");
			$("#data9_bp").val(' ');
		} */
		
		data9_gp=$_checkEmptyObject_value($("#data9_gp").val());
		population_3=$_checkEmptyObject_value($("#population_3").val());
		if(data9_gp>0 && population_3>0){
				var value = (population_3 / data9_gp).toFixed(2);
			$("#data12_state").val(value);
		}
	
		
		if((stateCode != 11 && (stateCode !=14 && stateCode != 25)) && (stateCode != 26 && (stateCode != 30 && stateCode != 31))){
			
			/* data9_bp=$_checkEmptyObject_value($("#data9_bp").val());
			data9_dp=$_checkEmptyObject_value($("#data9_dp").val());
			if(data9_bp>0 && data9_bp<data9_dp){
				alert("Value Should be less than Block Panchayat");
				$("#data9_dp").val(' ');
			} */
			data9_bp=$_checkEmptyObject_value($("#data9_bp").val());
			data9_dp=$_checkEmptyObject_value($("#data9_dp").val());
			
			if(data9_bp>0 && data9_dp > data9_bp){
				alert("Value Should be greater than District Panchayat");
				$("#data9_bp").val(' ');
			}
			
			data9_bp=$_checkEmptyObject_value($("#data9_bp").val());
			data9_gp=$_checkEmptyObject_value($("#data9_gp").val());
			if(data9_gp > 0 && data9_bp > data9_gp){
				alert("Value Should be greater than Block Panchayat");
				$("#data9_gp").val(' ');
			}
		}else{
			/* data9_gp=$_checkEmptyObject_value($("#data9_gp").val());
			data9_dp=$_checkEmptyObject_value($("#data9_dp").val());
			if(data9_gp>0 && data9_gp<data9_dp){
				alert("Value Should be less than Gram Panchayat");
				$("#data9_dp").val(' ');
			} */
			data9_gp=$_checkEmptyObject_value($("#data9_gp").val());
			data9_dp=$_checkEmptyObject_value($("#data9_dp").val());
			if(data9_dp > 0 && data9_gp > 0 && data9_dp > data9_gp){
				alert("Value Should be Greater than District Panchayat");
				$("#data9_gp").val(' ');
			}
		}
		
		data7_state=$_checkEmptyObject_value($("#data7_state").val());
		data9_gp=$_checkEmptyObject_value($("#data9_gp").val());
		 if(data9_gp>0 && data7_state> data9_gp){
			alert("Value Should be less than Gram Panchayat");
			$("#data7_state").val(' ');
		} 
		 
		 data7_state=$_checkEmptyObject_value($("#data7_state").val());
		 data8_state=$_checkEmptyObject_value($("#data8_state").val());
		 data9_gp=$_checkEmptyObject_value($("#data9_gp").val());
		var additionValue = data7_state + data8_state;
		if(additionValue>0 && additionValue >data9_gp){
			alert("Value Should be less than Gram Panchayat");
			$("#data8_state").val(' ');
		}else{
			$("#data21_state").val(data9_gp - additionValue);
		}
		
		data9_gp=$_checkEmptyObject_value($("#data9_gp").val());
		data13_gp=$_checkEmptyObject_value($("#data13_gp").val());
		if(data9_gp>0 && data13_gp> data9_gp){
			alert("Value Should be less than Gram Panchayat");
			$("#data13_gp").val(' ');
		}
		
		data9_gp=$_checkEmptyObject_value($("#data9_gp").val());
		data14_gp=$_checkEmptyObject_value($("#data14_gp").val());
		data13_gp=$_checkEmptyObject_value($("#data13_gp").val());
		if(data9_gp>0 && data14_gp >data9_gp){
			alert("Value Should be less than Gram Panchayat");
			$("#data14_gp").val(' ');
		}else{
			if(data13_gp>0 &&  (data14_gp +data13_gp) >data9_gp){
				alert("Value Should be less than partly covered in Fifth Schedule/ PESA-Areas");
				$("#data14_gp").val(' ');
			}
		}
		
		
		data9_bp=$_checkEmptyObject_value($("#data9_bp").val());
		data14_bp=$_checkEmptyObject_value($("#data14_bp").val());
		data13_bp=$_checkEmptyObject_value($("#data13_bp").val());
		if(data9_bp>0 && data14_bp >data9_bp){
			alert("Value Should be less than Block Panchayat");
			$("#data14_bp").val(' ');
		}else{
			if(data13_bp>0 &&  (data14_bp +data13_bp) >data9_bp){
				alert("Value Should be less than partly covered in Fifth Schedule/ PESA-Areas");
				$("#data14_bp").val(' ');
			}
		}
		
		data9_dp=$_checkEmptyObject_value($("#data9_dp").val());
		data14_dp=$_checkEmptyObject_value($("#data14_dp").val());
		data13_dp=$_checkEmptyObject_value($("#data13_dp").val());
		if(data9_dp>0 &&  data14_dp >data9_dp){
			alert("Value Should be less than District Panchayat");
			$("#data14_dp").val(' ');
		}else{
			if(data13_dp>0 &&   (data14_dp +data13_dp) >data9_dp){
				alert("Value Should be less than partly covered in Fifth Schedule/ PESA-Areas");
				$("#data14_dp").val(' ');
			}
		}
		
		
		data9_bp=$_checkEmptyObject_value($("#data9_bp").val());
		data13_bp=$_checkEmptyObject_value($("#data13_bp").val());
		if(data9_bp>0 && data13_bp>data9_bp){
			alert("Value Should be less than Block Panchayat");
			$("#data13_bp").val(' ');
		}
		
		data9_dp=$_checkEmptyObject_value($("#data9_dp").val());
		data13_dp=$_checkEmptyObject_value($("#data13_dp").val());
		if(data9_dp>0 && data13_dp>data9_dp){
			alert("Value Should be less than District Panchayat");
			$("#data13_dp").val(' ');
		}
		
		data9_gp=$_checkEmptyObject_value($("#data9_gp").val());
		data10_state=$_checkEmptyObject_value($("#data10_state").val());
		if(data9_gp>0 && data10_state>data9_gp){
			alert("Value Should be less than Gram Panchayat");
			$("#data10_state").val(' ');
		}
		
		data9_gp=$_checkEmptyObject_value($("#data9_gp").val());
		data11_state=$_checkEmptyObject_value($("#data11_state").val());
		if(data9_gp>0 && data11_state>data9_gp){
			alert("Value Should be less than Gram Panchayat");
			$("#data11_state").val(' ');
		}
	
		/* Added by Ajit */
		
		data15_gp=$_checkEmptyObject_value($("#data15_gp").val());
		data15_bp=$_checkEmptyObject_value($("#data15_bp").val());
		if(data15_bp > 0){
			if(data15_gp > 0 && data15_bp > data15_gp){
			alert("Value Should not be less than no. of Autonomous District Councils (ADCs)");
			$("#data15_gp").val(' ');
		}
			}

		data9_gp=$_checkEmptyObject_value($("#data9_gp").val());
		data9_bp=$_checkEmptyObject_value($("#data9_bp").val());
		data9_dp=$_checkEmptyObject_value($("#data9_dp").val());
		 var AVG_GP =0;
		 var AVG_BP = 0;
		if($.parseJSON('${blockEnable}')){
				if(data9_bp>0 && data9_gp>0){
				  	AVG_GP=data9_gp/data9_bp;
				}
				if(data9_bp>0 && data9_dp>0){
					AVG_BP=data9_bp/data9_dp
				}
			
			}else{
				if(data9_gp>0 && data9_dp>0){
					AVG_GP = data9_gp/data9_dp;
				}
			 
			     AVG_BP =0;
			} 

				if(!$_checkEmptyObject(AVG_GP)){
					var avg=AVG_GP.toFixed(2);
					$("#data16_gp").val(avg);
				}
				if(!$_checkEmptyObject(AVG_BP)){
					var avgBp=AVG_BP.toFixed(2);
					$("#data16_bp").val(avgBp);
				}
			
				/* /*added by aashish barua  */
				/* var gram_panchayat = ($("#data9_gp").val() != '' && $("#data9_gp").val() != null && $("#data9_gp").val() != undefined) ? +$("#data9_gp").val() : 0; 
				var vdcs = ($("#data15_gp").val() != '' && $("#data15_gp").val() != null && $("#data15_gp").val() != undefined) ? +$("#data15_gp").val() : 0;  */
				/*  */ 
				
					data9_gp=$_checkEmptyObject_value($("#data9_gp").val()) + $_checkEmptyObject_value($("#data15_gp").val());
					data27_gp=$_checkEmptyObject_value($("#data27_gp").val());	
					if(data9_gp>0 && data27_gp > data9_gp){
						alert("Value Should be less than the total Gram Panchayat and VDCs if it is present.");
						$("#data27_gp").val(' ');
					}
					
					
					else{
						if(data27_gp>0 && $(this).attr('id')=="data27_gp" ){
							var BAL_NUMB=data9_gp-parseInt($("#data27_gp").val());
							/* var BAL_NUMB=parseInt($("#data9_gp").val())-parseInt($("#data27_gp").val()); */
							if(BAL_NUMB !== NaN){
								$("#data27_bp").parent('div').addClass('focused');
								$("#data27_bp").val(BAL_NUMB);
							}
						}
						
						
					}
				
					data9_gp=$_checkEmptyObject_value($("#data9_gp").val()) + $_checkEmptyObject_value($("#data15_gp").val());
					data27_bp=$_checkEmptyObject_value($("#data27_bp").val());	
					if(data9_gp>0 && data27_bp>data9_gp){
						alert("Value Should be less than the total Gram Panchayat and VDCs if it is present.");
						$("#data27_bp").val(' ');
					}
					else{
						if(data27_bp>0 && $(this).attr('id')=="data27_bp"){
						/* var BAL_NUMB=parseInt($("#data9_gp").val()) -parseInt($("#data27_bp").val()); */
						var BAL_NUMB=data9_gp -parseInt($("#data27_bp").val());
						if(BAL_NUMB !== NaN){
							$("#data27_gp").parent('div').addClass('focused');
							$("#data27_gp").val(BAL_NUMB);
						}
					}
						
					}
				/* }else{
					alert("Please enter Gram Panchayat value first");
					$(this).val(' ');
				} */
			
			/* data45_state=$_checkEmptyObject_value($("#data45_state").val());
			data27_gp=$_checkEmptyObject_value($("#data27_gp").val());	
			if(data27_gp>0 && data45_state >data27_gp){
				alert("Value Should be less than or equal to number of Gram Panchayats having bhawan");
				$("#data45_state").val(' ');
			}
			
			data9_gp=$_checkEmptyObject_value($("#data9_gp").val());
			data30_gp=$_checkEmptyObject_value($("#data30_gp").val());	
			if(data9_gp>0 && data30_gp > data9_gp){
				alert("Value Should be less than Gram Panchayat");
				$("#data30_gp").val(' ');
			}
			
			data9_gp=$_checkEmptyObject_value($("#data9_gp").val());
			data31_gp=$_checkEmptyObject_value($("#data31_gp").val());	
			if(data9_gp>0 && data31_gp > data9_gp){
				alert("Value Should be less than Gram Panchayat");
				$("#data31_gp").val(' ');
			} */
			
					/* Added by Ajit */	
					
			        data9_gp=$_checkEmptyObject_value($("#data27_gp").val()); //here data9_gp denotes total panchayat with bhawans 
					/* if(data27_gp>0)
					{ */
							data45_gp=$_checkEmptyObject_value($("#data45_gp").val());	
						if(data27_gp>0 && data45_gp > data27_gp){
							alert("Value Should be less than Gram Panchayat with Bhawan");
							$("#data45_gp").val(' ');
						}
						
						
						else{
							if(data45_gp>0 && $(this).attr('id')=="data45_gp"){
								var BAL_NUMB=parseInt($("#data27_gp").val())-parseInt($("#data45_gp").val());
								if(BAL_NUMB!= NaN){
									$("#data45_bp").parent('div').addClass('focused');
									$("#data45_bp").val(BAL_NUMB);
								}
							}
							
							
						}
					
						data27_gp=$_checkEmptyObject_value($("#data27_gp").val());
						data45_bp=$_checkEmptyObject_value($("#data45_bp").val());	
						if(data27_gp>0 && data45_bp > data27_gp){
							alert("Value Should be less than Gram Panchayat with Bhawan");
							$("#data45_bp").val(' ');
						}
						else{
							if(data45_bp>0 && $(this).attr('id')=="data45_bp"){
							var BAL_NUMB=parseInt($("#data27_gp").val()) -parseInt($("#data45_bp").val());
							if(BAL_NUMB!= NaN){
								$("#data45_gp").parent('div').addClass('focused');
								$("#data45_gp").val(BAL_NUMB);
							}
						}
							
						}
					/* }else{
						alert("Please enter Gram Panchayat with Bhawan value first");
						$(this).val(' ');
					} */
				
				/* data45_state=$_checkEmptyObject_value($("#data45_state").val()); */
		/* 		data45_gp=$_checkEmptyObject_value($("#data45_gp").val());	
				data45_bp=$_checkEmptyObject_value($("#data45_bp").val());	
				data27_gp=$_checkEmptyObject_value($("#data27_gp").val());	
				total45 = data45_gp + data45_bp;
				if(data27_gp>0 && total45 > data27_gp){
					alert("Value Should be less than or equal to number of Gram Panchayats having bhawan");
					/* $("#data45_state").val(' '); */
				/* 	$("#data45_gp").val(' ');
					$("#data45_bp").val(' ');
				} */ 
				
				data27_gp=$_checkEmptyObject_value($("#data27_gp").val());
				/* if(data27_gp>0)
				{ */
						data30_gp=$_checkEmptyObject_value($("#data30_gp").val());	
					if(data27_gp>0 && data30_gp > data27_gp){
						alert("Value Should be less than Gram Panchayat with Bhawan");
						$("#data30_gp").val(' ');
					}
					
					
					else{
						if(data30_gp>0 && $(this).attr('id')=="data30_gp"){
							var BAL_NUMB=parseInt($("#data27_gp").val())-parseInt($("#data30_gp").val());
							if(BAL_NUMB!= NaN){
								$("#data30_bp").parent('div').addClass('focused');
								$("#data30_bp").val(BAL_NUMB);
							}
						}
						
						
					}
				
					data27_gp=$_checkEmptyObject_value($("#data27_gp").val());
					data30_bp=$_checkEmptyObject_value($("#data30_bp").val());	
					if(data27_gp>0 && data30_bp>data27_gp){
						alert("Value Should be less than Gram Panchayat with Bhawan");
						$("#data30_bp").val(' ');
					}
					else{
						if(data30_bp>0 && $(this).attr('id')=="data30_bp"){
						var BAL_NUMB=parseInt($("#data27_gp").val()) -parseInt($("#data30_bp").val());
						if(BAL_NUMB!= NaN){
							$("#data30_gp").parent('div').addClass('focused');
							$("#data30_gp").val(BAL_NUMB);
						}
					}
						
					}
				/* }else{
					alert("Please enter Gram Panchayat value first");
					$(this).val(' ');
				} */
				 
			/* 	data9_gp=$_checkEmptyObject_value($("#data9_gp").val());
				data30_gp=$_checkEmptyObject_value($("#data30_gp").val());	
				data30_bp=$_checkEmptyObject_value($("#data30_bp").val());
				tatal30 = data30_gp + data30_bp;
				if(data9_gp>0 && tatal30 > data9_gp){
					alert("Value Should be less than Gram Panchayat");
					$("#data30_gp").val(' ');
					$("#data30_bp").val(' ');
				} */
				
				data27_gp=$_checkEmptyObject_value($("#data27_gp").val());
				/* if(data27_gp>0)
				{ */
						data31_gp=$_checkEmptyObject_value($("#data31_gp").val());	
					if(data27_gp>0 && data31_gp > data27_gp){
						alert("Value Should be less than Gram Panchayat with Bhawan");
						$("#data31_gp").val(' ');
					}
					
					
					else{
						if(data31_gp>0 && $(this).attr('id')=="data31_gp"){
							var BAL_NUMB=parseInt($("#data27_gp").val())-parseInt($("#data31_gp").val());
							if(BAL_NUMB!= NaN){
								$("#data31_bp").parent('div').addClass('focused');
								$("#data31_bp").val(BAL_NUMB);
							}
						}
						
						
					}
				
					data27_gp=$_checkEmptyObject_value($("#data27_gp").val());
					data31_bp=$_checkEmptyObject_value($("#data31_bp").val());	
					if(data27_gp>0 && data31_bp>data27_gp){
						alert("Value Should be less than Gram Panchayat with Bhawan");
						$("#data31_bp").val(' ');
					}
					else{
						if(data31_bp>0 && $(this).attr('id')=="data31_bp"){
						var BAL_NUMB=parseInt($("#data27_gp").val()) -parseInt($("#data31_bp").val());
						if(BAL_NUMB!= NaN){
							$("#data31_gp").parent('div').addClass('focused');
							$("#data31_gp").val(BAL_NUMB);
						}
					}
						
					}
				/* }else{
					alert("Please enter Gram Panchayat value first");
					$(this).val(' ');
				} */
				
				/* data9_gp=$_checkEmptyObject_value($("#data9_gp").val());
				data31_gp=$_checkEmptyObject_value($("#data31_gp").val());	
				data31_bp=$_checkEmptyObject_value($("#data31_bp").val());	
				total31 = data31_gp + data31_bp;
				if(data9_gp>0 && total31 > data9_gp){
					alert("Value Should be less than Gram Panchayat");
					$("#data31_gp").val(' ');
					$("#data31_bp").val(' ');
				} */
			
			/* data9_gp=$_checkEmptyObject_value($("#data9_gp").val());
			data32_gp=$_checkEmptyObject_value($("#data32_gp").val());	
			
			if(data9_gp>0 && data32_gp > data9_gp){
				alert("Value Should be less than Gram Panchayat");
				$("#data32_gp").val(' ');
			} */
			
			

			data27_gp=$_checkEmptyObject_value($("#data27_gp").val());
			data32_bp=$_checkEmptyObject_value($("#data32_bp").val());	
			data32_gp=$_checkEmptyObject_value($("#data32_gp").val());
			
			
			
			if(data27_gp>0 && data32_bp>data27_gp){
				alert("Value Should be less than Gram Panchayat with Bhawan");
				$("#data32_bp").val(' ');
			}
			else{
				if(data32_bp>0 ){
				var BAL_NUMB=data27_gp-data32_bp;
				$("#data32_gp").parent('div').addClass('focused');
				$("#data32_gp").val(BAL_NUMB);
				
			}
				
			}
			
			if(data27_gp>0 && data32_gp>data27_gp){
				alert("Value Should be less than Gram Panchayat with Bhawan");
				$("#data32_gp").val(' ');
			}
			else{
				if(data32_gp>0){
				var BAL_NUMB=data27_gp-data32_gp;
				$("#data32_bp").parent('div').addClass('focused');
				$("#data32_bp").val(BAL_NUMB);
				
			}
				
			}
			
			
			
			data9_gp=$_checkEmptyObject_value($("#data9_gp").val());
			data33_gp=$_checkEmptyObject_value($("#data33_gp").val());
			data33_bp=$_checkEmptyObject_value($("#data33_bp").val());
			if(data9_gp>0 && data33_gp != (data9_gp*10)){
				if((data33_gp+data33_bp) > (data9_gp*10)){
					alert("Value Should be less than or equal to "+(data9_gp*10));
					$("#data33_gp").val(' ');
				}
			}
			
			data27_gp=$_checkEmptyObject_value($("#data27_gp").val());
			data48_gp=$_checkEmptyObject_value($("#data48_gp").val());	
			if(data27_gp>0 && data48_gp != (data27_gp*10)){
				if(data48_gp >(data27_gp*10)){
					alert("Value Should be less than Gram Panchayat");
					$("#data48_gp").val(' ');
				}
			}
			
			
			data9_gp=$_checkEmptyObject_value($("#data9_gp").val());
			data48_gp=$_checkEmptyObject_value($("#data48_gp").val());
			data48_bp=$_checkEmptyObject_value($("#data48_bp").val());
			if(data48_gp>0 && data9_gp<data48_gp){
				alert("Value Should be less than Gram Panchayat");
				$("#data48_gp").val(' ');
			}else{
				if(data48_gp>0 && data9_gp>0){
					$("#data48_bp").parent('div').addClass('focused');
					$("#data48_bp").val(data9_gp-data48_gp);	
					
				}
			}
			
			if(data48_bp>0 && data9_gp<data48_bp){
				alert("Value Should be less than Gram Panchayat");
				$("#data48_bp").val(' ');
			}else{
				if(data48_bp>0 && data9_gp>0){
					$("#data48_gp").parent('div').addClass('focused');
					$("#data48_gp").val(data9_gp-data48_bp);	
				}
			}
			
			
			
			
			
			data9_gp=$_checkEmptyObject_value($("#data9_gp").val());
			data11_gp=$_checkEmptyObject_value($("#data11_gp").val());	
			if(data9_gp>0 && data11_gp > data9_gp){
				alert("Value Should be less than of total no of Gram Panchayat of State");
				$("#data11_gp").val(' ');
			}
			
			data9_bp=$_checkEmptyObject_value($("#data9_bp").val());
			data11_bp=$_checkEmptyObject_value($("#data11_bp").val());	
			if(data9_bp>0 && data11_bp > data9_bp){
				alert("Value Should be less than of total no of Block  Panchayat of State");
				$("#data11_bp").val(' ');
			}
			
			
			data9_dp=$_checkEmptyObject_value($("#data9_dp").val());
			data11_dp=$_checkEmptyObject_value($("#data11_dp").val());	
			if(data9_dp>0 && data11_dp > data9_dp){
				alert("Value Should be less than of total no of District Panchayat of State");
				$("#data11_dp").val(' ');
			}
			
			
			data9_gp=$_checkEmptyObject_value($("#data9_gp").val());
			data34_gp_count=$_checkEmptyObject_value($("#data34_gp_count").val());	
			if(data9_gp>0 && data34_gp_count > data9_gp){
				alert("Value Should be less than of total no of Gram Panchayat of State");
				$("#data34_gp_count").val(' ');
			}
			
			data9_bp=$_checkEmptyObject_value($("#data9_bp").val());
			data34_bp_count=$_checkEmptyObject_value($("#data34_bp_count").val());	
			if(data9_bp>0 && data34_bp_count > data9_bp){
				alert("Value Should be less than of total no of Block  Panchayat of State");
				$("#data34_bp_count").val(' ');
			}
			
			
			data9_dp=$_checkEmptyObject_value($("#data9_dp").val());
			data34_dp_count=$_checkEmptyObject_value($("#data34_dp_count").val());	
			if(data9_dp>0 && data34_dp_count > data9_dp){
				alert("Value Should be less than of total no of District Panchayat of State");
				$("#data34_dp_count").val(' ');
			}
			
			
		   
			if($("#data34_gp1").is(':checked')){
				$("#data34_gp_count_div").show();
			}else{
				$("#data34_gp_count_div").hide();
			}
			
			if($("#data34_bp1").is(':checked')){
				$("#data34_bp_count_div").show();
			}else{
				$("#data34_bp_count_div").hide();
			}
			
			if($("#data34_dp1").is(':checked')){
				$("#data34_dp_count_div").show();
			}else{
				$("#data34_dp_count_div").hide();
			}
		
	});
	
	
	
	$("#data18_gp").on('change', function () {
        var dateNext = Date.parse($(this).val());
        var datePRV = Date.parse($("#data18_bp").val());
        
        if (dateNext < datePRV) {
            alert('Next date must be greater than Previous date');
            $(this).val('');
        }
    });
	
	
	$(".validate").keypress(function (e) {
	     //if the letter is not digit then display error and don't type anything
	     if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
	        //display error message
	        $("#errmsg").html("Digits Only").show().fadeOut("slow");
	               return false;
	    }
	   });
	
	
});


function calculatePercentage(obj){
	/* if(obj != null && obj != undefined){
		var total_population= document.getElementById("data2_state").value;
		var percent=((document.getElementById("population_"+obj).value / total_population) *100).toFixed(2);
		if(percent <= 100){
			document.getElementById("percentage_"+obj).value =percent ; 
		}else{
			alert("Population should be less than Total population.");
			document.getElementById("population_"+obj).value ='';
			document.getElementById("percentage_"+obj).value='';
		}
		
		}else{
			alert("percentage function not working!");
		}
	validateCountOfScSt(obj); */
	if(obj != null && obj != undefined){
		if(obj == 3){
		var total_population= document.getElementById("data2_state").value;
		var percent=((document.getElementById("population_"+obj).value / total_population) *100).toFixed(2);
		if(percent <= 100){
			document.getElementById("percentage_"+obj).value =percent ; 
		}else{
			alert("Population should be less than Total population.");
			document.getElementById("population_"+obj).value ='';
			document.getElementById("percentage_"+obj).value='';
		}
		}else{
			var total_population= document.getElementById("population_3").value;
			var percent=((document.getElementById("population_"+obj).value / total_population) *100).toFixed(2);
			if(percent <= 100){
				document.getElementById("percentage_"+obj).value =percent ; 
			}else{
				alert("Population should be less than Total rural population.");
				document.getElementById("population_"+obj).value ='';
				document.getElementById("percentage_"+obj).value='';
			}
			
		}
		
		}else{
			alert("percentage function not working!");
		}
	if(obj != 3)
	validateCountOfScSt(obj);
}

/* Added by Ajit */

function validateTotalPopulation(obj){
	var total_population=0;
	var population_3=0;
	    total_population=$_checkEmptyObject_value($("#data2_state").val());
		population_3=$_checkEmptyObject_value($("#population_3").val());
		if(total_population<population_3){
			alert("Total population should be greater than  total rural population.")
			document.getElementById("data2_state").value ='';
			document.getElementById("population_3").value ='';
			document.getElementById("population_5").value ='';
			document.getElementById("population_6").value ='';
			document.getElementById("population_20").value ='';
			document.getElementById("percentage_3").value ='';
			document.getElementById("percentage_5").value ='' ;
			document.getElementById("percentage_6").value ='' ;
			document.getElementById("percentage_20").value ='' ;
			
			
		}
}

function validateCountOfScSt(obj){
	/* var remaining_population=parseInt($("#data2_state").val());
	if(obj == 5){
		if($("#population_6").val() == ""){
			remaining_population -= 0;
		}else{
			remaining_population -= parseInt($("#population_6").val());
		}
	}
	else{
		if($("#population_5").val() == ""){
			remaining_population -= 0;
		}else{
			remaining_population -= parseInt($("#population_5").val());
		}
	}
	if(parseInt($("#population_5").val()) > remaining_population && obj == 5){
		alert("SC population should be less than :" + remaining_population);
		$("#population_5").val('');
		document.getElementById("percentage_"+obj).value='';
	}
	if(parseInt($("#population_6").val()) > remaining_population && obj == 6){
		alert("ST population should be less than :" + remaining_population);
		$("#population_6").val('');
		document.getElementById("percentage_"+obj).value='';
	} */
	
	var remaining_population=parseInt($("#population_3").val());
	if(obj == 5){
		if($("#population_6").val() == ""){
			remaining_population -= 0;
		}else{
			remaining_population -= parseInt($("#population_6").val());
		}
	}
	else{
		if($("#population_5").val() == ""){
			remaining_population -= 0;
		}else{
			remaining_population -= parseInt($("#population_5").val());
		}
	}
	if(parseInt($("#population_5").val()) > remaining_population && obj == 5){
		alert("SC population should be less than :" + remaining_population);
		$("#population_5").val('');
		document.getElementById("percentage_"+obj).value='';
	}
	if(parseInt($("#population_6").val()) > remaining_population && obj == 6){
		alert("ST population should be less than :" + remaining_population);
		$("#population_6").val('');
		document.getElementById("percentage_"+obj).value='';
	}
	
}


function setTotalModal(){
	
var totscmodal=0;
var totstmodal=0;
var totgenmodal=0;
var errorFlag=false;
	/* $( "[id^=erSC]" ).each(function( ) {
		if(!$_checkEmptyObject($(this).val())){
			totscmodal=totscmodal+parseInt($(this).val());
		}
	});
	if(parseInt($("#population_5").val())<totscmodal){
		errorFlag=true;
		alert("Total Elected Representative of SC not exceed Total population of SC");
	}

	$( "[id^=erST]" ).each(function( ) {
		if(!$_checkEmptyObject($(this).val())){
			totstmodal=totstmodal+parseInt($(this).val());
		}
	});
	if(parseInt($("#population_6").val())<totstmodal){
		errorFlag=true;
		alert("Total Elected Representative of ST not exceed Total population of ST");
	}
	
	$( "[id^=erGEN]" ).each(function( ) {
		if(!$_checkEmptyObject($(this).val())){
			totgenmodal=totgenmodal+parseInt($(this).val());
		}
	});
	genpop=(parseInt($("#data2_state").val())-(parseInt($("#population_5").val())+parseInt($("#population_6").val())))
	if(genpop<totstmodal){
		errorFlag=true;
		alert("Total Elected Representative of Gernal not exceed Total population of Gernal");
	} */
	
	
	
	if(!errorFlag){
		
		var scSM=0;
		var stSM=0;
		var genSM=0;
		var scMM=0;
		var stMM=0;
		var genMM=0;
		
			if(!$_checkEmptyObject($("#erSC00").val())){
				scSM=	parseInt($("#erSC00").val());
			}
				
			if(!$_checkEmptyObject($("#erST00").val())){
				stSM=	parseInt($("#erST00").val());
			}
			
			if(!$_checkEmptyObject($("#erGEN00").val())){
				genSM=	parseInt($("#erGEN00").val());
			}
			
			if(!$_checkEmptyObject($("#erSC10").val())){
				scMM=	parseInt($("#erSC10").val());
			}
				
			if(!$_checkEmptyObject($("#erST10").val())){
				stMM=	parseInt($("#erST10").val());
			}
			
			if(!$_checkEmptyObject($("#erGEN10").val())){
				genMM=	parseInt($("#erGEN10").val());
			}
			
		totMGP=scSM+stSM+genSM+scMM+stMM+genMM;
		
		 scSM=0;
		 stSM=0;
		 genSM=0;
		 scMM=0;
		 stMM=0;
		 genMM=0;
		
			if(!$_checkEmptyObject($("#erSC01").val())){
				scSM=	parseInt($("#erSC01").val());
			}
				
			if(!$_checkEmptyObject($("#erST01").val())){
				stSM=parseInt($("#erST01").val());
			}
			
			if(!$_checkEmptyObject($("#erGEN01").val())){
				genSM=	parseInt($("#erGEN01").val());
			}
			
			if(!$_checkEmptyObject($("#erSC11").val())){
				scMM=	parseInt($("#erSC11").val());
			}
				
			if(!$_checkEmptyObject($("#erST11").val())){
				stMM=	parseInt($("#erST11").val());
			}
			
			if(!$_checkEmptyObject($("#erGEN11").val())){
				genMM=	parseInt($("#erGEN11").val());
			}
			
		
		
		
		totMBP=scSM+stSM+genSM+scMM+stMM+genMM;
		
		
		 scSM=0;
		 stSM=0;
		 genSM=0;
		 scMM=0;
		 stMM=0;
		 genMM=0;
		
			if(!$_checkEmptyObject($("#erSC02").val())){
				scSM=	parseInt($("#erSC02").val());
			}
				
			if(!$_checkEmptyObject($("#erST02").val())){
				stSM=	parseInt($("#erST02").val());
			}
			
			if(!$_checkEmptyObject($("#erGEN02").val())){
				genSM=	parseInt($("#erGEN02").val());
			}
			
			if(!$_checkEmptyObject($("#erSC12").val())){
				scMM=	parseInt($("#erSC12").val());
			}
				
			if(!$_checkEmptyObject($("#erST12").val())){
				stMM=	parseInt($("#erST12").val());
			}
			
			if(!$_checkEmptyObject($("#erGEN12").val())){
				genMM=	parseInt($("#erGEN12").val());
			}
			
		
		
		
		totMDP=scSM+stSM+genSM+scMM+stMM+genMM;
		
		$("#total10").val(totMGP);
		$("#total11").val(totMBP);
		$("#total12").val(totMDP);
		
		var scSF=0;
		var stSF=0;
		var genSF=0;
		var scMF=0;
		var stMF=0;
		var genMF=0;
		
			if(!$_checkEmptyObject($("#erSC20").val())){
				scSF=	parseInt($("#erSC20").val());
			}
				
			if(!$_checkEmptyObject($("#erST20").val())){
				stSF=	parseInt($("#erST20").val());
			}
			
			if(!$_checkEmptyObject($("#erGEN20").val())){
				genSF=	parseInt($("#erGEN20").val());
			}
			
			if(!$_checkEmptyObject($("#erSC30").val())){
				scMF=	parseInt($("#erSC30").val());
			}
				
			if(!$_checkEmptyObject($("#erST30").val())){
				stMF=	parseInt($("#erST30").val());
			}
			
			if(!$_checkEmptyObject($("#erGEN30").val())){
				genMF=	parseInt($("#erGEN30").val());
			}
			
		totFGP=scSF+stSF+genSF+scMF+stMF+genMF;
		
			scSF=0;
			stSF=0;
			genSF=0;
			scMF=0;
			stMF=0;
			genMF=0;
		
			if(!$_checkEmptyObject($("#erSC21").val())){
				scSF=	parseInt($("#erSC21").val());
			}
				
			if(!$_checkEmptyObject($("#erST21").val())){
				stSF=	parseInt($("#erST21").val());
			}
			
			if(!$_checkEmptyObject($("#erGEN21").val())){
				genSF=	parseInt($("#erGEN21").val());
			}
			
			if(!$_checkEmptyObject($("#erSC31").val())){
				scMF=	parseInt($("#erSC31").val());
			}
				
			if(!$_checkEmptyObject($("#erST31").val())){
				stMF=	parseInt($("#erST31").val());
			}
			
			if(!$_checkEmptyObject($("#erGEN31").val())){
				genMF=	parseInt($("#erGEN31").val());
			}
			
		totFBP=scSF+stSF+genSF+scMF+stMF+genMF;
		
		scSF=0;
		stSF=0;
		genSF=0;
		scMF=0;
		stMF=0;
		genMF=0;
	
		if(!$_checkEmptyObject($("#erSC22").val())){
			scSF=	parseInt($("#erSC22").val());
		}
			
		if(!$_checkEmptyObject($("#erST22").val())){
			stSF=	parseInt($("#erST22").val());
		}
		
		if(!$_checkEmptyObject($("#erGEN22").val())){
			genSF=	parseInt($("#erGEN22").val());
		}
		
		if(!$_checkEmptyObject($("#erSC32").val())){
			scMF=	parseInt($("#erSC32").val());
		}
			
		if(!$_checkEmptyObject($("#erST32").val())){
			stMF=	parseInt($("#erST32").val());
		}
		
		if(!$_checkEmptyObject($("#erGEN32").val())){
			genMF=	parseInt($("#erGEN32").val());
		}
		
		totFDP=scSF+stSF+genSF+scMF+stMF+genMF;
		
		$("#total30").val(totFGP);
		$("#total31").val(totFBP);
		$("#total32").val(totFDP);
	
	}
}
</script>

  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content" style="width: 1123px;margin-left: -198px;margin-top: 66px;">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Panchayat At each Level</h4>
        </div>
        <div class="modal-body" style="overflow-y: auto; ">
          	<table class="table table-bordered">
				<tr>
					<td  rowspan="4"><b>Panchayat</b></td>
					<td  colspan="14"><b>Elected Representative</b></td>
				</tr>
				<tr>
					<td  colspan="7"><b>Male</b></td>
					<td  colspan="7"><b>Female</b></td>
				</tr>
				<tr>
					<c:forEach begin="0" end="1" varStatus="condition">
					<td colspan="3"><b>Sarpanch/President</b></td>
					<td  colspan="3"><b>Members</b></td>
					
					<c:if test="${condition.index eq 0}">
							<td colspan="1"><b>Total Male</b></td>
						</c:if>
						<c:if test="${condition.index eq 1}">
							<td colspan="1"><b>Total Female</b></td>
						</c:if>
					</c:forEach>
					
				</tr>
				<tr>
					<c:forEach begin="0" end="3" varStatus="indexa">
						<td >SC</td>
						<td>ST</td>
						<td>General</td>
						
						<c:if test="${indexa.index eq 1 or indexa.index eq 3 }">
							<td></td>
						</c:if>
					</c:forEach>
				</tr>
				
				<c:forEach begin="0" end="2" varStatus="index">
					<tr>
						<td style="text-align: center;"><b>
							<c:if test="${index.index eq 0}">GP</c:if>
							<c:if test="${index.index eq 1}">BP</c:if>
							<c:if test="${index.index eq 2}">DP</c:if>
							</b>
						</td>
						
						
						<c:forEach begin="0" end="3" varStatus="indx">
						
							<td>
							 <c:choose>
			                 <c:when test="${blockEnable}">
								<input type="text" id="erSC${indx.index}${index.index}" onblur="setTotalModal()"   class="form-control input-sm" />
							</c:when>
							<c:otherwise>
								 <c:choose>
			                 		<c:when test="${index.index eq 1}">
										<input type="text" id="erSC${indx.index}${index.index}" disabled="true"   class="form-control input-sm" />
									</c:when>
									<c:otherwise>
										<input type="text" id="erSC${indx.index}${index.index}" onblur="setTotalModal()"   class="form-control input-sm" />
									</c:otherwise>
								</c:choose>
							</c:otherwise>
							</c:choose>
							</td>
							<td>
							 <c:choose>
			                 <c:when test="${blockEnable}">
								<input type="text" id="erST${indx.index}${index.index}" onblur="setTotalModal()"   class="form-control input-sm" />
							</c:when>
							<c:otherwise>
								<c:choose>
			                 		<c:when test="${index.index eq 1}">
										<input type="text" id="erST${indx.index}${index.index}" disabled="true"   class="form-control input-sm" />
									</c:when>
									<c:otherwise>
										<input type="text" id="erST${indx.index}${index.index}" onblur="setTotalModal()"   class="form-control input-sm" />
									</c:otherwise>
								</c:choose>
								
							</c:otherwise>
							</c:choose>
							</td>
							<td>
							<c:choose>
			                 <c:when test="${blockEnable}">
								<input type="text" id="erGEN${indx.index}${index.index}" onblur="setTotalModal()"   class="form-control input-sm" />
							</c:when>
							<c:otherwise>
								<c:choose>
			                 		<c:when test="${index.index eq 1}">
										<input type="text" id="erGEN${indx.index}${index.index}" disabled="true"   class="form-control input-sm" / >
									</c:when>
									<c:otherwise>
										<input type="text" id="erGEN${indx.index}${index.index}" onblur="setTotalModal()"   class="form-control input-sm" />
									</c:otherwise>
								</c:choose>
							
								
							</c:otherwise>
							</c:choose>
							</td>
							
							
							<c:if test="${indx.index eq 1 or indx.index eq 3 }">
							<td><input type="text" id="total${indx.index}${index.index}" class="form-control input-sm" disabled="true"></td>
							</c:if>
						</c:forEach>
						
					</tr>
				</c:forEach>
				
			</table>
          
          
        </div>
        <div class="modal-footer">
        	<button type="button" class="btn btn-success" onclick="setElectedRepData()">Save</button>
            <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>
  
  
  <!-- MODAL FOR FATCH FOCUS AREA -->
  
  <div class="modal fade" id="subjectArea" role="dialog">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Select the Flow/Subject area devolut to GPs</h4>
        </div>
        <div class="modal-body" style="height: 400px;">
       
          	<table class="table table-bordered table table-striped">
				<thead>
					<th>Sr.No</th>
					<th> Select</th>
					<th>Focus Area Name</th>
				</thead>
				<tbody>
					<c:forEach items="${FOCUS_AREAS_LIST}" var="focusAres" varStatus="index">
						<tr>
							<td>${index.count}</td>
							<td>
								<input type="checkbox" class="form-control" name="selectFocusArea" value="${focusAres.serialNumber}" />
								
							</td>
							<td>${focusAres.focusAreaName}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
          
          
        </div>
        <div class="modal-footer">
        	<button type="button" class="btn btn-success" onclick="setFocusArea()">Save</button>
            <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>
 
    <section class="content">
        <div class="container-fluid">
            <div class="row clearfix">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                	<div class="header">
                            <h4> Basic Information</h4>
                        </div>
                    
                         <form:form action="basicinfo.html" class="form-inline" modelAttribute="BASIC_INFO_MODEL" id="basicInfo" method="POST" onsubmit="disablingSave()">
                         <form:hidden path="basicInfoDefinationId" value="${BESIC_DEFINATION.basicInfoDefinationId}"/>
                          	<c:set var="sNo" value="0"/>
                          	<input type="hidden" id="stateCode" value="${STATE_CODE}" />
							 <c:forEach items="${BESIC_DEFINATION.basicInfoDefinationDetails}" var="field" varStatus="count">
							 
							  <c:if test="${field.basicInfoDefinationDetailsId eq 35}">
							   <form:hidden path="data[${field.basicInfoDefinationDetailsId}_focusAres]" id="dataFA"/>
							   </c:if>
							 
							 <c:if test="${field.basicInfoDefinationDetailsId ne 10 and field.basicInfoDefinationDetailsId ne 4}">
							 
							 <c:set value="${fn:length(BESIC_DEFINATION.basicInfoDefinationDetails)}" var="lenght"></c:set>
							 
							 <c:if test="${field.fieldType eq 'title'}">
							 <div class="card">
							 <div class="body">
							 </c:if>
	                              <c:choose>
	                              	<c:when test="${field.fieldType eq 'text'}">
	                              		
	                              		<c:if test="${!field.isState()}">
	                              			<label for="${field.labelName}">${sNo} . ${field.labelName}</label>
	                              		</c:if>
	                              		<c:if test="${field.isState()}">
									    	
								    	<div class="row clearfix">
		                                   	<c:choose>
								    		<c:when test="${field.basicInfoDefinationDetailsId ne 5 and (field.basicInfoDefinationDetailsId ne 6 and field.basicInfoDefinationDetailsId ne 20 and field.basicInfoDefinationDetailsId ne 3)}">
									    		<div class="col-sm-6">
			                                        <label >${sNo}. ${field.labelName}</label>
			                                    </div>
								    		</c:when>
								    		<c:otherwise>
								    			<div class="col-sm-3">
		                                       		 <label >${sNo}. ${field.labelName}</label>
		                                    	</div>
								    		</c:otherwise>
								    	</c:choose>
		                                   
		                                            
		                                            <c:if test="${field.basicInfoDefinationDetailsId eq 2}">
		                                            	<div class="col-sm-6">
		                                        			<div class="form-group">
		                                            			<div class="form-line">
		                                               				 <form:input   min="0" path="data[${field.basicInfoDefinationDetailsId}_state]" maxlength="10" class="form-control validate" onkeyup="validateTotalPopulation(this.value)" placeholder="Please enter ${field.labelName} "/>
		                                           				 </div>
		                                            		</div>
		                                           		</div>
		                                            </c:if>
		                                            
		                                            <c:if test="${field.basicInfoDefinationDetailsId ne 2}"> 
		                                            	<c:choose>
		                                            	<c:when test="${field.basicInfoDefinationDetailsId ne 5 and (field.basicInfoDefinationDetailsId ne 6 and field.basicInfoDefinationDetailsId ne 20 and field.basicInfoDefinationDetailsId ne 3)}">
		                                            	<div class="col-sm-6">
		                                        			<div class="form-group">
		                                            			<div class="form-line">
		                                                			<form:input   min="0" path="data[${field.basicInfoDefinationDetailsId}_state]"  class="form-control validate"  placeholder="Please enter ${field.labelName}"/>
																</div>
															</div>
														</div>
		                                            	</c:when>
		                                            	<%-- <c:when test="${field.basicInfoDefinationDetailsId eq 30 and field.basicInfoDefinationDetailsId eq 31 and field.basicInfoDefinationDetailsId eq 45}">
		                                            	<div class="col-sm-5">
		                                        			<div class="form-group">
		                                            			<div class="form-line">
		                                                			<form:input   min="0" path="data[${field.basicInfoDefinationDetailsId}_state]"  class="form-control validate" id="population_${field.basicInfoDefinationDetailsId}" onkeyup="calculatePercentage(${field.basicInfoDefinationDetailsId})" placeholder="Please enter ${field.labelName}"/>
																</div>
															</div>
														</div>
		                                            	</c:when> --%>
		                                            	<c:otherwise>
		                                            	<div class="col-sm-3">
		                                        			<div class="form-group">
		                                            			<div class="form-line">
		                                                			<form:input   min="0" path="data[${field.basicInfoDefinationDetailsId}_state]"  class="form-control validate" id="population_${field.basicInfoDefinationDetailsId}" onkeyup="calculatePercentage(${field.basicInfoDefinationDetailsId})" placeholder="Please enter ${field.labelName}"/>
																</div>
															</div>
														</div>
	                                            		<div class="col-sm-3">
	                                            			<c:if test="${field.basicInfoDefinationDetailsId eq 3}"><label >% of Rural Population of State/UT</label></c:if>
		                                            		 <c:if test="${field.basicInfoDefinationDetailsId eq 5}"><label >% of SC population</label></c:if>
		                                       		 		 <c:if test="${field.basicInfoDefinationDetailsId eq 6}"><label >% of ST population</label></c:if>
		                                       		 		 <c:if test="${field.basicInfoDefinationDetailsId eq 20}"><label >% of Women population</label></c:if>	
	                                    				</div>
	                                    				<div class="col-sm-3">
		                                        			<div class="form-group">
		                                            			<div class="form-line">
		                                                			<input type="text" min="0" class="form-control validate" id="percentage_${field.basicInfoDefinationDetailsId}" readonly="readonly"/>
																</div>
															</div>
														</div>
		                                            	</c:otherwise>
		                                            	</c:choose>		                                            			                                            
		                                            </c:if>
		                                            
		                                	</div>
	                              		</c:if>
	                              		<c:if test="${!field.isState()}">
			                               <div class="form-group ">
			                                 <div class="row clearfix">
			                               
			                               <c:if test="${field.isDP()}">
			                                <div class="col-sm-4">
			                                    <div class="form-group form-float">&nbsp;&nbsp;&nbsp;
			                                        <div class="form-line">
			                                        <%-- <c:choose> --%>
			                                        	<%-- <c:when test="${districtEnable}"> --%>
			                                        	<form:input  min="0" maxlength="10" path="data[${field.basicInfoDefinationDetailsId}_dp]" cssClass="form-control validate" disabled="${not districtEnable and field.basicInfoDefinationDetailsId ne 11}"/> &nbsp;&nbsp;&nbsp;
			                                        	<%-- </c:when> --%>
			                                       <%--  </c:choose> --%>
			                                            <label class="form-label">
			                                            <c:choose>
			                                            <c:when test="${field.basicInfoDefinationDetailsId eq 11}">
			                                            Number of Aspirational Districts
			                                            </c:when>
			                                            <c:when test="${districtEnable}">
			                                            District Panchayat 
			                                            </c:when>
			                                            <c:otherwise>
			                                            <div style="color: red">
			                                            District Panchayat not applicable</div>
			                                            </c:otherwise>
			                                            </c:choose>
			                                            
			                                            
			                                            
			                                            </label>
			                                        </div>
			                                    </div>
			                                </div>
			                                </c:if>
			                               
			                                 <%-- <c:if test="${field.isGP()}"> 
				                                <div class="col-sm-4">
				                                     <div class="form-group form-float">&nbsp;&nbsp;&nbsp;
				                                        <div class="form-line">
				                                            <form:input min="0" maxlength="10" path="data[${field.basicInfoDefinationDetailsId}_gp]" cssClass="form-control validate"/>&nbsp;&nbsp;&nbsp;
				                                            <label class="form-label">
				                                             <c:if test="${field.basicInfoDefinationDetailsId eq 11}">
				                                            Number of GPs under Aspirational Districts
				                                            </c:if>
				                                            <c:if test="${field.basicInfoDefinationDetailsId eq 27}">
				                                            Gram Panchayat with Bhawan
				                                            </c:if>
				                                            <c:if test="${field.basicInfoDefinationDetailsId eq 15}">
				                                            Number of ADCs
				                                            </c:if>
				                                            <c:if test="${field.basicInfoDefinationDetailsId eq 48}">
				                                           	Gram Panchayats with CSCs
				                                            </c:if>
				                                             <c:if test="${field.basicInfoDefinationDetailsId eq 33}">
				                                           Panchayat Secy or equivalent
				                                            </c:if>
				                                            <c:if test="${field.basicInfoDefinationDetailsId ne 27 && field.basicInfoDefinationDetailsId ne 15 
				                                            && field.basicInfoDefinationDetailsId ne 48 && field.basicInfoDefinationDetailsId ne 11 && field.basicInfoDefinationDetailsId ne 33}">
				                                            Gram Panchayat
				                                            </c:if>
				                                            </label>
				                                        </div>
				                                    </div>
				                                </div>
			                              </c:if> --%>
			                                
			                                <c:if test="${field.isBP()}">
			                                <div class="col-sm-4">
			                                     <div class="form-group form-float">&nbsp;&nbsp;&nbsp;
			                                        <div class="form-line">
			                                      <c:choose>
			                                        <c:when test="${blockEnable}">
			                                        <form:input  min="0" maxlength="10" path="data[${field.basicInfoDefinationDetailsId}_bp]" cssClass="form-control validate"/> &nbsp;&nbsp;&nbsp;
			                                         <label class="form-label">
			                                         
			                                         <c:choose>
				                                         <c:when test="${field.basicInfoDefinationDetailsId eq 11}">
				                                          Number of Blocks under Aspirational Districts
				                                         </c:when>
				                                         <c:when test="${field.basicInfoDefinationDetailsId eq 27}">
				                                         Gram Panchayat without Bhawan
				                                         </c:when>
				                                          <c:when test="${field.basicInfoDefinationDetailsId eq 15}">
				                                         Number of ADCs
				                                         </c:when>
				                                          <c:when test="${field.basicInfoDefinationDetailsId eq 48}">
				                                         	Gram Panchayats without CSCs
				                                         </c:when>
				                                          <c:when test="${field.basicInfoDefinationDetailsId eq 33}">
				                                         	 Others
				                                         </c:when>
				                                         <c:when test="${field.basicInfoDefinationDetailsId eq 30}">
				                                         	  GP Bhawan without computer
				                                         </c:when>
				                                         <c:when test="${field.basicInfoDefinationDetailsId eq 31}">
				                                         	 GP Bhawan without internet connectivity
				                                         </c:when>
				                                         <c:when test="${field.basicInfoDefinationDetailsId eq 45}">
				                                         	 GP Bhawan without toilet facility
				                                         </c:when>
				                                          <c:when test="${field.basicInfoDefinationDetailsId eq 32}">
				                                           			GP Bhawan without Electricity
				                                            </c:when>
				                                          <c:when test="${field.basicInfoDefinationDetailsId ne 27 && field.basicInfoDefinationDetailsId ne 15 && field.basicInfoDefinationDetailsId ne 48 && field.basicInfoDefinationDetailsId ne 30 && field.basicInfoDefinationDetailsId ne 31 && field.basicInfoDefinationDetailsId ne 45
				                                          && field.basicInfoDefinationDetailsId ne 33 && field.basicInfoDefinationDetailsId ne 11 && field.basicInfoDefinationDetailsId ne 32 }">
				                                         	  Block Panchayat
				                                         </c:when>
			                                         </c:choose>
			                                         
			                                            </label>
			                                        </c:when>
			                                        <c:otherwise>
						                                        <c:choose>
						                                        	<c:when test="${field.basicInfoDefinationDetailsId eq 11}">
							                                         <form:input  min="0" maxlength="10" path="data[${field.basicInfoDefinationDetailsId}_bp]" cssClass="form-control validate"/> &nbsp;&nbsp;&nbsp;
			                                         				<label class="form-label">
							                                         Number of Blocks under Aspirational Districts
							                                          </label>
							                                         </c:when>
							                                         <c:when test="${field.basicInfoDefinationDetailsId eq 27}">
							                                         <form:input  min="0" maxlength="10" path="data[${field.basicInfoDefinationDetailsId}_bp]" cssClass="form-control validate"/> &nbsp;&nbsp;&nbsp;
			                                         				<label class="form-label">
							                                         Gram Panchayat without Bhawan
							                                          </label>
							                                         </c:when>
							                                          <c:when test="${field.basicInfoDefinationDetailsId eq 15}">
							                                          <form:input  min="0" maxlength="10" path="data[${field.basicInfoDefinationDetailsId}_bp]" cssClass="form-control validate"/> &nbsp;&nbsp;&nbsp;
			                                         				<label class="form-label">
							                                         Number of ADCs
							                                          </label>
							                                         </c:when>
							                                          <c:when test="${field.basicInfoDefinationDetailsId eq 48}">
							                                          <form:input  min="0" maxlength="10" path="data[${field.basicInfoDefinationDetailsId}_bp]" cssClass="form-control validate"/> &nbsp;&nbsp;&nbsp;
			                                         				<label class="form-label">
							                                         	Gram Panchayats without CSCs
							                                         	 </label>
							                                         </c:when>
							                                          <c:when test="${field.basicInfoDefinationDetailsId eq 33}">
							                                          <form:input  min="0" maxlength="10" path="data[${field.basicInfoDefinationDetailsId}_bp]" cssClass="form-control validate"/> &nbsp;&nbsp;&nbsp;
			                                         				<label class="form-label">
							                                         	 Others
							                                         	  </label>
							                                         </c:when>
							                                         <c:when test="${field.basicInfoDefinationDetailsId eq 30}">
							                                         <form:input  min="0" maxlength="10" path="data[${field.basicInfoDefinationDetailsId}_bp]" cssClass="form-control validate"/> &nbsp;&nbsp;&nbsp;
			                                         				<label class="form-label">
							                                         	  GP Bhawan without computer
							                                         	   </label>
							                                         </c:when>
							                                         <c:when test="${field.basicInfoDefinationDetailsId eq 31}">
							                                         <form:input  min="0" maxlength="10" path="data[${field.basicInfoDefinationDetailsId}_bp]" cssClass="form-control validate"/> &nbsp;&nbsp;&nbsp;
			                                         				<label class="form-label">
							                                         	 GP Bhawan without internet connectivity
							                                         	  </label>
							                                         </c:when>
							                                         <c:when test="${field.basicInfoDefinationDetailsId eq 45}">
							                                         <form:input  min="0" maxlength="10" path="data[${field.basicInfoDefinationDetailsId}_bp]" cssClass="form-control validate"/> &nbsp;&nbsp;&nbsp;
			                                         				<label class="form-label">
							                                         	 GP Bhawan without toilet facility
							                                         	  </label>
							                                         </c:when>
							                                          <c:when test="${field.basicInfoDefinationDetailsId eq 32}">
							                                          <form:input  min="0" maxlength="10" path="data[${field.basicInfoDefinationDetailsId}_bp]" cssClass="form-control validate"/> &nbsp;&nbsp;&nbsp;
			                                         				<label class="form-label">
							                                           			GP Bhawan without Electricity
							                                           			 </label>
							                                            </c:when>
							                                            <c:otherwise>
										                                        <form:input  min="0" maxlength="10" path="data[${field.basicInfoDefinationDetailsId}_bp]" cssClass="form-control validate" disabled="true"/> &nbsp;&nbsp;&nbsp;
									                                         <label class="form-label" style="color: red">
									                                          Block Panchayat not applicable
									                                         </label>
							                                            </c:otherwise>
						                                        </c:choose>
			                                        
			                                        </c:otherwise>
			                                        </c:choose>
			                                        </div>
			                                    </div>
			                                </div>
			                               </c:if>
			                               
			                               <c:if test="${field.isGP()}"> 
				                                <div class="col-sm-4">
				                                     <div class="form-group form-float">&nbsp;&nbsp;&nbsp;
				                                        <div class="form-line">
				                                            <form:input min="0" maxlength="10" path="data[${field.basicInfoDefinationDetailsId}_gp]" cssClass="form-control validate" disabled="${field.basicInfoDefinationDetailsId ne 11 and field.basicInfoDefinationDetailsId ne 27 && field.basicInfoDefinationDetailsId ne 15  && field.basicInfoDefinationDetailsId ne 48 
				                                            && field.basicInfoDefinationDetailsId ne 33	  && field.basicInfoDefinationDetailsId ne 30 
				                                            && field.basicInfoDefinationDetailsId ne 31 && field.basicInfoDefinationDetailsId ne 45    && field.basicInfoDefinationDetailsId ne 32 and not gpEnable}"/>&nbsp;&nbsp;&nbsp;
				                                            <label class="form-label">
				                                            <c:choose>
				                                             <c:when test="${field.basicInfoDefinationDetailsId eq 11}">
				                                            Number of GPs under Aspirational Districts
				                                            </c:when>
				                                            <c:when test="${field.basicInfoDefinationDetailsId eq 27 }">
				                                            Gram Panchayat with Bhawan
				                                            </c:when>
				                                            <c:when test="${field.basicInfoDefinationDetailsId eq 15}">
				                                            Number of VDCs
				                                            </c:when>
				                                            <c:when test="${field.basicInfoDefinationDetailsId eq 48}">
				                                           	Gram Panchayats with CSCs
				                                            </c:when>
				                                             <c:when test="${field.basicInfoDefinationDetailsId eq 33}">
				                                           Panchayat Secy or equivalent
				                                            </c:when>
				                                            <c:when test="${field.basicInfoDefinationDetailsId eq 30}">
				                                           GP Bhawan with computer
				                                            </c:when>
				                                             <c:when test="${field.basicInfoDefinationDetailsId eq 31}">
				                                           GP Bhawan with internet connectivity
				                                            </c:when>
				                                             <c:when test="${field.basicInfoDefinationDetailsId eq 45}">
				                                           GP Bhawan with toilet facility
				                                            </c:when>
				                                              <c:when test="${field.basicInfoDefinationDetailsId eq 32}">
				                                           			GP Bhawan with Electricity
				                                            </c:when>
				                                            
				                                            <c:when test="${field.basicInfoDefinationDetailsId ne 27 && field.basicInfoDefinationDetailsId ne 15  && field.basicInfoDefinationDetailsId ne 48 
				                                            && field.basicInfoDefinationDetailsId ne 11 && field.basicInfoDefinationDetailsId ne 33	  && field.basicInfoDefinationDetailsId ne 30 
				                                            && field.basicInfoDefinationDetailsId ne 31 && field.basicInfoDefinationDetailsId ne 45    && field.basicInfoDefinationDetailsId ne 32 and gpEnable}">
				                                            Gram Panchayat
				                                            </c:when>
				                                            <c:when test="${not gpEnable}">
				                                            	<div style="color: red;">Gram Panchayat not applicable</div>
				                                            </c:when>
				                                            </c:choose>
				                                            </label>
				                                        </div>
				                                    </div>
				                                </div>
			                              </c:if>
			                               
			                              <%-- <c:if test="${field.isDP()}">
			                                <div class="col-sm-4">
			                                    <div class="form-group form-float">&nbsp;&nbsp;&nbsp;
			                                        <div class="form-line">
			                                            <form:input  min="0" maxlength="10" path="data[${field.basicInfoDefinationDetailsId}_dp]" cssClass="form-control validate"/> &nbsp;&nbsp;&nbsp;
			                                            <label class="form-label">
			                                            <c:choose>
			                                            <c:when test="${field.basicInfoDefinationDetailsId eq 11}">
			                                            Number of Aspirational Districts
			                                            </c:when>
			                                            <c:otherwise>
			                                            District Panchayat
			                                            </c:otherwise>
			                                            </c:choose>
			                                            
			                                            
			                                            
			                                            </label>
			                                        </div>
			                                    </div>
			                                </div>
			                                </c:if> --%>
			                                
			                              <c:if test="${field.isSubInfo()}"> 
			                                   <div class="col-sm-4">
			                                     <div class="form-group form-float">
			                                        <div class="form-line">
			                                       <!--  <table> -->
			                                            <c:forEach begin="0" end="2" varStatus="first">
			                                            
			                                            		<c:choose>
					                                            	<c:when test="${first.index eq 0}">
					                                            		<c:set var="type" value="GP"></c:set>
					                                            	</c:when>
					                                            	<c:when test="${first.index eq 1}">
					                                            		<c:set var="type" value="BP"></c:set>
					                                            	</c:when>
					                                            	<c:when test="${first.index eq 2}">
					                                            		<c:set var="type" value="DP"></c:set>
					                                            	</c:when>
					                                            </c:choose>
					                                            	
				                                            	
																<c:forEach begin="0" end="3" varStatus="second">
																	<c:if test="${second.index eq 0 or second.index eq 1}">
					                                            		<c:set var="GENDER" value="MALE"></c:set>
					                                            	</c:if>
																	<c:if test="${second.index eq 2 or second.index eq 3}">
					                                            		<c:set var="GENDER" value="FEMALE"></c:set>
					                                            	</c:if>
																	<c:if test="${second.index eq 0 or second.index eq 2}">
					                                            		<c:set var="memberType" value="Sarpanch"></c:set>
					                                            	</c:if>
																	<c:if test="${second.index eq 1 or second.index eq 3}">
					                                            		<c:set var="memberType" value="Members"></c:set>
					                                            	</c:if>
					                                            	
					                                            	
					                                            	<%-- <tr>
					                                            	<td>[${first.index},${second.index}]</td>
					                                            	<td>value@Elected${type}_${GENDER}_${memberType}_SC</td>
					                                            	<td>value@Elected${type}_${GENDER}_${memberType}_ST</td>
					                                            	<td>value@Elected${type}_${GENDER}_${memberType}_GEN</td>
					                                            	
					                                            	</tr> --%>
																<form:hidden id="Elected${type}_${GENDER}_${memberType}_SC" path="data[${field.basicInfoDefinationDetailsId}_${type}_${GENDER}_${memberType}_SC]" class="form-control"/>
																<form:hidden id="Elected${type}_${GENDER}_${memberType}_ST" path="data[${field.basicInfoDefinationDetailsId}_${type}_${GENDER}_${memberType}_ST]" class="form-control"/>
																<form:hidden id="Elected${type}_${GENDER}_${memberType}_GEN" path="data[${field.basicInfoDefinationDetailsId}_${type}_${GENDER}_${memberType}_GEN]" class="form-control"/> 
																	
																</c:forEach>
															 </c:forEach>
															<!--  </table> -->
			                                            <button id="btnERR" type="button" class="btn btn-info btn-sm" style="background-color:#661a74"   data-toggle="modal" data-target="#myModal" onclick="setValues()">Click here for ER-</button>
			                                        </div>
			                                    </div>
			                                </div>
			                              </c:if>  
			                            </div>
			                           </div>
			                           </c:if>
	                              	</c:when>
	                              	
	                              	
	                              	<c:when test="${field.fieldType eq 'checkbox'}">
	                              		<label for="password">${sNo} . ${field.labelName}</label>
			                               <div class="form-group">
			                                 <div class="row clearfix">
			                                
			                                <c:if test="${field.isGP()}"> 
			                                <div class="col-sm-4">
			                                     <div class="form-group form-float">
			                                       <label class="form-label">Gram Panchayat</label>
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
			                                     <label class="form-label">Block Panchayat</label>
			                                            <label for="yes">Yes</label>
			                                             <c:choose>
			                                        	<c:when test="${blockEnable}">
			                                            <form:radiobutton path="data[${field.basicInfoDefinationDetailsId}_bp]" value="true" /> &nbsp;&nbsp;&nbsp;
			                                            </c:when>
			                                            <c:otherwise>
			                                            <form:radiobutton path="data[${field.basicInfoDefinationDetailsId}_bp]" value="true" disabled="true" /> &nbsp;&nbsp;&nbsp;
			                                            </c:otherwise>
			                                            </c:choose>
			                                            <label for="yes">No</label>
			                                             <c:choose>
			                                        	<c:when test="${blockEnable}">
			                                            <form:radiobutton path="data[${field.basicInfoDefinationDetailsId}_bp]" value="false" /> &nbsp;&nbsp;&nbsp;
			                                            </c:when>
			                                            <c:otherwise>
			                                            <form:radiobutton path="data[${field.basicInfoDefinationDetailsId}_bp]" value="false" disabled="true" /> &nbsp;&nbsp;&nbsp;
			                                            </c:otherwise>
			                                            </c:choose>
			                                    </div>
			                                </div>
			                               </c:if>
			                               <c:if test="${field.isDP()}">
			                                <div class="col-sm-4">
			                                    <div class="form-group form-float">
			                                       <label class="form-label">District Panchayat</label>
			                                            <label for="yes">Yes</label>
			                                           <form:radiobutton path="data[${field.basicInfoDefinationDetailsId}_dp]" value="true" /> &nbsp;&nbsp;&nbsp;
			                                           <label for="yes">No</label>
			                                           <form:radiobutton path="data[${field.basicInfoDefinationDetailsId}_dp]" value="false" /> &nbsp;&nbsp;&nbsp;
			                                            
			                                           
			                                    </div>
			                                </div>
			                                </c:if>
			                               
			                               <c:choose>
				                                    <c:when test="${field.basicInfoDefinationDetailsId eq 34}">
				                                         <div class="col-sm-4" >
			                                    		<div class="form-group form-float"  id="data34_gp_count_div" style="display: none;">&nbsp;&nbsp;&nbsp;
			                                       		 <div class="form-line">
			                                            <form:input  min="0" maxlength="10" path="data[${field.basicInfoDefinationDetailsId}_gp_count]" cssClass="form-control validate"/> &nbsp;&nbsp;&nbsp;
			                                            <label class="form-label">No. of Garam Panchayat</label>
			                                            </div>
			                                            </div>
			                                			</div>
			                                 			<div class="col-sm-4" >
			                                    		<div class="form-group form-float" id="data34_bp_count_div" style="display: none;">&nbsp;&nbsp;&nbsp;
			                                       		 <div class="form-line" >
			                                            <form:input  min="0" maxlength="10" path="data[${field.basicInfoDefinationDetailsId}_bp_count]" cssClass="form-control validate"/> &nbsp;&nbsp;&nbsp;
			                                            <label class="form-label">No. of Block Panchayat</label>
			                                            </div>
			                                            </div>
			                               				 </div>
						                                 <div class="col-sm-4" >
				                                    		<div class="form-group form-float" id="data34_dp_count_div" style="display: none;">&nbsp;&nbsp;&nbsp;
				                                       		 <div class="form-line" >
				                                            <form:input  min="0" maxlength="10" path="data[${field.basicInfoDefinationDetailsId}_dp_count]" cssClass="form-control validate"/> &nbsp;&nbsp;&nbsp;
				                                            <label class="form-label">No. of District Panchayat</label>
				                                            </div>
				                                            </div>
						                                </div>
				                                     </c:when>
				                                  </c:choose>     
			                              <c:if test="${field.isSubInfo()}"> 
			                              <div class="col-sm-4">
			                                    <div class="form-group form-float">&nbsp;&nbsp;&nbsp;
			                                        <div class="form-line">
														<button id="btnSubArea" type="button" class="btn btn-info btn-sm" style="background-color:#661a74"   data-toggle="modal" data-target="#subjectArea">Click here for Focus Area</button>
													</div>
			                                    </div>
			                                </div>
			                              
			                              </c:if>
			                               
			                            </div>
			                           </div>
	                              	</c:when>
	                              	
	                              	<c:when test="${field.fieldType eq 'date'}">
	                              		<label for="password">${sNo} . ${field.labelName}</label>
			                               <div class="form-group">
			                                 <div class="row clearfix">
			                                
			                                <c:if test="${field.isDP()}">
			                                <div class="col-sm-4">
			                                    <div class="form-group form-float">&nbsp;&nbsp;&nbsp;
			                                        <div class="form-line">
			                                            <form:input type="date" class="form-control" max="2050-05-20" path="data[${field.basicInfoDefinationDetailsId}_dp]" /> &nbsp;&nbsp;&nbsp;
			                                            <!-- <label class="form-label">District Panchayat/District</label> -->
			                                        </div>
			                                    </div>
			                                </div>
			                                </c:if>
			                                <c:if test="${field.isBP()}">
			                                <div class="col-sm-4">
			                                     <div class="form-group form-float">&nbsp;&nbsp;&nbsp;
			                                     <label class="form-label">Previous Date</label>
			                                        <div class="form-line">
			                                            <form:input type="date"  class="form-control" path="data[${field.basicInfoDefinationDetailsId}_bp]" /> &nbsp;&nbsp;&nbsp;
			                                            
			                                        </div>
			                                    </div>
			                                </div>
			                               </c:if>
			                               <c:if test="${field.isGP()}"> 
				                                <div class="col-sm-4">
				                                     <div class="form-group form-float">&nbsp;&nbsp;&nbsp;
				                                     <label class="form-label">Next Date</label>
				                                        <div class="form-line">
				                                            <form:input type="date"  class="form-control" path="data[${field.basicInfoDefinationDetailsId}_gp]" /> &nbsp;&nbsp;&nbsp;
				                                            
				                                        </div>
				                                    </div>
				                                </div>
			                              </c:if>  
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
	                            	
	                            <c:if test="${(BESIC_DEFINATION.basicInfoDefinationDetails[count.index+1].fieldType eq 'title') or lenght eq count.count}">
	                              </div>
	                              </div>
	                              </c:if>  
	                         </c:if>
                           </c:forEach> 
                           <div class="card">
							 <div class="body">
                             <div class="form-group text-right">
                            	 
                                	<button type="submit" class="btn bg-green waves-effect save-button" onclick="return removeDisabledAttr('S')">SAVE
                                	</button>
                                	<button type="submit" class="btn bg-green waves-effect" onclick="return removeDisabledAttr('F')">FREEZE</button>
                              
                                	<button type="button" onclick="onClear(this)" class="btn bg-light-blue waves-effect">CLEAR</button>
                                	<button type="button" onclick="onClose('home.html?<csrf:token uri='home.html'/>')"  class="btn bg-orange waves-effect">CLOSE</button>
                               </div>
                              </div>
                           </div>
                        </div>
                        </form:form>
                        <c:if test="${isPesaState eq false }">

						<script>
						$("#data13_gp").prop("disabled", true);
						$("#data13_bp").prop("disabled", true);
						$("#data13_dp").prop("disabled", true);
						$("#data14_gp").prop("disabled", true);
						$("#data14_bp").prop("disabled", true);
						$("#data14_dp").prop("disabled", true);
						</script>
						</c:if>
                    </div>
                </div>
            </div>
    </section>
</html>