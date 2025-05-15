import 'package:command_care/core/shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:command_care/features/onBoarding/presentation/onBoarding_screen.dart';
import 'features/splash/presentation/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: 'AIzaSyCPs0_j_zGG8dCaxcSKFx02-XvIyBPj_Ek',
        appId: 'command-care-1613a',
        messagingSenderId: 'sendid',
        projectId: 'command-care-1613a',
        // storageBucket: 'condo-5ad01.appspot.com',
      )
  );
  await AppSettingsPreferences.init();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Command-Care',
        theme:
        ThemeData(
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            elevation: 10,
            selectedLabelStyle: TextStyle(
                color: Color(0xFFA67926),
                fontFamily: 'Montserrat',
                fontSize: 14.0
            ),
            unselectedLabelStyle: TextStyle(
                color: Colors.grey[600],
                fontFamily: 'Montserrat',
                fontSize: 12.0
            ),
            selectedItemColor: Color(0xFFA67926),
            unselectedItemColor: Colors.grey[600],
            showUnselectedLabels: true,
          ),
        ),
        home: AppSettingsPreferences().isOnboarding
        ? SplashScreen()
        : OnboardingScreen(),);
  }
}
