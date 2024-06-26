//import from packages
const express = require("express");

//IMPORT FROM OTHER FILES
const authRouter = require('./routes/auth');

//MIDDLEWARE
app.use(authRouter);
//jouf uh b viuyfuw bcv uy

//INIT
const PORT = 3000;
const app=express();

app.get("/hello",(req,res)=>{
    res.json({hi:"hdhciijbcjsa"})
});

 app.listen(PORT,"0.0.0.0",() => {
    console.log(`connected at port ${PORT}`)
 });