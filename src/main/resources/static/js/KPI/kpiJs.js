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