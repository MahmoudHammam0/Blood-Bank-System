$(document).ready(function() {

    let hospitals = "";
    let patients = '<option value="" disabled selected>Select Patient</option>';
    let hospitalId = '';
    let bloodGroupId = '';

    $.ajax({
        url: "http://localhost:5001/api/v1/hospitals",
        method: "GET",
        dataType: "json",
        success: function(res) {
            res.forEach((hospital) => {
                hospitals += `<option value="${hospital.id}">${hospital.name}</option>`;
            });

            $('#hospital').append(hospitals);
        }
    });

    $('#hospital').on('change', function() {
        hospitalId = $('#hospital').val();
        $('#patient').removeAttr('disabled').empty();
        $('#status').val('');
        $('#blood_group').val('');

        $.ajax({
            url: `http://localhost:5001/api/v1/patients/hospital/${hospitalId}`,
            method: "GET",
            dataType: "json",
            success: function(res) {
                patients = '<option value="" disabled selected>Select Patient</option>';
                res.forEach((patient) => {
                    patients += `<option value="${patient.id}">${patient.name}</option>`;
                });

                $('#patient').append(patients);
            }
        });
    });

    $('#patient').on('change', function() {
        let patientId = $('#patient').val();

        $.ajax({
            url: `http://localhost:5001/api/v1/patients/${patientId}`,
            method: "GET",
            dataType: "json",
            success: function(res) {
                console.log(res);
                $('#status').val(res.status);
                bloodGroupId = res.blood_group_id
                $('#blood_group').val(res.blood_group);
            }
        });
    });

    $('#request_form').on('submit', function(event) {
        event.preventDefault();

        $('input[type="submit"]').attr('disabled', true);

        let dateInput = $('#date').val();
        let formattedDate = new Date(dateInput).toISOString().split('T')[0];

        let requestObject = {
            quantity_required: $('#quantity').val(),
            hospital_id: hospitalId,
            blood_group_id: bloodGroupId,
            patient_status: $('#status').val(),
            request_date: formattedDate
        }

        $.ajax({
            url: "http://localhost:5001/api/v1/requests",
            method: "POST",
            contentType: "application/json",
            data: JSON.stringify(requestObject),
            success: function(res) {
                console.log("Request created successfully", res);
                $('.result').append('<img src="../static/images/green_check.png">');
                $('.result').append('<h4>Request made successfully</h4>');

                $.ajax({
                    url: `http://localhost:5001/api/v1/requests/fulfilment/${hospitalId}`,
                    method: "GET",
                    dataType: "json",
                    success: function(res) {
                        console.log(res);
                    }
                });

                setTimeout(function() {
                    window.location.href = "/";
                }, 2000)
            }
        });
    });

    $('.logo').on('click', function() {
        window.location.href = "/";
    })

});