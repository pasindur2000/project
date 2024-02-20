import 'dart:io';
import 'package:flutter/material.dart';

class NextPage extends StatelessWidget {
  final File imageFile; // Define the imageFile parameter

  const NextPage({Key? key, required this.imageFile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Next Page'),
        centerTitle: true,
      ),
      body: Center(
        child: Image.file(imageFile), // Display the selected image
      ),
    );
  }
}
