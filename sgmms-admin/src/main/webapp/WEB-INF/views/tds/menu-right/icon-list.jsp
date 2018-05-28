<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>

<style>
   .modal-dialog {
        width: 600px;
    }
    
    .modal-body {
     	height: 500px;
     	overflow: auto;
    }
    
    .icon:hover,.activity{
		background-color: #563D7C;
		color: pink;
		cursor: pointer;
		
    }
    
    .icon {
		padding: 10px;
    }
</style>

<script type="text/javascript">
	function selectIcon(fieldObj){
		$(".activity").removeClass("activity");
		$(fieldObj).addClass("activity");
	}
</script>

<div id="iconListDiv" class="row">
	<div class="col-sm-12">
		<ul class="nav nav-tabs" role="tablist">
			<c:forEach items="${menuIconMap}" var="menuIconMap" varStatus="status">
				<li role="presentation" <c:if test="${status.index==0}">class="active"</c:if>>
					<a href="#${menuIconMap.key}" role="tab" data-toggle="tab" aria-controls="${menuIconMap.key}">${menuIconMap.key}</a>
				</li>
			</c:forEach>
		</ul>
		
		<div class="tab-content">
			<c:forEach items="${menuIconMap}" var="menuIconMap" varStatus="status">
			    <div role="tabpanel" class="tab-pane <c:if test="${status.index==0}">active</c:if>" id="${menuIconMap.key}">
			    	<c:forEach items="${menuIconMap.value}" var="iconPath">
			    		<div class="col-xs-2 col-md-2 text-center">
				    		<div class="icon" onclick="selectIcon(this)">
								<img src="${ctx}/${iconPath}" icon="${iconPath}">
							</div>
						</div>
			    	</c:forEach>
			    </div>
		    </c:forEach>
		</div>
	</div>
	<%-- 
	<c:forEach items="${icons}" var="icon">
		<div class="col-xs-2 col-md-2 text-center">
			<div class="icon" onclick="selectIcon(this)">
				<img src="${ctx}/${icon}" icon="${icon}">
			</div>
		</div>
	</c:forEach>
	--%>
</div>