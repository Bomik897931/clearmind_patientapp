import 'package:get/get.dart';
import '../../languageswitcher.dart';
import '../../modules/Auth/controllers/splash_controller.dart';
import '../../modules/Auth/view/login_screen.dart';
import '../../modules/Auth/view/onboardingPage.dart';
import '../../modules/Auth/view/otp_screen.dart';
import '../../modules/Auth/view/registration_screen.dart';
import '../../modules/Auth/view/splash_screen.dart';
import '../../modules/Cart/controller/MyPrescriptions_Controller.dart';
import '../../modules/Cart/controller/cart_controller.dart';
import '../../modules/Cart/views/cart.dart';
import '../../modules/Cart/views/prescription_screen.dart';
import '../../modules/address/controller/editaddress_controller.dart';
import '../../modules/address/controller/save_address_controller.dart';
import '../../modules/address/view/editAddress_view.dart';
import '../../modules/address/view/save_address_view.dart';
import '../../modules/appointments/controllers/book_appointment_controller.dart';
import '../../modules/appointments/controllers/my_appointments_controller.dart';
import '../../modules/appointments/controllers/patient_details_controller.dart';
import '../../modules/appointments/views/book_appointment_screen.dart';
import '../../modules/appointments/views/my_appointments_screen.dart';
import '../../modules/appointments/views/patient_details_screen.dart';
import '../../modules/categories/controllers/categories_controller.dart';
import '../../modules/categories/views/categories_screen.dart';
import '../../modules/consultation/controllers/appointment_detail_controller.dart';
import '../../modules/consultation/controllers/chat_controller.dart';
import '../../modules/consultation/controllers/consultation_end_controller.dart';
import '../../modules/consultation/views/appointment_detail_screen.dart';
import '../../modules/consultation/views/chat_screen.dart';
import '../../modules/consultation/views/consultation_end_screen.dart';
import '../../modules/doctors/controllers/doctor_detail_controller.dart';
import '../../modules/doctors/controllers/top_doctors_controller.dart';
import '../../modules/doctors/views/doctor_detail_screen.dart';
import '../../modules/doctors/views/top_doctors_screen.dart';
import '../../modules/favorite/controller/favorite_controller.dart';
import '../../modules/favorite/view/favorite_screen.dart';
import '../../modules/home/controller/home_controller.dart';
import '../../modules/home/views/home_screen.dart';
import '../../modules/incomingCall/view/incoming_call_screen.dart';
import '../../modules/medicalReports/controller/medical_reports_controller.dart';
import '../../modules/medicalReports/view/medical_reports_screen.dart';
import '../../modules/myOrders/controllers/my_orders_controller.dart';
import '../../modules/myOrders/controllers/order_details_controller.dart';
import '../../modules/myOrders/views/my_orders_screen.dart';
import '../../modules/myOrders/views/order_details_screen.dart';
import '../../modules/notifications/controller/notification_controller.dart';
import '../../modules/notifications/views/notification_screen.dart';
import '../../modules/payments/controllers/add_card_controller.dart';
import '../../modules/payments/controllers/payment_controller.dart';
import '../../modules/payments/views/add_card_screen.dart';
import '../../modules/payments/views/payment_screen.dart';
import '../../modules/profile/controllers/edit_profile_controller.dart';
import '../../modules/profile/controllers/faqs_controller.dart';
import '../../modules/profile/controllers/help_controller.dart';
import '../../modules/profile/controllers/profile_controller.dart';
import '../../modules/profile/views/edit_profile_screen.dart';
import '../../modules/profile/views/faqs_screen.dart';
import '../../modules/profile/views/help_screen.dart';
import '../../modules/profile/views/profile_screen.dart';
import '../../modules/review/controller/review_confirm_controller.dart';
import '../../modules/review/controller/review_controller.dart';
import '../../modules/review/controller/review_list_controller.dart';
import '../../modules/review/views/review_confirm_screen.dart';
import '../../modules/review/views/review_list_screen.dart';
import '../../modules/review/views/review_screen.dart';
import '../../modules/slot/controller/slot_controller.dart';
import '../../modules/slot/view/slot_screen.dart';
import '../../modules/videoscreen/view/test_video_screen.dart';
import '../../modules/videoscreen/view/video_call_screen.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  // static const String login = '/login';
  // static const String register = '/register';
  // static const String home = '/home';
  // static const String videoCall = '/video-call';

  static final pages = [
    GetPage(
      name: AppRoutes.test, // Add this
      page: () => const TestVideoScreen(),
      transition: Transition.fadeIn,
    ),

    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<SplashController>(() => SplashController());
      }),
    ),
    GetPage(
      name: AppRoutes.ONBOARDVIEW,
      page: () => const OnboardingPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<SplashController>(() => SplashController());
      }),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.otpScreen,
      page: () => const OtpScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.register,
      page: () =>  RegisterScreen(),
      transition: Transition.rightToLeft,
    ),
    // GetPage(
    //   name: AppRoutes.home,
    //   page: () => const HomeVCScreen(),
    //   transition: Transition.fadeIn,
    // ),
    GetPage(
      name: AppRoutes.videoCall,
      page: () => const VideoCallScreen(),
      // binding: BindingsBuilder(() {
      //   Get.lazyPut(() => VideoCallController());
      // }),
      transition: Transition.zoom,
    ),

    GetPage(
      name: AppRoutes.incomingCall, // ADD THIS
      page: () => const IncomingCallScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => const HomeScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => HomeController());
      }),
    ),
    GetPage(
      name: AppRoutes.CATEGORIES,
      page: () => const DoctorsBySpecializationScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => DoctorsBySpecializationController());
      }),
    ),
    GetPage(
      name: AppRoutes.TOP_DOCTORS,
      page: () => const TopDoctorsScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => TopDoctorsController());
      }),
    ),
    GetPage(
      name: AppRoutes.DOCTOR_DETAIL,
      page: () => const DoctorDetailScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => DoctorDetailController());
      }),
    ),
    GetPage(
      name: AppRoutes.MY_APPOINTMENTS,
      page: () => const MyAppointmentsScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => MyAppointmentsController());
      }),
    ),
    GetPage(
      name: AppRoutes.BOOK_SLOT,
      page: () => const SlotsScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => SlotsController());
      }),
    ),
    GetPage(
      name: AppRoutes.BOOK_APPOINTMENT,
      page: () => const BookAppointmentScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => BookAppointmentController());
      }),
    ),
    GetPage(
      name: AppRoutes.PATIENT_DETAILS,
      page: () => const PatientDetailsScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => PatientDetailsController());
      }),
    ),
    GetPage(
      name: AppRoutes.ADD_CARD,
      page: () => const AddCardScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => AddCardController());
      }),
    ),
    GetPage(
      name: AppRoutes.PAYMENT,
      page: () => const PaymentScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => PaymentController());
      }),
    ),
    GetPage(
      name: AppRoutes.APPOINTMENT_DETAIL,
      page: () => const AppointmentDetailScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => AppointmentDetailController());
      }),
    ),
    // GetPage(
    //   name: AppRoutes.VIDEO_CALL,
    //   page: () => const VideoCallScreen(),
    //   binding: BindingsBuilder(() {
    //     Get.lazyPut(() => VideoCallController());
    //   }),
    // ),
    GetPage(
      name: AppRoutes.CHAT,
      page: () => const ChatScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ChatController());
      }),
    ),
    GetPage(
      name: AppRoutes.CONSULTATION_END,
      page: () => const ConsultationEndScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ConsultationEndController());
      }),
    ),
    GetPage(
      name: AppRoutes.PROFILE,
      page: () => const ProfileScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ProfileController());
      }),
    ),
    GetPage(
      name: AppRoutes.EDIT_PROFILE,
      page: () => const EditProfileScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => EditProfileController());
      }),
    ),
    // GetPage(
    //   name: AppRoutes.WRITE_REVIEW,
    //   page: () => const WriteReviewScreen(),
    //   binding: BindingsBuilder(() {
    //     Get.lazyPut(() => WriteReviewController());
    //   }),
    // ),
    GetPage(
      name: AppRoutes.FAQS,
      page: () => const FaqsScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => FaqsController());
      }),
    ),
    GetPage(
      name: AppRoutes.HELP,
      page: () => const HelpScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => HelpController());
      }),
    ),
    GetPage(
      name: AppRoutes.WRITE_REVIEW,
      page: () => const ReviewScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ReviewController());
      }),
    ),

    // Reviews List Screen
    GetPage(
      name: AppRoutes.REVIEWS_LIST,
      page: () => const ReviewsListScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ReviewsListController());
      }),
    ),
    GetPage(
      name: AppRoutes.FAVORITE_DOCTORS,
      page: () => const FavoriteDoctorsScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => FavoriteDoctorsController());
      }),
    ),
    GetPage(
      name: AppRoutes.NOTIFICATIONS,
      page: () => const NotificationScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => NotificationController());
      }),
    ),
    GetPage(
      name: AppRoutes.REVIEW_CONFIRM,
      page: () => const ReviewConfirmScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ReviewConfirmController());
      }),
    ),
    GetPage(name: AppRoutes.LanguageSwitcher, page: () => LanguageSwitcher()),
    GetPage(
      name: AppRoutes.CartScreen,
      page: () => CartScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => CartController());
      }),
    ),
    GetPage(
      name: AppRoutes.Prescription,
      page: () => MyPrescriptionsScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => MyPrescriptionsController());
      }),
    ),
    GetPage(
      name: AppRoutes.MedicalReport,
      page: () => MedicalReportScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => MedicalReportController());
      }),
    ),
    GetPage(
      name: AppRoutes.MyOrders,
      page: () => MyOrdersScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => MyOrdersController());
      }),
    ),
    GetPage(
      name: AppRoutes.OrdersDetails,
      page: () => OrderDetailsScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => OrderDetailsController());
      }),
    ),
    GetPage(
      name: AppRoutes.editAddress,
      page: () => const EditAddressView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<EditAddressController>(
              () => EditAddressController(),
        );
      }),
    ),
    GetPage(
      name: AppRoutes.SaveAddress,
      page: () => const SaveAddressView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<SaveAddressController>(
              () => SaveAddressController(),
        );
      }),
    ),
  ];
}
