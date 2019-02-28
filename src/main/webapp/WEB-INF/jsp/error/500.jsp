<%@include file="../taglib/taglib.jsp"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <title>500 </title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/waves/css/waves.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/core/style.css">
</head>
<body class="five-zero-zero">
    <div class="five-zero-zero-container">
        <div class="error-code">500</div>
        <div class="error-message">Internal Server Error</div>
        <div class="button-place">
        	<c:choose>
        		<c:when test="${!empty sessionScope['scopedTarget.userPreference'].userName}">
        			<a href="home.html" class="btn btn-default btn-lg waves-effect">GO TO HOMEPAGE</a>
        		</c:when>
        		<c:otherwise>
					<a href="index.html" class="btn btn-default btn-lg waves-effect">GO TO HOMEPAGE</a>        		
        		</c:otherwise>
        	</c:choose>
        </div>
    </div>
<script  type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/jquery/jquery.min.js"></script>
<script  type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/bootstrap/js/bootstrap.min.js"></script>
<script  type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/waves/js/waves.min.js"></script>
</body>

</html>