;(function($) {
  var open = function($closed, callback, speed) {
    var $image = $closed.find('img.main')
    var $con = $closed.find('.event_content');
    var $scon = $closed.find('.short_content');
    var $fcon = $closed.find('.full_content');
      
    var base_duration = speed == null ? 1000 : speed;
    var hc = $image.height() / $fcon.outerHeight();
    var duration = hc <= 1 ? base_duration * hc : base_duration;

    var content_height = Math.max($fcon.outerHeight(), $image.outerHeight());
    
    $closed.addClass('animated');
    
    $image.attr('data-top', $image.css('top'));
    $image.animate({top: '0px'}, duration);
      
    $scon.attr('data-height', $scon.css('height'));
    $scon.attr('data-padding-top', $scon.css('padding-top'));
    $scon.animate({height: '0px', top: '-' + $scon.height() + 'px', 'padding-top': '0px'}, base_duration, function() {
      $(this).hide();
    });
    $closed.animate({height: content_height}, base_duration, function() {
      $closed.switchClass('closed', 'opened');
      $closed.removeClass('animated');

      if($.isFunction(callback)) {
        callback();
      }
    });
    //$closed.switchClass('closed', 'opened', base_duration);
    $closed.parent().children('a').addClass('afisha-item-header-selected');
    $closed.find('.read_more').hide();
  };

  var close = function($opened, callback, speed) {
    var $image = $opened.find('img.main')
    var $con = $opened.find('.event_content');
    var $scon = $opened.find('.short_content');
    var $fcon = $opened.find('.full_content');

    var base_duration = speed == null ? 1000 : speed;
    var hc = $image.height() / $fcon.outerHeight();
    var duration = hc <= 1 ? base_duration * hc : base_duration;
    
    $opened.addClass('animated');
      
    $image.delay(base_duration - duration).animate({top: $image.attr('data-top')}, duration);

    $scon.show();
    $scon.attr('data-height', '100px');
    $scon.animate({height: $scon.attr('data-height'), top: '0px', 'padding-top': $scon.attr('data-padding-top')}, base_duration);
      
    $opened.animate({height: $scon.attr('data-height')}, base_duration, function() {
      $opened.switchClass('opened', 'closed');
      $opened.find('.read_more').show('blind', 100);
      $opened.removeClass('animated');

      if($.isFunction(callback)) {
        callback();
      }
    });

    $opened.parent().children('a').removeClass('afisha-item-header-selected');
  };

  $.fn.squatEvent = function(action, callback, speed) {
    if($(this).size() == 0 && $.isFunction(callback)) {
      callback();
    }

    return $(this).each(function() {
      var $this = $(this);

      if(action == 'open') {
        open($this, callback, speed);
      } else {
        close($this, callback, speed);
      }
    });
  };
})(jQuery);
