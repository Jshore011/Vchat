const mongoose = require("../database");

//create as schema
var userSchema = new mongoose.Schema({
    name: String;
    password: String;
    email: String
});

var userModel = mongoose.model('users', userSchema);

module.exports = mongoose.model("Users", userModel);
