var publicModule = angular.module("publicModule", []);
publicModule.controller("gramPanchayatProgressReportController", [ '$scope', "gramPanchayatProgressReportService",
		function($scope, gramPanchayatProgressReportService) {
	
	$scope.PanchayatBhawanActvityId=0;
	$scope.DistrictListId=0;
	$scope.GpBhawanStatusId=0;
	$scope.qprPanchayatBhawan={};
	$scope.qprPanchayatBhawan.qprPanhcayatBhawanDetails=[];
	$scope.GPBhawanData={};
	
	
	$(document).ready(function() {
		fetchDetailsForGramPanchayatProgressReport();
		});
	
	
	function fetchDetailsForGramPanchayatProgressReport(){
		gramPanchayatProgressReportService.fetchDetailsForGramPanchayatProgressReport().then(function(response) {
			$scope.quatorDuration = response.data.quarterDuration;
			$scope.panchayatActivity =response.data.panchayatActivity;
			$scope.districtList = response.data.districtList;
		},function(error){
			alert(error);
		});
	}
	
	$scope.fetchGPBhawanStatus=function(PanchayatBhawanActvityId){
         gramPanchayatProgressReportService.fetchGPBhawanStatus(PanchayatBhawanActvityId).then(function(response){
        	 $scope.GPBhawanStatus=response.data;
		});
	};
	
	$scope.resetDetails=function(){
		$scope.qprPanchayatBhawan.activityId=0;
		$scope.qprPanchayatBhawan.districtCode=0;
	}
	
	$scope.resetDistrictList=function(){
		$scope.qprPanchayatBhawan.districtCode=0;
	}
	
	$scope.FetchDataOfGps=function(PanchayatBhawanActvityId,DistrictListId){
		gramPanchayatProgressReportService.FetchDataOfGps(PanchayatBhawanActvityId,DistrictListId).then(function(response){
       	 $scope.GPBhawanData=response.data;
		});
		
	};
	
	$scope.fetchDataAccordingToQuator=function(quatorId,PanchayatBhawanActvityId,districtCode){
		gramPanchayatProgressReportService.fetchDataAccordingToQuator(quatorId,PanchayatBhawanActvityId,districtCode).then(function(response){
			if(response.data.QprPanchayatBhawan != undefined){
				$scope.qprPanchayatBhawan=response.data.QprPanchayatBhawan;
			}else{
				$scope.qprPanchayatBhawan.qprPanchayatBhawanId=null;
				$scope.qprPanchayatBhawan.panchayatBhawanActivityId=null;
				$scope.qprPanchayatBhawan.createdBy=null;
				$scope.qprPanchayatBhawan.createdOn=null;
				$scope.qprPanchayatBhawan.lastUpdatedBy=null;
				$scope.qprPanchayatBhawan.lastUpdatedOn=null;
				$scope.qprPanchayatBhawan.isFreeze=false;
			}	
			if(response.data.QprPanhcayatBhawanDetails !=undefined){
				$scope.qprPanchayatBhawan.qprPanhcayatBhawanDetails=response.data.QprPanhcayatBhawanDetails;
			}else{
				for(let j=0;j<$scope.qprPanchayatBhawan.qprPanhcayatBhawanDetails.length;j++){
					for(let key in $scope.qprPanchayatBhawan.qprPanhcayatBhawanDetails[j]){
						key =='gpBhawanStatusId'?$scope.qprPanchayatBhawan.qprPanhcayatBhawanDetails[j][key]=0 : $scope.qprPanchayatBhawan.qprPanhcayatBhawanDetails[j][key]=null;
					}
				}
			}
				
		});
		
	};
	
   $scope.saveQprPanchayatBhawanData=function(){
	   let status=false;
	   for(var i=0; i < $scope.GPBhawanData.length;i++){
		   $scope.qprPanchayatBhawan.panchayatBhawanActivityId=$scope.GPBhawanData[i].panchayatBhawanActivityId;
		   $scope.qprPanchayatBhawan.qprPanhcayatBhawanDetails[i].localBodyCode=$scope.GPBhawanData[i].localBodyCode;
		   if("expenditureIncurred" in $scope.qprPanchayatBhawan.qprPanhcayatBhawanDetails[i]){
			   status=true;
		   }else{
			   status=false;
			   break;
		   }
	   }
	   if(status){
		   gramPanchayatProgressReportService.saveQprPanchayatBhawanData($scope.qprPanchayatBhawan).then(function(response){
			   $scope.qprPanchayatBhawan = response.data;
					toastr.success("Data Saved Successfully");
			},function(error){
				toastr.error("Something went wrong");
			});
	   }else{
		   toastr.error("Please fill All the Fields.");
	   }	
	  };
	  
}]);