// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require_tree .

/*
jQuery(function($){
        $('select').each(function(i, e){
                if (!($(e).data('convert') == 'no')) {
                        $(e).hide().wrap('<div class="btn-group" id="select-group-' + i + '" />');
                        var select = $('#select-group-' + i);
                        var current = ($(e).val()) ? $(e).val(): '&nbsp;';
                        select.html('<input type="hidden" value="' + $(e).val() + '" name="' + $(e).attr('name') + '" id="' + $(e).attr('id') + '" class="' + $(e).attr('class') + '" /><a class="btn" href="javascript:;">' + current + '</a><a class="btn dropdown-toggle" data-toggle="dropdown" href="javascript:;"><span class="caret"></span></a><ul class="dropdown-menu"></ul>');
                        $(e).find('option').each(function(o,q) {
                                select.find('.dropdown-menu').append('<li><a href="javascript:;" data-value="' + $(q).attr('value') + '">' + $(q).text() + '</a></li>');
                                if ($(q).attr('selected')) select.find('.dropdown-menu li:eq(' + o + ')').click();
                        });
                        select.find('.dropdown-menu a').click(function() {
                                select.find('input[type=hidden]').val($(this).data('value')).change();
                                select.find('.btn:eq(0)').text($(this).text());
                        });
                }
        });
});
*/