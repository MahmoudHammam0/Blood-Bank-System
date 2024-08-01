$(document).ready(function() {

    $('.donation').on('click', function() {
        const donorId = $(this).data('id')
        window.location.href = `/${donorId}/donation`;
    });

    $('.logo').on('click', function() {
        window.location.href = "/";
    });

    $('.h-btn').on('click', function() {
        const donorId = $('.donation').data('id')
        window.location.href = `/${donorId}/donation`;
    });

    $('.bb-btn').on('click', function() {
        window.location.href = "/register"
    });

    $('.req-btn, .requests').on('click', function() {
        window.location.href = "/request";
    });

    $('.logout').on('click', function() {
        window.location.href = "/logout";
    });

    setTimeout(() => {
        document.querySelector('.content1').style.opacity = 1;
    }, 500);

    setTimeout(() => {
        document.querySelector('.content2').style.opacity = 1;
    }, 800);

});