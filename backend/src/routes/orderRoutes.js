const router = require('express').Router();
const orderController = require('../controllers/orderController');

router.post('/orders', orderController.createOrder);

module.exports = router;