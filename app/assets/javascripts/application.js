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
//= require_tree .


$(document).ready(function(){
  $("#filter input[type='checkbox']").click(function(){
    $('#filter').submit();
  })
  $("#condition input[type='checkbox']").click(function(){
    $('#condition').submit();
  })
  $("#location input[type='checkbox']").click(function(){
    $('#location').submit();
  })

  $('#v_video').click(function(){
    $('#att_video').show()
    $('#cancel_video').show();
    if ($('#att_video').val()!= ''){
      $(form).submit();
    }
    else
      {return false}

  })

  $('#cancel_video').click(function(){
    $('#att_video').hide();
    $('#att_video').val('');
    $('#cancel_video').hide();
    return false
  })


  $('.make_fav').click(function(){
    var v_id=$(this).attr('id');
    var th = this
    $.ajax({
      dataType: 'json',  // not jsonp
      url: "/favo",
      type: "get",
      data: { id : v_id },
      success: function(response) {
        console.log(response.active)
          if (response.active==false){
            $(th).addClass('fav_ajax').attr("title",'Add_Favorite')
            $(th).removeClass('unfav_ajax')
          }else{
            $(th).addClass('unfav_ajax').attr('title','Remove_Favorite')
            $(th).removeClass('fav_ajax')
          }
      }
    });

  })

});

