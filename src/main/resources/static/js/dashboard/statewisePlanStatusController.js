/**
 * Maneesh
 */

var statewiseplanStatus=angular.module("publicModule",[]);

statewiseplanStatus.controller("statewisePlanStatusController",['$scope','statewisePlanStatusService',function($scope,statewisePlanStatusService){
	$scope.sdata=null;
	fetchOnLoad();
	
	function fetchOnLoad(){
		$("#loader").show();
		statewisePlanStatusService.getStatewisePlanStatus().then(function(response){
			$scope.sdata=response.data;
			onLoadGIS();
		});
	}
	
	function onLoadGIS(){

		var map, dialog,sdata=null,ddata=null,entityType=null;
		var startExtent = null;		
		var red = [ 1,5,10,18,21,23,29,33 ];
		var green = [ 2,8,9,12,14,16,19,22,27,28,34 ];	
		var yellow = [ 3,7,11,13,15,17,20,24,30,32,36];
		var redName=["Jammu & Kashmir","Uttarakhand","Bihar","Haryana","Assam","Odisha","Madhya Pradesh","Karnataka","Tamil Nadu"];
		var greenName=["Himachal Pradesh","Rajasthan","Uttar Pradesh","Arunachal Pradesh","Manipur","Tripura","West Bengal","Chhattisgarh",
		               "Maharashtra","Andhra Pradesh","Puducherry"];
		var yellowName=["Punjab","Delhi","Sikkim","Nagaland","Mizoram","Meghalaya","Jharkhand","Gujarat","Goa","Kerala","Telangana"];
		require([
		"esri/map", "esri/layers/FeatureLayer", "esri/tasks/QueryTask", "esri/graphicsUtils","esri/layers/GraphicsLayer",
		"esri/graphic","esri/symbols/Font", "esri/symbols/TextSymbol",
		"esri/tasks/query","esri/InfoTemplate", "esri/symbols/SimpleMarkerSymbol", 
		"esri/symbols/SimpleLineSymbol", "esri/symbols/SimpleFillSymbol",
		"esri/renderers/UniqueValueRenderer","esri/lang", "esri/Color", "dojo/dom-style",
		"dijit/TooltipDialog", "dijit/popup", "dojo/on",  "dojo/domReady!"

		], function(
			Map, FeatureLayer,QueryTask,graphicsUtils,GraphicsLayer,Graphic,Font,TextSymbol, Query, InfoTemplate,
			SimpleMarkerSymbol,SimpleLineSymbol, SimpleFillSymbol,
			UniqueValueRenderer,esriLang, Color, domStyle,
			TooltipDialog, dijitPopup,on
		  ) {
			
			startExtent = new esri.geometry.Extent(2664790.7619840866, 9783.939620515332, 15902461.068520531, 5263759.515828993, new esri.SpatialReference({
			wkid : 102100
			}));


		  

		    dialog = new TooltipDialog({
		        id: "tooltipDialog",
		        style: "position: absolute; width: 500px; font: normal normal normal 10pt Helvetica;z-index:100"
		    });
		    dialog.startup();

		    highlightSymbol = new SimpleFillSymbol(
		    SimpleFillSymbol.STYLE_SOLID,
		    new SimpleLineSymbol(
		    SimpleLineSymbol.STYLE_SOLID,
		    new Color([255, 0, 0]), 3),
		    new Color([125, 125, 125, 0.35]));

			var StateDispGraphicLayer = new GraphicsLayer();
			var StateDispLabelGraphicLayer = new GraphicsLayer();
			var DistrictDispGraphicLayer = new GraphicsLayer();
			var DistrictDispLabelGraphicLayer = new GraphicsLayer();

			map = new Map("map", {
				basemap: "streets",
				center: [78,21],
				extent : startExtent,
				slider: false,
				logo: false,  
				zoom: 5,
			});
		       
			map.on("load", function(){
				var a = map.layerIds;			        	
				var b = map.getLayer(a);
				map.removeLayer(b);
				map.graphics.enableMouseEvents();
				map.disableScrollWheelZoom();
				map.disableDoubleClickZoom();
				//map.disablePan();
				map.disableKeyboardNavigation();
				map.infoWindow.resize(245, 125);
				addFeatureLayer();
			});        
		       
				
			function addFeatureLayer() {
				
				map.removeAllLayers();
				var query = new Query();
				query.where = "1=1";
				query.outFields = ["*"];
				query.returnGeometry = true;
				var queryTask = new QueryTask("http://rsgis.nic.in/ArcGIS/rest/services/adminbd/MapServer/0");
				queryTask.execute(query,showResultsState,errCallback);
			}
				 
				 
			function showResultsState(featureSet) { 

				

				var i, featureSetLength = featureSet.features.length;
				var filledColorSymbol3 = new esri.symbol.SimpleFillSymbol(esri.symbol.SimpleFillSymbol.STYLE_SOLID, new esri.symbol.SimpleLineSymbol(
					esri.symbol.SimpleLineSymbol.STYLE_SOLID, new dojo.Color("#CC9999"), 1), new dojo.Color([ 255, 255, 204, 0.5 ]));
				var StategraphicArray = [];
				var StateFeatures = featureSet.features;
			

				

				for (i = 0; i < featureSetLength; i++) {
					// Get the current feature from the featureSet. Feature is a graphic
					var StFeature = StateFeatures[i];
					var Stgraphic = new Graphic(StFeature.geometry, filledColorSymbol3 , StFeature.attributes);
					StategraphicArray.push(Stgraphic);
					

					var stcode=StFeature.attributes["stcode"];
					obj=searchColorbyState(stcode);
					var redColor = new Color([ 204,50,50, 0.9]);  
					var yellowColor = new Color([231,180,22, 0.9]);  
					var greenColor = new Color([45,201,55, 0.9]);
					var setStatusColor=redColor;
					if(obj!=null){
						if( obj.planStatus=="N"){
							setStatusColor=redColor;
						}else if( obj.planStatus=="D"){
							setStatusColor=yellowColor;
						}else if( obj.planStatus=="M"){
							setStatusColor=greenColor;
						}
					}
					
					
					StFeature.setSymbol( new SimpleFillSymbol().setColor(setStatusColor));
					var StateNameAttr = StFeature.attributes["STNAME"];
					var StlabelPoint = StFeature.geometry.getCentroid();
					var Stlabelfont = new Font("8px", Font.STYLE_NORMAL, Font.VARIANT_NORMAL, Font.WEIGHT_BOLDER);
					var StlabelTextSymbol = new TextSymbol(StateNameAttr, Stlabelfont, new Color([0, 0,0 ]));
					var StlabelGraphic = new Graphic(StlabelPoint, StlabelTextSymbol);
					
					StateDispGraphicLayer.add(StFeature);
					StateDispLabelGraphicLayer.add(StlabelGraphic);
					
				}
				
				$("#loader").hide();
				document.getElementById("loader").style.display = "none";
				var StExtent = graphicsUtils.graphicsExtent(StategraphicArray);
					map.setExtent(StExtent.expand(1.5), 1.5);	
					map.addLayer(StateDispGraphicLayer);
					map.addLayer(StateDispLabelGraphicLayer);
					StateDispGraphicLayer.on("click", showtooltip);
					
					//map.on("mouse-out", closeDialog);
					
			}
					 
		   function errCallback(error) {  
				alert("error in");
				
			 }
		   
		   
		   function closeDialog() {
				 // evt.graphic.symbol = symbol;
			     map.graphics.clear();
			        dijitPopup.close(dialog);     
				}
		   
		   	
		   
		   function showtooltip(evt){
				flag=true;
					
						var slc=(evt.graphic['attributes'])['stcode'];
						
						obj=searchColorbyState(slc);
						
						if(obj!=null && obj.planStatus=='M'){
							var msg="";
							var msghead="Plan Summary report of "+obj.stateNameEnglish+" State" ;
								//+"<a onClick='closeDialog'><i  class='fa fa-times' aria-hidden='true'></i></a> " ;
							
							var msg="<table id='showgis'>";
							
							var arrComp = obj.summaryDetails.split("$");
							$.each( arrComp, function( index1, value1 ) {
							if(value1!=""){
							
								compName=value1.split(",")[0].split("&")[0];
								compId=value1.split(",")[0].split("&")[1];
								msg=msg+"<tr class='comp_class'><th colspan='2' ><p>Component Name:" +compName.trim()+"</p></th>" +
								"<th><a href='#' onclick='showDetailsModal("+compId+","+slc+")'> <p>View Deatils</p></a></th></tr>" +
								//" <th class='comp_class'> <i class='fa fa-file-text' aria-hidden='true'></i></th></tr>" +
										"<tr class='subcomp_class'><th>Sub-Component Name</th>" +
							"<th>No. of Proposal Units</th><th> Proposal Funds</th></tr>";
							
								var arrRow = value1.split(",")[1].split("@");
								$.each( arrRow, function( index, value ) {
									//alert(value);
									if(value!=null && value.trim()!=""){
										arrCol=value.split("#");
										msg=msg+"<tr id='staticRow'>" +
												"<td>"+arrCol[0]+"</td><td>"+arrCol[1]+"</td><td>"+arrCol[2]+"</td>"
												"</tr>";
									}
									
									
								});
							}
							
							
							});
							
							msg=msg+"</tr></table>";
							 $("#summaryAlertBody").empty();
							 var divTemplate = $("#summaryAlertBody");
							divTemplate.append(msg);
							$('#summaryAlertHead').text(msghead);
							//$('#summaryAlertBody').text(msg);
				  	 		$('#summaryAlert').modal('show');
					       /* var content = esriLang.substitute(evt.graphic.attributes, msg);
					        evt.graphic.symbol = highlightSymbol;

					        dialog.setContent(content);
					        
					       

					        domStyle.set(dialog.domNode, "opacity", 0.85);
					        dijitPopup.open({
					            popup: dialog,
					            x: evt.pageX,
					            y: evt.pageY
					        });*/
						}
						
		   }		
		
		 
		   
		   
		});
			
			
		 
		
		var searchColorbyState=function(entityCode){
			 //alert(stateCode);
			var dobj=null;
			jQuery.each($scope.sdata,function(index,obj) {
			/*if(obj.stateNameEnglish.trim().substr(1,5).toUpperCase()==entityCode.substr(1,5).toUpperCase()){
				 dobj=obj;
				 
			}*/
				if(obj.stateCode==entityCode){
					 dobj=obj;
				}
			});
			return dobj;
		} 
			  

			
			  
	}
	
}]); 


function showDetailsModal(compId,slc){
	  // alert("hi");
	   if(compId==1){
		   $('#myIframe').attr('src', 'showGISStatewisePlanDetails.html?compId=' + compId + '&stateCode='+slc+'&yearId=6');  
		   $('#DetaildAlert').modal('show'); 
	   }
	 
}