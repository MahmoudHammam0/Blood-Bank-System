$(document).ready(function() {
    const url = window.location.href;
    const donationId = url.substring(url.lastIndexOf('/') + 1);
    const donorId = $('.donation').data('id');
    
    $.ajax({
        url: `http://localhost:5001/api/v1/donations/${donationId}`,
        method: "GET",
        dataType: "json",
        success: function(res) {
            $('#blood_bank').append(res.blood_bank);
            $('.blood_group').append(res.blood_group);
            $('#reasons').append(res.reason_for_rejection);
            const date = new Date(res.donation_date);
            const day = date.getDate();
            const month = date.toLocaleString('en-GB', { month: 'short' });
            const year = date.getFullYear();
            const formattedDate = `${day} ${month} ${year}`;
            $('#date').append(formattedDate);
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

    $(window).on('beforeunload', function() {
        $.ajax({
            url: `http://localhost:5001/api/v1/donations/${donationId}`,
            method: "DELETE",
            dataType: "json",
            success: function(res) {
                console.log("donation removed successfully", res)
            }
        })
    });

});