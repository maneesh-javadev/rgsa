<%@include file="../taglib/taglib.jsp"%>
<html lang="en">
<head>
<meta charset="utf-8">
<title>RASHTRIYA GRAM SWARAJ ABHIYAN-Government of India</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta name="description" content="Bootstrap 3 template for corporate business" />
<!-- css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/index/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/font-awesome/font-awesome-4.2.0/css/font-awesome.min.css">

<link href="${pageContext.request.contextPath}/resources/plugins/flexslider/flexslider.css" rel="stylesheet" media="screen" />	

<style>
@font-face {
font-family:'jackfrost';
src:url('fonts/jackfrost.otf') format('opentype');
}
</style>
	
</head>
<body  data-ng-app="indexModule" data-ng-controller="indexController" style="overflow-x:hidden;">

<!-- Add all page content inside this div if you want the side nav to push page content to the right (not used if you only want the sidenav to sit on top of the page -->
<div id="main">
	<div id="wrapper">

 		<tiles:insertAttribute name="header" ignore="true" />
 
 		<tiles:insertAttribute name="body" ignore="true" />	
 		
 		<tiles:insertAttribute name="footer" ignore="true" />	
 
	 </div>
</div>
</body>

<a href="#" class="scrollup"><i class="fa fa-angle-up active"></i></a>

 
<!-- Placed at the end of the document so the pages load faster -->
<script  type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/jquery/jquery.min.js"></script>
<script  type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/bootstrap/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/plugins/flexslider/jquery.flexslider-min.js"></script> 
<script src="${pageContext.request.contextPath}/resources/plugins/flexslider/flexslider.config.js"></script>

<script >
$(document).ready(function() {
  $('#media').carousel({
    pause: true,
    interval: false,
  });
});	
</script>
<!--FOR LATEST UPPLOADED SECTION-->
<script>
$('#myCarousel').carousel({
  interval: 4000
});

$('.carousel1 .item1').each(function(){
  var next = $(this).next();
  if (!next.length) {
    next = $(this).siblings(':first');
  }
  next.children(':first-child').clone().appendTo($(this));

  for (var i=0;i<2;i++) {
    next=next.next();
    if (!next.length) {
      next = $(this).siblings(':first');
    }

    next.children(':first-child').clone().appendTo($(this));
  }
});
</script>
<script>
// for language change
function changeLanguage(id){
	alert(id);
	window.location.href="index.html?language="+id;
}
</script>
<script>
$(document).ready(function(){

$("div.bhoechie-tab-menu>div.list-group>a").click(function(e) {
        e.preventDefault();
        $(this).siblings('a.active').removeClass("active");
        $(this).addClass("active");
        var index = $(this).index();
        $("div.bhoechie-tab>div.bhoechie-tab-content").removeClass("active");
        $("div.bhoechie-tab>div.bhoechie-tab-content").eq(index).addClass("active");
    });

////

    $(".filter-button").click(function(){
        var value = $(this).attr('data-filter');
        
        if(value == "all")
        {
            //$('.filter').removeClass('hidden');
            $('.filter').show('1000');
        }
        else
        {
//            $('.filter[filter-item="'+value+'"]').removeClass('hidden');
//            $(".filter").not('.filter[filter-item="'+value+'"]').addClass('hidden');
            $(".filter").not('.'+value).hide('3000');
            $('.filter').filter('.'+value).show('3000');
            
        }
    });
    
    if ($(".filter-button").removeClass("active")) {
$(this).removeClass("active");
}
$(this).addClass("active");

});
</script>
<script>
function allPolicies(id) {
			var a = "Menu";
			var newMenuA = a + "A" + id;
			var newMenuC = a + "C" + id;
			//alert(newMenuA);
			//alert(newMenuC);
			$("[id^='Menu']").removeClass("active");
			$("#" + newMenuA).addClass("active");
			$("#" + newMenuC).addClass("active");

}
</script>


<c:choose>
	<c:when test="${!empty CAPCHAERROR}">
		<script>
			$('#login').modal('show');
			$('#errorMessageCapcha').addClass('show');
			$('#errorMessageCapcha').html('${CAPCHAERROR}');
		</script>

	</c:when>
	<c:when test="${!empty ERROR}">
		<script>
			$('#login').modal('show');
			$('#errorMessage').addClass('show');
			$('#errorMessage').html('${ERROR}');
		</script>
	</c:when>
</c:choose>


<div class="modal fade and carousel slide" id="lightboxGallery">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-body">
          <ol class="carousel-indicators">
            <li data-target="#lightboxGallery" data-slide-to="0" class="active"></li>
            <li data-target="#lightboxGallery" data-slide-to="1"></li>
            <li data-target="#lightboxGallery" data-slide-to="2"></li>
          </ol>
          <div class="carousel-inner">
            <div class="item active">
              <img src="${pageContext.request.contextPath}/resources/index/images/sample_img.jpg" alt="First slide">
            </div>
            <div class="item">
              <img src="${pageContext.request.contextPath}/resources/index/images/sample_img.jpg"alt="Second slide">
            </div>
            <div class="item">
              <img src="${pageContext.request.contextPath}/resources/index/images/sample_img.jpg" alt="Third slide">
              <div class="carousel-caption"><p>even with captions...</p></div>
            </div>
          </div><!-- /.carousel-inner -->
          <a class="left carousel-control" href="#lightboxGallery" role="button" data-slide="prev">
            <span class="glyphicon glyphicon-chevron-left"></span>
          </a>
          <a class="right carousel-control" href="#lightboxGallery" role="button" data-slide="next">
            <span class="glyphicon glyphicon-chevron-right"></span>
          </a>
        </div><!-- /.modal-body -->
      </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
  </div><!-- /.modal -->
  
  
  <!--all menu content-->
  <div id="contactsUs" class="modal fade" role="dialog">
	<div class="modal-dialog">
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<!-- <button type="button" class="close" data-dismiss="modal">&times;</button> -->
				<h4 class="modal-title">Contact us</h4>
			</div>
			<div class="modal-body">
				<div class="container-fluid">

				<div class="row main-contentBody ">
				<!-- <dl>
				<dt><i class="fa fa-university fa-1x" aria-hidden="true"></i><u> Address</u></dt>
				<dd style="margin-left: 40px;">Ministry of Panchayati Raj Government of
					 India 11th Floor, J.P. Building, Kasturba Gandhi Marg, 
					 Connaught Place, New Delhi - 110001</dd>
				 <dt><i class="fa fa-envelope fa-1x" aria-hidden="true"></i><u>Email ID : </u></dt>
				<dd style="margin-left: 40px;">mis-rgsa@gov.in</dd>
				<dt><i class="fa fa-phone-square fa-1x" aria-hidden="true"></i> </i><u>Helpdesk : </u></dt>
				<dd style="margin-left: 40px;">011-24305484</dd>
				
				</dl> -->
				
				
						<p style="color: black;"><i class="fa fa-university fa-1x" aria-hidden="true"></i><strong style="font-size: 16px;"> Address : </strong><span>Ministry of Panchayati Raj Government of
													India 11th Floor, J.P. Building, Kasturba Gandhi Marg, 
													Connaught Place, New Delhi - 110001</span></p> 
													
						<p style="color: black;"><i class="fa fa-envelope fa-1x" aria-hidden="true"></i> <strong style="font-size: 16px;">Email ID : </strong><span>mis-rgsa@gov.in</span></p> 							
						<p style="color: black;"><i class="fa fa-phone-square fa-1x" aria-hidden="true"></i> <strong style="font-size: 16px;">Helpdesk : </strong><span>011-24305284</span></p>
					
				</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
			</div>
		</div>

	</div>
</div>
<script>
(function($, window, document, undefined){
    var pluginName = "marquee",
    defaults = {
       enable : true,  
       direction: 'vertical',  
       itemSelecter : 'li',  
       delay: 3000,  
	   speed: 1,  
       timing: 1, 
       mouse: true 
    };
    function Widget(element, options) {
        this.element = element;
        this.settings = $.extend({}, defaults, options);
        this._defaults = defaults;
        this._name = pluginName;
        this.version = 'v1.0';
        this.$element = $(this.element);
        this.$wrapper = this.$element.parent();
        this.$items = this.$element.children(this.settings.itemSelecter);
        this.next = 0;
        this.timeoutHandle;
        this.intervalHandle
        if(!this.settings.enable)return; 
        this.init();
    }
    Widget.prototype = {
       init:function(){
            var that = this;
            var totalSize = 0;
            $.each(this.$items, function(index, element){
                totalSize += that.isHorizontal() 
                            ? parseInt($(element).outerWidth())
                            : parseInt($(element).outerHeight());
            }); 
            var elmentTotalSize = this.isHorizontal()
               ? this.$element.outerWidth
               : this.$element.outerHeight;
            if(totalSize < elmentTotalSize)return;
            this.$wrapper.css({
                position : 'relative',
                overflow : 'hidden',
				
            });
            this.$element.css({
                 position : 'absolute',
                 top : 0,
                 left: 0
            });
            this.$element.css(this.isHorizontal() ? 'width' : 'height', '1000%');
            this.cloneAllItems();
            if(this.settings.mouse)
            this.addHoverEvent(this);
            this.timer(this);
       },
        timer : function(that){
            this.timeoutHandle = setTimeout(function(){that.play(that)}, this.settings.delay);
        },
        play : function(that){
           this.clearTimeout();
            var target = 0;
            for(var i = 0; i <= this.next; i++){
                 
                 target -= this.isHorizontal()
                    ? parseInt($(this.$items.get(this.next)).outerWidth())
                    : parseInt($(this.$items.get(this.next)).outerHeight());
            }
            this.intervalHandle = setInterval(function(){that.animate(target)},this.settings.timing);
        },
        animate : function(target){
            var mark = this.isHorizontal() ? 'left' : 'top';
            var present =  parseInt(this.$element.css(mark));
            if(present > target)
            {
                if(present - this.settings.speed <= target)
                {
                     this.$element.css(mark, target);
                }else
                     this.$element.css(mark, present - this.settings.speed);
            }else{
                this.clearInterval();

                if(this.next + 1 < this.$items.length){
                     
                     this.next++;
                }else{
                    this.next = 0;
                    this.$element.css(mark,0);
                }
                this.timer(this);
            }
        },
        isHorizontal : function(){

            return this.settings.direction == 'horizontal';
        },
       cloneAllItems: function(){

            this.$element.append(this.$items.clone());
        },
        clearTimeout : function(){
            clearTimeout(this.timeoutHandle);
        },
      clearInterval : function(){
            
            clearInterval(this.intervalHandle);
        },
        addHoverEvent : function(that){
            this.$wrapper
              .mouseenter(function(){
                   that.clearInterval()
                   that.clearTimeout();
              })
              .mouseleave(function(){
                   that.play(that);
              });
        }
    }
    $.fn[pluginName] = function(options) {
        return this.each(function() {
            if (!$.data(this, "plugin_" + pluginName)) {
                $.data(this, "plugin_" + pluginName, new Widget(this, options));
            }
        });
    };
})(jQuery, window, document);

</script>
<script type="text/javascript">
  
  $(function(){


  $('#marquee-vertical').marquee();  
  $('#marquee-horizontal').marquee({direction:'horizontal', delay:0, timing:50});  

});

</script>
