$(document).ready(function() {
    const url = window.location.href;
    const stockId = url.substring(url.lastIndexOf('/') + 1);
    const donorId = $('.donation').data('id');
    
    $.ajax({
        url: `http://localhost:5001/api/v1/blood_stocks/${stockId}`,
        method: "GET",
        dataType: "json",
        success: function(res) {
            $('#blood_bank').append(res.blood_bank);
            $('.blood_group').append(res.blood_group);
            $('#volume').append(`${res.volume} ml`);
            $('#date').append(res.donation_date);
        }
    });

    $('.donation').on('click', function() {
        window.location.href = `/${donorId}/donation`;
    });

    $('.logo, .home').on('click', function() {
        window.location.href = "/";
    });

    $('.logout').on('click', function() {
        window.location.href = "/logout";
    });

});