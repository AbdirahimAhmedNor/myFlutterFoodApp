const mongoose = require('mongoose');
const UserSchema = new mongoose.Schema({
    name: {
	type: String,
	required: true,
    },
    username: {
	type: String,
	required: true,
	unique: true,
    },
    password: {
	type: String,
	required: true,
    },
    createdAt: {
	type: Date,
	default: Date.now
    },
});
const model = mongoose.model('user', UserSchema);
module.exports = model;
