
var pathname;
$(document).ready(function() {
	pathname = window.location.pathname;
});
function onClose(s) {
	var position = pathname.indexOf("/", 2);
	var newPath = "";
	var val = s.indexOf("?", 1);
	if (val > 0) {
		newPath = s;
	} else {
		newPath = s;
	}
	 swal({
	        title: "Are you sure?",
	        text: "you want to close this Form.",
	        type: "warning",
	        showCancelButton: true,
	        confirmButtonColor: "#FF9800",
	        confirmButtonText: "Yes",
	        cancelButtonText: "No",
	        closeOnConfirm: true,
	        closeOnCancel: true
	    }, function (isConfirm) {
	        if (isConfirm) {
	        	window.location.replace(".." + pathname.substring(0, position) + "/"+ newPath);
	        }
	    });
}

function onClear(obj){
	
	var idForm = obj.form.id;
	 swal({
	        title: "Are you sure?",
	        text: "you want to clear this Form.",
	        type: "warning",
	        showCancelButton: true,
	        confirmButtonColor: "#2196F3",
	        confirmButtonText: "Yes",
	        cancelButtonText: "No",
	        closeOnConfirm: true,
	        closeOnCancel: true
	    }, function (isConfirm) {
	        if (isConfirm) {
	        	$("#"+idForm)[0].reset();
	        }
	    });
}

function showCancelMessage() {
    swal({
        title: "Are you sure?",
        text: "You will not be able to recover this imaginary file!",
        type: "warning",
        showCancelButton: true,
        confirmButtonColor: "#DD6B55",
        confirmButtonText: "Yes, delete it!",
        cancelButtonText: "No, cancel plx!",
        closeOnConfirm: false,
        closeOnCancel: false
    }, function (isConfirm) {
        if (isConfirm) {
            swal("Deleted!", "Your imaginary file has been deleted.", "success");
        } else {
            swal("Cancelled", "Your imaginary file is safe :)", "error");
        }
    });
}

function disablingSave(){
	$('.save-button').attr('disabled','disabled');
}

$('document').ready(function(){
	$('.save-button').removeAttr('disabled');
});