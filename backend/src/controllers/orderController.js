const Order = require("../models/order");

const createOrder = async (req, res) => {
    try {
      const { id, user, products, total } = req.body;
      console.log(req.body);
  
  
      const newOrder = new Order({
        user,
        products,
        total,
      });

      console.log(newOrder);
  
      const savedOrder = await newOrder.save();
      console.log(savedOrder);
      res.status(201).json(savedOrder);
    } catch (error) {
      res.status(500).json({ message: 'Failed to create order', error });
    }
  }

  module.exports = {
    createOrder,
}