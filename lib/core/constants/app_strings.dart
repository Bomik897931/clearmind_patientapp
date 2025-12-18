// class AppStrings {
//   AppStrings._();
//
//   static const String appName = 'Medical App';
//   static const String letsFindDoctor = "Let's find a doctor";
//   static const String searchSpecialist = 'Search Specialist/City';
//   static const String topDoctors = 'Top Doctors';
//   static const String seeAll = 'See All';
//   static const String categories = 'Categories';
//   static const String myAppointment = 'My Appointment';
//   static const String upcoming = 'Upcoming';
//   static const String completed = 'Completed';
//   static const String bookAppointment = 'Book Appointment';
//   static const String selectDate = 'Select Date';
//   static const String selectHour = 'Select Hour';
//   static const String next = 'Next';
//   static const String cancel = 'Cancel';
//   static const String submit = 'Submit';
//   static const String update = 'Update';
//   static const String reviews = 'Reviews';
//   static const String reschedule = 'Reschedule';
//   static const String viewDetail = 'ViewDetail';
//   static const String workingTime = 'WorkingTime';
//   static const String aboutMe = 'AboutMe';
//   static const String patientDetails = 'Pateint Details';
//   static const String fullName = 'Full Name';
//   static const String dateOfBirth = 'DateOfBirth';
//   static const String weight = 'Weight';
//   static const String writeYourSymptoms = 'Write Your Symptoms';
//   static const String gender = 'Gender';
//   static const String blood = 'Blood';
//   static const String addNewCard = 'Add New Card';
//   static const String cardName = 'Card Name';
//   static const String cardNumber = 'Card Number';
//   static const String expiryDate = 'Expiry Date';
//   static const String cvv = 'CVV';
//   static const String payments = 'Payments';
//   static const String selectPaymentMethod = 'Select Payment Method';
//   static const String aboutApp = 'About App';
//   static const String notification = 'Notification';
//   static const String changePassword = 'Change Password';
//   static const String faqs = 'FAQS';
//   static const String help = 'Help';
//   static const String logout = 'LogOut';
//   static const String yourAge = 'Your Age';
//   static const String writeReview = 'Write Review';
//   static const String sendMail = 'Send Mail';
//   static const String editProfile = 'Edit Profile';
//   static const String emailID = 'Email ID';
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../l10n/app_localizations.dart';

class AppStrings {
  AppStrings._();

  static AppLocalizations get _l10n {
    final context = Get.context;
    if (context == null) {
      throw Exception('GetX context is null');
    }
    return AppLocalizations.of(context)!;
  }

  static String get appName => _l10n.appName;
  static String get letsFindDoctor => _l10n.letsFindDoctor;
  static String get searchSpecialist => _l10n.searchSpecialist;
  static String get topDoctors => _l10n.topDoctors;
  static String get seeAll => _l10n.seeAll;
  static String get categories => _l10n.categories;
  static String get myAppointment => _l10n.myAppointment;
  static String get upcoming => _l10n.upcoming;
  static String get completed => _l10n.completed;
  static String get bookAppointment => _l10n.bookAppointment;
  static String get selectDate => _l10n.selectDate;
  static String get selectHour => _l10n.selectHour;
  static String get next => _l10n.next;
  static String get cancel => _l10n.cancel;
  static String get submit => _l10n.submit;
  static String get update => _l10n.update;
  static String get reviews => _l10n.reviews;
  static String get reschedule => _l10n.reschedule;
  static String get viewDetail => _l10n.viewDetail;
  static String get workingTime => _l10n.workingTime;
  static String get aboutMe => _l10n.aboutMe;
  static String get patientDetails => _l10n.patientDetails;
  static String get fullName => _l10n.fullName;
  static String get dateOfBirth => _l10n.dateOfBirth;
  static String get weight => _l10n.weight;
  static String get writeYourSymptoms => _l10n.writeYourSymptoms;
  static String get gender => _l10n.gender;
  static String get blood => _l10n.blood;
  static String get addNewCard => _l10n.addNewCard;
  static String get cardName => _l10n.cardName;
  static String get cardNumber => _l10n.cardNumber;
  static String get expiryDate => _l10n.expiryDate;
  static String get cvv => _l10n.cvv;
  static String get payments => _l10n.payments;
  static String get selectPaymentMethod => _l10n.selectPaymentMethod;
  static String get aboutApp => _l10n.aboutApp;
  static String get notification => _l10n.notification;
  // static String get language => _l10n.language;
  static String get changePassword => _l10n.changePassword;
  static String get faqs => _l10n.faqs;
  static String get help => _l10n.help;
  static String get logout => _l10n.logout;
  static String get yourAge => _l10n.yourAge;
  static String get writeReview => _l10n.writeReview;
  static String get sendMail => _l10n.sendMail;
  static String get editProfile => _l10n.editProfile;
  static String get emailID => _l10n.emailID;
}
