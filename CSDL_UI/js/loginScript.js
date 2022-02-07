function showPwd() {
    var p = document.getElementById('_password');
    p.setAttribute('type', 'text');
}
function hidePwd() {
    var p = document.getElementById('_password');
    p.setAttribute('type', 'password');
}
document.getElementById("eye").addEventListener("click", function () {
    if (this.checked) {
        showPwd();
    } else {
        hidePwd();
    }
});
function show(message) {
    var el = document.createElement("div");
    el.className = "snackbar";
    var y = document.getElementById("snackbar-container");

    el.innerHTML = message;
    y.append(el);
    el.className = "snackbar show";
    setTimeout(function () { el.remove(); }, 5000);
}


// function signin() {
//     var userId = document.getElementById('_user_id').value;
//     var password = document.getElementById('_password').value;
//     if (userId.trim() == '' || password.trim() == '') {
//         // show('Nhập thiếu thông tin mã nhân viên hoặc mật khẩu');
//         return;
//     }
//     fetch('signin', {
//         method: 'POST',
//         headers: {
//             'Accept': 'application/json',
//             'Content-Type': 'application/json'
//         },
//         body: JSON.stringify({
//             userId: userId,
//             password: password
//         })
//     })
//         .then(response => {
//             if (response.status == 200) {
//                 window.location = '/admin';
//                 return;
//             }
//             response.json().then(data => {
//                 show(data['message']);
//             });
//         });
// }
function signin() {
    var userId = document.getElementById('_user_id').value;
    var password = document.getElementById('_password').value;
    $.ajax('/signin', {
        type: 'POST',
        data: { userId: userId, password: password },
        success: function (data, status, xhr) {
            localStorage.setItem('QPANKtoken', data.acessToken);
            window.location = '/admin' + '?token=' + localStorage.getItem('QPANKtoken');
        },
        error: function (jqXhr, textStatus, errorMessage) {
            show(errorMessage);
        }
    });
}
(function () {
    'use strict'
    var forms = document.querySelectorAll('.needs-validation')
    Array.prototype.slice.call(forms)
        .forEach(function (form) {
            form.addEventListener('submit', function (event) {
                if (!form.checkValidity()) {
                    event.preventDefault()
                    event.stopPropagation()
                }
                form.classList.add('was-validated')
            }, false)
        })
})()