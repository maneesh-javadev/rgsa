<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/core/style.css">
<%@include file="../taglib/taglib.jsp"%>
<meta charset="UTF-8">
<title>Insert title here</title>
<script></script>
</head>
<body>

<section class="content">
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="card">
					<div class="header">
						<h2>
							Sql Pannel
						</h2>
					</div>
					<form  id="sqlPannelForm" action="rgsaSqlPannelRunUpdate.html" method="POST">
						<input type="hidden" name="<csrf:token-name/>"	value="<csrf:token-value uri="rgsaSqlPannelRun.html"/>" />
						<div class="form-group">
				    		<label for="email">Query Pannel</label><br>
				    		<textarea name="queryString" rows="10" cols="140">${queryString}</textarea>
				  		</div>
						
						
				    	<div class="box-footer">
				   			<div class="col-sm-offset-2 col-sm-10">
					  			<div class="pull-right">		
						 			<button  type="submit"  class="btn btn-success"  ><i class="fa fa-play" aria-hidden="true"></i></button>
						 			<button style="width: 80px;" type="button" name="Submit3" class="btn btn-danger" onclick="javascript:location.href='home.htm?<csrf:token uri='home.htm'/>';"><i class="fa fa-times-circle" aria-hidden="true"></i> </button>
								</div>
							</div>
						</div>
					    
					   
					   <br> <br>
					 <c:if test="${! empty retRow  }"><c:out value="${retRow}"></c:out> Row updated</c:if> -
				      <c:out value="${errorData}"/>
					
					
					</form>
				</div>
		</div>
	</div>
 </div>
</section>

      
</body>
</html>