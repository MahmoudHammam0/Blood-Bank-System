$(document).ready(function() {
    let banks = '<option value="" disabled selected>Select a blood bank</option>';
    const donorId = $('.donation').data('id');
    console.log(donorId);
    let bloodGroupId = '';
    
    $('.donation').on('click', function() {
        window.location.href = `/${donorId}/donation`;
    });

    $('.logo, .home').on('click', function() {
        window.location.href = "/";
    });

    $('.logout').on('click', function() {
        window.location.href = "/logout";
    });

    $.ajax({
        url: `http://localhost:5001/api/v1/donors/${donorId}`,
        method: "GET",
        dataType: "json",
        success: function(res) {
            console.log(res);
            $('.home, .name').append(res.name);
            $('#national_id').append(res.national_id);
            $('#email').append(res.email);
            $('#blood_group').append(res.blood_group);
            $('#city').append(res.city);
            bloodGroupId = res.blood_group_id;

            $.ajax({
                url: `http://localhost:5001/api/v1/cities/${res.city_id}/blood_banks`,
                method: "GET",
                dataType: "json",
                success: function(banksRes) {
                    banksRes.forEach((bank) => {
                        banks += `<option value="${bank.id}">${bank.name}</option>\n`;
                    });

                    $('#blood_bank').append(banks);
                }
            });
        }
    });

    $('#donation_form').on('submit', function(event) {
        event.preventDefault();

        let testResult = $('#virus_test').val();
        let actualValue = (testResult === 'true');
        let dateInput = $('#date').val();
        let formattedDate = new Date(dateInput).toISOString().split('T')[0];
        let requestDict = {
            donor_id: donorId,
            blood_group_id: bloodGroupId,
            blood_bank_id: $('#blood_bank').val(),
            virus_test_result: actualValue,
            donation_date: formattedDate,
        };

        $.ajax({
            url: "http://localhost:5001/api/v1/donations",
            method: "POST",
            contentType: "application/json",
            data: JSON.stringify(requestDict),
            success: function(res) {
                console.log("Donation made successfully", res);
                if (res.result === 'rejected') {
                    window.location.href = `/rejected/${res.id}`;
                    
                    $.ajax({
                        url: `http://localhost:5001/api/v1/donations/rejection/${res.id}`,
                        method: "GET",
                        dataType: "json",
                        success: function(res) {
                            console.log(res);
                        }
                    });
                    
                } else {
                    window.location.href = `/accepted/${res.id}`;
                }
            }
        });
    });

});