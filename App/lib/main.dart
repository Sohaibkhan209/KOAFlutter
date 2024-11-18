import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:bone_app/firebase_options.dart';
import 'package:bone_app/screens/colors.dart';
import 'package:bone_app/screens/image_crousal.dart';
import 'package:bone_app/screens/login_screen.dart';
import 'package:bone_app/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isOnboardingShown = prefs.getBool('onboardingShown') ?? false;
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  Widget initialScreen;
  if (!isOnboardingShown) {
    initialScreen = ImageCarousel();
  } else if (isLoggedIn) {
    initialScreen = const HomeScreen();
  } else {
    initialScreen = const LoginScreen();
  }

  runApp(MyApp(initialScreen: initialScreen));
}

class MyApp extends StatelessWidget {
  final Widget initialScreen;

  const MyApp({Key? key, required this.initialScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: AnimatedSplashScreen(
        splash: 'lib/assets/Logo.png',
        splashIconSize: 300,
        duration: 3000,
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: white,
        nextScreen: initialScreen,
      ),
    );
  }
}



