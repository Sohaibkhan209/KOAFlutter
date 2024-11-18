import 'dart:io';
import 'package:flutter/material.dart';
import 'package:bone_app/screens/colors.dart';
import 'package:bone_app/screens/scan_screen.dart';
import 'package:intl/intl.dart'; // Import for date and time formatting

class TilePage extends StatefulWidget {
  final String patientName; // Patient's name
  final File imageFile; // X-ray image file
  final String prediction; // AI model prediction result (Severe, Moderate, Healthy)
  final String confidence; // Confidence percentage of prediction

  const TilePage({
    super.key,
    required this.patientName,
    required this.imageFile,
    required this.prediction,
    required this.confidence,
  });

  @override
  State<TilePage> createState() => _TilePageState();
}

class _TilePageState extends State<TilePage> {
  late String formattedTime;
  late String formattedDate;

  @override
  void initState() {
    super.initState();
    // Format current date and time
    DateTime now = DateTime.now();
    formattedTime = DateFormat('h:mm a').format(now);
    formattedDate = DateFormat('dd MMMM yyyy').format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ScanScreen()), // Return to the scan screen
              );
            },
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(120, 30),
              backgroundColor: buttonColor,
            ),
            child: Text(
              'Delete',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          )
        ],
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
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
                  widget.patientName,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: blueColor,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Record",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  const Text(
                    "Patient Name:",
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(width: 3),
                  Text(
                    widget.patientName,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text(
                    "Time:",
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(width: 3),
                  Text(
                    formattedTime, // Display formatted time
                    style: const TextStyle(
                      fontSize: 14, 
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    "Date:",
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(width: 3),
                  Text(
                    formattedDate, // Display formatted date
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                "Results:",
                style: TextStyle(fontSize: 14),
              ),
              Row(
                children: [
                  const Text(
                    "Severity: ",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.prediction, // Display AI prediction
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "Uploaded Image",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Center(
                child: Image.file(
                  widget.imageFile, // Display the selected image file
                  height: 200,
                ),
              ),
              const SizedBox(height: 20),
              ClassificationResultsWidget(prediction: widget.prediction, confidence: widget.confidence),
              const SizedBox(height: 20),
              const Text(
                "Detailed Analysis",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildDetailedAnalysis(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailedAnalysis() {
    String details = _getDetailsForPrediction(widget.prediction);
    return Text(
      details,
      style: const TextStyle(
        fontSize: 14,
      ),
    );
  }

  String _getDetailsForPrediction(String prediction) {
    switch (prediction) {
      case "Severe":
        return "The image is predicted to be in the severe category. Severe osteoarthritis presents with significant cartilage loss, bone spurs, and possible joint deformity. Pain is often chronic and debilitating, severely limiting mobility.";
      case "Moderate":
        return "The image is predicted to be in the moderate category. Moderate osteoarthritis is characterized by the progressive wearing away of cartilage and the presence of bone spurs.";
      case "Healthy":
      default:
        return "The image is predicted to show no signs of osteoarthritis, indicating a healthy knee joint.";
    }
  }
}

class ClassificationResultsWidget extends StatelessWidget {
  final String prediction;
  final String confidence; // Confidence of the prediction

  const ClassificationResultsWidget({
    Key? key,
    required this.prediction,
    required this.confidence,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildClassificationRow("Severe", prediction == "Severe" ? double.parse(confidence) : 0, Colors.red.shade300),
          const SizedBox(height: 10),
          _buildClassificationRow("Moderate", prediction == "Moderate" ? double.parse(confidence) : 0, Colors.blue.shade600),
          const SizedBox(height: 10),
          _buildClassificationRow("Healthy", prediction == "Healthy" ? double.parse(confidence) : 0, Colors.green.shade300),
          const SizedBox(height: 20),
          const Text(
            "Classification Model - EfficientNetB5 (TensorFlow)\nModel Version - KneeOsteoarthritis3ClassesV1",
            style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }

  Widget _buildClassificationRow(String title, double percentage, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            Expanded(
              child: LinearProgressIndicator(
                value: percentage / 100,
                color: color,
                backgroundColor: color.withOpacity(0.2),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              "${percentage.toStringAsFixed(1)}%",
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }
}


