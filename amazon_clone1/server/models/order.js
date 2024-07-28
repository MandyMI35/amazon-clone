const mongoose = require('mongoose');
const { productSchema } = require('./product');

const orderSchema = mongoose.Schema({
    products: [
        {
            product: productSchema,
            quantity: {
                type: Number,
                required: true,
            },
        },
    ],
    totalPrice: {
        type: Number,
        required: true,
    },
    address: {
        type: String,
        required: true,
    },
    userId: {
        required:true,
        type: String,
    },
    orderedAt: {
        type: Number,
        required: true,
    },
    status: {
        type: Number,
        default: 0, //0 : just ordered, 1: completed, 2: recieved, 3: delivered
    }
});

const Order = mongoose.model('Order',orderSchema);
module.exports = Order;