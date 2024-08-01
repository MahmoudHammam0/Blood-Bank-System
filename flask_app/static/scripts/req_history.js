$(document).ready(function() {
    let content = '';
    let status = '';

    $.ajax({
        url: "http://localhost:5001/api/v1/requests",
        method: "GET",
        dataType: "json",
        success: function(res) {
            res.forEach((req) => {
                content = `
                <div class="info">Hospital Name: ${req.hospital_name}</div>
                <div class="info">Blood Group: ${req.blood_group_name}</div>
                <div class="info">Patient Status: ${req.patient_status}</div>
                <div class="info">Quantity: ${req.quantity_required * 500} ml</div>
                <div class="info">Request Date: ${req.request_date}</div>
                `;

                let leftContainer = `<div class="request-info">${content}</div>`;
                if (req.fulfilment_status === '' || req.fulfilment_status === "not fulfilled") {
                    req.fulfilment_status = "not fulfilled";
                    status = "not-fulfilled";
                } else {
                    status = "fulfilled"
                }
                let rightContainer = `<div class="fulfilment ${status}">${req.fulfilment_status.toUpperCase()}</div>`
                let mainContainer = `<div class="form-container">${leftContainer + rightContainer}</div>`
                $('.right-container').append(mainContainer);

            });
        }
    });

    $('.logo').on('click', function() {
        window.location.href = "/";
    });

});