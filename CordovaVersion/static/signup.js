function signup() {

    if(($("#newname").val() === "" )||( $("newword").val() === "")){
        alert("Invalid input");
        return false;
    }
    $.post("/open_api/signup_firebase", {"username": $("#newname").val(), "password": $('#newword').val()},
        function (data, textStatus) {
            console.log("made signup request");
            console.log(data.token);
            jwt = data.token;

        }, "json").fail(function (response) {
        console.log("error");
        console.log(response);
    })
    return false;
}