/**
 * Maneesh
 * 
 * 
 * 
 */
/*var installmentNo=1;*/
var compFileMap =new Map();
var uploadFileMap=new Map();
var existDataMap=new Map();

var sanctionOrder=angular.module("publicModule",["ngCkeditor"]);




sanctionOrder.directive('fileModel', ['$parse', function ($parse) {
	 return {
	 restrict: 'A',
	 link: function(scope, element, attrs) {
	 var model = $parse(attrs.fileModel);
	 var modelSetter = model.assign;

	element.bind('change', function(){
	 scope.$apply(function(){
	 modelSetter(scope, element[0].files[0]);
	 });
	 });
	 }
	 };
	 }]);


sanctionOrder.directive('ckEditor', function () {
	  return {
	    require: '?ngModel',
	    link: function (scope, elm, attr, ngModel) {
	      var ck = CKEDITOR.replace(elm[0]);
	      scope.l=ck.getData();
	      if (!ngModel) return;
	      ck.on('instanceReady', function () {
	        ck.setData(ngModel.$viewValue);
	      });
	      function updateModel() {
	        scope.$apply(function () {
	          ngModel.$setViewValue(ck.getData());
	        });
	      }
	      
	      ngModel.$render = function (value) {
	        ck.setData(ngModel.$viewValue);
	      };
	    }
	  };
	});



sanctionOrder.directive("ngUploadChange",function(){
    return{
        scope:{
            ngUploadChange:"&"
        },
        link:function($scope, $element, $attrs){
            $element.on("change",function(event){
                $scope.$apply(function(){
                    $scope.ngUploadChange({$event: event})
                })
            })
            $scope.$on("$destroy",function(){
                $element.off();
            });
        }
    }
});

sanctionOrder.controller("sanctionOrderController",['$scope','sanctionOrderService',function($scope,sanctionOrderService){
	
	
	$scope.divShow=false;
	
	
	
	$(document).ready(function() {
		fetchOnLoad();
		});
	
	
	function fetchOnLoad(){
		/*sanctionOrderService.getAllFinYear().then(function(response){
			$scope.finYears = response.data;
		});*/
		
		sanctionOrderService.getAllState(yid).then(function(response){
			$scope.states = response.data;
			
		});
	}
	
	/*$scope.fetchState = function(selected,list){
		console.log("inside fetchState fn");
		angular.forEach(list,function(item){
		  	if(item.yearId == selected)
		  		$scope.currentObject = item;
		  })
		
		yearId=$scope.currentObject.yearId;
		if(yearId!=null && yearId!="" && parseInt(yearId)>0){
			sanctionOrderService.getAllState(yearId).then(function(response){
				$scope.states = response.data;
			});
		}
	}*/
	
	
	 
	
	
	$scope.dataUpload = true;
	 $scope.errVisibility = false;
	 
	 $scope.fileChanged = function($event,componentId){
		 //alert(componentId);
		
		  var files = $event.target.files;
		  
		  if(files.length>0){
			  var uploadUrl = "uploadFiletoServer.html?<csrf:token uri=uploadFiletoServer.htm/>";
				
			    sanctionOrderService.uploadFileToUrl(files[0], uploadUrl).then(function(response){
			    	if(response!=null && response.data.responseCode==200){
			    	 	uploadedClass = $("#uploaded_"+componentId);
			    	 	uploadedClass.addClass('fa fa-check-square-o');
			 			compFileMap.set(componentId,response.data.responseResult);
			    		//$scope.saveSactionOrder(response.data.responseResult);
			    	}else{
			    		toastr.error(response.data.responseMessage);
			    	}
			    });
		  }
		   
	}
	 
	 $scope.uploadFile = function(file){
	
		 
		 console.log('file is ' );
		 console.dir(file);

		 var uploadUrl = "uploadFiletoServer.html?<csrf:token uri=uploadFiletoServer.htm/>";
		/* sanctionOrderService.uploadFileToUrl(file, uploadUrl).then(function(response){
		if(response!=null && response.data.responseCode==200){
			
			$scope.saveSactionOrder(response.data.responseResult);
    	}else{
    		toastr.error(response.data.responseMessage);
    	}
	});*/
	};
	
	$scope.isFreezeValidate=function(isFreeze){
		flag=true;
		if(isFreeze){
			if(!(compFileMap.has(1) && compFileMap.has(2) && compFileMap.has(3) && compFileMap.has(4) && compFileMap.has(5) && compFileMap.has(6)) ){
				flag=false;
				toastr.error("please uploaded all sanction order of componment wise");
			}
			sdate=$("#bsanctionDate").find("input").val();
			if(sdate.length<10){
				flag=false;
				toastr.error("please select Date");
			}
		}
		return flag;
	}
	
	$scope.saveSactionOrder=function(isFreeze){
		
		var pbProposedInfo=[];
		
		
		var flag=$scope.isFreezeValidate(isFreeze)
		
		if(flag){
			sdate=$("#bsanctionDate").find("input").val();
			if(sdate.length==10){
				sdateArr=sdate.split("-");
			}
			stateCode=$scope.stateModel;
			soComponentId=$scope.soComponentModel;
			var d =null;
			if(sdateArr.length==3){
				var d = new Date(sdateArr[1]+"/"+sdateArr[0]+"/"+sdateArr[2]);	
			}
			
		
			
			var releaseIntallmentSno=null;
			if(existDataMap.has("releaseIntallmentSno")){
				releaseIntallmentSno=existDataMap.get("releaseIntallmentSno");
			}
			
			
			angular.forEach($scope.sanctionOrderCompomentAmountList,function(item){
				filePath=null;
				if(compFileMap.has(item.componentId)){
					filePath=compFileMap.get(item.componentId);
				}
				var sanctionOrderSno=null;
				if(existDataMap.has("SanctionOrderSno"+item.componentId)){
					sanctionOrderSno=existDataMap.get("SanctionOrderSno"+item.componentId);
				}
				
				var componentAmountVal=$("#"+item.componentId+"_componentAmount").val();
				
				mySubObj= {
		    			"componentId":item.componentId,
					    "componentName" : item.componentName,    //your artist variable
					    //"componentAmount" :item.componentAmount ,  //your title variable
					    "componentAmount" :componentAmountVal,
					    "filePath":filePath,
					    "sanctionOrderSno":sanctionOrderSno
					};
				
				pbProposedInfo.push(mySubObj);
			});
			//var intallmentNo = $scope.installmentModel;
			myObj= {
	    			"stateCode":stateCode,
				    "yearId" : yid,    //your artist variable
				    "sactionDate" : d,
				    "sanctionOrderCompomentAmountList":pbProposedInfo,
				    "releaseIntallmentSno":releaseIntallmentSno,
				    "status":isFreeze,
				    "installmentNo":$scope.installmentModel
				};
	    	
			sanctionOrderService.saveSanctionOrder(myObj).then(function(response){
				if(response!=null && response.data.responseCode==200){
					toastr.success(response.data.responseMessage);
					$scope.fetchApprovePlanDetail(); 
		    	}else{
		    		toastr.error(response.data.responseMessage);
		    		$scope.fetchApprovePlanDetail(); 
		    	}
			});
			
		}
		
		
		
	}
	
	/*$scope.selectCurrentState=function(selected,list){
		console.log("inside fetchState fn");
		angular.forEach(list,function(item){
		  	if(item.stateCode == selected)
		  		$scope.currentObjectState = item;
		  		$scope.fetchApprovePlanDetail(); 
		  });
	}*/
	
	$scope.selectCurrentInstallment=function(){
		
		
		  		$scope.stateModel;
		  		$scope.installmentModel;
		  		
		  		
		  		$scope.fetchApprovePlanDetail(); 
		 
	}
	
	
	$scope.fetchApprovePlanDetail = function(){
		
		  
		if($scope.stateModel!=null){
			sanctionOrderService.getAllSanctionOrderComponentAmount($scope.stateModel ,$scope.installmentModel).then(function(response){
				$scope.sanctionOrderCompomentAmountList=response.data;
				$scope.divShow=true;
				$scope.btnShow=true;
				
				sanctionOrderService.fetchSanctionOrderData($scope.stateModel ,$scope.installmentModel).then(function(response){
					$scope.sanctionOrderData=response.data;
					//alert($scope.sanctionOrderData.releaseIntallment.releaseDate);
					if($scope.sanctionOrderData.releaseIntallment!=null){
 						

						var d=null;
						temp=$scope.sanctionOrderData.releaseIntallment.releaseDate;
						
						if(temp!=null){
							 d=new Date($scope.sanctionOrderData.releaseIntallment.releaseDate);
						}
					
						if($scope.sanctionOrderData.releaseIntallment.status!=null && $scope.sanctionOrderData.releaseIntallment.status==true){
							$scope.btnShow=false;
						}
					
						
						var releaseIntallmentSno=$scope.sanctionOrderData.releaseIntallment.releaseIntallmentSno;
						existDataMap.set("releaseIntallmentSno",releaseIntallmentSno);
						//alert(d.getDate()+"-"+(d.getMonth()+1)+"-"+d.getFullYear());
						if(d!=null){
							var day="0"+d.getDate()
							if(d.getDate()>9){
								 day=d.getDate();
							}
							var month="0"+(d.getMonth()+1)
							if((d.getMonth()+1)>9){
								 day=(d.getMonth()+1);
							}
							
							$("#bsanctionDate").find("input").val(day+"-"+month+"-"+d.getFullYear());
						}
						
						
						
						angular.forEach($scope.sanctionOrderData.sanctionOrderList,function(item){
							existDataMap.set("SanctionOrderSno"+item.soComponentId,item.sanctionOrderSno);
						  	if(item.filePath!=null){
						  		//var model = $parse('isfileupload_'+item.soComponentId);
						  		//model.assign($scope, true);
						  		 $scope['isfileupload_'+item.soComponentId] = true;
 								 $scope['newFile_'+item.soComponentId] = false;

						  		 if(!compFileMap.has(item.soComponentId)){
						  			compFileMap.set(item.soComponentId,item.filePath);
						  		 }
						  		 if(!uploadFileMap.has(item.soComponentId)){
						  			uploadFileMap.set(item.soComponentId,item.filePath);
							  		 }
						  		
						  	}else{
						  		//var model = $parse('newFile_'+item.soComponentId);
						  		//model.assign($scope, true);
						  		 $scope['newFile_'+item.soComponentId] = true;
								 $scope['isfileupload_'+item.soComponentId] = false;

						  	}
						  });
					}else{
						angular.forEach($scope.sanctionOrderCompomentAmountList,function(item){
							 $scope['newFile_'+item.componentId] = true;
						});
					}
			
					
				});
				
			});
			
			
			
			
		}
		
	}
	
	$scope.changeFileOption=function(isFileUploaded,componentId)
	{
		if(isFileUploaded){
			$scope['newFile_'+componentId] = true;
			$scope['isfileupload_'+componentId] = false;
		}else{
			$scope['newFile_'+componentId] = false;
			$scope['isfileupload_'+componentId] = true;
		}
		
	}
	
	
	
	
	
	
	$scope.publishTemplate=function(){
		/*alert($scope.currentObject.finYear);
		alert($scope.currentObjectState.stateNameEnglish);
		alert($scope.fileModel);*/
		
		//$scope.l=$scope.contentModel;
		
		$scope.l=$scope.l.replace("FILE_NO",$scope.fileModel);
		$scope.l=$scope.l.replace("SANCTION_DATE",$scope.sanctionDateModel);
		//$scope.l.replace("FILE_NO",$scope.fileModel);
		
	/*	var fileNo=$("#fileNo").val();
		var totalFund=$("#totalFund").val(); 
		var relFund=$("#relFund").val(); 
		var dyNo=$("#dyNo").val();
		var sanctionDate=$("#sanctionDate").val();
		var state=$("#state option:selected").text();
		var finYear=$("#finYear option:selected").text();*/
		
		
		//l=l.replace("SANCTION_DATE",sanctionDate);
		$scope.l=$scope.l.replace("STATE_NAME_ENGLISH",$scope.currentObjectState.stateNameEnglish);
		$scope.l=$scope.l.replace("FIN_YEAR",$scope.currentObject.finYear);
		
		$scope.l=$scope.l.replace("TOTAL_FUNDS_DIGIT",$scope.totalFundModel);
		$scope.l=$scope.l.replace("TOTAL_FUNDS_WORDS",convertNumberToWords($scope.totalFundModel));
		$scope.l=$scope.l.replace("RELEASE_FUNDS_DIGIT",$scope.relFundModel);
		$scope.l=$scope.l.replace("RELEASE_FUNDS_WORDS",convertNumberToWords($scope.relFundModel));
		$scope.content=$scope.l;
		// var strNewString = "my name ram".replace('ram','sita');
	}
	
	
	$scope.downloadFile=function(componentId){
		 if(uploadFileMap.has(componentId)){
			 filename=uploadFileMap.get(componentId);
				sanctionOrderService.downloadSanctionOrder(filename).then(function(response){
					
				});
		 }
	}
	
}]);