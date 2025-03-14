import 'package:flutter/material.dart';
import '../core/constants/app_constants.dart';

import 'theme.dart';
import 'app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      theme: buildAppTheme(),
      home: const AppRouter(),
    );
  }
}
