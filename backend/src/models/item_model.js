import mongoose from "mongoose";

const item = new mongoose.Schema({
	productType: {
		type: String,
		required: true,
	},
	name: {
		type: String,
		required: true,
	},
	company: {
		type: String,
		required: true,
	},
	color: {
		type: String,
		require: true,
	},
	price: {
		type: Number,
		requrired: true,
	},
  rating: {
    type: Number,
    requrired: true,
  }
});

const Item = mongoose.model("Item", item);

export default Item;
