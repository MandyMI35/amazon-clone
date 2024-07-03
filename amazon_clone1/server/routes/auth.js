const express = require("express");
const User = require("../models/user");
const bcryptjs=require('bcryptjs');

const authRouter = express.Router(); //instead of app, now we dont listen

//SIGN UP
authRouter.post('/api/signup', async (req, res) => {
    try {
        const { name, email, password } = req.body; //get data from client

        //findOne is a promise
        const existingUser = await User.findOne({ email }); //shorthand synytax for {email: email}
        if (existingUser) {
            return res.status(400).json({ msg: 'user with same email already exists' });
        }
        //encrypting pw
        const hashedPassword = await bcryptjs.hash(password, 8) //here salt=8

        //everything is an object
        let user = new User({          //calls user.js/model
            email,
            password: hashedPassword,
            name,
        })
        user = await user.save();  //saves to database 'users'

        //send data to user
        res.json({ user });
    } catch(e){
        res.status(500).json({error: e.message})
    }
    
});


module.exports = { authRouter }; //in case u want to export multiple things u have to create an object nd use {}