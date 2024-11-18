import 'dart:io';
import 'package:flutter/material.dart';
import 'package:bone_app/screens/colors.dart';
import 'package:bone_app/screens/scan_screen.dart'; // Import ScanScreen to allow retry

class Results extends StatelessWidget {
  final File imageFile; // The uploaded X-ray image
  final String prediction; // The prediction result
  final double confidence; // The confidence score

  const Results({
    super.key,
    required this.imageFile,
    required this.prediction,
    required this.confidence,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Classification Results",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: blueColor,
            ),
          ),
        ),
        automaticallyImplyLeading: false, // Disable back button in AppBar
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Prediction Outcome",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: blueColor,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Uploaded Image",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Image.file(
                  imageFile, // Display the selected image
                  height: 250,
                  width: 250,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Prediction: $prediction",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _getPredictionColor(prediction),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Confidence: ${confidence.toStringAsFixed(2)}%",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Analysis Details",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _getPredictionDescription(prediction),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ScanScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(250, 60),
                    backgroundColor: buttonColor,
                  ),
                  child: Text(
                    'Try Another Image',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

Color _getPredictionColor(String prediction) {
  switch (prediction.trim().toLowerCase()) {  // Trim and lower-case string
    case 'severe':
      return Colors.red;
    case 'moderate':
      return Colors.orange;
    case 'healthy':
      return Colors.green;
    default:
      return Colors.black;
  }
}

Widget _getPredictionDescription(String prediction) {
  switch (prediction.trim().toLowerCase()) {  // Trim and lower-case string
    case 'severe':
      return const Text(
        "The model predicts a SEVERE case of knee osteoarthritis. It's highly recommended to consult a healthcare professional.",
        style: TextStyle(fontSize: 16),
      );
    case 'moderate':
      return const Text(
        "The model predicts a MODERATE case of knee osteoarthritis. It's advisable to seek medical advice for further assessment.",
        style: TextStyle(fontSize: 16),
      );
    case 'healthy':
      return const Text(
        "The model predicts a HEALTHY knee with no signs of osteoarthritis. Keep maintaining a healthy lifestyle!",
        style: TextStyle(fontSize: 16),
      );
    default:
      return const Text(
        "Prediction not available. Please try again.",
        style: TextStyle(fontSize: 16),
      );
  }
}}