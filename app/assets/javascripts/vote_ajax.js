// $("input[type='submit']").click(function(event) {
// 	event.preventDefault();
//
// 	var the_name = $("#poro_name").val();
//
// 	if(the_name.trim() == "") {
// 		alert("Pleaes enter a name!");
// 	} else {
// 		var request = $.ajax({
// 			method: "POST",
// 			url: "/poros",
// 			data: { name: the_name }
// 		});
// 	}
//
// 	request.done(function() {
// 		$("ul").append('<li class="poro">' + the_name + '</li>')
// 		$("#poro_name").val("")
// 	});
// });
