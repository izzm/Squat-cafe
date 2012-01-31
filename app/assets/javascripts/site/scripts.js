$(function() {
  var $fixed = $('#menu_fixed_scroll');
  var $slave_fixed = $('#sidebar_fixed_scroll');
  var menu_offset = $fixed.offset().top;
  var menu_height = $fixed.outerHeight();
  var sidebar_offset = $slave_fixed.offset().left;

  $(window).scroll(function() {
    var page_scroll = $(this).scrollTop();
    var offset = page_scroll - menu_offset;

    if(page_scroll > menu_offset) {
      $fixed.css({
        position: 'fixed'
      });
      $slave_fixed.css({
        position: 'fixed',
        top: menu_height,
        left: sidebar_offset - 20
      });
    } else {
      $fixed.css({top: '0px', position: 'relative'});
      $slave_fixed.css({top: '0px', left: '0px', position: 'relative'});
    }
    
    return true;
  });
});
