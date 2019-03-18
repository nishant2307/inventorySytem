<html>
	<head>
		<script
		  src="http://code.jquery.com/jquery-3.3.1.min.js"
		  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
		  crossorigin="anonymous"></script>
	</head>
	<body>
		Select Warehouse : <select id="warehouse">
			<option value="W1">W1</option>
			<option value="W2">W2</option>
			<option value="ALL">All</option>
		</select><br>
		<table border="2">
			<thead>
				<tr>Ware House</tr>
				<tr>Model No</tr>
				<tr>On Hand</tr>
			</thead>
			<tbody id="tbody">
			</tbody>
		</table>
	</body>
	<script type="text/javascript">
		$(document).ready(function(){
			$('#warehouse').trigger('change');
		});
	
		$('#warehouse').on('change',() => {
			let warehouse = $('#warehouse').val();
			let json = {
					warehouse:warehouse
					};
			console.log(warehouse);
			ajaxFunc('POST','rest/get_data',json,function(resp){
				console.log(resp);	
				console.log('success');	
				let html = '';
				for ( var i in resp) {
					if(!isNaN(i)){
						let [wh,mno,oh] = resp[i];
						html += '<tr>';	
						html += '<td>'+wh+'</td>';
						html += '<td>'+mno+'</td>';
						html += '<td>'+oh+'</td>';
						html += '</tr>';
					}
				}
				$('#tbody').empty().html(html);
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