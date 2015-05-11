$(document).ready(function(){

  addAjaxSubmit();
  removeBasicSubmit();

  $('#main').on('submit', '#new-question', function(event){
    event.preventDefault();
    submitAjaxForForm(event);
  });

  $('#main').on('submit','#finalize-survey', function(event){
    event.preventDefault();
    submitAjaxForForm(event);
  });

});



// Remove basic html submit buttons on form if Javascript is in use

var removeBasicSubmit = function(){
  $('#new-question-noajax').remove();
  $('#finalize-survey-noajax').remove();
};

// Add submit buttons on load of page and after successful ajax request and response

var addAjaxSubmit = function(){
  $('#new-question').css('display', 'block');
  $('#finalize-survey').css('display', 'block');
}

// Actually submit ajax request. Process when done.

var submitAjaxForForm = function(event){
  $('#create-question').on('submit', function(create_event){
    create_event.preventDefault();
    $.ajax({
      url: event.target.action,
      method: create_event.target.method,
      data: $(create_event.target).serialize()
    }).done(function(response){
      $('#main').html(response);
      removeBasicSubmit();
      addAjaxSubmit();
    })
  });
  $('#create-question').submit();
}