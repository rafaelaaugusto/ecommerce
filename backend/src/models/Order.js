const mongoose = require('mongoose');

const OrderSchema = new mongoose.Schema({
    user: {
        name: { type: String, required: true },
        email: { type: String, required: true },
        phone: { type: String},
        adress: {
          street: { type: String, required: true },
          city: { type: String, required: true },
          state: { type: String, required: true },
          zipcode: { type: String, required: true },
          extra: { type: String},
        }
    },
    products: [
        {
            id: { type: String, required: true },
            name: { type: String, required: true },
            price: { type: Number, required: true },
           
        }
    ],
    total: { type: Number, required: true },
}, { timestamps: true });

module.exports = mongoose.model('Order', OrderSchema);
