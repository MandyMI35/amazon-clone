const mongoose = require('mongoose');

const userSchema = mongoose.Schema({
    name:{
        required : true,
        type: String, //vartype for mongoose
        trim: true, //removes all leading and trailig spaces
    },
    email:{
        required:true,
        type: String,
        trim:true,
        validate:{
            validator: (value) =>{
                //regex
                const re =/^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return value.match(re);
            },
            //if the value returned above matches re then it means email is valid
            //however if (value != re) then following msg will be shown
            message:"Please enter a valid email address",
        }
    },
    password:{
        required:true,
        type: String,
        validate:{
            validator: (value) => {
                return value.length >6;
            },
            message: "please enter a long password",
        },
    },
    address:{
        type:String,
        default:'',
    },
    //the app doesnt have seller page, only user and admin
    type: {
        type:String,
        default:'user', //by default we want to open the user window
    }
});

const User = mongoose.model("User",userSchema);
module.exports = User;