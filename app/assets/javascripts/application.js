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
//= require bootstrap-sprockets
//= require underscore
//= require calendar.min
//= require bootstrap-datepicker
//= require turbolinks
//= require_tree .
$(function(){
  var options = {
    tmpl_path: "/calendar_templates/",
    events_source: function () { return []; },
    onAfterViewLoad: function(view) {
      $('#page-header').text(this.getTitle());
      $('.btn-group button').removeClass('active');
      $('button[data-calendar-view="' + view + '"]').addClass('active');
    }
  };
  var calendar = $('#calendar').calendar(options);
  $('.btn-group button[data-calendar-nav]').each(function() {
    var $this = $(this);
    $this.click(function() {
      calendar.navigate($this.data('calendar-nav'));
    });
  });

  $('.btn-group button[data-calendar-view]').each(function() {
    var $this = $(this);
    $this.click(function() {
      calendar.view($this.data('calendar-view'));
    });
  });

  var leave_date_from = $('#leave_date_from').datepicker({
    format: "dd/mm/yyyy"
  });

  leave_date_from.on('changeDate', function(ev){ 

  });
  
  leave_date_from.on('show',function(ev){
  	$(".datepicker.datepicker-dropdown").css('z-index',"1051");
  });
  
});
        