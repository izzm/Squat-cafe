/* require active_admin/base     // line disabled since it includes an old version!*/
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require jquery-ui-ru
//= require jquery_plugins/jquery.cookie
//= require jquery_plugins/jquery.treeview
//= require jquery_plugins/jquery.chosen
//= require jquery_plugins/jquery.form
//= require jquery_plugins/jquery.tmpl
//= require jquery_plugins/jquery.uploadify

/* Active Admin JS */
/* copied from 'app/assets/javascripts/base.js in active_admin source code */
$(function(){
  $.datepicker.setDefaults( $.datepicker.regional[ "ru" ] );
  $(".datepicker").datepicker({dateFormat: 'yy-mm-dd 00:00:00'});
  $('#ui-datepicker-div').hide();
  
  $(".clear_filters_btn").click(function(){
    window.location.search = "";
    return false;
  });

  $.fn.attachment_image_upload = function() { 
    var $this = $(this);

    $this.find('.attachment_image_upload').change(function() {
      $(this).closest('.new_attachment').submit();
    });

    return $this;
  };
  
  $.fn.new_attachment = function() { 
    var $this = $(this);

    $this.find('form.new_attachment').submit(function() {
      var $form = $(this);
      var $row = $form.closest('tr');
  
      $form.ajaxSubmit({
        dataType: 'json',
        beforeSubmit: function() {
          $form.find('.file_upload').hide();
          $form.find('.file_processing').hide();
          $row.find('.image img').attr('src', '/assets/image_processing.gif');
        },
        success: function(data) { 
          if(data.thumb != false) {
            $row.find('.image img').attr('src', data.thumb);
          }
          $row.children('.info').html(data.info);
          $row.children('.destroy').html(data.destroy_link);
  
          $row.image_destroy_link();
          $row.attachment_update_form();
        }
      });
  
      return false;
    });

    return $this;
  }; 

  $.fn.attachment_update_form = function() {
    var $this = $(this);
    
    $this.find('form.attachment input[type="text"]').change(function() {
      $(this).closest('li').addClass('error');
    });
     
    $this.find('form.attachment').submit(function() {
      var $form = $(this);
      var $row = $form.closest('tr');
      
      $form.ajaxSubmit({
        dataType: 'json',
        beforeSubmit: function() {
          $form.find('input[type="submit"]').attr('disabled', 'disabled');

          $row.find('.image img').attr('src', '/assets/image_processing.gif');
        },
        success: function(data) {
          $form.find('input[type="submit"]').removeAttr('disabled');
          $form.find('li.error').removeClass('error');
          if(data.thumb != false) {
            $row.find('.image img').attr('src', data.thumb);
          }
          if(data.main) {
            $('.attachment_main_input').removeAttr('checked');
            $('#attachment_'+data.id+'_main_input').attr('checked', 'checked');
          }
        }
      });
  
      return false;
    });

    return $this;
  };

  $.fn.image_destroy_link = function() {
    var $this = $(this);
  
    $this.find('.image_destroy_link').click(function() {
      var url = $(this).attr('href');

      if(confirm($(this).attr('data-confirm-message'))) {
        var $row = $(this).closest('tr');
        $(this).hide();
        $row.find('.image img').attr('src', '/assets/image_processing.gif');

        $.post(url, {'_method': 'delete'}, function(data) {
          $row.remove();
        });
      }
  
      return false;
    });

    return $this;
  };

});
	


