<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/tds/common/tag-lib.jsp"%>
  <%
  
      String processInstanceId= (String)request.getParameter("processInstanceId");
      String processDefinitionId= (String)request.getParameter("processDefinitionId");
      String path= (String)request.getParameter("path");
      System.out.println("processInstanceId:"+processInstanceId+"====processDefinitionId:"+processDefinitionId+"===path="+path);
  %>

  <link rel="stylesheet" href="${ctx}/tds/workflow/diagram-viewer/style.css" type="text/css" media="screen">
  
  
  <script src="${ctx}/tds/workflow/diagram-viewer/js/jstools.js" type="text/javascript" charset="utf-8"></script>
  <script src="${ctx}/tds/workflow/diagram-viewer/js/raphael.js" type="text/javascript" charset="utf-8"></script>
  
  <script src="${ctx}/tds/workflow/diagram-viewer/js/jquery/jquery.js" type="text/javascript" charset="utf-8"></script>
  <script src="${ctx}/tds/workflow/diagram-viewer/js/jquery/jquery.progressbar.js" type="text/javascript" charset="utf-8"></script>
  <script src="${ctx}/tds/workflow/diagram-viewer/js/jquery/jquery.asyncqueue.js" type="text/javascript" charset="utf-8"></script>
  
  <script src="${ctx}/tds/workflow/diagram-viewer/js/Color.js" type="text/javascript" charset="utf-8"></script>
  <script src="${ctx}/tds/workflow/diagram-viewer/js/Polyline.js" type="text/javascript" charset="utf-8"></script>
  <script src="${ctx}/tds/workflow/diagram-viewer/js/ActivityImpl.js" type="text/javascript" charset="utf-8"></script>
  <script src="${ctx}/tds/workflow/diagram-viewer/js/ActivitiRest.js" type="text/javascript" charset="utf-8"></script>
  <script src="${ctx}/tds/workflow/diagram-viewer/js/LineBreakMeasurer.js" type="text/javascript" charset="utf-8"></script>
  <script src="${ctx}/tds/workflow/diagram-viewer/js/ProcessDiagramGenerator.js" type="text/javascript" charset="utf-8"></script>
  <script src="${ctx}/tds/workflow/diagram-viewer/js/ProcessDiagramCanvas.js" type="text/javascript" charset="utf-8"></script>
  
  <style type="text/css" media="screen">
    
  </style>
  
  <body onload="initBox();">
  
<div class="wrapper" >
  <div id="pb1"  style="display: none;"></div>
  <div id="overlayBox" >
    <div id="diagramBreadCrumbs" style="display: none;"  class="diagramBreadCrumbs" onmousedown="return false" onselectstart="return false"></div>
    <div id="diagramHolder" class="diagramHolder"></div>
    <div class="diagram-info" id="diagramInfo"></div>
  </div>
</div>

  </body>
<script language='javascript'>
var DiagramGenerator = {};
var pb1;
$(document).ready(function(){
  var query_string = {};
  var query = window.location.search.substring(1);
  var vars = query.split("&");
  for (var i=0;i<vars.length;i++) {
    var pair = vars[i].split("=");
    query_string[pair[0]] = pair[1];
  } 
  
  query_string={"processDefinitionId":'<%=processDefinitionId %>',"processInstanceId":'<%=processInstanceId %>'};
  // query_string={"processDefinitionId":'processtest333:1:237524',"processInstanceId":'242501'};
  var processDefinitionId = query_string["processDefinitionId"];
  var processInstanceId = query_string["processInstanceId"];
  
  console.log("Initialize progress bar");
  
  pb1 = new $.ProgressBar({
    boundingBox: '#pb1',
    label: 'Progressbar!',
    on: {
      complete: function() {
        console.log("Progress Bar COMPLETE");
        this.set('label', 'complete!');
        if (processInstanceId) {
          ProcessDiagramGenerator.drawHighLights(processInstanceId);
        }
      },
      valueChange: function(e) {
        this.set('label', e.newVal + '%');
      }
    },
    value: 0
  });
  console.log("Progress bar inited");
  
  ProcessDiagramGenerator.options = {
    diagramBreadCrumbsId: "diagramBreadCrumbs",
    diagramHolderId: "diagramHolder",
    diagramInfoId: "diagramInfo",
    on: {
      click: function(canvas, element, contextObject){
        var mouseEvent = this;
        console.log("[CLICK] mouseEvent: %o, canvas: %o, clicked element: %o, contextObject: %o", mouseEvent, canvas, element, contextObject);

        if (contextObject.getProperty("type") == "callActivity") {
          var processDefinitonKey = contextObject.getProperty("processDefinitonKey");
          var processDefinitons = contextObject.getProperty("processDefinitons");
          var processDefiniton = processDefinitons[0];
          console.log("Load callActivity '" + processDefiniton.processDefinitionKey + "', contextObject: ", contextObject);

          // Load processDefinition
        ProcessDiagramGenerator.drawDiagram(processDefiniton.processDefinitionId);
        }
      },
      rightClick: function(canvas, element, contextObject){
        var mouseEvent = this;
        console.log("[RIGHTCLICK] mouseEvent: %o, canvas: %o, clicked element: %o, contextObject: %o", mouseEvent, canvas, element, contextObject);
      },
      over: function(canvas, element, contextObject){
        var mouseEvent = this;
        //console.log("[OVER] mouseEvent: %o, canvas: %o, clicked element: %o, contextObject: %o", mouseEvent, canvas, element, contextObject);

        // TODO: show tooltip-window with contextObject info
        ProcessDiagramGenerator.showActivityInfo(contextObject);
      },
      out: function(canvas, element, contextObject){
        var mouseEvent = this;
        //console.log("[OUT] mouseEvent: %o, canvas: %o, clicked element: %o, contextObject: %o", mouseEvent, canvas, element, contextObject);

        ProcessDiagramGenerator.hideInfo();
      }
    }
  };
  
  var baseUrl = window.document.location.protocol + "//" + window.document.location.host + "/";
  var shortenedUrl = window.document.location.href.replace(baseUrl, "");
  baseUrl = baseUrl + shortenedUrl.substring(0, shortenedUrl.indexOf("/"));
  
 baseUrl='<%=path %>';
 
  ActivitiRest.options = {
    processInstanceHighLightsUrl:  "${ctx}/service/process-instance/{processInstanceId}/highlights?callback=?",
    processDefinitionUrl: "${ctx}/service/process-definition/{processDefinitionId}/diagram-layout?callback=?",
    processDefinitionByKeyUrl:  "${ctx}/service/process-definition/{processDefinitionKey}/diagram-layout?callback=?"
  };
  
  if (processDefinitionId) {
    ProcessDiagramGenerator.drawDiagram(processDefinitionId);
  } else {
    alert("processDefinitionId parameter is required");
  }
});

   function initBox(){
	  $(".diagram").attr("style","width: 720px; height: 402px;");
	    var  parameter ={"width":"720","height":"402" };
	    $("svg").attr(parameter);
	    $("svg").attr("style","overflow: hidden; position: relative;background:url(./images/bg.png) ;");

	}

</script>