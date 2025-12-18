import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'controller/locale_controller.dart';
import 'core/theme/app_theme.dart';
import 'core/routes/app_pages.dart';
import 'core/routes/app_routes.dart';
import 'l10n/app_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    // final localeController = Get.find<LocaleController>();
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetBuilder<LocaleController>(
          builder: (localeController) {
            return GetMaterialApp(
              title: 'Medical App',
              locale: localeController.locale,
              supportedLocales: LocaleController.supportedLocales,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              fallbackLocale: const Locale('en'),
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              initialRoute: AppRoutes.splash,
              getPages: AppPages.pages,
              defaultTransition: Transition.cupertino,
            );
          }
        );
      },
    );
  }
}
