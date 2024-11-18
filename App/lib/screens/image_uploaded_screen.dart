import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart'; // For TensorFlow Lite inference
import 'package:image/image.dart' as img; // For image preprocessing
import 'package:bone_app/screens/colors.dart'; // Adjust according to your project
import 'package:bone_app/screens/home_screen.dart'; // Adjust according to your project
import 'package:bone_app/screens/result_screen.dart'; // Adjust according to your project
import 'package:flutter/services.dart' show rootBundle;

class ImageUploadScreen extends StatefulWidget {
  final File image;

  const ImageUploadScreen({super.key, required this.image});

  @override
  State<ImageUploadScreen> createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  bool isLoading = false;
  String? prediction;
  double? confidence;
  Interpreter? _interpreter;
  List<String> _labels = [];

  @override
  void initState() {
    super.initState();
    _loadModel();
    _loadLabels();
  }

  @override
  void dispose() {
    _interpreter?.close();
    super.dispose();
  }

  // Load the TFLite model
  Future<void> _loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset('assets/kneeosteoarthritis_model.tflite');
      print('Model loaded successfully');
    } catch (e) {
      print('Error loading model: $e');
      _showErrorDialog('Failed to load the model. Please try again.');
    }
  }

  // Load the labels from the assets
  Future<void> _loadLabels() async {
    try {
      final labelData = await rootBundle.loadString('assets/labels.txt');
      _labels = labelData.split('\n').map((line) => line.trim()).toList();
      print('Labels loaded successfully: $_labels'); // Debugging step to confirm labels
    } catch (e) {
      print('Error loading labels: $e');
      _showErrorDialog('Failed to load labels. Please try again.');
    }
  }

  // Preprocess the image by resizing and normalizing it
  Uint8List preprocessImage(img.Image image, int targetHeight, int targetWidth) {
    img.Image resizedImage = img.copyResize(image, width: targetWidth, height: targetHeight);

    // Prepare the input array as Float32List and normalize pixel values for the model
    var imgData = Float32List(targetHeight * targetWidth * 3);  // 3 color channels (RGB)
    var index = 0;

    // Normalize the image based on EfficientNet standards
    for (var y = 0; y < targetHeight; y++) {
      for (var x = 0; x < targetWidth; x++) {
        var pixel = resizedImage.getPixel(x, y);
        imgData[index++] = (img.getRed(pixel) / 255.0 - 0.485) / 0.229;
        imgData[index++] = (img.getGreen(pixel) / 255.0 - 0.456) / 0.224;
        imgData[index++] = (img.getBlue(pixel) / 255.0 - 0.406) / 0.225;
      }
    }

    print('Preprocessed image data: $imgData'); // Debugging step to check input data
    return imgData.buffer.asUint8List();
  }

  // Classify the uploaded image using the TFLite model
  Future<void> _classifyImage() async {
    setState(() {
      isLoading = true;
    });

    try {
      Uint8List imageBytes = widget.image.readAsBytesSync();
      img.Image? image = img.decodeImage(imageBytes);

      if (image == null) {
        throw Exception("Error decoding image");
      }

      Uint8List inputImage = preprocessImage(image, 224, 224);

      // Prepare the output buffer with the correct shape [1, 3]
      var output = List.filled(3, 0.0).reshape([1, 3]);

      // Run inference
      _interpreter?.run(inputImage, output);

      print('Raw model output: $output'); // Debugging step to print raw model output

      // Extract the prediction result and confidence
      var outputList = output[0] as List<double>;  // Extract first element
      double maxConfidence = outputList.reduce((a, b) => a > b ? a : b);
      int predictedIndex = outputList.indexOf(maxConfidence);

      print('Output List: $outputList'); // Debugging step to print all class confidences

      setState(() {
        prediction = _labels[predictedIndex];
        confidence = maxConfidence * 100;  // Convert to percentage
        isLoading = false;
      });

      // Navigate to the Results screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Results(
            imageFile: widget.image,
            prediction: prediction!,
            confidence: confidence!,
          ),
        ),
      );
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error during classification: $e');
      _showErrorDialog('An error occurred during classification.');
    }
  }

  // Show error dialog
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Navigate back to the home screen
  void _navigateBackToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: _navigateBackToHome,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Text(
                  "Image Uploaded",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: blueColor,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Welcome to the image classification page! Upload and analyze knee X-ray images to determine the severity of osteoarthritis. Follow the instructions below to begin the process.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              Center(
                child: Image.file(
                  widget.image,
                  height: 250,
                  width: 250,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _classifyImage,
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(250, 60),
                          backgroundColor: buttonColor,
                        ),
                        child: Text(
                          'Classify Knee Osteoarthritis',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                      ),
              ),
              const SizedBox(height: 20),
              if (prediction != null && confidence != null) ...[
                Text(
                  'Prediction: $prediction',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Confidence: ${confidence!.toStringAsFixed(2)}%',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
