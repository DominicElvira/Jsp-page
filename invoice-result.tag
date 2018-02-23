<%@tag import="net.sf.json.JSONObject"%>
<%@ attribute name="pending" required="false" %>
<%@ attribute name="ostatus" required="false" %>
<%@ taglib tagdir="/WEB-INF/tags/" prefix="tag" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<sql:setDataSource dataSource="jdbc/mysql/ota" />

<sql:query var="countRS">
	SELECT count(*) AS cnt FROM invoice a where 1 =1 
	<c:if test="${not empty param.OrderNo}">
		and a.flight_Order_Id = ? <sql:param value="${param.OrderNo}"/>
	</c:if>
	
	<c:if test="${not empty param.InvoiceNo}">
		and a.invoiceNo = ? <sql:param value="${param.InvoiceNo}"/>
	</c:if>
	<c:if test="${not empty param.timeFrom}">
   		AND a.invoice_date>= ? <sql:param value="${param.timeFrom}" />
	</c:if>
	<c:if test="${not empty param.timeTo}">
  		 AND a.invoice_date < ? + interval 1 day <sql:param value="${param.timeTo}" />
	</c:if>
</sql:query>
<c:set var="page" value="${empty param.page ? 1 : param.page * 1}" />
<c:if test="${page le 0}">
	<c:set var="page" value="1" />
</c:if>
<c:set var="totalResultCount" value="${countRS.rows[0].cnt}" />
<c:set var="totalPage">
	<fmt:parseNumber value="${(totalResultCount + 9) div 10}" integerOnly="true" />
</c:set>
<c:if test="${totalResultCount le 0}">
<p class="text-danger">Sorry, data not found!</p>
</c:if>
<c:if test="${totalResultCount gt 0}">
<c:if test="${page lt 0}">
<c:set var="page" value="1" />
</c:if>
<c:if test="${page gt totalPage}">
<c:set var="page" value="${totalPage}" />
</c:if>
<c:set var="skip" value="${(page - 1) * 10}" />

<sql:query var="invoiceRs">
	select * from invoice a where 1=1
	<c:if test="${not empty param.OrderNo}">
		and a.flight_Order_Id = ? <sql:param value="${param.OrderNo}"/>
	</c:if>
	
	<c:if test="${not empty param.InvoiceNo}">
		and a.invoiceNo = ? <sql:param value="${param.InvoiceNo}"/>
	</c:if>
	<%-- <c:if test="${not empty param.timeFrom}">
   		AND a.invoice_date>= CONVERT_TZ(?, '+05:30', @@session.time_zone) <sql:param value="${param.timeFrom}" />
	</c:if>
	<c:if test="${not empty param.timeTo}">
  		 AND a.invoice_date < CONVERT_TZ(?, '+05:30', @@session.time_zone) + interval 1 day <sql:param value="${param.timeTo}" />
	</c:if> --%>
	<c:if test="${not empty param.timeFrom}">
   		AND a.invoice_date>= ? <sql:param value="${param.timeFrom}" />
	</c:if>
	<c:if test="${not empty param.timeTo}">
  		 AND a.invoice_date < ? + interval 1 day <sql:param value="${param.timeTo}" />
	</c:if>
	order by a.id
	LIMIT 10
	OFFSET ${skip}
</sql:query>

<tag:page-info total="${totalResultCount}" page="${page}" />

<div  style="overflow:auto;">
<table class="table table-hover">
	<thead>
		<tr>
			<th>OrderNo</th>
			<th>InvoiceNo</th>
			<th>InvoiceDate</th>
			<th style="white-space:nowrap;">Client Download Number</th>
			<th style="white-space:nowrap;">Seller Download Number</th> 
			<th style="white-space:nowrap;">Base Fare</th>
			<th style="white-space:nowrap;">Tax and Fees</th>
			<th style="white-space:nowrap;">Convenience Fee</th>
			<th style="white-space:nowrap;">Customer Prom/Discount</th>
			<th style="white-space:nowrap;">Total-1</th>
			<th style="white-space:nowrap;">Coupon</th>
			<th style="white-space:nowrap;">Happey Silver</th>
			<th style="white-space:nowrap;">Happey Gold</th>
			<th style="white-space:nowrap;">Total-2</th>
			<th style="white-space:nowrap;">Payment Received against Fare Difference</th>
			<th style="white-space:nowrap;">Net Total Received</th>
			<th>GSTAmount</th>
			<th>Client Name</th>
			<th>Client Address</th>
			<th>State</th>
			<th style="white-space:nowrap;">GSTIN No</th>
		</tr>
	</thead>
	<tbody>
	
<c:forEach var="invoice" items="${invoiceRs.rows}" varStatus="invoiceVS">
		<tr>
			<td>${invoice.flight_Order_Id }</td>
			<td>${invoice.invoiceNo }</td>
			<td style="white-space:nowrap;"><fmt:formatDate pattern="dd MMM, yyyy" value="${invoice.invoice_date }" /></td>
			<td><a href="${pageContext.request.contextPath}/financial/invoiceDownload/index.jsp?orderId=${invoice.flight_Order_Id }&type=1">${invoice.client_download_num }</a></td>
			<td><a href="${pageContext.request.contextPath}/financial/invoiceDownload/index.jsp?orderId=${invoice.flight_Order_Id }&type=2">${invoice.seller_download_num }</a></td>
			<td>${invoice.baseFare }</td>
			<td>${invoice.taxAndFare }</td>
			<td>${invoice.convenienceFee }</td>
			<td>${invoice.discount }</td>
			<td>${invoice.total1 }</td>
			<td>${invoice.coupon }</td>
			<td>${invoice.happySilver }</td>
			<td>${invoice.happyGold }</td>
			<td>${invoice.total2 }</td>
			<td>${invoice.difference }</td>
			<td>${invoice.netTotal }</td>
			<td>${invoice.GSTAmount }</td>
			<td>${invoice.client_name }</td>
			<td>${invoice.client_address }</td>
			<td>${invoice.client_state }</td>
			<td>${invoice.client_gstin_no }</td>
			<%-- <td><a href="${pageContext.request.contextPath}/financial/invoiceDownload/index.jsp?orderId=${balance.userName }">${balance.userName }</a></td>
			<td>${balance.userEmail }</td>
			<td style="white-space: nowrap;"><fmt:formatDate pattern="dd MMM, yyyy HH:mm" value="${balance.ClosingDate}" /></td>
			<td style="white-space: nowrap;"><tag:money amount="${balance.balance_user}" /></td> --%>
		</tr>
	</c:forEach>
	</tbody>
</table>
</div>

<tag:page-info total="${totalResultCount}" page="${page}" />
</c:if>