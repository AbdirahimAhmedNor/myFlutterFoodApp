const express = require('express');
const bcrypt = require('bcryptjs');
const User = require('../models/register');
const router = express.Router();

// user register route
router.post('/register', async (req, res) => {
  const { name, username, password } = req.body;
  const existedUser = await User.findOne({ username });
  if (!existedUser) {
    const hash = await bcrypt.hash(password, 10);
    const newUser = new User({
      name,
      username,
      password: hash,
    });
    await newUser.save();
    res.send('saved');
  } else {
    console.log(existedUser);
    res.status(400).send('user existed');
  }
});

//login route
router.post('/login', async (req, res) => {
  const { username, password } = req.body;
  const user = await User.findOne({ username });
  if (!user) {
    res.status(404).send('user doesn"t exist');
  } else {
    const isPasswordMatched = await bcrypt.compare(password, user.password);
    if (isPasswordMatched) res.send('authorized');
    else res.status(403).send('password wrong');
  }
});

module.exports = router;
