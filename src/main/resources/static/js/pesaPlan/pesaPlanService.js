publicModule.service('pesaPlanService', [ '$http', function($http) {
	
	this.fetchDesignations=function(){
		return $http.get("fetchPesaPost.html?<csrf:token uri=fetchPesaPost.htm/>");
	}

	this.fetchPesaPlanDetailsForStateAndMOPR=function(){
		return $http.get("fetchPesaPlanDetailsForStateAndMOPR.html?<csrf:token uri=fetchPesaPlanDetailsForStateAndMOPR.htm/>");
	}
	
	this.savePesaPlan=function(pesaPlan){
		console.log(pesaPlan);
		console.log("inside savePesaPlan")
		return $http.post("savePesaPlan.html?<csrf:token uri=savePesaPlan.html/>",pesaPlan);
	}

// not in use right now "we are fetching and saving data from the same function which are using in MOPR"	
	this.savePesaPlanForCEC=function(pesaPlan){
		console.log(pesaPlan);
		console.log("inside savePesaPlan")
		return $http.post("savePesaPlanForCEC.html?<csrf:token uri=savePesaPlanForCEC.html/>",pesaPlan);
	}
//-----------------------------------------------------------------------------------
	this.freezUnFreezPesaPlan=function(pesaPlan){
		return $http.post("feezUnFreezPesaPlan.html?<csrf:token uri=feezUnFreezPesaPlan.html/>",pesaPlan);
	}
	
} ]);