var publicModule = angular.module("publicModule", []);
publicModule.controller("InstitutionalInfraProgressReportController", [ '$scope', "InstitutionalInfraProgressReportService",
		function($scope, InstitutionalInfraProgressReportService) {
	
	$scope.TrainingInstituteTypeId=0;
	$scope.QprInstitutionalInfrastructure={};
	$scope.QprInstitutionalInfrastructure.qprInstitutionalInfraDetails=[];
	$scope.institutionaInfraReportStateData={};
	
	$scope.institutionalInfraActivityPlanDetailsNBState=[];
	$scope.institutionalInfraActivityPlanDetailsNBDistrict=[];
	$scope.institutionalInfraActivityPlanDetailsCFState=[];
	$scope.institutionalInfraActivityPlanDetailsCFDistrict=[];
	
	fetchquarterDuration();
	
	function fetchquarterDuration(){
		InstitutionalInfraProgressReportService.fetchquarterDuration().then(function(response) {
			$scope.quatorDuration = response.data.quarterDuration;
			
		},function(error){
			alert(error);
		});
	}
	
	$scope.fetchDetailsForInstitutionalInfraProgressReport=function(quterId){
         InstitutionalInfraProgressReportService.fetchDetailsForInstitutionalInfraProgressReport(quterId).then(function(response){
        	 $scope.qprDetailsForInstitutional=response.data.instInfraStateDataForProgressReport;
        	 load_data();
		});
	};
	
	
	function load_data(){
		$scope.nbsindex=0;
		$scope.nbdindex=0;
		$scope.cfsindex=0;
		$scope.cfdindex=0;
		
		
			for (var i = 0; i < $scope.qprDetailsForInstitutional.length; i++) { 
				workType=$scope.qprDetailsForInstitutional[i].workType;
				trainingInstitueTypeId=$scope.qprDetailsForInstitutional[i].institutionalActivityTypeId;
				
				if(workType=='N' && trainingInstitueTypeId==2){
					$scope.institutionalInfraActivityPlanDetailsNBState[$scope.nbsindex]=$scope.qprDetailsForInstitutional[i];
					$scope.nbsindex++;
				}else if(workType=='N' && trainingInstitueTypeId==4 ){
					$scope.institutionalInfraActivityPlanDetailsNBDistrict[$scope.nbdindex]=$scope.qprDetailsForInstitutional[i];
					$scope.nbdindex++;
				}else if(workType=='C' && trainingInstitueTypeId==2 ){
					$scope.institutionalInfraActivityPlanDetailsCFState[$scope.cfsindex]=$scope.qprDetailsForInstitutional[i];
					$scope.cfsindex++;
				}else if(workType=='C' && trainingInstitueTypeId==4 ){
					$scope.institutionalInfraActivityPlanDetailsCFDistrict[$scope.cfdindex]=$scope.qprDetailsForInstitutional[i];
					$scope.cfdindex++;
				}
				
				
			}
	}
	
	
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