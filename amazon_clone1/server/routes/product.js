const express = require('express');
const auth = require('../middlewares/auth');
const Product = require('../models/product');
const productRouter = express.Router();

productRouter.get('/api/products',auth, async (req, res)=>{
    try {
        console.log(req.query.category);
        const products = await Product.find({category: req.query.category});
        res.json(products);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

productRouter.get('/api/products/search/:name',auth, async (req, res)=>{
    try {
        const products = await Product.find({
            //name: req.params.name will work but then it will serach as === nd not ==(just example) as in case of below
            name: {$regex: req.params.name, $options: "i"}, //i for insensitive
        });
        res.json(products);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

module.exports = productRouter;