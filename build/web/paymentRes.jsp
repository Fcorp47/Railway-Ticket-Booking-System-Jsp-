<%-- 
    Document   : paymentRes
    Created on : 1 Nov, 2022, 9:26:57 AM
    Author     : Asus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.paytm.pg.merchant.CheckSumServiceHelper" %>
<%@page import="java.util.*" %>

<%!
public class PaytmConstants{

	public static final String MID="TYmwCE61492093834199";
	public static final String MERCHANT_KEY="rKFy9v9vGjp7ajt5";
	public static final String INDUSTRY_TYPE_ID="Retail";
	public static final String CHANNEL_ID="WEB";
	public static final String WEBSITE="WEBSTAGING";

	public static final String PAYTM_URL="https://securegw-stage.paytm.in/order/process";


}

%>

<%
Enumeration paramNames=request.getParameterNames();
Map<String, String[]> mapData=request.getParameterMap();
TreeMap parameters=new TreeMap<>();
String paytmChecksum="";
while(paramNames.hasMoreElements()){
	String paramName=(String)paramNames.nextElement();
	if(paramName.equals("CHECKSUMHASH")){
		paytmChecksum=mapData.get(paramName)[0];

	}else{
		parameters.put(paramName,mapData.get(paramName)[0]);
	}
	
}
boolean isValidChecksum=false;
String outputHtml="";
try{
	isValidChecksum=CheckSumServiceHelper.getCheckSumServiceHelper().verifycheckSum(PaytmConstants.MERCHANT_KEY,parameters,paytmChecksum);
	if(isValidChecksum && parameters.containsKey("RESPCODE")){
		if(parameters.get("RESPCODE").equals("01")){
			outputHtml=parameters.toString();
			Enumeration aa=request.getParameterNames();
			while(aa.hasMoreElements()){
			Object a=aa.nextElement();
			%>
			<h2>PAYMENT DONE SUCESSFULLY!</h2>
			System.out.println("PAID SUCESSFULLY!");
			<jsp:forward page="orderconf.jsp"/>

			<%
		}

	}else{		
			outputHtml="<b>PAYMENT FAILED!</b>";
			Enumeration aa=request.getParameterNames();
			while(aa.hasMoreElements()){
			Object a=aa.nextElement();
			out.println(a);
		}%>
			<script type="text/javascript">
function Redirect()
{
    window.location="./index.jsp";
}
document.write("Error Occured! You will be redirected to main page in a few sec.");
setTimeout('Redirect()', 5000);
</script>
		<%

}

}else{
	%>
		<script type="text/javascript">
function Redirect()
{
    window.location="./index.jsp";
}
document.write("Error Occured! You will be redirected to main page in a few sec.");
setTimeout('Redirect()', 5000);
</script>
	<%
	outputHtml="<b>Checksum Mismatched!</b>";
}

}catch(Exception e){
	outputHtml=e.toString();
}




%>



<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
