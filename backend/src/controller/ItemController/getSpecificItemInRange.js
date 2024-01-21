import Item from "../../models/item_model.js"

const searchInRange = async (req,res,next) => {
  let lowerLimit = await req.params.lowerLimit;
  let upperLimit = await req.params.upperLimit;

  try {
   const items = await Item.find({
     $and: [
       {"price": {$gt: lowerLimit}},
       {"price": {$lt: upperLimit}}
     ]
   }); 
   res.status(201).json({items: items});
  } catch (e) {
    console.log(`The error is ${e}`);
  }
}

export default searchInRange;
