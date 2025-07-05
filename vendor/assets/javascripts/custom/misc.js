(function($) {
  'use strict';
  $(document).on('turbolinks:load',function() {
    var body = $('body');
    var contentWrapper = $('.content-wrapper');
    var scroller = $('.container-scroller');
    var footer = $('.footer');
    var sidebar = $('.sidebar');

    //Close other submenu in sidebar on opening any
    sidebar.on('show.bs.collapse', '.collapse', function() {
      sidebar.find('.collapse.show').collapse('hide');
    });

    $('[data-toggle="minimize"]').on("click", function() {
      if ((body.hasClass('sidebar-toggle-display')) || (body.hasClass('sidebar-absolute'))) {
        body.toggleClass('sidebar-hidden');
      } else {
        body.toggleClass('sidebar-icon-only');
      }
    });

    $('input[required]').on("invalid", function() {
      if($(this).siblings("label").length > 0){
        this.setCustomValidity("Please enter " + $(this).siblings("label").text().replace("*", ""));
      }
    });
    $('input[required]').on("input", function() {
      if($(this).siblings("label").length > 0){
        this.setCustomValidity("");
      }
    });

    //checkbox and radios
    $(".form-check label,.form-radio label").append('<i class="input-helper"></i>');

    $('.file-upload-browse').on('click', function() {
      var file = $(this).parent().parent().parent().find('.file-upload-default');
      file.trigger('click');
    });
    $('.file-upload-default').on('change', function() {
      $(this).parent().find('.form-control').val($(this).val().replace(/C:\\fakepath\\/i, ''));
    });
    $('[data-toggle="offcanvas"]').on("click", function() {
      $('.sidebar-offcanvas').toggleClass('active')
    });
    $('.aside-toggler').click(function(){
      $('.chat-list-wrapper').toggleClass('slide')
    });
    $('[data-toggle="tooltip"]').tooltip();
    $('[data-toggle="popover"]').popover();

    if ($('.datetimepicker').length) {
      $('.datetimepicker').datetimepicker({
        format: 'DD-MM-YYYY hh:mm A'
      });
    }

    if ($('.datepicker').length) {
      $('.datepicker').datetimepicker({
        format: 'DD-MM-YYYY'
      });
    }

    if ($('.monthpicker').length) {
      $('.monthpicker').datetimepicker({
        format: 'MM-YYYY'
      });
    }

    if ($('.yearpicker').length) {
      $('.yearpicker').datetimepicker({
        format: 'YYYY',
        viewMode: 'years',
        minViewMode: 'years',
        autoclose: true
      });
    }

    if ($('.timepicker').length) {
      $('.timepicker').datetimepicker({
        format: 'LT'
      });
    }

    if ($(".color-picker").length) {
      $('.color-picker').asColorPicker();
    }

    if ($("#lightgallery").length) {
      $("#lightgallery").lightGallery();
    }

    if ($('.checkbox-dependent-dropdown').length) {
      $('.checkbox-dependent-dropdown').change(function() {
        if ($(this).prop('checked')){
          $($(this).data('dependent')).attr("disabled", $(this).data('on') == 'reverse');
        }else{
          $($(this).data('dependent')).attr("disabled", $(this).data('on') != 'reverse');
        }
      });
      $(".checkbox-dependent-dropdown").trigger("change");
    }

    if ($(".select2-field").length) {
      $(".select2-field").select2();
      $(".select2-field").removeClass('select2-field');
    }

  });

  $(document).on('mouseenter mouseleave', '.sidebar .nav-item', function(ev) {
    var body = $('body');
    var sidebarIconOnly = body.hasClass("sidebar-icon-only");
    var sidebarFixed = body.hasClass("sidebar-fixed");
    if (!('ontouchstart' in document.documentElement)) {
      if (sidebarIconOnly) {
        if (sidebarFixed) {
          if (ev.type === 'mouseenter') {
            body.removeClass('sidebar-icon-only');
          }
        } else {
          var $menuItem = $(this);
          if (ev.type === 'mouseenter') {
            $menuItem.addClass('hover-open')
          } else {
            $menuItem.removeClass('hover-open')
          }
        }
      }
    }
  });
})(jQuery);

if (top !== self) { top.location.replace(self.location.href); }
function CopyToClipboard(containerid) {
  if (document.selection) {
    var range = document.body.createTextRange();
    range.moveToElementText(document.getElementById(containerid));
    range.select().createTextRange();
    document.execCommand("copy");
  } else if (window.getSelection) {
    var range = document.createRange();
    range.selectNode(document.getElementById(containerid));
    window.getSelection().addRange(range);
    document.execCommand("copy");
  }
}
