import Item from "../../models/item_model.js";
import { tranlateText } from "../googleTranslateController/googleTranslate.js";

const getSpecificItem = async (req, res) => {
	const itemName = await req.body.itemName;
	const nameInEnglish = await tranlateText(itemName, "en");

	let words = nameInEnglish.split(/[ \n]/);
	console.log(words);
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

	if (words.length == 4) {
		items = await Item.find({
			$and: [
				{ $or: productTypeQuery },
				{ $or: companyQuery },
				{ $or: nameQuery },
				{ $or: colorQuery },
			],
		});
	} else if (words.length == 3) {
		items = await Item.find({
			$and: [
				{ $or: productTypeQuery },
				{ $or: companyQuery },
				{ $or: nameQuery },
			],
		});

		if (items.length == 0) {
			items = await Item.find({
				$and: [
					{ $or: companyQuery },
					{ $or: nameQuery },
					{ $or: colorQuery },
				],
			});

			if (items.length == 0) {
				items = await Item.find({
					$and: [
						{ $or: productTypeQuery },
						{ $or: nameQuery },
						{ $or: colorQuery },
					],
				});

				if (items.length == 0) {
					items = await Item.find({
						$and: [
							{ $or: productTypeQuery },
							{ $or: companyQuery },
							{ $or: colorQuery },
						],
					});
				}
			}
		}
	} else if (words.length == 2) {
		items = await Item.find({
			$and: [{ $or: productTypeQuery }, { $or: companyQuery }],
		});

		if (items.length == 0) {
			items = await Item.find({
				$and: [{ $or: productTypeQuery }, { $or: nameQuery }],
			});

			if (items.length == 0) {
				items = await Item.find({
					$and: [{ $or: productTypeQuery }, { $or: colorQuery }],
				});

				if (items.length == 0) {
					items = await Item.find({
						$and: [{ $or: companyQuery }, { $or: nameQuery }],
					});

					if (items.length == 0) {
						items = await Item.find({
							$and: [{ $or: companyQuery }, { $or: colorQuery }],
						});

						if (items.length == 0) {
							items = await Item.find({
								$and: [{ $or: nameQuery }, { $or: colorQuery }],
							});
						}
					}
				}
			}
		}
	} else if (words.length == 1) {
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
	}

	if (items.length == 0) {
		items = await Item.find({
			$and: [
				{ $or: productTypeQuery },
				{ $or: companyQuery },
				{ $or: nameQuery },
				{ $or: colorQuery },
			],
		});

		if (items.length == 0) {
			items = await Item.find({
				$and: [
					{ $or: productTypeQuery },
					{ $or: companyQuery },
					{ $or: nameQuery },
				],
			});

			if (items.length == 0) {
				items = await Item.find({
					$and: [
						{ $or: productTypeQuery },
						{ $or: nameQuery },
						{ $or: colorQuery },
					],
				});

				if (items.length == 0) {
					items = await Item.find({
						$and: [
							{ $or: companyQuery },
							{ $or: nameQuery },
							{ $or: colorQuery },
						],
					});

					if (items.length == 0) {
						items = await Item.find({
							$and: [
								{ $or: productTypeQuery },
								{ $or: companyQuery },
								{ $or: colorQuery },
							],
						});

						if (items.length == 0) {
							items = await Item.find({
								$and: [
									{ $or: productTypeQuery },
									{ $or: nameQuery },
								],
							});

							if (items.length == 0) {
								items = await Item.find({
									$and: [
										{ $or: productTypeQuery },
										{ $or: companyQuery },
									],
								});

								if (items.length == 0) {
									items = await Item.find({
										$and: [
											{ $or: productTypeQuery },
											{ $or: colorQuery },
										],
									});

									if (items.length == 0) {
										items = await Item.find({
											$and: [
												{ $or: companyQuery },
												{ $or: nameQuery },
											],
										});

										if (items.length == 0) {
											items = await Item.find({
												$and: [
													{ $or: companyQuery },
													{ $or: colorQuery },
												],
											});

											if (items.length == 0) {
												items = await Item.find({
													$and: [
														{ $or: nameQuery },
														{ $or: colorQuery },
													],
												});

												if(items.length == 0) {
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
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
		}
	}

	console.log(items);

	res.status(201).json({ items: items });
};

export default getSpecificItem;
