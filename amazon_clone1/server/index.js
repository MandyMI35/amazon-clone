//import from packages
const express = require("express"); //require function: import a module from your project's dependencies
const mongoose=require('mongoose');

//IMPORT FROM OTHER FILES
const {authRouter} = require('./routes/auth'); 

//INIT
const PORT = 3000;
const app=express(); //Create a new Express application instance and store it in the app
const DB = "mongodb+srv://mndalwee:sheeshmongo@mnd.pxcuzub.mongodb.net/?retryWrites=true&w=majority&appName=mnd";

//MIDDLEWARE
app.use(express.json());
app.use(authRouter);

//connections
mongoose.connect(DB)
.then (()=>{console.log("connxn successful");})
.catch((e)=>{console.log(e);})


// app.get("/hello",(req,res)=>{
//     res.json({hi:"hdhciijbcjsa"})
// });

 app.listen(PORT,"0.0.0.0",() => {
    console.log(`connected at port ${PORT}`)
 });