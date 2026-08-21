document.getElementById("loginForm").addEventListener("submit", function(event) {

    // Email Validation
    let email = document.getElementsByName("email")[0].value.trim();

    if (email === "") {
        alert("Email is required.");
        event.preventDefault();
        return;
    }

    let emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

    if (!emailPattern.test(email)) {
        alert("Please enter a valid email address.");
        event.preventDefault();
        return;
    }

    // Password Validation
    let password = document.getElementsByName("password")[0].value;

    if (password === "") {
        alert("Password is required.");
        event.preventDefault();
        return;
    }

});