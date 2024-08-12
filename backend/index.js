const express = require('express');
const cors = require('cors');
const dotenv = require('dotenv');
const mongoose = require('mongoose');
const app = express();

const productRoutes = require('./src/routes/productRoutes');
const orderRoutes = require('./src/routes/orderRoutes');

dotenv.config()
mongoose.connect(process.env.MONGO_URL).then(() => console.log('db connect')).catch((err) => console.log(err))

app.use(cors());
app.use(express.json()); 
app.listen(3000);

app.use('/api', productRoutes);
app.use('/api', orderRoutes);

module.exports = app;