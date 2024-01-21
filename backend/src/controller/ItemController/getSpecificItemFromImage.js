import Item from "../../models/item_model.js";
import { tranlateText } from "../googleTranslateController/googleTranslate.js";

const getSpecificItemFromImage = async (req, res) => {
	const itemName = await req.body.itemName;
	const nameInEnglish = await tranlateText(itemName, "en");

	let words = nameInEnglish.split(/[ \n]/);
	words = words.filter((word) => word != "");

	const productTypeQuery = words.map((word) => ({
		productType: { $regex: new RegExp(word, "i") },
	}));

	const companyQuery = words.map((word) => ({
		company: { $regex: new RegExp(word, "i") },
	}));

	const nameQuery = words.map((word) => ({
		name: { $regex: new RegExp(word, "i") },
	}));

	const colorQuery = words.map((word) => ({
		color: { $regex: new RegExp(word, "i") },
	}));

	let items = [];

	items = await Item.find({
		$and: [{ $or: productTypeQuery }],
	});

	if (items.length == 0) {
		items = await Item.find({
			$and: [{ $or: companyQuery }],
		});

		if (items.length == 0) {
			items = await Item.find({
				$and: [{ $or: nameQuery }],
			});

			if (items.length == 0) {
				items = await Item.find({
					$and: [{ $or: colorQuery }],
				});
			}
		}
	}

	console.log(items);

	res.status(201).json({ items: items });
};

export default getSpecificItemFromImage;
