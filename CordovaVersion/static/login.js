// Import the functions you need from the SDKs you need
import { initializeApp } from "https://www.gstatic.com/firebasejs/9.6.5/firebase-app.js";
import { getAnalytics } from "https://www.gstatic.com/firebasejs/9.6.5/firebase-analytics.js";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

const firebaseConfig = {
    apiKey: "AIzaSyCjMU8ankorPuxvYnxQpbk5hX1a0ZjvwSk",
    authDomain: "vchat-37136.firebaseapp.com",
    projectId: "vchat-37136",
    storageBucket: "vchat-37136.appspot.com",
    messagingSenderId: "993893663736",
    appId: "1:993893663736:web:87f489696d2f23656dcc0d",
    measurementId: "G-7K5G0D6MMW"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);
var firebase = require('firebase');
var firebaseui = require('firebaseui');
//$('#dashboard').hide();
function login(){
    $.post("/open_api/login", {"username" : $("#username").val(), "password": $('#password').val()},
        function(data, textStatus){
            console.log("made login request");
            console.log(data.token);
            jwt = data.token;
            // console.log(jwt);
            $.get("settings.html", function(data){
                $("#login_page").replaceWith(data);
            });
            //location.replace("settings.html");
            //$('#login_page').hide();
            //$('#dashboard').show();

        }, "json").fail(function(response){
        console.log("error");
        console.log(response);
    })
    return false;
}



