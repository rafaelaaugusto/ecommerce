const mongoose = require('mongoose');

const OrderSchema = new mongoose.Schema({
    id: { type: String, required: true },
    user: {
        id: { type: String, required: true },
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
            price: { type: String, required: true },
            description: { type: String, required: false },
            hasDiscount: { type: Boolean, required: false },
            discountValue: { type: String, required: false },
            gallery: { type: Array, required: false },
            material: { type: String, required: false },
            department: { type: String, required: false },
            details: { type: Map, required: false },
        }
    ],
    total: { type: String, required: true },
}, { timestamps: true });

module.exports = mongoose.model('Order', OrderSchema);
