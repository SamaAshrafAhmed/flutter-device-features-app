import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageGalleryScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<ImageGalleryScreen> createState() => _ImageGalleryScreenState();
}

class _ImageGalleryScreenState extends State<ImageGalleryScreen> {
  List<File> images = [];
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Images Gallery"),
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 550,
            child: images.isNotEmpty
                ? ListView.builder(
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(10),
                        height: 250,
                        child: ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(29),
                          child: Image.file(images[index], fit: BoxFit.fill),
                        ),
                      );
                    },
                  )
                : Center(child: Text("Please Choose Images")),
          ),
          SizedBox(height: 10),
          TextButton(
            onPressed: () async {
              await pickImages();
            },

            style: TextButton.styleFrom(
              backgroundColor: Colors.amber,
              foregroundColor: Colors.black,
              fixedSize: Size(200, 30),
            ),
            child: Text("Pick Images"),
          ),
        ],
      ),
    );
  }

  Future<void> pickImages() async {
    final List<XFile> imagesPaths = await picker.pickMultiImage();
    for (var img in imagesPaths) {
      images.add(File(img.path));
    }
    setState(() {});
  }
}
