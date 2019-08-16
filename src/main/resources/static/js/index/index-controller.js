var indexModule = angular.module("indexModule", []);
indexModule.controller("indexController", [ '$scope', "indexService", 
function($scope,  indexService) {
	
	indexService.fetchStatewiseEntitiesCount().then(function(response) {
		$scope.statewiseEntitiesCount = response.data;
	});
	
	indexService.findLatestImages().then(function(response) {
		$scope.data = response.data;
		$scope.details = {};
		
		var imageDetails = new Array();
		angular.forEach($scope.data, function(obj, key) {
			var image = new imageDetail();
			image.positionId = key + 1;
			image.fileId = obj.uploadFileId;
			imageDetails.push(image);
		});	
		$scope.details = imageDetails;
	});
	
	indexService.findNewDocs().then(function(response) {
		$scope.data = response.data;
		$scope.docs = {};
		var newDocs = new Array();
		angular.forEach($scope.data, function(obj, key) {
			var doc = new whatsNew();
			doc.docId = obj.uploadDocumentId;
			doc.docTitle = obj.fileTitle;
			newDocs.push(doc);
		});	
		$scope.docs = newDocs;
	});
	
	
	
	$scope.openModal = function openModal() {
		document.getElementById('imageModal').style.display = "block";
	}
	
	$scope.currentSlide = function currentSlide(n) {
		showSlides(slideIndex = n);
	}
	
}]);


var slideIndex = 1;
showSlides(slideIndex);

// Next/previous controls
function plusSlides(n) {
  showSlides(slideIndex += n);
}
function showSlides(n) {
	var i;
	var slides = document.getElementsByClassName("mySlides");
	var dots = document.getElementsByClassName("imageSlider");
	if (n > slides.length) {
		slideIndex = 1
	}
	if (n < 1) {
		slideIndex = slides.length
	}
	for (i = 0; i < slides.length; i++) {
		slides[i].style.display = "none";
	}
	for (i = 0; i < dots.length; i++) {
		dots[i].className = dots[i].className.replace(" active", "");
	}
	slides[slideIndex - 1].style.display = "block";
	dots[slideIndex - 1].className += " active";
}
