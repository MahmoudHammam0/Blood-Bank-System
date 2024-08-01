$(document).ready(function() {
    const donorId = $('.donation').data('id');
    const url = window.location.href;
    const donationId = url.substring(url.lastIndexOf('/') + 1);
    let bloodBankId = '';
    let bloodGroupId = '';

    $.ajax({
        url: `http://localhost:5001/api/v1/donors/${donorId}`,
        method: "GET",
        dataType: "json",
        success: function(res) {
            $(`#blood_group`).append(`<br>${res.blood_group}`);
            bloodGroupId = res.blood_group_id;
        }
    });

    $.ajax({
        url: `http://localhost:5001/api/v1/donations/${donationId}`,
        method: "GET",
        dataType: "json",
        success: function(res) {
            bloodBankId = res.blood_bank_id
        }
    });


    $('#donation_form').on('submit', function(event) {
        event.preventDefault();

        inputVolume = $('#volume').val();
        intVolume = parseInt(inputVolume, 10);
        let dateInput = $('#date').val();
        let formattedDate = new Date(dateInput).toISOString().split('T')[0];

        let requestObject = {
            blood_bank_id: bloodBankId,
            blood_group_id: bloodGroupId,
            volume: intVolume,
            exp_date: formattedDate
        }

        $.ajax({
            url: `http://localhost:5001/api/v1/blood_stocks`,
            method: "POST",
            contentType: "application/json",
            data: JSON.stringify(requestObject),
            success: function(res) {
                console.log("stock created successfully", res);
                window.location.href = `/success/${res.id}`
            }
        });
    });

    $('.logo, .home').on('click', function() {
        window.location.href = "/";
    });

    $('.logout').on('click', function() {
        window.location.href = "/logout";
    });

});