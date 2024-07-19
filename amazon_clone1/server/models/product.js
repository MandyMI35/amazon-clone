const mongoose = require('mongoose');
const ratingSchema = require('./rating');

const productSchema = mongoose.Schema({
    name: {
        type: String,
        required: true,
        trim: true,
    },
    description: {
        type: String,
        required: true,
        trim: true,
    },
    images: [        //array of urls
        {
            type: String,
            required: true,
        }
    ],
    description: {
        type: String,
        required: true,
        trim: true,
    },
    quantity: {
        type: Number,
        required: true,
    },
    price: {
        type: Number,
        required: true,
    },
    category: {
        type: String,
        required: true,
    },
    ratings: [ratingSchema], //ratings is going to be array of all ratingSchema we have
    //like an object containing data of multiple users
})

const Product = mongoose.model('Product', productSchema);
module.exports = Product;