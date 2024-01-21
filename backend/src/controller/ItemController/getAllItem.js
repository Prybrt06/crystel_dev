import Item from "../../models/item_model.js";

const getItem = async (req, res, next) => {
	const items = await Item.find();

	const shuffledItems = items.sort((a,b)=>0.5 - Math.random());

	res.status(201).json({ items: shuffledItems });
};

export default getItem;
