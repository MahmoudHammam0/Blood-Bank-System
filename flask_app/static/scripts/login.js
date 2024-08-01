$(document).ready(function() {

    $('#login_form').on('submit', function(event) {
        event.preventDefault();
        
        let requestObject = {
            national_id: $('#national_id').val(),
            email: $('#email').val()
        };

        $.ajax({
            url: "http://localhost:5000/login",
            method: "POST",
            contentType: "application/json",
            data: JSON.stringify(requestObject),
            success: function(res) {
                console.log("Donor login successfully", res);
                window.location.href = `/${res.id}/donation`
            },
            error: function(x, status, error) {
                console.log(x.responseJSON.Error);
                $('.error').html(x.responseJSON.Error)   
            }
        });
    });

    $('.logo').on('click', function() {
        window.location.href = "/";
    });

});