$(document).ready(function(){

  // $('#new-question').on('click', function(event){
  //   event.preventDefault();
  //   $('#create-question').on('submit', function(create_event){
  //     create_event.preventDefault();
  //     $.ajax({
  //       url: create_event.target.action,
  //       method: create_event.method,
  //       data: $(create_event.target).serialize()
  //     }).done(function(response){
  //       $('#main').fadeOut('fast', function(){
  //         $('#main').html(response);
  //         $('#main').fadeIn();
  //       })
  //     });
  //     $('#create-question').submit();
  //   })
  // })

  $('#finalize-survey').on('click', function(event){
    event.preventDefault();
    $('#create-question').on('submit', function(create_event){
      create_event.preventDefault();
      $.ajax({
        url: create_event.target.action,
        method: create_event.target.method,
        data: $(create_event.target).serialize()
      }).done(function(response){
        $('#main').html(response);
      })
    });
    $('#create-question').submit();
  });

});
