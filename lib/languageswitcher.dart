import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/locale_controller.dart';
import 'core/constants/app_strings.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    // final localeController = Get.find<LocaleController>();

    return GetBuilder<LocaleController>(
      builder: (localeController) {
        return Column(
          children: [
            Text(AppStrings.aboutApp),
            Text(AppStrings.addNewCard),
            Text(AppStrings.bookAppointment),
            Text(AppStrings.appName),
            Text(AppStrings.completed),
            IconButton(
              icon: const Icon(Icons.language),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Select Language'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: const Text('🇺🇸'),
                          title: const Text('English'),
                          trailing: localeController.locale.languageCode == 'en'
                              ? const Icon(Icons.check, color: Colors.blue)
                              : null,
                          onTap: () {
                            localeController.changeLocale(const Locale('en'));
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: const Text('🇮🇳'),
                          title: const Text('हिंदी'),
                          trailing: localeController.locale.languageCode == 'hi'
                              ? const Icon(Icons.check, color: Colors.blue)
                              : null,
                          onTap: () {
                            localeController.changeLocale(const Locale('hi'));
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
