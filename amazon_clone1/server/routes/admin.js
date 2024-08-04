const express = require('express');
const admin = require('../middlewares/admin');
const { Product } = require('../models/product');
const adminRouter = express.Router();
const Order = require('../models/order')

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

adminRouter.post('/admin/delete-product', admin, async(req,res)=>{
    try {  //post bcuz we want to send the id of the post we want to delete
        const {id}=req.body;
        let product = await Product.findByIdAndDelete(id);
        res.json(product); //no need , just to send status code of 200
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

adminRouter.get('/admin/get-orders', admin, async(req,res)=>{
    try {  //post bcuz we want to send the id of the post we want to delete
        const orders = await Order.find({});
        res.json(orders);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

adminRouter.post('admin/change-order-status', admin, async(req,res)=>{
    try {  //post bcuz we want to send the id of the post we want to delete
        const {id,status}=req.body;
        let order = await Order.findById(id);
        order.status=status;
        order = await order.save;
        res.json(product);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

adminRouter.get('admin/ananlytics', admin, async(req,res)=>{
    try {  //post bcuz we want to send the id of the post we want to delete
        const orders = await Order.find({});
        totalEarnings = 0;

        for(let i=0;i<orders.length;i++){
            for(let j=0;j<orders[i].products.length;j++){
                totalEarnings += orders[i].products[j].quantity *orders[i].products[j].product.price
            }
        }

        //category wise order fetching
        let mobileEarnings = await fetchCategoryWiseProduct('Mobiles');
        let essentialEarnings = await fetchCategoryWiseProduct("Essentials");
        let applianceEarnings = await fetchCategoryWiseProduct("Appliances");
        let booksEarnings = await fetchCategoryWiseProduct("Books");
        let fashionEarnings = await fetchCategoryWiseProduct("Fashion");

        let earnings = {
            totalEarnings,
            mobileEarnings,
            essentialEarnings,
            applianceEarnings,
            booksEarnings,
            fashionEarnings,
          };

        res.json(earnings);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

async function fetchCategoryWiseProduct(category){
    let earnings =0;
    let categoryOrders = await Order.find({
        'products.product.category':category,
    });

    for(let i=0;i<categoryOrders.length;i++){
        for(let j=0;j<categoryOrders[i].products.length;j++){
            earnings += categoryOrders[i].products[j].quantity *categoryOrders[i].products[j].product.price
        }
    }
    return earnings;
}

module.exports = adminRouter;