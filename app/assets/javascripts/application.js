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
//= require jquery.turbolinks
//= require jquery_ujs
//= require jquery-ui
//= require bootstrap-wysihtml5
//= require autocomplete-rails
//= require jquery-ui/datepicker-pt-BR
//= require alert_message
//= require turbolinks

$(document).ready(function() {
  // Jquery ui
  $('.datepicker').datepicker();

  // active
  (function(){
    var location = window.location.pathname;
    location = location.split('/');

    var url = '';

    for (var i = 1; i < location.length; i++) {
      url += '/' + location[i];
      $('a[href="'+ url +'"]').addClass('active');
    }
  })();

  // Editor
  $('.wysihtml5').each(function(i, elem) {
    $(elem).wysihtml5();
  });

})
