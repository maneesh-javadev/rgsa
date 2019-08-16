  function refreshCaptcha()
  {
	  $('#img_Capatcha').attr('src', 'captchaImage?cache=' + new Date().getTime());
      $('#captchaAnswer').val('');
      $('#captchaAnswer').focus();
 }
