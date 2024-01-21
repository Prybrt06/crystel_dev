import mongoose from "mongoose";
import { itemRoute } from "./src/routes/itemRoute.js";
import app  from "./server.js";

app.listen(3500, () => {
	mongoose.connect("mongodb://localhost:27017/shopify");
	console.log("Server starts at http://localhost:3500");
});

app.use("/item", itemRoute);
