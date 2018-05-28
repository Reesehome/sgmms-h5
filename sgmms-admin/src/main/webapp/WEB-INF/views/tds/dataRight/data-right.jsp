<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
<%@ include file="/tds/dataRight/js/data-right-edit.js.jsp"%>

<form id="dataRightFactorForm" class="form-horizontal">
	<input id="dataRightId_old" name="dataRightId_old" value="${dataRightFactor.dataRightId}" type="hidden">
    <input id="rightTypeId" name="rightTypeId" value="${dataRightFactor.rightTypeId}" type="hidden">
    
 <div class="inner-panel">   
  <div class="panel panel-info">
     <div class="panel-heading"><spring:message code="tds.dataRight.label.dataRightBaseInfo"/> 
     </div>
       <div class="panel-body">

			<div class="form-group">
			    <label for="rightTypeName" class="col-md-2 control-label"><spring:message code="tds.dataRight.label.RightType"/></label>
				<div class="col-md-4">
					<input id="rightTypeName" name="rightTypeName" value="${rightFactorType.rightTypeName}" class="form-control"  readonly="readonly">
			    </div>
			
			</div>
			
			
            <div class="form-group">
			    <label for="dataRightId" class="col-md-2 control-label"><spring:message code="tds.dataRight.label.RightCodeID"/></label>
				<div class="col-md-4">
					<input id="dataRightId" name="dataRightId" value="${dataRightFactor.dataRightId}" class="form-control" 
					 <c:if test='${dataRightFactor.dataRightId!=null}'> readonly="readonly"</c:if>
					 />
			    </div>
			
				<label for="rightFactorName" class="col-md-2 control-label"><spring:message code="tds.dataRight.label.RightName"/></label>
				<div class="col-md-4">
					<input id="dataRightName" name="dataRightName" value="${dataRightFactor.dataRightName}" class="form-control"  >
				</div>
			</div>
			 
              <div class="form-group">
	                  
<!-- 	                  <label for="checkedMode" class="col-md-2 control-label">权限选择方式</label> -->
<!-- 					   <div class="col-md-4"> -->
<!-- 						<select class="form-control" id="checkedMode" name="checkedMode"> -->
<%-- 							 <c:forEach var="dictionaryItem" items="${listCheckModes}"> --%>
<%-- 							        <c:choose> --%>
<%-- 								        <c:when test="${dictionaryItem.value == dataRightFactor.checkedMode}"> --%>
<%-- 							                 <option value="${dictionaryItem.value}" selected='selected'>${dictionaryItem.name}</option> --%>
<%-- 						                 </c:when> --%>
<%-- 						                 <c:otherwise> --%>
<%-- 						                   <option value="${dictionaryItem.value}">${dictionaryItem.name}</option> --%>
<%-- 					                     </c:otherwise> --%>
<%-- 							        </c:choose> --%>
<%-- 				            </c:forEach> --%>
<!-- 						</select> -->
<!-- 				       </div>        -->
              
			    <div class="col-sm-offset-2 col-sm-4">
			      <div class="checkbox">
			        <label> 
			          <input type="checkbox"  id="isValid" name="isValid" <c:if test='${dataRightFactor.isValid=="Y" }'> checked="checked"</c:if> /> <spring:message code="tds.dataRight.label.isStartDataRight"/>
			        </label>
			      </div>
			    </div>
			  </div>

			<div class="form-group">
				<label for="dataRightFactor" class="col-md-2 control-label"> <spring:message code="tds.dataRight.label.description"/></label>
				<div class="col-md-10">
					<textarea class="form-control" rows="3" id="remark" name="remark">${dataRightFactor.remark}</textarea>
				</div>
			</div>
			
		</div>	<!-- 面板 -->
	 </div>		
  </div>
</div>

<div class="inner-panel">  
<div class="panel panel-info">
     <div class="panel-heading"><spring:message code="tds.dataRight.label.dataSource"/></div>
       <div class="panel-body">
 
			<div class="form-group">
			      <div class="col-sm-offset-2 col-sm-10">
				     <label class="radio-inline"  class="col-md-5" >
					  <input type="radio" title="java" name="dataSourceType"  onclick="radioClick('java')"
					  <c:if test='${dataRightFactor.dataSourceType=="J" || dataRightFactor.dataSourceType==null}'> checked="checked"</c:if> /> <spring:message code="tds.dataRight.label.dataSourceJava"/>
					</label>
					<label class="radio-inline" class="col-md-5">
					  <input type="radio" title="sql" name="dataSourceType"  onclick="radioClick('sql')"
					  <c:if test='${dataRightFactor.dataSourceType=="S" }'> checked="checked"</c:if>  /><spring:message code="tds.dataRight.label.dataSourceSql"/>
					</label>
				</div>
			</div>
			
			    
			    
				      <div id="java_dataSource">
						<div class="form-group">
							<label for="dataSource" class="col-md-2 control-label"><spring:message code="tds.dataRight.label.javaDoClass"/></label>
							<div class="col-md-10">
								<input id="dataSource_java" name="dataSource_java" value="${dataRightFactor.dataSource_java}" class="form-control" placeholder="" >
							</div>
						</div>
				
						<div class="form-group">
						     <div class="col-sm-offset-2 col-md-10">
							    <p class="text-left">该java处理类必须实现com.tisson.tds.api.DataRightAdapter接口,</p>
								<p class="text-left">业务开发时通过编程实现。该处理类需要实现函数:</p>
								<p class="text-left" style="padding-left: 28px" >public List &ltDataRight&gt getDataAll();</p>
								<p class="text-left" style="padding-left: 28px" >该返回所有的授权数据，返回对象 DataRight具有如下属性:</p>
								<p class="text-left" style="padding-left: 28px">String id-被授权的权限数据编号。</p>
								<p class="text-left" style="padding-left: 28px">String name-被授权的权限数据名称。</p>
								<p class="text-left" style="padding-left: 28px">String pId-当前数据的上级parent权限数据编号（树形结构时，否则为空)</p>
                                <p class="text-left" style="padding-left: 28px"> int seqNum-同级情况下的排列次序值，数值小排在前。</p>
								<p class="text-left" style="padding-left: 28px"> 返回结果为列表，系统自动转换为树形结构。</p>
							</div>
						</div>
		              </div>
		     
			         <div id="sql_dataSource">
							 <div class="form-group">
<!-- 							     <div class="col-sm-offset-2 col-sm-10"> -->
							        <label class="col-md-2 control-label"><spring:message code="tds.dataRight.label.getALLRightSQL"/></label>
								    <div class="col-md-10">
								    <textarea class="form-control" rows="4" id="dataSource_sql" name="dataSource_sql"  placeholder=" select areaId as Id,areaName as Name,pAreaId as pId seqNum from sys_area_table">${dataRightFactor.dataSource_sql}</textarea>
                                     </div>
<!-- 								 </div> -->
						     </div>
						     <div class="form-group">
						     <div class="col-sm-offset-2 col-md-10">
							    <p class="text-left">sql语句返回id，name,pId及seqNum字段，与javaclass返回的属性一致。</p>
<!-- 								<p class="text-left">$userId#做为查询条件，以宏替换的方式执行。</p> -->
							</div>
						</div>
		            </div>
			
	         
	
	   </div><!-- 面板 -->
	</div>
 </div>
</div>	<!-- form-group -->
	
	<div class="form-group">
		<div class="col-xs-offset-10 col-sm-offset-10 col-md-2 text-right">
<%-- 			<button type="button" class="btn btn-primary" onclick="saveRightFactor()">　<spring:message code="tds.common.label.save"/>　</button> --%>
		</div>
	</div>
	
</form>