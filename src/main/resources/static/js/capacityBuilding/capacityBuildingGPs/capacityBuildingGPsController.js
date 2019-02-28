
var lbCodes1=[];
	var lbCodes2=[];
	var lbCodes3=[];
	var lbCodes4=[];
	var saveEntityId1 =new Map();
	var saveEntityId2 =new Map();
	var saveEntityId3 =new Map();
	var saveEntityId4 =new Map();
	var activityDetailIdMap =new Map();
	var activityDetailId=[];
var capacityBuildingGPs=angular.module("publicModule",[]);

capacityBuildingGPs.controller("capacityBuildingGPsController",['$scope','capacityBuildingGPsService',function($scope,capacityBuildingGPsService ){
	
	var selActivityId=null;
	fetchOnLoad();
	
	
	$scope.clearPage=function(){
		fetchOnLoad();
	}
	
	function fetchOnLoad(){
		
		$scope.selGPs1=0;
		$scope.selGPs2=0;
		$scope.selGPs3=0;
		$scope.selGPs4=0;
		$scope.totGPS1=0;
		$scope.totGPS2=0;
		$scope.totGPS3=0;
		$scope.totGPS4=0;
		
		lbCodes1=[];
		lbCodes2=[];
		lbCodes3=[];
		lbCodes4=[];
		saveEntityId1 =new Map();
		saveEntityId2 =new Map();
		saveEntityId3 =new Map();
		saveEntityId4 =new Map();
		activityDetailIdMap =new Map();
		$scope.isSaveVisible = true;
		activityDetailIdMap =new Map();
		capacityBuildingGPsService.fetchCBMastersAndCapacityBuildingData().then(function(response){
		$scope.cbmasters = response.data.cbMasters;
		$scope.capacityBuilding = response.data.capacityBuildingDetails;	
		//activityDetailId
		if($scope.capacityBuilding!=null){
			angular.forEach($scope.capacityBuilding.capacityBuildingActivityDetails,function(item){
				if (item.cbMaster==5 || item.cbMaster==6 || item.cbMaster==7 ||  item.cbMaster==8 ){
					if(item.cbMaster==5){
						$scope.totGPS1= item.noOfUnits;
					}else if(item.cbMaster==7){
						$scope.totGPS2= item.noOfUnits;
					}
					else if(item.cbMaster==8){
						$scope.totGPS3= item.noOfUnits;
					}else if(item.cbMaster==6){
						$scope.totGPS4= item.noOfUnits;
					}
					
					if(!activityDetailIdMap.has(item.cbMaster)){
						activityDetailIdMap.set(item.cbMaster,item.capacityBuildingActivityDetailsId);
					}
					
				}  	
			});
		}else{
			alert("Please fill first 'Training Activities' Form from Action Plan");
			$scope.isSaveVisible = false;
		}
		
		
		
		$scope.isDisabled5 = true;
		$scope.isDisabled7 = true;
		$scope.isDisabled8 = true;
		$scope.isDisabled6 = true;
		if(activityDetailIdMap.has(5)){
			$scope.isDisabled5 = false;
			cbActivityDetailsId=activityDetailIdMap.get(5);
			capacityBuildingGPsService.getCBActivityGPs(cbActivityDetailsId,5).then(function(response){
				if(response.data.length >0){
					angular.forEach(response.data,function(item){
						lbCodes1.push(item.localbodyCode);
						$scope.selGPs1=$scope.selGPs1+1;
						if(!saveEntityId1.has(item.localbodyCode)){
							saveEntityId1.set(item.localbodyCode,item.capacityBuildingActivityGPsId);
						}
					});
				}
				
			});
			
		}
		if(activityDetailIdMap.has(7)){
			$scope.isDisabled7 = false;
			cbActivityDetailsId=activityDetailIdMap.get(7);
			capacityBuildingGPsService.getCBActivityGPs(cbActivityDetailsId,7).then(function(response){
				if(response.data.length >0){
					angular.forEach(response.data,function(item){
						lbCodes2.push(item.localbodyCode);
						$scope.selGPs2=$scope.selGPs2+1;
						if(!saveEntityId2.has(item.localbodyCode)){
							saveEntityId2.set(item.localbodyCode,item.capacityBuildingActivityGPsId);
						}
					});		
				}
				
			});
		}
		if(activityDetailIdMap.has(8)){
			$scope.isDisabled8 = false;
			cbActivityDetailsId=activityDetailIdMap.get(8);
			capacityBuildingGPsService.getCBActivityGPs(cbActivityDetailsId,8).then(function(response){
				if(response.data.length >0){
					angular.forEach(response.data,function(item){
						lbCodes3.push(item.localbodyCode);
						$scope.selGPs3=$scope.selGPs3+1;
						if(!saveEntityId3.has(item.localbodyCode)){
							saveEntityId3.set(item.localbodyCode,item.capacityBuildingActivityGPsId);
						}
					});
				}
				
			});
		}
		
		if(activityDetailIdMap.has(6)){
			$scope.isDisabled6 = false;
			cbActivityDetailsId=activityDetailIdMap.get(6);
			capacityBuildingGPsService.getCBActivityGPs(cbActivityDetailsId,6).then(function(response){
				if(response.data.length >0){
					angular.forEach(response.data,function(item){
						lbCodes4.push(item.localbodyCode);
						$scope.selGPs4=$scope.selGPs4+1;
						if(!saveEntityId4.has(item.localbodyCode)){
							saveEntityId4.set(item.localbodyCode,item.capacityBuildingActivityGPsId);
						}
					});
				}
				
			});
			
		}
		
		});
		
		capacityBuildingGPsService.getAllDistrict().then(function(response){
			$scope.districtCodes=response.data;
		});
		
		capacityBuildingGPsService.getAllState().then(function(response){
			$scope.stateCodes=response.data;
		});
		
	}
	
	
	$scope.fetchDistrictListbyState = function(selected){
		if(!selected){
			toastr.error("Please select State");
			
		}else{
			capacityBuildingGPsService.getAllDistrictbyStateCode(selected).then(function(response){
				$scope.districtCodes1=response.data;
			});
		}
		
	}
	
	$scope.showGaramPanchayatModal = function(selected,activityId,activityName,isState){
		console.log("inside showGaramPanchayatModal fn");
		if(!selected){
			toastr.error("Please select district");
			
		}else{
			selActivityId=activityId;
			if(isState){
				angular.forEach($scope.districtCodes1,function(item){
				  	if(item.districtCode == selected)
				  		$scope.selectDistrictCode = item;
				});
			}else{
				angular.forEach($scope.districtCodes,function(item){
				  	if(item.districtCode == selected)
				  		$scope.selectDistrictCode = item;
				});
			}
			
				capacityBuildingGPsService.getAllGramPanchayat(selected).then(function(response){
				$scope.lbCodes = response.data;
				$scope.createContentGPModal(activityName);
			});
		}
		
	}
	
	/*$scope.filterLbCodes=[];
	
	
	$scope.filterLbCodesFn = function(){
		$scope.filterLbCodes=[];
		if(selActivityId==5){
			angular.forEach($scope.lbCodes,function(item){
				if(!(lbCodes2.includes(item[0]) || lbCodes3.includes(item[0]))){
					$scope.filterLbCodes.push(item);
				}
			  		
			});
		}else if(selActivityId==7){
			angular.forEach($scope.lbCodes,function(item){
				if(!(lbCodes1.includes(item[0]) || lbCodes3.includes(item[0]))){
					$scope.filterLbCodes.push(item);
				}
			  		
			});
		}else if(selActivityId==8){
			angular.forEach($scope.lbCodes,function(item){
				if(!(lbCodes1.includes(item[0]) || lbCodes2.includes(item[0]))){
					$scope.filterLbCodes.push(item);
				}
			  		
			});
		}
		
	}*/
	
	$scope.createContentGPModal = function(activityName){
		//$scope.filterLbCodesFn();
		 $("#garamPanchayatBody").empty();
		 var divTemplate = $("#garamPanchayatBody");
		
		
		 $("#garamPanchayatHead").text(activityName+" Finalize Work Location of "+$scope.selectDistrictCode.districtNameEnglish+" District");
		 
		 table=$("<table/>");
		 table.attr("id", "example");
		 table.addClass("table table-hover dashboard-task-infos");
		
		 thead=$("<thead/>");
		 
		 tr=$("<TR/>");
		 
		 th=createLabel("Garam Panchayat");
		 tr.append(th);
		 
		 th=createLabel("Garam Panchayat");
		 tr.append(th);
		 
		 th=createLabel("Garam Panchayat");
		 tr.append(th);
		 
		 th=createLabel("Garam Panchayat");
		 tr.append(th);
		 
		 th=createLabel("Garam Panchayat");
		 tr.append(th);
		 
		 th=createLabel("Garam Panchayat");
		 tr.append(th);
		 
		
		 
		thead.append(tr);
		 
		 table.append(thead);
		 
		 tbody=$("<tbody/>");
		 
		 angular.forEach($scope.lbCodes,function(item,key){
			
			 if(key>0 && key%6==0){
				 tbody.append(tr);
				 table.append(tbody);
				}
			 
			if(key==0 || key%6==0){
				tr=$("<TR/>");
			}
			 
			 
			 td=$("<TD/>");
			 templateInput = $("<input/>");
			 templateInput.attr("type", "checkbox");
			 templateInput.attr("name", "chkEntity");
			 if(selActivityId==5 && lbCodes1.includes(item[0])){
				 $( templateInput ).prop('checked', true);		 
			 }else if(selActivityId==7 && lbCodes2.includes(item[0])){
				 $( templateInput ).prop('checked', true);		 
			 }else if(selActivityId==8 && lbCodes3.includes(item[0])){
				 $( templateInput ).prop('checked', true);		 
			 }else if(selActivityId==6 && lbCodes4.includes(item[0])){
				 $( templateInput ).prop('checked', true);		 
			 }
			 templateInput.attr("id", "chkEntity_"+$scope.selectDistrictCode.districtCode+"_"+item[0]);
			 
			
			 td.append(templateInput);
			 templateLabel = $("<label/>");
			 templateLabel.html(item[1]);
			 td.append(templateLabel);
			 tr.append(td);
			 
			
			 
			
			
			 
			 
			 
			 
		});
		
		 divTemplate.append(table); 
		 callDatatable();
		 //$('#example').DataTable();
		 
		
		 
		 $('#garamPanchayatModal').modal('show');
	}
	
	var createLabel=function (labelName){
		 th=$("<TH/>");
		 templateLabel = $("<label/>");
		 templateLabel.html(labelName);
		 th.append(templateLabel);
		 return th;
	};
	
	var createCheckbox=function (labelName,districtCode,lbCode){
		 td=$("<TD/>");
		 templateInput = $("<input/>");
		 templateInput.attr("type", "checkbox");
		 if(lbCodes1.includes(lbCode)){
			 if(selActivityId==5 && selactivity1.has(labelName+"_"+lbCode)){
				 $( templateInput ).prop('checked', true);	
			 }else if(selActivityId==7 && selactivity2.has(labelName+"_"+lbCode)){
				 $( templateInput ).prop('checked', true);	
			 }else if(selActivityId==8 && selactivity3.has(labelName+"_"+lbCode)){
				 $( templateInput ).prop('checked', true);	
			 }else if(selActivityId==6 && selactivity4.has(labelName+"_"+lbCode)){
				 $( templateInput ).prop('checked', true);	
			 }
		 }
		 else{
		 templateInput.attr("disabled", "true");
		}
		 
		 
		 templateInput.attr("id", "chk_"+districtCode+"_"+lbCode+"_"+labelName);
		 td.append(templateInput);
		 return td;
	};
	
	
	
	$scope.SaveData = function(){
		
			
		/*$.each($("input[name='chkEntity']"), function(){            
			idArr=$(this).attr('id').split("_");
			
			
			
			if(selActivityId==5){
				temp=parseInt(idArr[2]);
				if(!lbCodes1.includes(temp)){
					if($(this).is(':checked')){
						lbCodes1.push(parseInt(temp));
					}
						 	
				}else if(!$(this).is(':checked')) {
					var index = lbCodes1.indexOf(parseInt(temp));
				 	if (index > -1) {
				    	lbCodes1.splice(index, 1);
				   }
				}
				
			}else if(selActivityId==7){
				temp=parseInt(idArr[2]);
				if(!lbCodes2.includes(temp)){
					if($(this).is(':checked')){
						lbCodes2.push(parseInt(temp));
					}
						 	
				}else if(!$(this).is(':checked')) {
					var index = lbCodes2.indexOf(parseInt(temp));
				 	if (index > -1) {
				    	lbCodes2.splice(index, 1);
				   }
				}
				
				
			}else if(selActivityId==8){
				temp=parseInt(idArr[2]);
				if(!lbCodes3.includes(temp)){
					if($(this).is(':checked')){
						lbCodes3.push(parseInt(temp));
					}
						 	
				}else if(!$(this).is(':checked')) {
					var index = lbCodes3.indexOf(parseInt(temp));
				 	if (index > -1) {
				    	lbCodes3.splice(index, 1);
				   }
				}
				
				
			}
			
			
	    });*/
		
		 $('#garamPanchayatModal').modal('hide');
	}
	
	
	
	
	
	function callDatatable(){
		$('#example').dataTable({
	        "lengthMenu": [[ 25,50,100, -1], [25, 50,100, "All"]],
	         
	    });	
		$('INPUT[name=chkEntity]').change(function(){
				idArr=$(this).attr('id').split("_");
			
			
			
			if(selActivityId==5){
				temp=parseInt(idArr[2]);
				if(!lbCodes1.includes(temp)){
					if($(this).is(':checked')){
						if( $scope.totGPS1>$scope.selGPs1){
							$scope.selGPs1=$scope.selGPs1+1;
							lbCodes1.push(parseInt(temp));
							
						}else{
							$(this).prop('checked', false);
							toastr.error("You are select maximum GPS of activity");
						}
					}
						 	
				}else if(!$(this).is(':checked')) {
					var index = lbCodes1.indexOf(parseInt(temp));
				 	if (index > -1) {
				    	lbCodes1.splice(index, 1);
				   }
				 	if($scope.selGPs1>0){
				 		$scope.selGPs1=$scope.selGPs1-1
				 	}
				}
				
			}else if(selActivityId==7){
				temp=parseInt(idArr[2]);
				if(!lbCodes2.includes(temp)){
					if($(this).is(':checked')){
						if( $scope.totGPS2>$scope.selGPs2){
							$scope.selGPs2=$scope.selGPs2+1;
							lbCodes2.push(parseInt(temp));
							
						}else{
							$(this).prop('checked', false);
							toastr.error("You are select maximum GPS of activity");
						}
					}
						 	
				}else if(!$(this).is(':checked')) {
					var index = lbCodes2.indexOf(parseInt(temp));
				 	if (index > -1) {
				    	lbCodes2.splice(index, 1);
				   }
				 	if($scope.selGPs2>0){
				 		$scope.selGPs2=$scope.selGPs2-1
				 	}
				}
				
				
			}else if(selActivityId==8){
				temp=parseInt(idArr[2]);
				if(!lbCodes3.includes(temp)){
					if($(this).is(':checked')){
						if( $scope.totGPS3>$scope.selGPs3){
							$scope.selGPs3=$scope.selGPs3+1;
							lbCodes3.push(parseInt(temp));
							
						}else{
							$(this).prop('checked', false);
							toastr.error("You are select maximum GPS of activity");
						}
					}
						 	
				}else if(!$(this).is(':checked')) {
					var index = lbCodes3.indexOf(parseInt(temp));
				 	if (index > -1) {
				    	lbCodes3.splice(index, 1);
				   }
				 	if($scope.selGPs3>0){
				 		$scope.selGPs3=$scope.selGPs3-1
				 	}
				}
				
				
			}else if(selActivityId==6){
				temp=parseInt(idArr[2]);
				if(!lbCodes4.includes(temp)){
					if($(this).is(':checked')){
						if( $scope.totGPS4>$scope.selGPs4){
							$scope.selGPs4=$scope.selGPs4+1;
							lbCodes4.push(parseInt(temp));
							
						}else{
							$(this).prop('checked', false);
							toastr.error("You are select maximum GPS of activity");
						}
					}
						 	
				}else if(!$(this).is(':checked')) {
					var index = lbCodes4.indexOf(parseInt(temp));
				 	if (index > -1) {
				    	lbCodes4.splice(index, 1);
				   }
				 	if($scope.selGPs4>0){
				 		$scope.selGPs4=$scope.selGPs4-1
				 	}
				}
				
				
			}
			
		});
	} 
	
	
	
	
	$scope.savePanchayatBhawanData = function(){
		var capacityBuildingActivityGPs=[];
		
		
	    $.each( lbCodes1, function( index, value ) {
	    cbactivityid=activityDetailIdMap.get(5);
	    activityDetailId.push(cbactivityid);
	    cbGPsId=null;
	    if(saveEntityId1.has(value)){
			cbGPsId=saveEntityId1.get(value);
		}
	    	myObj= {
	    			"capacityBuildingActivityGPsId":cbGPsId,
				    "capacityBuildingActivityDetailsId" : cbactivityid,    //your artist variable
				    "cbMaster" : 5 ,  //your title variable
				    "localbodyCode" : value
				    
				};
	    	
	    	capacityBuildingActivityGPs.push( myObj );
		});
	    
	    $.each( lbCodes2, function( index, value ) {
	    	 cbactivityid=activityDetailIdMap.get(7);
	    	 activityDetailId.push(cbactivityid);
	 	    cbGPsId=null;
	 	    if(saveEntityId2.has(value)){
	 			cbGPsId=saveEntityId2.get(value);
	 		}
	    	myObj= {
	    			"capacityBuildingActivityGPsId":cbGPsId,
				    "capacityBuildingActivityDetailsId" : cbactivityid,    //your artist variable
				    "cbMaster" :7 ,  //your title variable
				    "localbodyCode" : value
				    
				};
	    	
	    	capacityBuildingActivityGPs.push( myObj );
		});
	    
	    $.each( lbCodes3, function( index, value ) {
	    	 cbactivityid=activityDetailIdMap.get(8);
	    	 activityDetailId.push(cbactivityid);
		 	    cbGPsId=null;
		 	    if(saveEntityId3.has(value)){
		 			cbGPsId=saveEntityId3.get(value);
		 		}
	    	myObj= {
	    			"capacityBuildingActivityGPsId":cbGPsId,
				    "capacityBuildingActivityDetailsId" : cbactivityid,    //your artist variable
				    "cbMaster" : 8 ,  //your title variable
				    "localbodyCode" : value
				    
				};
	    	
	    	capacityBuildingActivityGPs.push( myObj );
		});
	    
	    
	    $.each( lbCodes4, function( index, value ) {
	    	 cbactivityid=activityDetailIdMap.get(6);
	    	 activityDetailId.push(cbactivityid);
		 	    cbGPsId=null;
		 	    if(saveEntityId4.has(value)){
		 			cbGPsId=saveEntityId4.get(value);
		 		}
	    	myObj= {
	    			"capacityBuildingActivityGPsId":cbGPsId,
				    "capacityBuildingActivityDetailsId" : cbactivityid,    //your artist variable
				    "cbMaster" : 6 ,  //your title variable
				    "localbodyCode" : value
				    
				};
	    	
	    	capacityBuildingActivityGPs.push( myObj );
		});
	    
	    capacityBuildingGPsService.saveFinalizeWorkLocation(capacityBuildingActivityGPs,activityDetailId.toString()).then(function(response){
	    	if(response!=null && response.status==200){
	    		toastr.success(response.data.responseMessage);
	    	}else{
	    		toastr.error(response.data.responseMessage);
	    	}
	    	fetchOnLoad();
	    	
	    });
	}
	
	
	
	
}]);