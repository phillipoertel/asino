Initializers.AccountsOverview = function($) {

    $(document).on('click', 'tr.overview_category a', function() {
       var identifier = $(this).data('subcategory');
       $("#" + identifier).toggle();
    });
    
}