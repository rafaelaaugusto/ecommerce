const router = require('express').Router();
const orderController = require('../controllers/orderController');

router.post('/orders', orderController.createOrder);

router.get('/orders', orderController.getAllOrders);

module.exports = router;