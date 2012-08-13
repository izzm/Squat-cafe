$(function() {
  var $fixed = $('#menu_fixed_scroll');
  var $slave_fixed = $('#sidebar_fixed_scroll');
  var menu_offset = $fixed.offset().top;
  var menu_height = $fixed.outerHeight();

  var check_position = function() {
    var page_scroll = $(this).scrollTop();
    var offset = page_scroll - menu_offset;
    var sidebar_offset = $('#keyword').offset().left;

    if(page_scroll > menu_offset) {
      $fixed.css({
        position: 'fixed'
      });
      $slave_fixed.css({
        position: 'fixed',
        top: menu_height,
        left: sidebar_offset - 10
      });
    } else {
      $fixed.css({top: '0px', position: 'relative'});
      $slave_fixed.css({top: '0px', left: '0px', position: 'relative'});
    }
    
    return true;
  };

  $(window).resize(check_position).scroll(check_position);
  
  $('.block-content').each(function(){
    if($.cookie('right_column_' + $(this).attr('id')) == "false") {
      $(this).hide();
    }
  });

  $('input[placeholder]').placeholder();
  
  $('.block-header').click(function(){
    var $content = $(this).parent().children('.block-content');
    
    $content.toggle('blind', function(){
      $.cookie('right_column_' + $content.attr('id'), $content.css('display') == 'none' ? 'false' : 'true');
    });
    
    return false;
  });
  
  $('#calendar').datepicker({
    onSelect: function(dateText, inst) {
      window.location = "/events/bydate/" + dateText;
    },
    numberOfMonths: [1, 1],
    showCurrentAtPos: 0,
    beforeShowDay: function(date) {
      for(var i=0 ; i<window.events.length ; i++) {
        if(date.getMonth() == window.events[i].date_json[0] - 1
          && date.getDate() == window.events[i].date_json[1]
          && date.getFullYear() == window.events[i].date_json[2]) {
          return [true,"", window.events[i].name];
        }
      }
      
      return [false, ""];
    }
  });
  
  $('select#themes').multiSelect({ selectAllText: 'Выбрать все', oneOrMoreSelected: 'Выбрано: %', noneSelected: 'Выбери мероприятие', listHeight: 100500 });
  $('input#birthday').datepicker({changeMonth: true, changeYear: true, yearRange: "c-80:c+5", defaultDate: "-20y"});
});
