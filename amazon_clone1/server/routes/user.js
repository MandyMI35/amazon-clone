const express = require('express');
const userRouter = express.Router();
const auth=require('../middlewares/auth');
const { Product } = require('../models/product');
const User = require('../models/user');
const Order = require('../models/order');

userRouter.post('/api/add-to-cart',auth,async(req, res)=>{
    try {
        const {id} = req.body;
        const product = await Product.findById(id);
        //we r saving cart in user as we dont hv to fetch info everytime user clicks on cart icon and it will be messy to everytime post and get so saving the model in provider
        let user = await User.findById(req.user); 
        if (user.cart.length==0){
            user.cart.push({product,quantity:1});
        } else {
            let isProductFound = false;
            for(let i=0;i<user.cart.length;i++){
                if(user.cart[i].product._id.equals(product._id)){ //cannot use == as we r comparing orbjectId/mongooseId not string
                    isProductFound=true;
                }
            }

            if(isProductFound){
                let producttt = user.cart.find((productt)=>
                 productt.product._id.equals(product._id)
                );
                producttt.quantity+=1;
            } else{
                user.cart.push({product,quantity:1});
            }
            user = await user.save();
            res.json(user);
        }
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

userRouter.delete('/api/remove-from-cart/:id',auth,async(req, res)=>{
    try {
        const {id} = req.params;  //same as req.params.id
        const product = await Product.findById(id);
        //we r saving cart in user as we dont hv to fetch info everytime user clicks on cart icon and it will be messy to everytime post and get so saving the model in provider
        let user = await User.findById(req.user); 
        
        for(let i=0;i<user.cart.length;i++){
            if(user.cart[i].product._id.equals(product._id)){ //cannot use == as we r comparing orbjectId/mongooseId not string
                if (user.cart[i].quantity == 1){
                    user.cart.splice(i,1);
                } else{
                    user.cart[i].quantity -= 1;
                }               
            }
        }

        user = await user.save();
        res.json(user);
        
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

userRouter.post('api/save-user-address', auth, async (req,res)=>{
    try {
        const {address} = req.body;
        let user = await User.findById(req.user);
        user.address= address;
        user=  await user.save();
        req.json(user);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

userRouter.post('api/order', auth, async (req,res)=>{
    try {
        const {cart, totalPrice,address} = req.body;
        let products = [];

        for(let i=0;i<cart.length;i++){
            let product = await Product.findById(cart[i].product._id);
            if(product.quantity >= cart[i].quantity){
                products.quantity-=cart[i].quantity;
                products.push({product,quantity: cart[i].quantity});
                await product.save();
            } else {
                return res.status(400).json({msg: `${product.name} is out of stock`});
            }
        };

        let user = await User.findById(req.user);
        user.cart=[];//making sure that cart is empty
        user = await user.save();

        let order = new Order({
            products,
            totalPrice,
            address,
            userId: req.user,
            orderedAt: new Date().getTime(),
        });
        order = await order.save();
        req.json(order);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

userRouter.get('api/orders/me', auth, async (req,res)=>{
    try {
        const orders = await Order.findById({userId: req.user});//finding all orders with users id
        res.json(orders);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});


module.exports = userRouter;