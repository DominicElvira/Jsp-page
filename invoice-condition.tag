<%@ attribute name="pending" required="false"%>
<%@ attribute name="ostatus" required="false"%>

<form action="./" method="GET">
	<div class="row">
		<div class="col-lg-12">
			<h1 class="page-header"> Invoice Record</h1>
			<div class="panel-group" id="condition-container">
				<div class="panel panel-default">
					<div class="panel-heading">
						<a data-toggle="collapse" data-parent="#condition-container"
							href="#condition-area" class="" aria-expanded="true">Condition</a>
					</div>
					<div id="condition-area" class="panel-collapse collapse in"
						aria-expanded="true">
						<div class="panel-body">

							<table width=800>
								<tr>
									<td><span>
											<div class="row">
												<div class="col-md-12">
													<label>Order No</label>
												</div>
											</div>
											<div class="row">
												<div class="col-md-8">
													<div class="form-group input-group" title="OrderNo">
														<input class="form-control" name="OrderNo" id="OrderNo"
															placeholder="OrderNo" type="text">
													</div>
												</div>
											</div>

									</span></td>
									<td></td>
									<td><span>
											<div class="row">
												<div class="col-md-12">
													<label>Invoice No</label>
												</div>
											</div>
											<div class="row">
												<div class="col-md-8">
													<div class="form-group input-group" title="InvoiceNo">
														<input class="form-control" name="InvoiceNo"
															id="InvoiceNo" placeholder="InvoiceNo" type="text">
													</div>
												</div>
											</div>
									</span></td>
								</tr>
								<tr>
								<td>
									<div class="row">
								<div class="col-md-12">
									<label>Invoice Date From</label>
								</div>
							</div>
							<div class="row">
								<div class="col-md-3">
									<div class="form-group input-group" title="From">
										<span class="input-group-addon field-icon"><i
											class="fa fa-suitcase"></i><i class="fa fa-hashtag"></i></span> 
											<input
											class="form-control" name="timeFrom" id="timeFrom"
											placeholder="From" type="date">
									</div>
								</div>
							</div>
								</td>
								<td></td>
								<td>
								<div class="row">
								<div class="col-md-12" >
									<label>Invoice Date To</label>
								</div>
							</div>
							<div class="row">
								<div class="col-md-3">
									<div class="form-group input-group" title="To">
										<span class="input-group-addon field-icon"><i
											class="fa fa-suitcase"></i><i class="fa fa-hashtag"></i></span> 
											<input
											class="form-control" name="timeTo" id="timeTo"
											placeholder="To" type="date">
									</div>
								</div>
							</div>
								</td>
								</tr>

							</table>
							<!-- Order Info -->
							
						
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<input type="hidden" name="page" id="page" value="1" />
	<div class="row">
		<div class="col-lg-3">
			<input type="submit" class="btn btn-primary" value="Search">
			&nbsp;
			<input type="button" class="btn btn-primary" id="downLoad" onclick="download()" value="Export">
		</div>
	</div>
	<br>
</form>
<script type="text/javascript">
function download(){
	debugger;
	if(check()){
		
	
	var a = "timeTo="+$('#timeTo').val()+"&timeFrom="+$('#timeFrom').val()+"&InvoiceNo="+$('#InvoiceNo').val()+"&OrderNo="+$('#OrderNo').val();
	window.location.href="./download/index.jsp?"+a;
	 }
	}
	
function check(){
	debugger;
	var OrderNo = $('#OrderNo').val();
	var InvoiceNo  =$('#InvoiceNo').val();
	var timeFrom = $('#timeFrom').val();
	var timeTo =$('#timeTo').val();
	var Rs = ((OrderNo=="") &&(InvoiceNo=="") && (timeFrom=="") && (timeTo==""));
	if(Rs){
		alert("Please enter at least one complete download!");
		return false;
	}
	var Rs2 = ((OrderNo=="") &&(InvoiceNo=="") && (timeFrom==""));
	if(Rs2){
		alert("Please enter timeTo!");
		return false;
	}
	var dateFrom = new Date(timeFrom);
	var dateTo = new Date(timeTo);
	var mothFrom = dateFrom.getMonth()+1;
	var mothTo = dateTo.getMonth()+1;
	var result = (dateTo - dateFrom) / (1000 * 60 * 60 * 24);
	var yearFrom = dateFrom.getFullYear();
	var yearTo = dateTo.getFullYear();
	
	if(result>90){
		alert("Only three months of data can be downloaded!");
		return false;
	}
	return true;
}
	
	(function() {
		var param = Sys.parseQueryString();
		for ( var paramName in param) {
			var paramValue = param[paramName];
			$('[name="' + paramName + '"]').val(paramValue);
		}
	})();
</script>