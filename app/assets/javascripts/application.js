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
//= require bootstrap
//= require turbolinks
//= require ace/ace
//= require ace/theme-twilight
//= require ace/mode-ruby


...

$(document).on('ready page:load',function(){

  ...

  $('.schedules_container').on('click', '.schedules_clickable',function(){
    var id = $(this).data("scheduleid");
    var tag = $(this).data("scheduletag");
    var c_id = $(this).data("challengeid");
    var weekId = $(this).closest(".row").data("weekid");
    var day = $(this).closest(".list-group").data("day");
    var title = $(this).text();


    //tag_btn
    $('#challenge_tag').show();
    $('#challenge_tag').attr("href", "/schedules/" + id + "/tag")
    toggleTagBtnClass(tag);
    //Delete_btn
    $('#delete_challenge').show();
    $('#delete_challenge').attr("href", "/schedules/" + id)
    
    ...

    // Modal values
    $('#myModalLabel').text(title);
    $('#titlelink').attr("href", "/challenges/" + c_id);
  });


  $('.challenges_container').on('click', '.challenge_clickable',function(){
    var c_id = $(this).data("challengeid");
    var title = $(this).text();

    $('#challenge_tag').hide();
    $('#delete_challenge').hide();
    $('#schedule_week_id').val("");
    $('#schedule_day').val("");
    
    ...

  });

  $( ".sortable" ).sortable({
    update: function( event, ui ) {
      positions = $.map($(this).children(), function(elem,i){
        return $(elem).data("scheduleid");
      });
      $.post("/schedules/reorder", {positions:positions},function(){
        console.log("Reordeno");
      });
    }
  });

});

...