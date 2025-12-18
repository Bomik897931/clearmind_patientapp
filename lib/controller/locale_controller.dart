import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocaleController extends GetxController {
  static const String _storageKey = 'selected_locale';
  final _storage = GetStorage();

  Locale _locale = const Locale('en');
  Locale get locale => _locale;

  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('hi'),
  ];

  @override
  void onInit() {
    super.onInit();
    _loadSavedLocale();
  }

  void _loadSavedLocale() {
    final savedLocale = _storage.read(_storageKey);
    if (savedLocale != null) {
      _locale = Locale(savedLocale);
      Get.updateLocale(_locale);
      update(); // Notify listeners
    }
  }

  Future<void> changeLocale(Locale newLocale) async {
    if (!supportedLocales.contains(newLocale)) return;

    _locale = newLocale;
    await _storage.write(_storageKey, newLocale.languageCode);
    Get.updateLocale(newLocale);
    update(); // Notify listeners
  }

  Future<void> toggleLanguage() async {
    final newLocale = _locale.languageCode == 'en'
        ? const Locale('hi')
        : const Locale('en');
    await changeLocale(newLocale);
  }

  String get currentLanguageName {
    switch (_locale.languageCode) {
      case 'hi':
        return 'हिंदी';
      case 'en':
      default:
        return 'English';
    }
  }
}