var publicModule = angular.module("publicModule", []);
publicModule.controller("InstitutionalInfraProgressReportController", [ '$scope', "InstitutionalInfraProgressReportService",
		function($scope, InstitutionalInfraProgressReportService) {
	
	$scope.TrainingInstituteTypeId=0;
	$scope.QprInstitutionalInfrastructure={};
	$scope.QprInstitutionalInfrastructure.qprInstitutionalInfraDetails=[];
	$scope.institutionaInfraReportStateData={};
	
	fetchDetailsForInstitutionalInfraProgressReport();
	
	function fetchDetailsForInstitutionalInfraProgressReport(){
		InstitutionalInfraProgressReportService.fetchDetailsForInstitutionalInfraProgressReport().then(function(response) {
			$scope.quatorDuration = response.data.quarterDuration;
			$scope.trainingnstituteType =response.data.buildingType;
		},function(error){
			alert(error);
		});
	}
	
	$scope.fetchInstInfraStatus=function(TrainingInstituteTypeId){
         InstitutionalInfraProgressReportService.fetchInstInfraStatus(TrainingInstituteTypeId).then(function(response){
        	 $scope.instInfraStatus=response.data;
		});
	};
	
	$scope.resetDetails=function(){
		$scope.TrainingInstituteTypeId=0;
	}
	
	$scope.resetDistrictList=function(){
		$scope.QprInstitutionalInfrastructure.districtCode=0;
	}
	
	$scope.fetchInstInfraStateData=function(TrainingInstituteTypeId){
		InstitutionalInfraProgressReportService.fetchInstInfraStateData(TrainingInstituteTypeId).then(function(response){
			$scope.institutionaInfraReportStateData=response.data;
		});
	}
	
	$scope.fetchDataAccordingToQuator=function(quatorId,TrainingInstituteTypeId){
		InstitutionalInfraProgressReportService.fetchDataAccordingToQuator(quatorId,TrainingInstituteTypeId).then(function(response){
			if(response.data.QprInstitutionalInfrastructure != undefined){
				$scope.QprInstitutionalInfrastructure=response.data.QprInstitutionalInfrastructure;
			}else{
				$scope.QprInstitutionalInfrastructure.qprPanchayatBhawanId=null;
				$scope.QprInstitutionalInfrastructure.panchayatBhawanActivityId=null;
				$scope.QprInstitutionalInfrastructure.createdBy=null;
				$scope.QprInstitutionalInfrastructure.createdOn=null;
				$scope.QprInstitutionalInfrastructure.lastUpdatedBy=null;
				$scope.QprInstitutionalInfrastructure.lastUpdatedOn=null;
				$scope.QprInstitutionalInfrastructure.isFreeze=false;
				$scope.QprInstitutionalInfrastructure.qprInstInfraId=null;
			}	
			if(response.data.qprInstitutionalInfraDetails !=undefined && response.data.qprInstitutionalInfraDetails.length != 0){
				$scope.QprInstitutionalInfrastructure.qprInstitutionalInfraDetails=response.data.qprInstitutionalInfraDetails;
			}else{
				for(let j=0;j<$scope.institutionaInfraReportStateData.length;j++){
					if($scope.QprInstitutionalInfrastructure.qprInstitutionalInfraDetails[j] == undefined){
						$scope.QprInstitutionalInfrastructure.qprInstitutionalInfraDetails[j]={
								qprInstInfraDetailsId : '',
								instituteInfrsaHrActivityDetailsId :'',
								instInfraStatusId : 0,
								expenditureIncurred : '',
								institutionalActivityTypeId : '',
								filePath : null,
						}
					}
					$scope.QprInstitutionalInfrastructure.qprInstitutionalInfraDetails[j].qprInstInfraDetailsId='';
					$scope.QprInstitutionalInfrastructure.qprInstitutionalInfraDetails[j].instituteInfrsaHrActivityDetailsId='';
					$scope.QprInstitutionalInfrastructure.qprInstitutionalInfraDetails[j].instInfraStatusId=0;
					$scope.QprInstitutionalInfrastructure.qprInstitutionalInfraDetails[j].expenditureIncurred='';
					$scope.QprInstitutionalInfrastructure.qprInstitutionalInfraDetails[j].institutionalActivityTypeId='';
					$scope.QprInstitutionalInfrastructure.qprInstitutionalInfraDetails[j].filePath=null;
					
				/*	for(let key in $scope.QprInstitutionalInfrastructure.qprInstitutionalInfraDetails[j]){
						key =='instInfraStatusId'?$scope.QprInstitutionalInfrastructure.qprInstitutionalInfraDetails[j][key]=0 : $scope.QprInstitutionalInfrastructure.qprInstitutionalInfraDetails[j][key]=null;
					}*/
				}
			}
		});
		
	};
	
   $scope.saveQprInstitutionalInfrastructureData=function(){
	   let status=false;
	   for(let i=0; i < $scope.institutionaInfraReportStateData.length;i++){
		   $scope.QprInstitutionalInfrastructure.qprInstitutionalInfraDetails[i].instituteInfrsaHrActivityDetailsId=$scope.institutionaInfraReportStateData[i].institutionalInfraActivityDetailId;
		   $scope.QprInstitutionalInfrastructure.institutionalInfraActivivtyId=$scope.institutionaInfraReportStateData[i].institutionalInfraActivityId;
		   $scope.QprInstitutionalInfrastructure.qprInstitutionalInfraDetails[i].institutionalActivityTypeId=$scope.TrainingInstituteTypeId;
		   if("expenditureIncurred" in $scope.QprInstitutionalInfrastructure.qprInstitutionalInfraDetails[i]){
			   $scope.QprInstitutionalInfrastructure.qprInstitutionalInfraDetails[i].instInfraStatusId == 0 ? status=false : status=true;
		   }else{
			   status=false;
			   break;
		   }
	   }
	   if(status){
		   InstitutionalInfraProgressReportService.saveQprInstitutionalInfrastructureData($scope.QprInstitutionalInfrastructure).then(function(response){
			   $scope.QprInstitutionalInfrastructure = response.data;
					toastr.success("Data Saved Successfully");
			},function(error){
				toastr.error("Something went wrong");
			});
	   }else{
		   toastr.error("Please fill All the Fields.");
	   }	
	  };
	  
}]);