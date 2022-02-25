if (process.env.NODE_ENV !== 'production') require('dotenv').config();
const express = require('express');
const mongoose = require('mongoose');

// configuring database
const uri = process.env.URI;
mongoose.connect(uri);
const db = mongoose.connection;
db.once('open', () => console.log('connected to mongoose'));

// starting the server
const app = express();
app.use(express.json());
app.use(
  express.urlencoded({
    limit: '1mb',
    parameterLimit: 1000,
    extended: true,
  })
);
const port = process.env.PORT || 3000;

// importing routes
const userRoute = require('./routes/user');
const foodRoute = require("./routes/food");
app.use('/users', userRoute);
app.use('/foods', foodRoute);

app.listen(port, console.log('listening the port: ' + port));
