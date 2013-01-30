//= require jquery
//= require jquery_ujs
//= require_tree .


jQuery.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})