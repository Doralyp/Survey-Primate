$(document).ready(function(){
  var survey_id = $("#SI").attr("survey-id")
  var completion_id = $("#SI").attr("completion-id")

    $.ajax({
        url: "/surveys/" + survey_id + "/comparison/" + completion_id,
        method: 'get',
        dataType: "json"
    }).done(function(questions){
      var my_data = [];

      $.each(questions, function(question_index, question) {
        var my_data_total = 0;
        var my_ticks = []

        $.each(question.choices, function(cur_choice_index, cur_choice) {
          my_data_total += cur_choice.frequency;
        })

        $.each(question.choices, function(index, cur_choice) {
          if(cur_choice.choice == question.answer){
            my_data.push((cur_choice.frequency / my_data_total));
          }
        })
        $(".compare-" + String(question_index))[0].innerHTML = String(Math.round(my_data[question_index] * 100))
      })
    }
  )
})
