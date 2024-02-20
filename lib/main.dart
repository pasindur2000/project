import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'next_page.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File? imageFile; // Changed to hold only one image file

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Capturing Image'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 240,
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  border: Border.all(width: 8, color: Colors.black12),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: imageFile != null
                    ? Image.file(
                  imageFile!,
                  width: double.infinity,
                  height: 240,
                  fit: BoxFit.cover,
                )
                    : const Center(
                  child: Text(
                    'Image should appear here',
                    style: TextStyle(fontSize: 26),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => selectImage(),
                child: const Text('Select Image', style: TextStyle(fontSize: 18)),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => goToNextPage(context),
                child: const Text('Next', style: TextStyle(fontSize: 18)),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {}, // No function associated with this button
                child: const Text('Start', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void selectImage() async {
    final XFile? selectedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (selectedFile != null) {
      setState(() {
        imageFile = File(selectedFile.path);
      });
    }
  }

  void goToNextPage(BuildContext context) {
    if (imageFile != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NextPage(imageFile: imageFile!)),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('No Image Selected'),
            content: Text('Please select an image before proceeding.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
