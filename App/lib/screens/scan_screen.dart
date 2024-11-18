import 'dart:io';
import 'package:bone_app/screens/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bone_app/screens/image_uploaded_screen.dart'; // Import ImageUploadScreen

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  // Removed _image, _prediction, _isLoading from here
  // since handling is moved to ImageUploadScreen

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);

      if (pickedFile != null) {
        final fileExtension = pickedFile.path.split('.').last.toLowerCase();
        if (['png', 'jpg', 'jpeg'].contains(fileExtension)) {
          final selectedImage = File(pickedFile.path);
          // Navigate to ImageUploadScreen with the selected image
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ImageUploadScreen(image: selectedImage),
            ),
          );
        } else {
          _showErrorDialog('Invalid file type. Please select a PNG, JPG, or JPEG image.');
        }
      }
    } catch (e) {
      _showErrorDialog('An error occurred while picking the image.');
    }
  }

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

  void _showImageSourceActionSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Take a Photo'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.file_present),
                title: const Text('Choose from Files'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Scan Now!",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: blueColor,
            ),
          ),
        ),
        automaticallyImplyLeading: false, // Removes the back button
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text(
                  'Welcome to the image classification page! Here, you can easily upload and analyze knee X-ray images to determine the severity of osteoarthritis.'),
              const SizedBox(height: 20),
              const Text(
                "Image Requirements",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                  "1. Image must be captured from a straight-on (90-degree) angle.\n2. Ensure the image is in high resolution for clarity.\n3. The picture should be sharp and free of any blurriness.\n4. Use image file formats (png, jpg, jpeg) not PDF or other format for uploading images."),
              const SizedBox(height: 20),
              const Text(
                "Example Image",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('lib/assets/Xray2.png'),
                  ),
                  Image(
                    image: AssetImage('lib/assets/Xray2.png'),
                  )
                ],
              ),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('lib/assets/Xray2.png'),
                  ),
                  Image(
                    image: AssetImage('lib/assets/Xray2.png'),
                  )
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                  "Choose between taking a new X-ray image using your device's camera or selecting an existing image from your gallery. You can also provide link to image."),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: _showImageSourceActionSheet,
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(250, 60),
                    backgroundColor: buttonColor,
                  ),
                  child: Text(
                    'Select X-ray Image',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ),
              ),
              // Removed loading indicator and prediction display from here
            ],
          ),
        ),
      ),
    );
  }
}
