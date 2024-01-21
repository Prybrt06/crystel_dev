import 'package:shopify_app/models/item_model.dart';
import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  final ItemModel item;
  const ItemWidget({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            spreadRadius: 2,
            offset: Offset(0, 2),
            color: Colors.black.withOpacity(0.5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Image(
              image: AssetImage(
                'assets/${item.productType}.jpeg',
              ),
              fit: BoxFit.fitHeight,
              height: 80,
            ),
          ),
          Text(
            item.name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Container(
            child: Row(
              children: [
                Text(
                  item.company,
                  style: TextStyle(
                    color: Colors.blueGrey,
                  ),
                ),
                Spacer(),
                Text(
                  item.color,
                  style: TextStyle(
                    color: Colors.blueGrey,
                  ),
                )
              ],
            ),
          ),
          Spacer(),
          Text('₹ ${item.price}')
        ],
      ),
    );
  }
}
