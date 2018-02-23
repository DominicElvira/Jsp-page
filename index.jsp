<!DOCTYPE html>
<%@ taglib tagdir="/WEB-INF/tags/" prefix="tag" %>
<%@ taglib tagdir="/WEB-INF/tags/financial/invoice/" prefix="invoice" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%-- <fmt:timeZone value="GMT+530">
<fmt:setLocale value="en" scope="session" /> --%>
<html>
<tag:head />
<body>
<div id="wrapper">
<tag:header />
<div id="page-wrapper">
<invoice:invoice-condition />
<invoice:invoice-result />


</div>
</div>
</body>
</html>
<%-- </fmt:timeZone> --%>