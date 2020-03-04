<nav class="navbar">
        <div class="container-fluid">
        <div class="col-xs-1 hidden-lg hidden-md">&nbsp;</div>
        <div class="col-lg-1 col-xs-1"><img src="resources/images/emblem.png" width="48" height="48" alt="User" class="img-responsive" /></div>
        <div class="col-lg-8 col-xs-6"><a class="navbar-brand" href="#"><span class="logoutxt">Rashtriya Gram Swaraj Abhiyan</span><br /><span class="logodtxt">Government of India</span></a></div>
	    <div class="col-lg-3 col-xs-4 log_out"><div class="collapse navbar-collapse" id="navbar-collapse">
	                <ul class="nav navbar-nav navbar-right">
	                     <li class="pull-right"><a href="logout.html" ><i class="fa fa-sign-out" aria-hidden="true"></i> LogOut</a></li>
	                    <!-- <li class="pull-right"><a href="javascript:void(0);" class="js-right-sidebar" data-close="true"><i class="fa fa-eyedropper" aria-hidden="true"></i> Themes</a></li> -->
	                </ul>
	            </div>
	       </div>   
   
        	<a href="javascript:void(0);" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar-collapse" aria-expanded="false"></a>
            <a href="javascript:void(0);" class="bars"></a>
        </div>
    </nav>
    <!-- By Abhishek Singh dated 4-3-2020 -->
<script>
	$('document').ready(function(){
		var userVal = '${sessionScope['scopedTarget.userPreference'].userName}';
		//alert("userVal = "+userVal);
		if (userVal == ''){
		    $('.log_out').css("display","none");
		}else{
			$('.log_out').css("display","block");
		}
	});
</script>
<!-- till here -->