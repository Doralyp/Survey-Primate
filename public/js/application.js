$(document).ready(function() {

  $('#logout-link').click(function() {
    $('#form-logout').submit();
  });

  $('.btn-invite-user').click(function(e){
    e.preventDefault();
      $.ajax({
          url: this.action,
          method: this.method,
          data: $(e.target).serialize()
        })
        .done(function(resp){
          $(e.target).remove();
        })
        .error(function(resp){
          alert(JSON.stringify(resp))
        })
    });

});