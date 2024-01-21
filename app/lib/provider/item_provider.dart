import 'dart:convert';

import 'package:shopify_app/models/item_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ItemProvider with ChangeNotifier {
  var apiUrl = "http://10.0.2.2:3500/item";
  List<ItemModel> allItems = [];
  Future<List<ItemModel>> getAllItem() async {
    if (allItems.isNotEmpty) {
      return allItems;
    }
    var res = await http.get(Uri.parse(apiUrl));

    var jsonResponse = await jsonDecode(res.body);

    int len = jsonResponse["items"].length;

    for (int i = 0; i < len; i++) {
      ItemModel item = ItemModel(
        productType: jsonResponse["items"][i]["productType"],
        name: jsonResponse["items"][i]["name"],
        company: jsonResponse["items"][i]["company"],
        color: jsonResponse["items"][i]["color"],
        price: jsonResponse["items"][i]["price"],
      );

      allItems.add(item);
    }

    return allItems;
  }

  Future<List<ItemModel>> getSpecificItem({required String category}) async {
    // print("aaaaa $category");
    Map<String, String> jsonBody = {
      "itemName": category,
    };

    var body = await jsonEncode(jsonBody);

    var res = await http.post(
      Uri.parse("${apiUrl}/category"),
      headers: {"content-type": "application/json"},
      body: body,
    );

    var jsonResponse = await jsonDecode(res.body);

    print(jsonResponse);

    int len = jsonResponse["items"].length;

    List<ItemModel> items = [];

    for (int i = 0; i < len; i++) {
      ItemModel item = ItemModel(
        productType: jsonResponse["items"][i]["productType"],
        name: jsonResponse["items"][i]["name"],
        company: jsonResponse["items"][i]["company"],
        color: jsonResponse["items"][i]["color"],
        price: jsonResponse["items"][i]["price"],
      );

      items.add(item);
    }

    return items;
  }

  Future<List<ItemModel>> getSpecificItemFromImage(
      {required String category}) async {
    // print("aaaaa $category");
    Map<String, String> jsonBody = {
      "itemName": category,
    };

    var body = await jsonEncode(jsonBody);

    var res = await http.post(
      Uri.parse("${apiUrl}/categoryFromImage"),
      headers: {"content-type": "application/json"},
      body: body,
    );

    var jsonResponse = await jsonDecode(res.body);

    print(jsonResponse);

    int len = jsonResponse["items"].length;

    List<ItemModel> items = [];

    for (int i = 0; i < len; i++) {
      ItemModel item = ItemModel(
        productType: jsonResponse["items"][i]["productType"],
        name: jsonResponse["items"][i]["name"],
        company: jsonResponse["items"][i]["company"],
        color: jsonResponse["items"][i]["color"],
        price: jsonResponse["items"][i]["price"],
      );

      items.add(item);
    }

    return items;
  }
}
