// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks
//= require_tree .

setInterval(
function updateTweets() {

	$.ajax({
	  url: "/",
	  cache: false
	}).done(function( response, status, xhr) {
		console.log(response)
		console.log(status)
		console.log(xhr)

		
		if ($(response).find("#tweets-list").children().size() > 0) {
			
			console.log("new tweets " + $(response).find("#tweets-list").children().size())
			
	     	$("#tweets-list").replaceWith($(response).find("#tweets-list"));
			
 		} else {
			console.log("nothing to display")

 		} 	   
	});
	//alert("updating!")
}
, 30000);
