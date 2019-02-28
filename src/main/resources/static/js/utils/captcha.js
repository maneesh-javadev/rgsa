  function refreshCaptcha()
  {
	  
  	var img = document.getElementById('img_Capatcha');
      img.src="captchaImage?Id=" + Math.random();
      $('#captchaAnswer').val('');
      $('#captchaAnswer').focus();
 }