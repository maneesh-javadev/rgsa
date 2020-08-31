
var finalizeInstInfra=angular.module("publicModule",[]);

finalizeInstInfra.controller("finalizeInstInfraController",['$scope','finalizeInstInfraService',function($scope,finalizeInstInfraService){
		
	$(document).ready(function() {
		checkValidation();
	});
	
	
	$scope.clearPage=function(){
		checkValidation();
	}
	
	function checkValidation()
	{
		finalizeInstInfraService.getInstInfraActivityValidation().then(function(response){
			console.log("inst component   "+response.data.INST_INFRA_COMPONENT_DATA);
			$scope.isApproved=response.data.IS_APPROVED;
			console.log("approve  "+$scope.isApproved);
			$scope.isFreezed=	response.data.IS_FREEZ;
			$scope.instComponentData=response.data.INST_INFRA_COMPONENT_DATA;
			if(!$scope.isApproved)
			{
			$('#errorMessage').addClass('show');
			$('#errorMessage').html('Plan has been not Approved by CEC.');
			$scope.isSaveVisible=false;
			}
			else if($scope.isFreezed)
			{
			$('#errorMessage').addClass('show');
			$('#errorMessage').html('QPR already Freezed.');
			$scope.isSaveVisible=false;
			}
			else
				{
				if(!$scope.instComponentData)
					{
					$('#errorMessage').addClass('show');
					$('#errorMessage').html('Institutional component data not exist.');
					$scope.isSaveVisible=false;
					}
				else
					{
					fetchOnLoad();
					}
				}
			
		})
	}
	
	function fetchOnLoad(){
	
	finalizeInstInfraService.getInstInfraActivity().then(function(response){
			console.log("response    "+response.data.INST_INFRA_ACTIVITY);
			console.log("length   "+response.data.INST_INFRA_ACTIVITY.length);
			$scope.districtCodes=response.data.DISTRICT_LIST;
			$scope.institutionalInfraActivity=response.data.INST_INFRA_ACTIVITY;
				if($scope.institutionalInfraActivity!=null && $scope.institutionalInfraActivity.length>0 && $scope.institutionalInfraActivity!=undefined)
					{
					$('#errorMessage').addClass('hide');
					$('#errorMessage').html('');
					$scope.isSaveVisible=true;
					var flag=true;
					angular.forEach($scope.institutionalInfraActivity,function(item){
						
						console.log("id   "+item.instId);
						if(flag){
						$scope.instInfra=item.instId;
						flag=false;}
					})
					}
		});
	}

	$scope.nslist=[];
	$scope.getValue=function(key,index,instDtlsId)
	{  
		console.log("selected "+key+"  "+index+"   "+instDtlsId);
		var map=[];
		map.push(instDtlsId,key);
		$scope.nslist[index]=map;
	}
	
	$scope.removeDistList;
	function getRemovableDistList(object,index){
		finalizeInstInfraService.getRemovableDistList(object).then(function(response){
			console.log("remove list  "+response.data.REMOVE_DIST_LIST+"   "+response.data.REMOVE_DIST_LIST.length);
			$scope.removeDistList=response.data.REMOVE_DIST_LIST;
			
			var sclist=[];
			for(var i=0;i<$scope.institutionalInfraActivity.length;i++)
				{
				var filterLbCodes=[];
				var id="combo"+i;
				var labelValue=$("#label_"+i).val();
				var selectedCombo=$("#"+id+" option:selected").val();
				console.log("combo value "+selectedCombo)
				if(id==index){
					continue;}
				else
					{
					$scope.createContentGPModal(id,$scope.removeDistList,labelValue,selectedCombo);
					}
				}	
			
		})
	}

	var dslist=[];
	var rdlist=[];
	$scope.remove = function(newWorkLocation,index){
		
		var res=index.substring(5,6);
		dslist[res]=newWorkLocation;
		
		angular.forEach(dslist,function(item){
			if(item!=null && item!='' && item!=undefined)
				{
				 obj={
							"districtCode":newWorkLocation
					};
				 rdlist.push(obj);
				}
		})
		console.log("rdlist  "+rdlist);
		
		getRemovableDistList(rdlist,index);
	}


	
	$scope.createContentGPModal=function(id,object,labelVal,selectedCombo){
		//console.log("inner id"+id+"   "+selectedCombo);
		$("#"+id).empty();
		var flag=true;
		if(selectedCombo!=null && selectedCombo!=undefined && selectedCombo!='')
			{
			angular.forEach(object,function(item1){
				if(item1.districtCode!=labelVal){
				if(item1.districtCode!=selectedCombo)
					{
					if(flag){
					angular.forEach($scope.districtCodes,function(item){
						if(item.districtCode==selectedCombo){
							$("#"+id).append("<option value="+item.districtCode+" selected>"+item.districtNameEnglish+"</option>");
							flag=false;
						}
					})
					}
				$("#"+id).append("<option value="+item1.districtCode+">"+item1.districtNameEnglish+"</option>");
					}			
				}
			})
			}
	else{
			
		$("#"+id).append("<option value='' selected>Select District</option>");
		angular.forEach(object,function(item){
			if(item.districtCode!=labelVal){
			$("#"+id).append("<option value="+item.districtCode+">"+item.districtNameEnglish+"</option>");
			}
		})
		}
	}
	
	$scope.saveInstitutionalInfraData=function(){
		instInfo=[];
		mysubj={"institutionalInfraActivityId":$scope.instInfra}
		angular.forEach($scope.nslist,function(item){
			if(item!=null && item!=''){
			console.log("tttt   "+item[0] +"   "+item[1]);
			myObj= {
				    "institutionalInfraActivityPlan" : mysubj,   
				    "institutionalInfraActivityDetailsId" : item[0] , 
				    "institutionalInfraLocation" : item[1]
				};
			instInfo.push( myObj );
			}
		})

    console.log("array   "+instInfo);	
    	
		if(instInfo.length>0){
			finalizeInstInfraService.saveInstInfoFinalizeWorkLocation(instInfo).then(function(response){
		    	if(response!=null && response.status==200){
		    		toastr.success(response.data.responseMessage);
		    	}else{
		    		toastr.error(response.data.responseMessage);
		    	}
		    	fetchOnLoad();
		    });
	    }else{
	    	toastr.error("please select at lease one district");
	    }	
	}	
}]);