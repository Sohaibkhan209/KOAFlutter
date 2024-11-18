import 'package:bone_app/screens/colors.dart';
import 'package:flutter/material.dart';

class UsageGuide extends StatefulWidget {
  final bool fromProfile;

  // Constructor accepts a parameter to determine if it's accessed from ProfilePage
  const UsageGuide({super.key, required this.fromProfile});

  @override
  State<UsageGuide> createState() => _UsageGuideState();
}

class _UsageGuideState extends State<UsageGuide> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Show back button only if accessed from ProfilePage
        leading: widget.fromProfile 
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context); // Go back to the previous screen
                },
              )
            : null, // Hide the back button if not accessed from ProfilePage
        centerTitle: true, // Center the title in the AppBar
        title: Text(
          'Usage Guide',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: blueColor,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 10),
            const Text(
              "The Knee Osteoarthritis KL Classification System is an Android app that analyzes knee X-ray images to classify the severity of osteoarthritis using the EfficientNetB5 model. It categorizes the condition into three classes: healthy, moderate, and severe. This guide will help you use the app effectively.",
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            const Text(
              "Step By Step Instruction",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "1. Install the app on your Android device by following the on-screen instructions after downloading it from the Google Play Store.\n\n"
              "2. Open the app and grant the necessary permissions for accessing device storage and camera when prompted. This ensures the app can function correctly.\n\n"
              "3. Ensure you are logged in with your Google account. If not already logged in, the app will prompt you to sign in with your Google credentials.\n\n"
              "4. Navigate to the Upload section from the main menu to start the process.\n\n"
              "5. Choose between taking a new X-ray image using the camera or selecting an existing image from your device's gallery. Use the appropriate option provided in the Upload section.\n\n"
              "6. Ensure the image is clear, captured at a 90-degree angle from above, and preferably digitally scanned for the best results. Note that the app is configured specifically for knee X-rays; avoid uploading X-rays of any other body part to ensure accurate classification.\n\n"
              "7. Once the image is uploaded, tap the Classify button to start the analysis.\n\n"
              "8. The app will process the image and provide a classification result, which will indicate whether the knee is healthy, moderate, or severe in terms of osteoarthritis.\n\n"
              "9. View detailed information and recommendations based on the classification result provided by the app. This information will help you understand the severity of osteoarthritis and possible next steps.",
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
