import 'dart:io';

import 'package:shopify_app/models/item_model.dart';
import 'package:shopify_app/pages/result_from_image_page.dart';
import 'package:shopify_app/pages/search_page.dart';
import 'package:shopify_app/pages/search_result_page.dart';
import 'package:shopify_app/pages/text_from_image_page.dart';
import 'package:shopify_app/provider/item_provider.dart';
import 'package:shopify_app/widgets/item_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController searchController = TextEditingController();

  File? _image;
  final picker = ImagePicker();

  String scannedText = "";

  String imageLable = "";

  Future<String> detextText() async {
    final inputImage = InputImage.fromFilePath(_image!.path);
    final textDetector = GoogleMlKit.vision.textRecognizer();

    RecognizedText recognizedText = await textDetector.processImage(inputImage);

    await textDetector.close();

    scannedText = "";

    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement element in line.elements) {
          scannedText += '${element.text} ';
        }
      }
    }

    // print("hello $scannedText");

    setState(() {});

    return scannedText;
  }

  Future<String> getImageLabels() async {
    final inputImage = InputImage.fromFilePath(_image!.path);
    ImageLabeler imageLabeler = ImageLabeler(options: ImageLabelerOptions());

    List<ImageLabel> labels = await imageLabeler.processImage(inputImage);

    StringBuffer sb = StringBuffer();

    for (ImageLabel imageLabel in labels) {
      String lbltext = imageLabel.label;
      // double confidence = imageLabel.confidence;

      sb.write(lbltext);
      sb.write(" ");
      // sb.write(confidence);
    }

    imageLabeler.close();
    imageLable = sb.toString();

    print("Hello");

    print(imageLable);

    return imageLable;
  }

//Image Picker function to get image from gallery
  Future<String> getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
    String detectedText = await detextText();

    return detectedText;
  }

  Future<String> getImageFromGalleryForLabelling() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });

    String label = await getImageLabels();

    return label;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "shopify",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => SearchPage()),
              );
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () async {
              String category = await getImageFromGallery();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TextFromImagePage(
                    text: category,
                  ),
                ),
              );
            },
            icon: Icon(
              Icons.image_aspect_ratio,
            ),
          ),
          IconButton(
            onPressed: () async {
              String category = await getImageFromGalleryForLabelling();

              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ResultFromImagePage(category: category),
              ));
            },
            icon: Icon(
              Icons.image_search,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<ItemProvider>(context, listen: false).getAllItem(),
        builder: ((context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<ItemModel> items = snapshot.data;
            return SizedBox(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      // width: 200,
                      // height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.grey,
                        ),
                      ),
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: searchController,
                        decoration: const InputDecoration(
                            icon: Icon(Icons.search),
                            hintText: "Search",
                            border: InputBorder.none),
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
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 650,
                    child: GridView.count(
                      padding: const EdgeInsets.all(20),
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: items
                          .map(
                            (e) => ItemWidget(
                              item: e,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => SearchPage()),
          );
        },
        child: Icon(Icons.search),
      ),
    );
  }
}
