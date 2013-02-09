Initializers.AccountsNew = function($) {

    var originalLabel = $('label[for=account_feed]').text();
    
    $(document).on('change', 'select#account_importer', function() {
        
        var importer = $(this).val();
        var label    = $('label[for=account_feed]');
        var field    = $('input#account_feed');
        
        if (importer == "Saldomat") {
            
            label.text(originalLabel);
            field.show();
            
        } else if (importer == "Outbank") {
            
            label.text("Pfad zur Outbank-CSV-Datei (relativ zur Anwendung)");
            field.show();
            
        } else if (importer == "HBCI") {
            
            label.text("HBCI ist noch nicht implementiert ...");
            field.hide();
        }
    })
}