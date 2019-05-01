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
	
	$scope.qprInstitutionalNBState=[];
	$scope.qprInstitutionalNBDistrict=[];
	$scope.qprInstitutionalCFState=[];
	$scope.qprInstitutionalCFDistrict=[];
	
	$scope.InstInfraStatusState=[];
	$scope.InstInfraStatusDistrict=[];
	
	 var data = new FormData();

	
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
        	 $scope.InstInfraStatus=response.data.InstInfraStatus;
        	 load_data();
		});
	};
	
	
	function load_data(){
		$scope.nbsindex=0;
		$scope.nbdindex=0;
		$scope.cfsindex=0;
		$scope.cfdindex=0;
		k=0;
		l=0;
		
		for (var i = 0; i < $scope.InstInfraStatus.length; i++) { 
			trainingInstitueTypeId=$scope.InstInfraStatus[i].trainingInstitueType.trainingInstitueTypeId;
			if(trainingInstitueTypeId==2){
				$scope.InstInfraStatusState[k]=$scope.InstInfraStatus[i];
				k++;
			}else if(trainingInstitueTypeId==4){
				$scope.InstInfraStatusDistrict[l]=$scope.InstInfraStatus[i];
				l++;
			}
		}
		
		
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
	
	
	 $scope.saveQprInstitutionalInfrastructureData=function(){
		 
		 	document.qprInstitutionalInfrastructure.method = "post";
			document.qprInstitutionalInfrastructure.action = "institutionalInfraQuaterlyReport.html?<csrf:token uri='institutionalInfraQuaterlyReport.html'/>";
			document.qprInstitutionalInfrastructure.submit();
		 
		 var data = new FormData();

         for (var i in $scope.files) {
             data.append("uploadedFile", $scope.files[i]);
         }
		 
		 $scope.x=$scope.qprInstitutionalNBState;
		  /* let status=false;
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
		   }	*/
		  };
	
	
	$scope.getFileDetails = function (e) {

        //$scope.files = [];
        $scope.$apply(function () {

            // STORE THE FILE OBJECT IN AN ARRAY.
            for (var i = 0; i < e.files.length; i++) {
            	 //data.append("uploadedFile", e.files[i]);
            	//$scope.qprInstitutionalNBState[0].filename.push(e.files[i]);
               $scope.files.push(e.files[i])
            }

        });
    };
	
	
    /* $scope.uploadFiles = function () {

         //FILL FormData WITH FILE DETAILS.
         var data = new FormData();

         for (var i in $scope.files) {
             data.append("uploadedFile", $scope.files[i]);
         }
	 };*/
	
	
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
	
  
	  
}]);