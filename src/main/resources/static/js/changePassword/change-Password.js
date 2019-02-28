$(function () {
    $('#changepasswordId').validate({
        rules: {
            'oldPassword': {
                required: true
            },
            'newPassword': {
                required: true
            },
            
            'confirmPassword': {
                required: true
            },
            
        },
        highlight: function (input) {
            $(input).parents('.form-line').addClass('error');
        },
        unhighlight: function (input) {
            $(input).parents('.form-line').removeClass('error');
        },
        errorPlacement: function (error, element) {
            $(element).parents('.form-group').append(error);
        }
    });
    
});
   
    