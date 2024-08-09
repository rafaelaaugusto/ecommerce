const productService = require('../services/productService');

const getAllProducts = async (req, res) => {
    try {
      const products = await productService.getAllProducts();
      res.json(products);
    } catch (error) {
      res.status(500).json({ message: 'Failed to fetch products' });
    }
  }

module.exports = {
    getAllProducts,
}