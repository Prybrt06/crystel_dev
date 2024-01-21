import 'package:shopify_app/pages/search_result_page.dart';
import 'package:flutter/material.dart';

class TextFromImagePage extends StatelessWidget {
  final String text;

  TextFromImagePage({required this.text});

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    searchController.text = text;
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            SizedBox(
              height: 300,
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  // width: 200,
                  // height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    // border: Border.all(
                    //   color: Colors.grey,
                    // ),
                  ),
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: "Search",
                    ),
                    onFieldSubmitted: (value) {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SearchResultPage(
                          category: value,
                        ),
                      ));
                    },
                  ),
                ),
              ),
            ),
            IconButton(
              color: Colors.blue,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SearchResultPage(
                    category: searchController.text,
                  ),
                ));
              },
              icon: Icon(Icons.search),
            ),
          ],
        ),
      ),
    );
  }
}
