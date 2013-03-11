Initializers.AccountsIndex = function($) {

    // open a modal dialog to add a note
    $(document).on('click', '.add-note-modal', function() {
       $('#addNote form').attr("action", "/items/" +  $(this).data('item-id') + "/notes");
       $('#addNote').modal();
       return false;
    });

    // open a modal dialog to show a note
    $(document).on('click', '.show-note-modal', function() {
       $('#showNote .modal-body').load("/items/" +  $(this).data('item-id') + "/notes/0");
       $('#showNote').modal();
       return false;
    });
}