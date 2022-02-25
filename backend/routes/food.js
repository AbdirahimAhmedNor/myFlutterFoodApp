const express = require('express');
const Food = require('../models/food');
const Cart = require('../models/cart');
const router = express.Router();

router.get('/', async (req, res) => {
  const foods = await Food.find();
  res.send(foods);
});
router.get('/carts', async (req, res) => {
  const carts = await Cart.find();
  res.send(carts);
});

router.post('/carts/:cartName', async (req, res) => {
  const { cartName } = req.params;
  try {
    await Cart.deleteOne({ name: cartName });
    res.send('deleted');
  } catch (error) {
    res.status(400).send('something went wrong');
  }
});

router.post('/add', async (req, res) => {
  const { name, imageUrl, price, source } = req.body;
  const ifItemExists = await Cart.findOne({ name });
  if (!ifItemExists) {
    const newItem = new Cart({ name, imageUrl, price: Number(price), source });
    await newItem.save();
    res.send('saved');
  } else {
    res.status(400).send('exists');
  }
});

module.exports = router;
