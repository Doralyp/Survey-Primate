var $ = jQuery.noConflict();
$(document).ready(function(){
  var survey_id = $("#graph0").attr("survey-id")
  $.when (
    $.ajax({
      url: "/surveys/" + survey_id + "/results",
      method: 'get',
      dataType: "json"
  })
).done(function(questions){
  debugger;
  $.each(questions, function(question_index, question) {

      var my_data = [];
      var my_data_total = 0;
      var my_ticks = []

      $.each(question.choices, function(choice_index, choice) {
        my_data_total += choice.frequency;
        my_ticks.push([choice_index + 1, choice.choice])
    })
    $.each(question.choices, function(choice_index, choice) {
        my_data.push([(choice.frequency/ my_data_total),choice_index+1]);
    })

    // plot the data
    $.plot($("#graph" + String(question_index)), [
      { label: "Answer Percentage",
      data: my_data }],
      {
        series: {
          bars: {
            show: true,
            align: "center",
            barWidth: 0.5,
            horizontal: true,
          }
        },
        xaxis: {
          font:{
            size:11,
            style:"italic",
            weight:"bold",
            family:"sans-serif",
            variant:"small-caps",
          },
            show: true,
            ticks: 5,
            min: 0,
            max: 1
        },
        yaxis: {
          font:{
            size:12,
            style:"italic",
            family:"sans-serif",
            variant:"small-caps",
            color: "black",
          },
            show: true,
            ticks: my_ticks,
            tickLength: 10,
            min: 0,
          }
        }
      );
    })
  })
}); //end of $(document).ready(function()

