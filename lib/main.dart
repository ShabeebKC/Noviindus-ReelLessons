import 'package:flutter/material.dart';
import 'package:reel_lessons/constants/app_colors.dart';
import 'package:reel_lessons/modules/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:reel_lessons/modules/dashboard/domain/use_cases/dashboard_usecase.dart';
import 'package:reel_lessons/modules/dashboard/presentation/manager/dashboard_provider.dart';
import 'package:reel_lessons/modules/profile/presentation/manager/profile_provider.dart';
import 'modules/authentication/data/repositories/login_repository_impl.dart';
import 'modules/authentication/domain/use_cases/login_usecase.dart';
import 'modules/authentication/presentation/manager/login_provider.dart';
import 'modules/authentication/presentation/pages/login_screen.dart';
import 'package:provider/provider.dart';
import 'modules/dashboard/presentation/manager/add_feed_provider.dart';
import 'modules/profile/data/repositories/profile_repository_impl.dart';
import 'modules/profile/domain/use_cases/profile_usecase.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider(LoginUseCase(LoginRepositoryImpl()))),
        ChangeNotifierProvider(create: (_) => DashboardProvider(DashboardUseCase(DashboardRepositoryImpl()))),
        ChangeNotifierProvider(create: (_) => ProfileProvider(ProfileUseCase(ProfileRepositoryImpl()))),
        ChangeNotifierProvider(create: (_) => AddFeedProvider()),
      ],
      child: MaterialApp(
        title: 'Reel Lessons',
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.primary,
          splashColor: AppColors.transparent,
          highlightColor: AppColors.transparent,
          hoverColor: AppColors.transparent,
          focusColor: AppColors.transparent,
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.secondary),
        ),
        home: const LoginScreen(),
      ),
    );
  }
}