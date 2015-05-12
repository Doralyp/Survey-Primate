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
        for(var i = 0; i < questions.length; i++){

            var my_data = [];
            var my_data_total = 0;
            var my_ticks = []

            for(var ii = 0; ii < questions[i].choices.length; ii++){
                my_data_total += questions[i].choices[ii].frequency;
                my_ticks.push([ii + 1, questions[i].choices[ii].choice])
            }
            for(var ii = 0; ii < questions[i].choices.length; ii++){
                my_data.push([(questions[i].choices[ii].frequency/ my_data_total),ii+1]);
            }

            // plot the data
            $.plot($("#graph" + String(i)), [
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
        }
    })
}); //end of $(document).ready(function()

