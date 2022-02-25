const mongoose = require('mongoose');
const FoodSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
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
  description: {
    type: String,
    required: true,
  },
  source: {
    type: String,
  },
});

const model = mongoose.model('food', FoodSchema);
module.exports = model;
