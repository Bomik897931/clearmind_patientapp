class ApiConstants {
  // Replace with your actual .NET backend URL
  static const String baseUrl = 'http://erabdulg-001-site21.anytempurl.com/api/';

  //Firebase
  static const String registerDeviceEndpoint = 'Patient/register-userDevice';
  // // Auth Endpoints
  static const String registerEndpoint = 'Patient/register-patient';
  static const String loginEndpoint = 'auth/login';
  static const String getProfileEndpoint = 'Auth/my-profile';
  static const String updateProfileEndpoint = 'Patient/update-myprofile';

  static const String getSlotsEndpoint = 'Patient/all-slots';
  static const String bookAppointmentEndpoint = 'Patient/book-appointment';
  static const String doctorSlotsEndpoint = 'Patient/doctor-slots';
  static const String cancelAppointmentEndpoint = 'Patient/cancel-appointment';
  static const String getAppointmentsEndpoint = 'Patient/my-appointmentsPnt';// Update with your endpoint// Update with your endpoint
  static const String addReviewEndpoint = 'Patient/add-review';
  static const String getReviewsEndpoint = 'Patient/get-reviews';
  static const String getFavoriteDoctorsEndpoint = 'Patient/get-doctor-wishlist';
  static const String notificationsEndpoint = 'Patient/get-notification';
  static const String markNotificationReadEndpoint = 'Patient/mark-notification-read';

  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh-token';

  //Doctor Endpoints
  static const String getDoctorsEndpoint = 'Patient/all-doctor';
  static const String getDoctorByIdEndpoint = 'Patient/getDoctorById';
  static const String getSpecializationsEndpoint = 'Patient/get-doctorSpecialization';
  static const String addFavoriteEndpoint = 'Patient/add-doctor-wishlist';
  static const String removeFavoriteEndpoint = 'Patient/remove-doctor-wishlist';


  // User Endpoints
  static const String profile = '/user/profile';
  static const String updateProfile = '/user/update';

  // Video Call Endpoints
  static const String getAgoraToken = '/video/get-token';
  static const String startCall = '/video/start-call';
  static const String endCall = '/video/end-call';
  static const String callHistory = '/video/history';





  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // Agora Configuration
  static const String agoraAppId = '4db547526f3247f48c47958b706e0b9b';
  // static const String agoraAppId = 'Y6203f525327e4b42b6958ae822a30d5b';

  // Test mode: Set to true to skip backend API calls
  static const bool testMode = true; // ← Add this line

  // Headers
  static Map<String, String> getHeaders({String? token}) {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }
}
