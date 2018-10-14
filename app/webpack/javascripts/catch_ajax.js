/* catch_ajax.js */
$(function() {
  $('form[data-remote=true]').bind('ajax:success', function(event, data, status, xhr) {
    console.log(status);
    const success = ['success','created','updated']
    $('p.notice').html('');
    $('p.alert').html('');
    var msg;
    if (success.indexOf(data.status) > -1) {
      msg = $('p.notice').html('УСПЕХ: ');
    } else {
      msg = $('p.alert').html('ОШИБКА: ');
    }
    if (jQuery.type(data.message) === 'string') {
      msg.append(data.message);
    } else {
      var ul = $('<ul/>');
      $.each(data.message, function (key, val) {
        console.log('[for$=' + key + ']');
        var label = $('[for$=' + key + ']')[0].innerText;
        $.each(val, function(_, val) {
          ul.append($('<li/>').text(label + ' ' + val));
        });
      });
      msg.append(ul);
    }
    var action = event.target.action;
    if (data.redirect && action) {
      setTimeout(function() { 
        $(location).attr('href', action);
      }, 1000);
    }
  });
});
