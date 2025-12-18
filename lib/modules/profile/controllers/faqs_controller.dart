import 'package:get/get.dart';

class FaqsController extends GetxController {
  final RxList<Map<String, dynamic>> faqs = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadFAQs();
  }

  void loadFAQs() {
    faqs.value = [
      {
        'question': 'Are there any type of doctors who are not ?',
        'answer':
            'Yes, there are various types of specialized doctors available in our platform. We have general practitioners, specialists, and super-specialists across multiple medical fields.',
        'isExpanded': false,
      },
      {
        'question': 'How do the unlimited online consultations work',
        'answer':
            'Unlimited online consultations allow you to connect with doctors anytime through video call, voice call, or chat messaging based on your subscription plan.',
        'isExpanded': false,
      },
      {
        'question': 'How many online consultations can I use?',
        'answer':
            'You can use unlimited consultations based on your active subscription plan. There are no restrictions on the number of consultations per month.',
        'isExpanded': false,
      },
      {
        'question': 'Will family members can be able to use my account?',
        'answer':
            'Yes, you can add up to 5 family members to your account. Each family member will have their own profile and medical history.',
        'isExpanded': false,
      },
      {
        'question':
            'How many members can be part of one Doctor Point Pro Membership?',
        'answer':
            'Up to 5 family members can be added to one Doctor Point Pro Membership account at no additional cost.',
        'isExpanded': false,
      },
    ];
  }

  void toggleExpanded(int index) {
    faqs[index]['isExpanded'] = !faqs[index]['isExpanded'];
    faqs.refresh();
  }
}
