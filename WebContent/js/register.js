document.getElementById("registerForm").addEventListener("submit", function(event) {

	// Full Name Validation 
    let fullName = document.getElementsByName("fullname")[0].value.trim();

    if (fullName.length < 3) {
        alert("Full name must contain at least 3 characters.");
        event.preventDefault();
        return;
    }

    //Email Validation
    let email = document.getElementsByName("email")[0].value.trim();

    let emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

    if (!emailPattern.test(email)) {
        alert("Please enter a valid email address.");
        event.preventDefault();
        return;
    }
    
    //Password Validation
    let password = document.getElementsByName("password")[0].value;
//    validation Special character
    let passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z0-9]).{8,}$/;
//    let passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$/;
    

    if (!passwordPattern.test(password)) {
        alert("Password must contain at least 8 characters," +
        		"including uppercase, " +
        		"lowercase, " +
        		"number," +
        		"special character.");
        event.preventDefault();
        return;
    }
    
    //Phone Validation
    let phone = document.getElementsByName("phone")[0].value.trim();

    let phonePattern = /^[0-9]{10}$/;

    if (!phonePattern.test(phone)) {
        alert("Phone number must contain exactly 10 digits.");
        event.preventDefault();
        return;
    }

    // Gender Validation
    let gender = document.querySelector('input[name="gender"]:checked');

    if (gender === null) {
        alert("Please select your gender.");
        event.preventDefault();
        return;
    }
    
    // Date Of Birth validation
    let dob = document.getElementsByName("dob")[0].value;

    if (dob === "") {
        alert("Please select your date of birth.");
        event.preventDefault();
        return;
    }

    let dateOfBirth = new Date(dob);
    let today = new Date();

    today.setHours(0, 0, 0, 0);

    if (dateOfBirth > today) {
        alert("Date of birth cannot be a future date.");
        event.preventDefault();
        return;
    }
    
    //City Validation
    let city = document.getElementsByName("city")[0].value.trim();

    let cityPattern = /^[A-Za-z ]+$/;

    if (city.length < 2) {
        alert("City name must contain at least 2 characters.");
        event.preventDefault();
        return;
    }

    if (!cityPattern.test(city)) {
        alert("City name can contain only letters and spaces.");
        event.preventDefault();
        return;
    }
        
    // bio validation
    let bio = document.getElementsByName("bio")[0].value.trim();

    if (bio.length > 500) {
        alert("Bio must not exceed 500 characters.");
        event.preventDefault();
        return;
    }
    
    // Image validation
    let profilePicture = document.getElementsByName("profilePicture")[0];

    if (profilePicture.files.length > 0) {

        let file = profilePicture.files[0];

        let allowedTypes = [
            "image/jpeg",
            "image/png"
        ];

        if (!allowedTypes.includes(file.type)) {
            alert("Only JPG, JPEG, and PNG images are allowed.");
            event.preventDefault();
            return;
        }

        let maxSize = 2 * 1024 * 1024; // 2 MB

        if (file.size > maxSize) {
            alert("Profile image must not exceed 2 MB.");
            event.preventDefault();
            return;
        }
    }
    
});