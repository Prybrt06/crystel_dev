import 'package:shopify_app/pages/search_result_page.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SearchPage extends StatelessWidget {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(
              width: 250,
              child: TextFormField(
                controller: searchController,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SearchResultPage(
                      category: searchController.text,
                    ),
                  ),
                );
              },
              icon: Icon(
                Icons.search,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
