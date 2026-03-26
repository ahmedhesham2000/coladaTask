import 'package:coladatask/config/app_config.dart';
import 'package:coladatask/config/dependency_injection/dependency_injection.dart';
import 'package:coladatask/core/constants/app_constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/routes/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initDependencyInjection();

  AppConfig(
    buildFlavor: BuildFlavourConstants.dev,
    baseURL: AppConstants.baseUrl,
  );
  final prefs = await SharedPreferences.getInstance();
  final String? savedLang = prefs.getString('language_code');
  final startLocale = savedLang != null
      ? Locale(savedLang)
      : const Locale('en', 'US');
  runApp(
    ProviderScope(
      observers: [
        // LoggerObserver(), // Uncomment if you want to log provider changes
      ],
      child: EasyLocalization(
        supportedLocales: const [Locale('ar', 'EG'), Locale('en', 'US')],
        path: 'assets/translations',
        fallbackLocale: const Locale('ar', 'EG'),
        startLocale: startLocale,
        child: Phoenix(child: const MyApp()),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final GoRouter _router = AppRouter.router;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'Colada Task',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: 'IBMPlexSansArabic'),
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,

          routerConfig: _router,
        );
      },
    );
  }
}
