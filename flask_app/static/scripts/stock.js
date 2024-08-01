$(document).ready(function() {
    let content = '';
    const imgDict = {
        "A+": "1.png",
        "A-": "4.png",
        "B+": "5.png",
        "B-": "2.png",
        "O-": "7.png",
        "O+": "6.png",
        "AB+": "8.png",
        "AB-": "9.png"
    }

    $.ajax({
        url: "http://localhost:5001/api/v1/blood_stocks/summary",
        method: "GET",
        dataType: "json",
        success: function(res) {
            for (const key in res) {
                content = `
                <div class="type-icon"><img src="../static/images/${imgDict[key]}"></div>
                <div class="info">Blood Group: ${key}</div>
                <div class="info">Total Volume: ${res[key]['total_volume']} ml</div>
                `;

                let mainContainer = `<div class="form-container">${content}</div>`
                $('.right-container').append(mainContainer);
            }
        }
    });

    $('.logo').on('click', function() {
        window.location.href = "/";
    });

});