const Order = require("../models/order");

const createOrder = async (req, res) => {
    try {
      const { id, user, products, total } = req.body;
  
      const newOrder = new Order({
        id,
        user,
        products,
        total,
      });
  
      const savedOrder = await newOrder.save();
      res.status(201).json(savedOrder);
    } catch (error) {
      res.status(500).json({ message: 'Failed to create order', error });
    }
  }

  module.exports = {
    createOrder,
}