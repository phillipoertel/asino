var Initializers = {};

/** check if there is a global initializer function for the current page and run it.
 * if there isn't, run a default initializer.
 */
$(document).ready(function() {
    var pageInitializer = $('body').data('initializer');
    if (typeof Initializers[pageInitializer] == 'function') {
        Initializers[pageInitializer]($);
    } else {
        Initializers.Default($);
    }
})