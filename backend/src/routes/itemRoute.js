import { Router } from "express";
import createItem from "../controller/ItemController/createItem.js";
import getItem from "../controller/ItemController/getAllItem.js";
import getSpecificItem from "../controller/ItemController/getSpecificItem.js";
import getSpecificItemFromImage from "../controller/ItemController/getSpecificItemFromImage.js";
import searchInRange from "../controller/ItemController/getSpecificItemInRange.js";

export const itemRoute = Router();

itemRoute.post("/create", createItem);
itemRoute.get("", getItem);
itemRoute.post("/category", getSpecificItem);
itemRoute.post("/categoryFromImage", getSpecificItemFromImage);

itemRoute.get("/:lowerLimit/:upperLimit", searchInRange);
// export default itemRoute;
