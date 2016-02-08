<%@page import="java.net.URLEncoder"%>
<%@page import="com.jiudian.framework.http.upload.FileInformation"%>
<%@page import="com.jiudian.p2p.front.service.information.entity.PerformanceReport"%>
<%@page import="com.jiudian.p2p.front.service.information.PerformanceReportManage"%>
<%
PerformanceReportManage reportManage = serviceSession.getService(PerformanceReportManage.class);
PerformanceReport report = reportManage.get(IntegerParser.parse(request.getParameter("id")));
if(report==null){
	response.sendError(HttpServletResponse.SC_NOT_FOUND);
	return;
}
reportManage.view(report.id);
String fileName=report.title;
FileInformation info=fileStore.getFileInformation(report.attachmentCode);
String suffix = info.getSuffix();
if(!StringHelper.isEmpty(suffix)){
	fileName+='.'+suffix;
}
response.addHeader("Content-Disposition", "attachment; filename="+URLEncoder.encode(fileName,resourceProvider.getCharset()));
fileStore.read(info, response.getOutputStream());
%>