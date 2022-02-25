const mongoose = require('mongoose');
const CartSchema = new mongoose.Schema({
  name: {
    type: String,
    require: true,
    unique: true,
  },
  imageUrl: {
    type: String,
    required: true,
  },
  price: {
    type: Number,
    required: true,
  },
  source: {
    type: String,
  },
  delivery_fee: {
    type: Number,
  }
});

const model = mongoose.model('cart', CartSchema);
module.exports = model;