
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
        style: "position: absolute; width: 250px; font: normal normal normal 10pt Helvetica;z-index:100"
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
		slider: true,
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
			

			var sname=StFeature.attributes["STNAME"];
			obj=searchColorbyState(sname);
			var redColor = new Color([ 204,50,50, 0.9]);  
			var yellowColor = new Color([231,180,22, 0.9]);  
			var greenColor = new Color([45,201,55, 0.9]);
			var setStatusColor=redColor;
			
			if( obj=="R"){
				setStatusColor=redColor;
			}else if( obj=="Y"){
				setStatusColor=yellowColor;
			}else if( obj=="G"){
				setStatusColor=greenColor;
			}
			
			StFeature.setSymbol( new SimpleFillSymbol().setColor(setStatusColor));
			var StateNameAttr = StFeature.attributes["stname"];
			var StlabelPoint = StFeature.geometry.getCentroid();
			var Stlabelfont = new Font("8px", Font.STYLE_NORMAL, Font.VARIANT_NORMAL, Font.WEIGHT_BOLDER);
			var StlabelTextSymbol = new TextSymbol(StateNameAttr, Stlabelfont, new Color([0, 0, 255 ]));
			var StlabelGraphic = new Graphic(StlabelPoint, StlabelTextSymbol);
			
			StateDispGraphicLayer.add(StFeature);
			StateDispLabelGraphicLayer.add(StlabelGraphic);
			
		}
		
		var StExtent = graphicsUtils.graphicsExtent(StategraphicArray);
			map.setExtent(StExtent.expand(1.5), 1.5);	
			map.addLayer(StateDispGraphicLayer);
			map.addLayer(StateDispLabelGraphicLayer);
			
			
			
	}
			 
      
	
	
	 function errCallback(error) {  
		alert("error in");
		
	 }
});
	
	
	  
var searchColorbyState=function(entityCode){
	objColor="W";		 //alert(stateCode);
	if(redName.includes(entityCode)){
		objColor="R";	
	}else if(yellowName.includes(entityCode)){
		objColor="Y";	
	}else if(greenName.includes(entityCode)){
		objColor="G";	
	}
	 
	 return objColor;
} 
	  

	
	  