$(document).ready(function(){
  var survey_id = $("#SI").attr("survey-id")
  var completion_id = $("#SI").attr("completion-id")

  $.when (
        $.ajax({
            url: "/surveys/" + survey_id + "/comparison/" + completion_id,
            method: 'get',
            dataType: "json"
        })
    ).done(function(response){
      var my_data = [];

      for(var i = 0; i < response[0].length; i++){


        var my_data_total = 0;
        var my_ticks = []

        for(var ii = 0; ii < response[0][i][1].length; ii++){
            my_data_total += response[0][i][1][ii][1];
        }

        for(var ii = 0; ii < response[0][i][1].length; ii++){
          debugger;
          if(response[0][i][1][ii][0] == response[1][i]){
            my_data.push((response[0][i][1][ii][1]/ my_data_total));
          }
        }
        $(".compare-" + String(i))[0].innerHTML = String(Math.round(my_data[i] * 100))
      }
    }
  )
})
