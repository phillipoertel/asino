//= require jquery
//= require jquery_ujs
//= require bootstrap
// asino initializes the application, load it first
//= require asino
//= require_tree .


jQuery.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})