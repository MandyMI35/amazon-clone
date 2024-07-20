const express = require('express');
const userRouter = express.Router();
const auth=require('../middlewares/auth');
const { Product } = require('../models/product');
const User = require('../models/user');

userRouter.post('/api/add-to-cart',auth,async(req, res)=>{
    try {
        const {id} = req.body;
        const product = await Product.findById(id);
        //we r storing in provider as it will be messy to everytime post and get so saving in model, provider
        let user = await User.findById(req.user); 
        //cannot use == as we r comparing orbjectId/mongooseId not string
        if (user.cart.length==0){
            user.cart.push({product,quantity:1});
        } else {
            let isProductFound = false;
            for(let i=0;i<user.cart.length;i++){
                if(user.cart[i].product._id.equals(product._id)){
                    
                }
            }
        }
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

module.exports = userRouter;