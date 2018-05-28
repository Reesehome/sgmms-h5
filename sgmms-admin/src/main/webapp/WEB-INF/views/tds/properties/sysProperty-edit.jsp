<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>

<jsp:include page="/tds/sysProperties/js/edit.js.jsp" />

<form id="editForm" class="form-horizontal">
	<input id="propKey-old" name="propKey-old" value="${sysProperty.propKey}" type="hidden">


	<div class="form-group">
		<label for="propKey" class="col-sm-3 control-label"><spring:message code="tds.sys.property.key"/></label>
		<div class="col-sm-7">
			<input id="key" name="propKey"  value="${sysProperty.propKey}"   class="form-control" placeholder="<spring:message code='tds.sys.property.inputkey'/>"
			 <c:if test='${sysProperty.propKey!=null}'> readonly="readonly"</c:if> />
		</div>
	</div>
	
	<div class="form-group">
		<label for="propValue" class="col-sm-3 control-label"><spring:message code="tds.sys.property.value"/></label>
		<div class="col-sm-7">
			<input id="pValue" name="propValue" class="form-control" placeholder="<spring:message code='tds.sys.property.inputvalue'/>" value="${sysProperty.propValue}">
		</div>
	</div>
	
	

	
	<div class="form-group">
		<label for="deletable" class="col-sm-3 control-label"><spring:message code='tds.sys.property.isDelete'/></label>
		<div class="col-sm-7">
		           <label class="radio-inline"  class="col-md-5" >
					  <input type="radio" name="deletable_type"  onclick="radioClick('yes')"
					  <c:if test='${sysProperty.deletable=="Y"|| sysProperty.deletable==null}'> checked="checked"</c:if> 
					  <c:if test='${sysProperty.propKey!=null}'> disabled</c:if> /> <spring:message code='tds.sys.property.yes'/>
					</label>
					<label class="radio-inline" class="col-md-5">
					  <input type="radio"  name="deletable_type"  onclick="radioClick('no')"
					  <c:if test='${sysProperty.deletable=="N" }'> checked="checked"</c:if>  
					  <c:if test='${sysProperty.propKey!=null}'> disabled</c:if> /><spring:message code='tds.sys.property.no'/>
					</label>
		    <input id="deletable" name="deletable" type="hidden"  value="${sysProperty.deletable}"/>
		</div>
	</div>
	
	<div class="form-group">
		<label for="remark" class="col-sm-3 control-label"><spring:message code="tds.sys.property.remark"/></label>
		<div class="col-sm-7">
        <textarea class="form-control" rows="3" id="remark" name="remark"  placeholder="<spring:message code='tds.sys.property.inputremark'/>">${sysProperty.remark}</textarea>		
        </div>
	</div>
	
</form>