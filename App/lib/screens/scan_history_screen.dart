import 'package:bone_app/screens/colors.dart'; // Ensure colors are defined here
import 'package:flutter/material.dart';

class ScanHistory extends StatefulWidget {
  final bool fromProfile; // Flag to check if it's from ProfilePage

  const ScanHistory({super.key, required this.fromProfile});

  @override
  State<ScanHistory> createState() => _ScanHistoryState();
}

class _ScanHistoryState extends State<ScanHistory> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (widget.fromProfile)
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              Center(
                child: Text(
                  "Scan History",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: blueColor,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  "Each entry includes detailed results and timestamps,\nhelping you stay informed about your health journey.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  filled: true,
                  fillColor: Colors.grey[200],
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  // Handle search input change
                },
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: const [
                    XrayTile(
                      patientName: "Patient Name",
                      time: "10:00 PM - 20 March 2023",
                      result: "Severe",
                      imagePath: 'lib/assets/Xray.png',
                      filename: "filename.jpg",
                      resultColor: Colors.red,
                    ),
                    XrayTile(
                      patientName: "Patient Name",
                      time: "10:00 PM - 20 March 2023",
                      result: "Moderate",
                      imagePath: 'lib/assets/Xray.png',
                      filename: "filename.jpg",
                      resultColor: Colors.blue,
                    ),
                    XrayTile(
                      patientName: "Patient Name",
                      time: "10:00 PM - 20 March 2023",
                      result: "Healthy",
                      imagePath: 'lib/assets/Xray.png',
                      filename: "filename.jpg",
                      resultColor: Colors.green,
                    ),
                    XrayTile(
                      patientName: "Patient Name",
                      time: "10:00 PM - 20 March 2023",
                      result: "Severe",
                      imagePath: 'lib/assets/Xray.png',
                      filename: "filename.jpg",
                      resultColor: Colors.red,
                    ),
                    XrayTile(
                      patientName: "Patient Name",
                      time: "10:00 PM - 20 March 2023",
                      result: "Severe",
                      imagePath: 'lib/assets/Xray.png',
                      filename: "filename.jpg",
                      resultColor: Colors.red,
                    ),
                    XrayTile(
                      patientName: "Patient Name",
                      time: "10:00 PM - 20 March 2023",
                      result: "Moderate",
                      imagePath: 'lib/assets/Xray.png',
                      filename: "filename.jpg",
                      resultColor: Colors.blue,
                    ),
                    XrayTile(
                      patientName: "Patient Name",
                      time: "10:00 PM - 20 March 2023",
                      result: "Healthy",
                      imagePath: 'lib/assets/Xray.png',
                      filename: "filename.jpg",
                      resultColor: Colors.green,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class XrayTile extends StatelessWidget {
  final String patientName;
  final String time;
  final String result;
  final String imagePath;
  final String filename;
  final Color resultColor;

  const XrayTile({
    super.key,
    required this.patientName,
    required this.time,
    required this.result,
    required this.imagePath,
    required this.filename,
    required this.resultColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.asset(
              imagePath,
              height: 75,
              width: 75,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  patientName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Results: $result',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: resultColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  filename,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

