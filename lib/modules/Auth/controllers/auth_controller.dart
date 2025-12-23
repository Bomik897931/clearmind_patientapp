// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:patient_app/data/services/StorageService.dart';
// import 'package:patient_app/data/services/api_service.dart';
//
// import '../../../data/models/uservc_model.dart';
//
// class AuthController extends GetxController {
//   final _apiService = ApiService();
//   final _storage = Get.find<StorageService>();
//
//   final Rx<UserVCModel?> currentUser = Rx<UserVCModel?>(null);
//   final RxBool isLoading = false.obs;
//   final RxBool isLoggedIn = false.obs;
//
//   // Form Controllers
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final nameController = TextEditingController();
//   final confirmPasswordController = TextEditingController();
//
//   final RxBool obscurePassword = true.obs;
//   final RxBool obscureConfirmPassword = true.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     checkLoginStatus();
//   }
//
//   @override
//   void onClose() {
//     emailController.dispose();
//     passwordController.dispose();
//     nameController.dispose();
//     confirmPasswordController.dispose();
//     super.onClose();
//   }
//
//   void checkLoginStatus() {
//     isLoggedIn.value = _storage.isLoggedIn();
//     if (isLoggedIn.value) {
//       currentUser.value = _storage.getUser();
//     }
//   }
//
//   Future<void> login() async {
//     if (!_validateLoginForm()) return;
//
//     try {
//       isLoading.value = true;
//
//       final user = await _apiService.login(
//         emailController.text.trim(),
//         passwordController.text,
//       );
//
//       currentUser.value = user;
//       await _storage.saveUser(user);
//       isLoggedIn.value = true;
//
//       Get.snackbar(
//         'Success',
//         'Login successful!',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: AppColors.green,
//         colorText: AppColors.white,
//       );
//
//       Get.offAllNamed('/home');
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         e.toString(),
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: AppColors.red,
//         colorText: AppColors.white,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   Future<void> register() async {
//     if (!_validateRegisterForm()) return;
//
//     try {
//       isLoading.value = true;
//
//       final user = await _apiService.register(
//         nameController.text.trim(),
//         emailController.text.trim(),
//         passwordController.text,
//       );
//
//       currentUser.value = user;
//       await _storage.saveUser(user);
//       isLoggedIn.value = true;
//
//       Get.snackbar(
//         'Success',
//         'Registration successful!',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: AppColors.green,
//         colorText: AppColors.white,
//       );
//
//       Get.offAllNamed('/home');
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         e.toString(),
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: AppColors.red,
//         colorText: AppColors.white,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   Future<void> logout() async {
//     try {
//       isLoading.value = true;
//       await _apiService.logout();
//
//       currentUser.value = null;
//       isLoggedIn.value = false;
//
//       // Clear form fields
//       emailController.clear();
//       passwordController.clear();
//       nameController.clear();
//       confirmPasswordController.clear();
//
//       Get.offAllNamed('/login');
//
//       Get.snackbar(
//         'Success',
//         'Logged out successfully',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         e.toString(),
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: AppColors.red,
//         colorText: AppColors.white,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   bool _validateLoginForm() {
//     if (emailController.text.trim().isEmpty) {
//       Get.snackbar('Error', 'Please enter email');
//       return false;
//     }
//     if (!GetUtils.isEmail(emailController.text.trim())) {
//       Get.snackbar('Error', 'Please enter valid email');
//       return false;
//     }
//     if (passwordController.text.isEmpty) {
//       Get.snackbar('Error', 'Please enter password');
//       return false;
//     }
//     return true;
//   }
//
//   bool _validateRegisterForm() {
//     if (nameController.text.trim().isEmpty) {
//       Get.snackbar('Error', 'Please enter name');
//       return false;
//     }
//     if (emailController.text.trim().isEmpty) {
//       Get.snackbar('Error', 'Please enter email');
//       return false;
//     }
//     if (!GetUtils.isEmail(emailController.text.trim())) {
//       Get.snackbar('Error', 'Please enter valid email');
//       return false;
//     }
//     if (passwordController.text.isEmpty) {
//       Get.snackbar('Error', 'Please enter password');
//       return false;
//     }
//     if (passwordController.text.length < 6) {
//       Get.snackbar('Error', 'Password must be at least 6 characters');
//       return false;
//     }
//     if (confirmPasswordController.text.isEmpty) {
//       Get.snackbar('Error', 'Please confirm password');
//       return false;
//     }
//     if (passwordController.text != confirmPasswordController.text) {
//       Get.snackbar('Error', 'Passwords do not match');
//       return false;
//     }
//     return true;
//   }
//
//   void togglePasswordVisibility() {
//     obscurePassword.value = !obscurePassword.value;
//   }
//
//   void toggleConfirmPasswordVisibility() {
//     obscureConfirmPassword.value = !obscureConfirmPassword.value;
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_app/data/models/register_response.dart';

import '../../../core/constants/app_colors.dart';
import '../../../data/models/register_request.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/user_repository.dart';
import '../../../data/services/StorageService.dart';
import '../../../data/services/api_service.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepository;
  final StorageService _storage;

  AuthController({
    AuthRepository? authRepository,
    StorageService? storage,
  })  : _authRepository = authRepository ?? AuthRepository(),
        _storage = storage ?? StorageService();

  // Observable variables
  final isLoading = false.obs;
  final isLoggedIn = false.obs;
  final RxBool obscurePassword = true.obs;
  final RxBool obscureConfirmPassword = true.obs;
  final Rx<User?> currentUser = Rx<User?>(null);

  // Text controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final bloodGroupController = TextEditingController();
  final emergencyContactController = TextEditingController();
  final insuranceDetailsController = TextEditingController();
  final streetController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final countryController = TextEditingController();
  final zipCodeController = TextEditingController();

  final selectedGender = 'male'.obs;
  final Rx<DateTime?> selectedDob = Rx<DateTime?>(null);

  final _apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    passwordController.clear();
    _checkLoginStatus();
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    bloodGroupController.dispose();
    emergencyContactController.dispose();
    insuranceDetailsController.dispose();
    streetController.dispose();
    cityController.dispose();
    stateController.dispose();
    countryController.dispose();
    zipCodeController.dispose();
    super.onClose();
  }

  Future<void> _checkLoginStatus() async {
    final user = await _storage.getUser();
    if (user != null) {
      currentUser.value = user;
      isLoggedIn.value = true;
    }
  }

  bool _validateRegisterForm() {
    if (firstNameController.text.trim().isEmpty) {
      _showError('Please enter your first name');
      return false;
    }

    // if (lastNameController.text.trim().isEmpty) {
    //   _showError('Please enter your last name');
    //   return false;
    // }

    if (emailController.text.trim().isEmpty) {
      _showError('Please enter your email');
      return false;
    }

    // if (!GetUtils.isEmail(emailController.text.trim())) {
    //   _showError('Please enter a valid email address');
    //   return false;
    // }

    // if (phoneController.text.trim().isEmpty) {
    //   _showError('Please enter your phone number');
    //   return false;
    // }

    if (passwordController.text.isEmpty) {
      _showError('Please enter a password');
      return false;
    }

    if (passwordController.text.length < 6) {
      _showError('Password must be at least 6 characters long');
      return false;
    }

    if (passwordController.text != confirmPasswordController.text) {
      _showError('Passwords do not match');
      return false;
    }

    // if (selectedDob.value == null) {
    //   _showError('Please select your date of birth');
    //   return false;
    // }
    //
    // if (bloodGroupController.text.trim().isEmpty) {
    //   _showError('Please enter your blood group');
    //   return false;
    // }
    //
    // if (emergencyContactController.text.trim().isEmpty) {
    //   _showError('Please enter emergency contact number');
    //   return false;
    // }
    //
    // if (streetController.text.trim().isEmpty ||
    //     cityController.text.trim().isEmpty ||
    //     stateController.text.trim().isEmpty ||
    //     countryController.text.trim().isEmpty ||
    //     zipCodeController.text.trim().isEmpty) {
    //   _showError('Please complete all address fields');
    //   return false;
    // }

    return true;
  }

  Future<void> register() async {
    if (!_validateRegisterForm()) return;

    try {
      isLoading.value = true;

      final request = RegisterRequest(
        // firstName: firstNameController.text.trim(),
        // lastName: lastNameController.text.trim(),
        // email: emailController.text.trim(),
        // phoneNumber: phoneController.text.trim(),
        // gender: selectedGender.value,
        // password: passwordController.text,
        // bloodGroup: bloodGroupController.text.trim(),
        // emergencyContact: emergencyContactController.text.trim(),
        // insuranceDetails: insuranceDetailsController.text.trim(),
        // profilePicUrl: null,
        // street: streetController.text.trim(),
        // city: cityController.text.trim(),
        // state: stateController.text.trim(),
        // country: countryController.text.trim(),
        // zipCode: zipCodeController.text.trim(),
        // dob: selectedDob.value!.toIso8601String(),

            firstName:  firstNameController.text.trim(),
            lastName:  "",
            email:  emailController.text.trim(),
            phoneNumber:  "9098909890",
            gender:  "male",
            password:  passwordController.text,
            bloodGroup:  "A+",
            emergencyContact:  "9098909890",
            insuranceDetails:  "insu",
            profilePicUrl:  "string",
            street:  "mall road",
            city:  "Aligarh",
            state:  "UP",
            country:  "India",
            zipCode:  "123333",
            dob:  "2025-12-03T07:19:55.096Z"



      );
      print(request);

      final response = await _authRepository.register(request);

      if (response.success) {
        // final user = RegisterResponse(
        //   userId: response.userId,
        //   firstName: firstNameController.text.trim(),
        //   lastName: lastNameController.text.trim(),
        //   email: emailController.text.trim(),
        //   role: response.role,
        // );
        //
        // currentUser.value = user;
        // await _storage.saveUser(user);
        isLoggedIn.value = true;

        _showSuccess(response.message);
        _clearForm();
        Get.offAllNamed('/home');
      } else {
        _showError(response.message);
      }
    } on RepositoryException catch (e) {
      _showError(e.message);
    } catch (e) {
      _showError('An unexpected error occurred. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  //
  // bool _validateLoginForm() {
  //   if (loginEmailController.text.trim().isEmpty) {
  //     _showError('Please enter your email');
  //     return false;
  //   }
  //
  //   if (!GetUtils.isEmail(loginEmailController.text.trim())) {
  //     _showError('Please enter a valid email address');
  //     return false;
  //   }
  //
  //   if (loginPasswordController.text.isEmpty) {
  //     _showError('Please enter your password');
  //     return false;
  //   }
  //
  //   return true;
  // }

  Future<void> login() async {
    if (!_validateLoginForm()) return;

    try {
      isLoading.value = true;

      print('🔵 Controller: Starting login...');

      final user = await _authRepository.login(
        firstNameController.text.trim(),
        passwordController.text.trim(),
        role: '', // Empty role as per your API requirement
      );

      print('🟢 Controller: Login successful, user: ${user.email}');

      currentUser.value = user;

      // Save token separately if needed
      if (user.token != null) {
        print('✅ Controller: Saving token');
        await _storage.saveToken(user.token!);
      }

      await _storage.saveUser(user);
      isLoggedIn.value = true;

      _showSuccess(user.fullName != null
          ? 'Welcome back, ${user.fullName}!'
          : 'Login successful!');

      // loginEmailController.clear();
      // loginPasswordController.clear();

      Get.offAllNamed('/home');
    } on RepositoryException catch (e) {
      print('🔴 Controller: RepositoryException - ${e.message}');
      _showError(e.message);
    } catch (e) {
      print('🔴 Controller: Unexpected error - $e');
      _showError('An unexpected error occurred. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }


  // Future<void> login() async {
  //   // if (!_validateRegisterForm()) return;
  //
  //   try {
  //     isLoading.value = true;
  //
  //   final String email = "Amir@gmail.com";
  //   final String password = "Amir@123";
  //
  //
  //   print("wertyuio");
  //     final response = await _authRepository.login(email,password);
  //
  //     if (response.message =='Login successful.') {
  //       final user = User(
  //         userId: response.userId,
  //         fullName: response.fullName,
  //         message: response.message,
  //         email: response.email,
  //         role: response.role,
  //       );
  //
  //       currentUser.value = user;
  //       await _storage.saveUser(user);
  //       isLoggedIn.value = true;
  //
  //       _showSuccess(response.message);
  //       _clearForm();
  //       Get.offAllNamed('/home');
  //     } else {
  //       print("wertyuio $response.message");
  //       _showError(response.message);
  //     }
  //   } on RepositoryException catch (e) {
  //     print("asdfghjkl $e");
  //     _showError(e.message);
  //   } catch (e) {
  //     _showError('An unexpected error occurred. Please try again.');
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }



  void _clearForm() {
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    phoneController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    bloodGroupController.clear();
    emergencyContactController.clear();
    insuranceDetailsController.clear();
    streetController.clear();
    cityController.clear();
    stateController.clear();
    countryController.clear();
    zipCodeController.clear();
    selectedGender.value = 'male';
    selectedDob.value = null;
  }

  void _showError(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.red,
      colorText: AppColors.white,
      duration: const Duration(seconds: 3),
    );
  }
    void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }
    void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword.value = !obscureConfirmPassword.value;
  }

  void _showSuccess(String message) {
    Get.snackbar(
      'Success',
      message.isEmpty ? 'Registration successful!' : message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.primaryLight,
      colorText: AppColors.white,
      duration: const Duration(seconds: 3),
    );
  }
  Future<void> logout() async {
    try {
      isLoading.value = true;
      // await _apiService.logout();

      currentUser.value = null;
      isLoggedIn.value = false;

      // Clear form fields
      emailController.clear();
      passwordController.clear();
      firstNameController.clear();
      confirmPasswordController.clear();

      Get.offAllNamed('/login');

      Get.snackbar(
        'Success',
        'Logged out successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }


  bool _validateLoginForm() {



    if (firstNameController.text.trim().isEmpty) {
      _showError('Please enter your email');
      return false;
    }



    if (passwordController.text.isEmpty) {
      _showError('Please enter a password');
      return false;
    }

    if (passwordController.text.length < 6) {
      _showError('Password must be at least 6 characters long');
      return false;
    }
    return true;
  }
}