import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/onboarding_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
  );
  runApp(const FillNAdminApp());
}

class FillNAdminApp extends StatelessWidget {
  const FillNAdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FillN Admin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2853AA)),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const OnboardingScreen(),
    );
  }
}
