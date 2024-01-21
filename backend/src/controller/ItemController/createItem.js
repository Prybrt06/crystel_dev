import Item from "../../models/item_model.js";

const createItem = async (req, res, next) => {
	try {
		const item = await Item.create({
			productType: req.body.productType,
			name: req.body.name,
			company: req.body.company,
			color: req.body.color,
			price: req.body.price,
      rating: req.body.rating,
		});

		res.status(201).json({ item: item });
	} catch (err) {
		res.status(401).json({ error: "Item can't be created" });
		return;
	}
};

export default createItem;
