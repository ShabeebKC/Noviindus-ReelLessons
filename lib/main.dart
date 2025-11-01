import 'package:flutter/material.dart';
import 'package:reel_lessons/constants/app_colors.dart';
import 'modules/authentication/presentation/pages/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.secondary),
      ),
      home: const LoginScreen(),
    );
  }
}
