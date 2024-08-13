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

  const getAllOrders = async (req, res) => {
    const userId = req.query.userId;

    try {
      const orders = await Order.find({ 'user.id': userId });
      console.log(orders);
      res.status(200).json(orders);
    } catch (error) {
      res.status(500).json({ message: 'Failed to fetch orders', error });
    }
  }

  module.exports = {
    createOrder,
    getAllOrders,
}