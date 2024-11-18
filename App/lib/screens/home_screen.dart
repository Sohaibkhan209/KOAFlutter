import 'package:flutter/material.dart';
import 'package:bone_app/screens/colors.dart';
import 'package:bone_app/screens/scan_screen.dart';
import 'package:bone_app/screens/scan_history_screen.dart';
import 'package:bone_app/screens/usage_guide.dart';
import 'package:bone_app/screens/Profile.dart'; 
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  final List<Widget> children = [
    const HomeView(),
    const UsageGuide(fromProfile: false),
    const ScanScreen(),
    const ScanHistory(fromProfile: false),
    const ProfilePage(),
  ];

  void onTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  PreferredSizeWidget? getAppBar() {
    if (currentIndex == 0) {
      return AppBar(
        title: const Center(
          child: Image(
            image: AssetImage('lib/assets/logoHorizontal.png'),
            height: 50, // Adjust as per design
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: IndexedStack(
        index: currentIndex,
        children: children,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: buttonColor,
        currentIndex: currentIndex,
        onTap: onTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.document_scanner),
            label: 'Guide',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time_rounded),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String? firstName;
  
  // Function to fetch user's first name
  void getUserFirstName() {
    User? user = FirebaseAuth.instance.currentUser;
    
    if (user != null && user.email != null) {
      // Extract the first name from the email address
      String email = user.email!;
      setState(() {
        firstName = email.split('@')[0].split('.')[0].capitalize();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUserFirstName(); // Fetch first name when the screen initializes
  }

  @override
  Widget build(BuildContext context) {
    // Mock recent scans (replace with your data source)
    List<String> recentScans = ["Severe", "Moderate", "Healthy"];

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Welcome,",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 4), // Add some space between texts
                Text(
                  "${firstName ?? "User"}!", // Display first name or default text
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: blueColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10), // Space between sections
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.grey[200], // Background color for description
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                "Classify knee osteoarthritis severity from X-ray images using state-of-the-art methods. Get precise KL grade results to assist in diagnosis and treatment planning.",
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  final homeState = context.findAncestorStateOfType<_HomeScreenState>();
                  homeState?.onTapped(2); // Navigate to Scan tab
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(250, 60),
                  backgroundColor: buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Rounded edges
                  ),
                ),
                child: Text(
                  'New Scan',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 22),
            const Text(
              'Recents',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Display the first 3 scan results
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(), // Disable inner scroll
              itemCount: 3, // Limit to the first 3 items
              itemBuilder: (context, index) {
                return XrayTile(result: recentScans[index]);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class XrayTile extends StatelessWidget {
  final String result;
  const XrayTile({super.key, required this.result});

  // Function to determine result color
  Color _getResultColor(String result) {
    switch (result) {
      case "Severe":
        return Colors.red;
      case "Moderate":
        return Colors.blue;
      case "Healthy":
        return Colors.green;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(12.0),
        margin: const EdgeInsets.only(bottom: 16.0), // Add vertical spacing between tiles
        width: double.infinity, // Take full width of the parent
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 5,
              spreadRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(
              height: 75,
              width: 75,
              child: Image(
                image: AssetImage('lib/assets/Xray.png'),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12), // Spacing between image and text
            Expanded( // Wrap with Expanded to prevent overflow
              child: Container(
                height: 75,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Patient Name",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Flexible( // Wrap text with Flexible to handle overflow
                      child: RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: "10:00 PM - 20 March 2023\n",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: "Results: $result\n",
                              style: TextStyle(
                                fontSize: 14,
                                color: _getResultColor(result), // Color-coded based on result
                              ),
                            ),
                            const TextSpan(
                              text: "filename.jpg",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
