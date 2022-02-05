//function that gets user info from database
window.onload = function get_user(){
    //$('#loginContainer').hide();
    console.log("inside get_user")
    //make secure call with the jwt
    secure_get_with_token("/secure_api/settings",
        function(data){
            console.log("got data")
            console.log("got user");
            console.log(data);
            for(var i = 0; i < data.length; i++){
                console.log("inside loop")

                $("#book"+(i+1)).append("<tr><td>" + data.data.books[i].title +
                    "</td></tr><tr><td>" + data.data.books[i].price + "</td></tr>");
            }

        },
        function(err){ console.log(err) });
}
//going to need this to populate label when the dictionary is returned, we need to loop through the dictionary
//and assign each element to each label
//document.getElementById("placeholder-name").value = val1;
//document.getElementById("placeholder-email").value = val1;
//document.getElementById("placeholder-password").value = val1;
//document.getElementById("placeholder-phone").value = val1;
var profile_pic = window.localStorage;
function readURL(input) {

    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function(e) {
            $('#imagePreview').css('background-image', 'url('+e.target.result +')');
            $('#imagePreview').hide();
            $('#imagePreview').fadeIn(650);
        }
        reader.readAsDataURL(input.files[0]);
        localStorage.setItem(reader);
    }
}
$("#imageUpload").change(function() {
    readURL(this);
});

var theme = window.localStorage.currentTheme;

$('body').addClass(theme);

if ($("body").hasClass("night")) {
    $('.dntoggle').addClass('fa-sun-o');
    $('.dntoggle').removeClass('fa-moon-o');
} else {
    $('.dntoggle').removeClass('fa-sun-o');
    $('.dntoggle').addClass('fa-moon-o');
}

$('.dntoggle').click(function() {
    $('.dntoggle').toggleClass('fa-sun-o');
    $('.dntoggle').toggleClass('fa-moon-o');

    if ($("body").hasClass("night")) {
        $('body').toggleClass('night');
        localStorage.removeItem('currentTheme');
        localStorage.currentTheme = "day";
    } else {
        $('body').toggleClass('night');
        localStorage.removeItem('currentTheme');
        localStorage.currentTheme = "night";
    }
});
//function for popup that allows user to edit username
function edit_username(){
    var popup = document.getElementById("username_edit");
    popup.classList.toggle("show");
}
//function for popup that allows user to edit Email
function edit_email(){
    var popup = document.getElementById("email_edit");
    popup.classList.toggle("show");
}
//function for popup that allows user to edit password
function edit_pass(){
    var popup = document.getElementById("password_edit");
    popup.classList.toggle("show");
}
//function for popup that allows user to edit Phone Number
function edit_phone(){
    var popup = document.getElementById("phone_edit");
    popup.classList.toggle("show");
}