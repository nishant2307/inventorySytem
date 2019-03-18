<html>
	<head>
		<script
		  src="http://code.jquery.com/jquery-3.3.1.min.js"
		  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
		  crossorigin="anonymous"></script>
	</head>
	<body>
		<table>
			<tr>
				<td>Warehouse :</td><td><input type="text" name="warehouse" id="warehouse" ></td>
			</tr>
			<tr>
				<td>Model No : </td><td><input type="text" name="modelno" id="modelno"  > </td>
			</tr>
			<tr>
				<td>SN :</td><td><input type="text" name="sn" id="sn" ></td>
			</tr>
			<tr>
				<td>Quantity :</td><td><input type="text" name="quantity" id="quantity" ></td>
			</tr>
			<tr>
				<td></td><td><input type="button" id="smtBtn" value="Submit"></td>
			</tr>
		</table>
	</body>
	<script type="text/javascript">
		$('#smtBtn').on('click',() => {
			let warehouse = $('#warehouse').val();
			let modelno = $('#modelno').val();
			let sn = $('#sn').val();
			let quantity = $('#quantity').val();
			let json = {
					warehouse:warehouse,
					modelno:modelno,
					sn:sn,
					quantity:quantity
					};
			console.log(warehouse,modelno,sn,quantity);
			ajaxFunc('POST','rest/save',json,function(resp){
				console.log('success');	
			});
		});
		
		function ajaxFunc(type,url,data,successFun){
			$.ajax({
				url:url,
				type:type,
				dataType:'json',
				data:JSON.stringify(data),
				contentType:'application/json',
				success:successFun,
				error:function(e){
					console.log(e);
				}
			});
		} 
	</script>
</html>