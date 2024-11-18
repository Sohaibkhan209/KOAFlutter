import 'package:bone_app/screens/colors.dart';
import 'package:flutter/material.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.pop(context); // Ensure BottomNavigationBar is maintained
          },
        ),
        title: Text(
          'Contact Us',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: blueColor,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true, // This centers the title in the AppBar
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 10),
              const Text(
                "If you have any questions, concerns, or feedback regarding the Knee Osteoarthritis KL Classification System app, please feel free to reach out to us. We're here to help!",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Customer Support",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "Email: support@kneeosteoarthritisapp.com\nPhone: +1-800-123-4567\nSupport Hours: Monday to Friday, 9 AM to 5 PM (PST)",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Technical Issues",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "If you encounter any technical issues or bugs, please email us at techsupport@kneeosteoarthritisapp.com with a detailed description and screenshots if possible.",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Feedback & Suggestions",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "We value your feedback! If you have any suggestions for improving the app, please email us at feedback@kneeosteoarthritisapp.com.",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Social Media",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "Follow us on social media for updates and news:\n . Twitter: @KOA_Classify\n . Facebook: KneeOsteoarthritisApp\n . Instagram: @koa_classify_app",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Mailing Address",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "Knee Osteoarthritis KL Classification System\n123 HealthTech Drive Suite 456 MedCity,\nCA 98765 USA",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
