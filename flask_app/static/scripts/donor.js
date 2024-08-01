$(document).ready(function() {
    let cities = '<option value="" disabled selected>Select a city</option>';
    let groups = '<option value="" disabled selected>Select a blood group</option>';
    
    $('.logo').on('click', function() {
        window.location.href = "/";
    });

    $.ajax({
        url: 'http://localhost:5001/api/v1/cities',
        method: 'GET',
        dataType: 'json',
        success: function(res) {
            res.forEach((city) => {
                cities += `<option value="${city.id}">${city.name}</option>\n`;
            });

            $('#city').append(cities);
        }
    });

    $.ajax({
        url: 'http://localhost:5001/api/v1/blood_groups',
        method: 'GET',
        dataType: 'json',
        success: function(res) {
            res.forEach((group) => {
                groups += `<option value="${group.id}">${group.type}</option>\n`;
            });

            $('#blood_group').append(groups);
        }
    });

    $('#donor_form').on('submit', function(event) {
        event.preventDefault();
        
        let requestObject = {
            name: $('#name').val(),
            national_id: $('#national_id').val(),
            email: $('#email').val(),
            city_id: $('#city').val(),
            blood_group_id: $('#blood_group').val()
        };

        if (!requestObject.city_id) {
            $('.error').html('You need to select your city');
        }

        $.ajax({
            url: "http://localhost:5001/api/v1/donors",
            method: "POST",
            contentType: "application/json",
            data: JSON.stringify(requestObject),
            success: function(res) {
                $.ajax({
                    url: "http://localhost:5000/login",
                    method: "POST",
                    contentType: "application/json",
                    data: JSON.stringify({"email": res.email,
                        "national_id": res.national_id
                    }),
                    success: function(res) {
                        console.log("Donor login successfully", res);
                    }
                });
                console.log("Donor registered successfully", res);
                window.location.href = `/${res.id}/donation`
            },
            error: function(x, status, error) {
                console.log(x, status, error);
                $('.error').html(x.responseJSON.Error);
            }
        });
    });

});