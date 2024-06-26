const express = require("express");


const authRouter = express.Router(); //instead of app, now we dont listen

authRouter.get('/user',(req,res) => {
    res.json({msg:"auth.js"})
});

module.exports ={authRouter}; //in case u want to export multiple things u have to create an object nd use {}