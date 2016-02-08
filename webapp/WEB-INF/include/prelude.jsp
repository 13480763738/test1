<%@page import="com.jiudian.framework.http.session.authentication.PasswordAuthentication"%>
<%@page import="com.jiudian.framework.http.upload.FileStore"%>
<%@page import="com.jiudian.util.Formater"%>
<%@page import="com.jiudian.util.StringHelper"%>
<%@page import="com.jiudian.util.ObjectHelper"%>
<%@page import="com.jiudian.util.parser.*"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.jiudian.framework.config.*"%>
<%@page import="com.jiudian.framework.resource.*"%>
<%@page import="com.jiudian.framework.http.servlet.*"%>
<%@page import="com.jiudian.framework.http.session.*"%>
<%@page import="com.jiudian.framework.service.*"%>
<%@page import="com.jiudian.framework.service.query.*"%>
<%@page import="com.jiudian.p2p.common.enums.*"%>
<%@page import="com.jiudian.p2p.variables.defines.*"%>
<%@page session="false"%>
<%
	String _ALT = "麒麟通宝P2P网贷平台";
	boolean JQUERY_NOT_INCLUDED = true;
	boolean JQUERY_UI_NOT_INCLUDED = true;
	boolean DIALOG_NOT_INCLUDED = true;
	String CURRENT_CATEGORY = "";
	String CURRENT_SUB_CATEGORY = "";
	
	String WAP_TITLE_NAME = "";
	
	boolean IS_SHOW_FRIENDLINK = false;
	ResourceProvider resourceProvider = ResourceRegister.getResourceProvider(application);
	SessionManager sessionManager = resourceProvider.getResource(SessionManager.class);
	Session jiudianSession = sessionManager.getSession(request, response,true);
	SystemDefine systemDefine = resourceProvider.getSystemDefine();
	try (ServiceSession serviceSession = resourceProvider.getResource(
			ServiceProvider.class).createServiceSession(jiudianSession)) {
		FileStore fileStore  = resourceProvider.getResource(FileStore.class);
		Rewriter rewriter = resourceProvider.getSystemDefine().getRewriter();
		Controller controller = resourceProvider.getResource(Controller.class);
		ConfigureProvider configureProvider = resourceProvider.getResource(ConfigureProvider.class);
%>