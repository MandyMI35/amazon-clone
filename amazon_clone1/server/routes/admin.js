const express = require('express');
const admin = require('../middlewares/admin');
const Product = require('../models/product');
const adminRouter = express.Router();

//middleware

//add product
adminRouter.post('/admin/add-product',admin,async(req, res)=>{
    try {
        const {name, description, images, quantity, price, category} = req.body;
        let product =new Product({
            name,
            description,
            images,
            quantity,
            price,
            category
        });
        product = await product.save();
        res.json(product);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

adminRouter.get('/admin/get-products',admin, async (req, res)=>{
    try {
        const products = await Product.find({});
        res.json(products);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

adminRouter.post('/admin/delete-product', admin, async(req,res)=>{
    try {  //post bcuz we want to send the id of the post we want to delete
        const {id}=req.body;
        let product = await Product.findByIdAndDelete(id);
        res.json(product); //no need , just to send status code of 200
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

module.exports = adminRouter;