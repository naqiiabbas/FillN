import 'package:flutter/material.dart';

import 'screens/onboarding_screen.dart';

void main() {
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
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2540C9)),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const OnboardingScreen(),
    );
  }
}
