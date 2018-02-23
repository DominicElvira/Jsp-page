<%@ attribute name="total" required="true" %>
<%@ attribute name="page" required="true" %>
<%@ attribute name="pagesize" required="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:if test="${not empty pagesize}">
	<c:set var="pagesize" value="${pagesize }"/>
</c:if>
<c:if test="${empty pagesize}">
	<c:set var="pagesize" value="10"/>
</c:if>
<c:if test="${page le 0}"> 
	<c:set var="page" value="1" />
</c:if>
<c:set var="skip" value="${(page - 1) * pagesize}" />
<c:set var="totalPage">
	<fmt:parseNumber value="${(total + 9) div pagesize}" integerOnly="true" />
</c:set>
<c:set var="rowCount" value="${page eq totalPage ? total % pagesize : pagesize}" />
<c:set var="startPage" value="${page - 3 < 1 ? 1 : page - 3}" />
<c:set var="endPage" value="${page + 3 > totalPage ? totalPage : page + 3}" />
<div class="row">
	<div class="col-sm-4">
		<div class="dataTables_info" role="status" aria-live="polite">
			Showing ${skip + 1} to ${skip + rowCount} of ${total} entries.
		</div>
	</div>
	<div class="col-sm-8 text-right">
		<div class="dataTables_paginate paging_simple_numbers">
			<ul class="pagination">
				<li class="paginate_button previous ${page le 1 ? 'disabled': ''}">
					<a href="javascript: goPage(1)">First</a>
				</li>
				<li class="paginate_button previous ${page le 1 ? 'disabled': ''}">
					<a href="javascript: goPage(${page - 1})">Previous</a>
				</li>
<c:forEach var="p" begin="${startPage}" end="${endPage}">
				<li class="paginate_button ${p eq page ? 'active' : ''}">
					<a href="javascript: goPage(${p})">${p}</a>
				</li>
</c:forEach>
				<li class="paginate_button next ${(page+totalPage) ge 2*totalPage ? 'disabled': ''}">
					<a href="javascript: goPage(${page + 1})">Next</a>
				</li>
				<li class="paginate_button next ${(page+totalPage) ge 2*totalPage ? 'disabled': ''}">
					<a href="javascript: goPage(${totalPage})">Last</a>
				</li>
			</ul>
		</div>
	</div>
</div>
<script type="text/javascript">
	$('#page').val(${page});
	function goPage(p) {
		$('#page').val(p)[0].form.submit();
	}
	$('.paginate_button.disabled a').attr('href', '#');
</script>