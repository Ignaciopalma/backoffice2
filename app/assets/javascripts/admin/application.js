// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require underscore

//= require_self

// $(document).on('ready', function () {
// 	// Actions to do
//   	$(".button-collapse").sideNav();
// 	$(".dropdown-button").dropdown({hover:true,beloworigin:true});
// 	$('.tooltipped').tooltip({delay: 30});
// 	$('label').addClass('active');
// 	console.log('exec ready')
//     // $('.container-title').pushpin({ top: 94,offset:64});

// });

// $(document).on('page:load', function() {
// 	$(document).trigger('ready');
// });

// $(document).on('page:change', function() {
// 	$(".button-collapse").sideNav();
// 	$(".dropdown-button").dropdown({hover:true,beloworigin:true});
// 	$('.tooltipped').tooltip({delay: 30});
// 	$('label').addClass('active');
// 	// console.log('onchange');
// });

$(document).on('page:change', function() {

	var $overlay = $("<div id='overlay'><div>"); 

	$overlay.append($mod);

	$("body").append($overlay);

	$("#imageGallery a").click(function(event){
		event.preventDefault();
		$overlay.show();


		// var href = $(this).attr("class");
		// console.log(href);
		
	});

});


$(function() {
  $("#modal-1").on("change", function() {
    if ($(this).is(":checked")) {
      $("body").addClass("modal-open");
    } else {
      $("body").removeClass("modal-open");
    }
  });

  $(".modal-fade-screen, .modal-close").on("click", function() {
    $(".modal-state:checked").prop("checked", false).change();
  });

  $(".modal-inner").on("click", function(e) {
    e.stopPropagation();
  });
});

  $(document).ready(function () {
    if(window.location.href.indexOf("admin/deliveries"))
    {
         $(".main-navigation li#deliveries").addClass("selected");
    }
    else if(window.location.href.indexOf("admin/users"))
    {
         $(".main-navigation li#users").addClass("selected");
    }
    else if(window.location.href.indexOf("admin/senders"))
    {
         $(".main-navigation li#senders").addClass("selected");
    } 
    
});


$(function() {


// Create Select and append to menu
  var $select = $("<select></select>");
  $(".main-navigation").append($select);

  // Cycle over menu links
  $(".main-navigation a").each(function(){

      var $anchor = $(this);
      // Create Option
      var $option = $("<option></option>");
      // Option Value is the href
      $option.val($anchor.attr("href"));
      // Option text is the text of the link
      $option.text($anchor.text());
      // Append option to selct
      $select.append($option);

  });


  // Create Button 
  var $button = $("<button>Go</button>");

  $(".main-navigation").append($button);
  // Bind click to button
  $button.click(function(){
    //and go to select location
    window.location = $select.val();

  });

  // Modify CSS to hide links on small resolution
  // Also hide select and button on larger resolutions

  // Deal with selected options
});


