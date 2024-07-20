const express = require('express');
const auth = require('../middlewares/auth');
const {Product} = require('../models/product');
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

productRouter.post('api/rate-product',auth, async (req, res)=>{
    try {
        const {id, rating} = req.body;
        let product = await Product.findById(id);
        for(let i=0;i<product.ratings.length;i++){
            if(product.ratings[i].userId == req.user){ //we get access tp users id in req.user using auth middleware
                product.ratings.splice(i,1);
                break;
            }
        }

        const ratingSchema = {
            userId: req.user,
            rating :rating,
        }
        product.ratings.push(ratingSchema);
        product = await product.save();
        res.json(product);
        
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

productRouter.get('/api/deal-of-day',async (req,res)=>{
    //product with highest rating
    try {
        let products = await Product.find({});

        products = products.sort((a,b)=>{
            let asum,bsum=0;
            for(let i=0;i<a.ratings.length;i++){
                asum+=a.ratings[i].rating;
            }
            for(let i=0;i<b.ratings.length;i++){
                bsum+=b.ratings[i].rating;
            }
            return asum<bsum ? 1 : -1;
        });
        res.json(products[0]);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
})

module.exports = productRouter;