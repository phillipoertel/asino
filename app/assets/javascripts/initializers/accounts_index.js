Initializers.AccountsIndex = function($) {

    console.log('Initializer: AccountsIndex');
    
    // example
    $(document).on('click', 'div', function() {
        console.log("a div at the following position was clicked:");
        console.log($(this).position());
    })
}