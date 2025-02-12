const express = require("express");
const User = require("../models/user");
const bcryptjs=require('bcryptjs');
const jwt = require('jsonwebtoken');
const auth = require("../middlewares/auth");

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

//sign in 
authRouter.post('/api/signin', async (req, res) =>{
    try{
        const {email, password} = req.body;

        const user = await User.findOne({ email });
        if (!user){   //user will contain info a/c to User class, however if null then if condition takes place
            return res.status(400).json({msg : "User with this email does not exist!"});
        }

        //to verify password we cannot hash the user one and compare it in database. cuz we hv added salt and that ensures that no 2 same password are hashed same.
        //bcryptjs.compare asynchronously compares the given data against the given hash.
        const isMatch = await bcryptjs.compare(password, user.password);
        if (!isMatch) {
            return res.status(400).json({msg : "Incorrect password."});
        }
        //jwt to verify users
        const token = jwt.sign({id: user._id},"passwordKey"); // what we need jwt to sign in with , 
        res.json({token , ...user._doc})
    }catch(e){
        res.status(500).json({error: e.message});
    }
}
);

authRouter.post("/tokenIsValid",async (req, res)=>{
    try{
        const token = req.header("x-auth-token");   //check if token is null
        if(!token) return res.json(false);
        const verified = jwt.verify(token, "passwordKey");   //verify if the token match to the corresponding passwordKey or is it just some random token
        if(!verified) return res.json(false);

        const user = await User.findById(verified.id);  //if the token matches, but does user exist?
        if (!user) return res.json(false);
        res.json(true);
    }
    catch(e){
        res.status(500).json({error: e.message});
    }
});// token will be passed thorugh header not body

authRouter.get('/',auth, async (req, res)=>{
    const user = await User.findById(req.user);
    res.json({...user._doc,token:req.token});
});  //auth is middleware that ensures that u r authorised b4 giving access

module.exports = { authRouter }; //in case u want to export multiple things u have to create an object nd use {}