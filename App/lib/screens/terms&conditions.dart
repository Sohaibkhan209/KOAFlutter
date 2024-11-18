import 'package:bone_app/screens/colors.dart';
import 'package:flutter/material.dart';

class TermsandCondition extends StatefulWidget {
  const TermsandCondition({super.key});

  @override
  State<TermsandCondition> createState() => _TermsandConditionState();
}

class _TermsandConditionState extends State<TermsandCondition> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            // Use Navigator.pop() to go back to the previous screen
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Terms & Conditions',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: blueColor,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true, // Centers the title in the AppBar
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0), // Added padding around the content
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 10),
            const Text(
              "These Terms and Conditions outline the rules and regulations for using the Knee Osteoarthritis KL Classification System app.",
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "1. By downloading and using the app, you agree to these Terms and Conditions. If you do not agree, please do not use the app.\n\n"
              "2. Users must ensure that the images uploaded are clear and appropriate for medical analysis.\n\n"
              "3. Users must not use the app for any unlawful or unauthorized purpose.\n\n"
              "4. All personal data and images are processed in accordance with our Privacy Policy, ensuring confidentiality and security.\n\n"
              "5. While the app strives for high accuracy, it is not a substitute for professional medical advice, diagnosis, or treatment. Users should consult healthcare professionals for medical concerns.\n\n"
              "6. The app, including its content and algorithms, is the intellectual property of the developers. Unauthorized use or distribution is prohibited.\n\n"
              "7. The app developers are not liable for any damages resulting from the use or inability to use the app. Users assume all risks associated with its use.\n\n"
              "8. The developers reserve the right to modify these Terms and Conditions at any time. Users will be notified of any significant changes.\n\n"
              "9. For questions or concerns regarding these Terms and Conditions, users can contact customer support through the app.",
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "By using the Knee Osteoarthritis KL Classification System app, you acknowledge and agree to these Terms and Conditions.",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
