import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rice Leaf Disease Detection',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Rice Leaf Disease Detection'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Selected image file
  File? _imageFile;

  // Flag to indicate if an image is selected
  bool _isImageSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          // Show image only if selected
          _isImageSelected
              ? Image.file(
                  _imageFile!,
                  width: 600,
                  height: 240,
                  fit: BoxFit.cover,
                )
              : const SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () async {
                  try {
                    final XFile? pickedImage = await ImagePicker().pickImage(
                      source: ImageSource.camera,
                      imageQuality: 80,
                    );
                    if (pickedImage != null) {
                      setState(() {
                        _imageFile = File(pickedImage.path);
                        _isImageSelected = true;
                      });
                    }
                  } on Exception catch (e) {
                    print(e.toString());
                  }
                },
                child: const Text('Take Photo'),
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    final XFile? pickedImage = await ImagePicker().pickImage(
                      source: ImageSource.gallery,
                      imageQuality: 80,
                    );
                    if (pickedImage != null) {
                      setState(() {
                        _imageFile = File(pickedImage.path);
                        _isImageSelected = true;
                      });
                    }
                  } on Exception catch (e) {
                    print(e.toString());
                  }
                },
                child: const Text('Select Photo'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Implement image viewer logic
                  if (_imageFile != null) {}
                },
                child: const Text('Analyze Photo'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
