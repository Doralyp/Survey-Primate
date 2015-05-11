$(document).ready(function(){

  $('#new-question').css('display', 'block');
  $('#finalize-survey').css('display', 'block');
  $('#new-question-noajax').css('display', 'none');
  $('#finalize-survey-noajax').css('display', 'none');

  $('#main').on('submit','#new-question', function(event){
    event.preventDefault();
    $('#create-question').on('submit', function(create_event){
      create_event.preventDefault();
      console.log($(create_event.target).serialize())
      $.ajax({
        url: event.target.action,
        method: create_event.target.method,
        data: $(create_event.target).serialize()
      }).done(function(response){
        $('#main').html(response);
      })
    });
    $('#create-question').submit();
  });


  $('#main').on('submit','#finalize-survey', function(event){
    event.preventDefault();
    $('#create-question').on('submit', function(create_event){
      create_event.preventDefault();
      $.ajax({
        url: event.target.action,
        method: create_event.target.method,
        data: $(create_event.target).serialize()
      }).done(function(response){
        $('#main').html(response);
      })
    });
    $('#create-question').submit();
  });

});
