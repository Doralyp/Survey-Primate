$(document).ready(function(){
  var survey_id = $("#SI").data("survey-id")
  var completion_id = $("#SI").data("completion-id")

    $.ajax({
        url: "/surveys/" + survey_id + "/comparison/" + completion_id,
        method: 'get',
        dataType: "json"
    }).done(function(questions){
      var my_data = [];

      $.each(questions, function(question_index, question) {
        var my_data_total = 0;

        $.each(question.choices, function(choice_index, choice) {
          my_data_total += choice.frequency;
        })

        $.each(question.choices, function(index, choice) {
          if(choice.choice == question.answer){
            my_data.push((choice.frequency / my_data_total));
          }
        })
        $(".compare-" + String(question_index))[0].innerHTML = String(Math.round(my_data[question_index] * 100))
      })
    }
  )
})
