$(document).ready(function(){
  window.addEventListener('message', function(event){
    var item = event.data;
    if(item.openList == true) {
      $(".headers").css("display", "none");
      $(".list-container").css("display", "block").data('list-type', item.listType);
	  $("#" + item.listType).css("display", "block");
    } else if(item.openList == false) {
      $(".list-container").css("display", "none").removeData('list-type');
    } else if(item.clear == true) {
	  $(".button").remove();
    } else if(item.add == true) {
	  $("#cars").append('<a class="button" data-plate="' + item.plate + '"><p style = "margin: 0px 0px 0px 0%;"> <font color="black"> <b>Model:</b> </font> <b><font color="white">' + item.name + '</font></b></p>' + 
		'<p style = "margin: -24px 20px 30px 80%;"> <font color="black"> <b>Silnik: </b>' + item.engine + '%</p>' +
		'<p style = "margin: -30px 20px 30px 0%;"> <font color="black"><b>Tablice:</b></font> <b><font color="white">' + item.plate + '</font></b></p>' +
		'<p style = "margin: -53px 20px 30px 74.5%;"> <font color="black"> <b>Karoseria: </b>' + item.body + '%</p>' + '</a>'
		);
    }
  });

  // On 'Esc' call close method
  document.onkeyup = function (data) {
    if (data.which == 27) {
      $.post('http://exile_garages/close', JSON.stringify({}));
    }
  };
  // Handle Button Presses
  $("#cars").on('click', '.button', function(e) {
    e.preventDefault();
    $.post('http://exile_garages/pull',  JSON.stringify({ action: $(".list-container").data('list-type'), plate: $(this).data('plate') }));
  });
  
  $("#footer").click(function(e) {
    e.preventDefault();
    $.post('http://exile_garages/close', JSON.stringify({}));
  });
});