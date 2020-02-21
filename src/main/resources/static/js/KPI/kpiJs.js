setTimeout(function(){ voteViaAjax(0); }, 100);
function voteViaAjax(detailId){ 
	
   $.ajax({
   type : "POST",
   contentType : "application/json",
   url : "basicOrientationTrainingofER.html?<csrf:token uri='basicOrientationTrainingofER.html'/>&detailId="+detailId,
   dataType : 'json',
   cache : false,
   timeout : 100000,
   success : function(data) {
	$("#basicOrientationTrainingofERId").html(data[0]);
	$("#refreshertraningtoERId").html(data[1]);
	$("#shg_pri_convergenceID").html(data[2]);
	$("#eSPMUId").html(data[3]);
	$("#eDPMUId").html(data[4]);
	$("#eComputerizationId").html(data[5]);
	$("#bhawansConstructedId").html(data[6]);
	$("#bhawansRepairedId").html(data[7]);
	$("#CSCsId").html(data[8]);
	$("#withinStateId").html(data[9]);
	$("#OutsideStateId").html(data[10]);
	$("#panchyatStakeholderId").html(data[11]);
	$("#technicalsupporttoGPsId").html(data[12]);
   },
   error : function(e) {
    console.log(e);
   }
  });
}


function onloadKPI(kpiName){
	$('.bd-example-modal-lg').modal('show');
		$("label[for*='myModalLabel']").html(kpiName);
	$.ajax({
		   type : "POST",
		   contentType : "application/json",
		   url : "kpiHeaderPage.html?<csrf:token uri='kpiHeaderPage.html'/>&kpiName="+kpiName,
		   dataType : 'json',
		   cache : false,
		   timeout : 100000,
		   success : function(data) {
			   console.log(data);
			   var table='';
			   	table+='<thead style="background-color: #eeb2b2">';
			   		  table+='<tr>';
					   	 table+='<td><b> S.No </b></td>';
					   	 table+='<td> <b>State <b></td>';
					   	 table+='<td><b> G.P Name </b> </td>';
					     table+='<td><b> Status</b></td>';
					   	 table+='<td><b> Financial Year</b></td>';
					   table+='</tr>';
					   table+='</thead>';
					   table+='<tbody>';
					   
					   $.each(data, function (index) {
						   var slno=parseInt(index)+1;
						   table+='<tr>';
						   		table+='<td>'+slno+'</td>';
							   table+='<td>'+this.State+'</td>';
							   table+='<td>'+this.GP_Name+'</td>';
							   table+='<td>'+this.status+'</td>';
							   table+='<td>'+this.finyear+'</td>';
						   table+='</tr>'; 
					    });
					   
					   table+='</tbody>';
					  $('#tableExample').html(table);
		   },
		   error : function(e) {
		    console.log(e);
		   }
		  });
}