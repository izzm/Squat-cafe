;(function($) {
  $.squatEvents = {
    defaults: {}
  };

  var open = function($closed) {
    var $image = $closed.find('img.main')
    var $con = $closed.find('.event_content');
    var $scon = $closed.find('.short_content');
    var $fcon = $closed.find('.full_content');
      
    var base_duration = 1000;
    var hc = $image.height() / $fcon.outerHeight();
    var duration = hc <= 1 ? base_duration * hc : base_duration;
    
    $closed.addClass('animated');
    
    $image.attr('data-top', $image.css('top'));
    $image.animate({top: '0px'}, duration);
      
    $scon.attr('data-height', $scon.css('height'));
    $scon.attr('data-padding-top', $scon.css('padding-top'));
    $scon.animate({height: '0px', top: '-' + $scon.height() + 'px', 'padding-top': '0px'}, base_duration, function() {
      $(this).hide();
    });
    $closed.animate({height: $fcon.outerHeight()}, base_duration, function() {
      $closed.switchClass('closed', 'opened');
      $closed.removeClass('animated');
    });
    //$closed.switchClass('closed', 'opened', base_duration);
    $closed.find('.read_more').hide();
  };

  var close = function($opened) {
    var $image = $opened.find('img.main')
    var $con = $opened.find('.event_content');
    var $scon = $opened.find('.short_content');
    var $fcon = $opened.find('.full_content');

    var base_duration = 1000;
    var hc = $image.height() / $fcon.outerHeight();
    var duration = hc <= 1 ? base_duration * hc : base_duration;
    
    $opened.addClass('animated');
      
    $image.delay(base_duration - duration).animate({top: $image.attr('data-top')}, duration);

    $scon.show();
    $scon.animate({height: $scon.attr('data-height'), top: '0px', 'padding-top': $scon.attr('data-padding-top')}, base_duration);
      
    $opened.animate({height: $scon.attr('data-height')}, base_duration, function() {
      $opened.switchClass('opened', 'closed');
      $opened.find('.read_more').show('blind', 100);
      $opened.removeClass('animated');
    });
  };

  $.fn.squatEvent = function(action, settings) {
    $.extend((settings == null ? {} : settings), $.squatEvents.defaults);
    var s = settings;

    return $(this).each(function() {
      var $this = $(this);

      if(action == 'open') {
        open($this);
      } else {
        close($this);
      }
    });
  };
})(jQuery);
