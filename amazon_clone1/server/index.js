//import from packages
const express = require("express"); //require function: import a module from your project's dependencies
const mongoose=require('mongoose');
const cors = require('cors');

//IMPORT FROM OTHER FILES
const {authRouter} = require('./routes/auth'); 
const adminRouter = require("./routes/admin");

//INIT
const PORT = process.env.PORT || 3000;
console.log(process.env.PORT);
const app=express(); //Create a new Express application instance and store it in the app
const DB = "mongodb+srv://mndalwee:sheeshmongo@mnd.pxcuzub.mongodb.net/?retryWrites=true&w=majority&appName=mnd";

//MIDDLEWARE
app.use(cors());
app.use(express.json());  //Returns middleware that only parses json and only looks at requests where the Content-Type header matches the type option.
app.use(authRouter);  //calls auth.js
app.use(adminRouter);

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