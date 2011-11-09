$(document).ready(function(){

});
var App ={};

App.Chart = (function(){

 var options = {
    xaxis: {
      mode: "time",
      tickLength: 5,
      timeformat: "%y/%m/%d"
    },
    selection: { mode: "x" },
    grid: { hoverable: true },
    yaxis: { },
    series: {
      lines: { show: true },
      points: { show: true }
    }

  };

  var showTooltip = function(x, y, contents) {
    $('<div id="tooltip">' + contents + '</div>').css( {
      position: 'absolute',
      display: 'none',
      top: y + 5,
      left: x + 5,
      border: '1px solid #fdd',
      padding: '2px',
      'background-color': '#fee',
      opacity: 0.80
    }).appendTo("body").fadeIn(200);
  };

  var draw = function(chartId, data){

    var plot = $.plot($(chartId), data, options);
    var previousPoint = null;

    $(chartId).bind("plothover", function (event, pos, item) {
      $("#x").text(pos.x.toFixed(2));
      $("#y").text(pos.y.toFixed(2));
        if (item) {
          if (previousPoint != item.dataIndex) {
            previousPoint = item.dataIndex;
            $("#tooltip").remove();
            var x = item.datapoint[0],
            y = item.datapoint[1].toFixed(2);
            var d = new Date(x);

            showTooltip( item.pageX, item.pageY,
            " Data: " + d.toDateString() + " = " + y);
          }
        }
        else {
          $("#tooltip").remove();
          previousPoint = null;
        }
    });


  };

  return {
    draw:draw
  };

}());
