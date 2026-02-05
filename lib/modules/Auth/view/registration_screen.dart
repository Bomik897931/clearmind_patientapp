import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../widgets/custom_dropdown.dart';
import '../../../widgets/textWidget.dart';

import '../controllers/auth_controller.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    bool isChecked = false;

    // For REsponsive
    const double referenceHeight = 800;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.extraPrimaryLight,
      // appBar: AppBar(title: const Text('Create Account')),
      // body: SafeArea(
      //   child: SingleChildScrollView(
      //     padding: const EdgeInsets.all(24.0),
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       crossAxisAlignment: CrossAxisAlignment.stretch,
      //       children: [
      //         Icon(
      //           Icons.person_add,
      //           size: 80,
      //           color: Theme.of(context).primaryColor,
      //         ),
      //         const SizedBox(height: 16),
      //         Text(
      //           'Sign Up',
      //           style: Theme.of(context).textTheme.headlineMedium?.copyWith(
      //             fontWeight: FontWeight.bold,
      //           ),
      //           textAlign: TextAlign.center,
      //         ),
      //         const SizedBox(height: 8),
      //         Text(
      //           'Create your account',
      //           style: Theme.of(
      //             context,
      //           ).textTheme.bodyLarge?.copyWith(color: AppColors.grey600),
      //           textAlign: TextAlign.center,
      //         ),
      //         const SizedBox(height: 48),

      //         // Name Field
      //         TextField(
      //           controller: authController.firstNameController,
      //           keyboardType: TextInputType.name,
      //           decoration: InputDecoration(
      //             labelText: 'Full Name',
      //             hintText: 'Enter your full name',
      //             prefixIcon: const Icon(Icons.person_outlined),
      //             border: OutlineInputBorder(
      //               borderRadius: BorderRadius.circular(12),
      //             ),
      //           ),
      //         ),
      //         const SizedBox(height: 16),

      //         // Email Field
      //         TextField(
      //           controller: authController.emailController,
      //           keyboardType: TextInputType.emailAddress,
      //           decoration: InputDecoration(
      //             labelText: 'Email',
      //             hintText: 'Enter your email',
      //             prefixIcon: const Icon(Icons.email_outlined),
      //             border: OutlineInputBorder(
      //               borderRadius: BorderRadius.circular(12),
      //             ),
      //           ),
      //         ),
      //         const SizedBox(height: 16),

      //         // Password Field
      //         Obx(
      //           () => TextField(
      //             controller: authController.passwordController,
      //             obscureText: authController.obscurePassword.value,
      //             decoration: InputDecoration(
      //               labelText: 'Password',
      //               hintText: 'Enter your password',
      //               prefixIcon: const Icon(Icons.lock_outlined),
      //               suffixIcon: IconButton(
      //                 icon: Icon(
      //                   authController.obscurePassword.value
      //                       ? Icons.visibility_outlined
      //                       : Icons.visibility_off_outlined,
      //                 ),
      //                 onPressed: authController.togglePasswordVisibility,
      //               ),
      //               border: OutlineInputBorder(
      //                 borderRadius: BorderRadius.circular(12),
      //               ),
      //             ),
      //           ),
      //         ),
      //         const SizedBox(height: 16),

      //         // Confirm Password Field
      //         Obx(
      //           () => TextField(
      //             controller: authController.confirmPasswordController,
      //             obscureText: authController.obscureConfirmPassword.value,
      //             decoration: InputDecoration(
      //               labelText: 'Confirm Password',
      //               hintText: 'Confirm your password',
      //               prefixIcon: const Icon(Icons.lock_outlined),
      //               suffixIcon: IconButton(
      //                 icon: Icon(
      //                   authController.obscureConfirmPassword.value
      //                       ? Icons.visibility_outlined
      //                       : Icons.visibility_off_outlined,
      //                 ),
      //                 onPressed: authController.toggleConfirmPasswordVisibility,
      //               ),
      //               border: OutlineInputBorder(
      //                 borderRadius: BorderRadius.circular(12),
      //               ),
      //             ),
      //           ),
      //         ),
      //         const SizedBox(height: 24),

      //         // Register Button
      //         Obx(
      //           () => SizedBox(
      //             height: 50,
      //             child: ElevatedButton(
      //               onPressed: authController.isLoading.value
      //                   ? null
      //                   : authController.register,
      //               style: ElevatedButton.styleFrom(
      //                 shape: RoundedRectangleBorder(
      //                   borderRadius: BorderRadius.circular(12),
      //                 ),
      //               ),
      //               child: authController.isLoading.value
      //                   ? const CircularProgressIndicator(
      //                       color: AppColors.white,
      //                     )
      //                   : const Text('Sign Up', style: TextStyle(fontSize: 16)),
      //             ),
      //           ),
      //         ),
      //         const SizedBox(height: 16),

      //         // Login Link
      //         Row(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             Text(
      //               'Already have an account? ',
      //               style: TextStyle(color: AppColors.grey600),
      //             ),
      //             TextButton(
      //               onPressed: () => Get.toNamed('/login'),
      //               child: const Text('Login'),
      //             ),
      //           ],
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: screenHeight * 8 / referenceHeight),
            Center(
              child: mediumtext(
                text: "Register",
                fontsize: 18,
                color: AppColors.primaryLight,
              ),
            ),
            SizedBox(height: screenHeight * 24 / referenceHeight),
            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 24,
                  left: 16,
                  right: 16,
                  top: 16,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    mediumtext(
                      text: "Welcome",
                      fontsize: 16,
                      color: AppColors.primaryLight,
                    ),
                    SizedBox(height: screenHeight * 4 / referenceHeight),
                    mediumtext(
                      text: "Create Your Account To Get Started.",
                      fontsize: 12,
                      color: AppColors.grey300,
                    ),
                    SizedBox(height: screenHeight * 24 / referenceHeight),
                    textfieldlabel("Full Name*"),
                    SizedBox(height: screenHeight * 8 / referenceHeight),
                    Container(
                      height: screenHeight * 40 / referenceHeight,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: authController.firstNameController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          fillColor: AppColors.white,
                          hintText: 'Enter Your Full Name',
                          hintStyle: AppTextStyles.bodySmallGrey,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 13,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 16 / referenceHeight),
                    textfieldlabel("Age*"),
                    SizedBox(height: screenHeight * 8 / referenceHeight),
                    Container(
                      height: screenHeight * 40 / referenceHeight,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: authController.firstNameController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          fillColor: AppColors.white,
                          hintText: 'Enter Your Age',
                          hintStyle: AppTextStyles.bodySmallGrey,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 13,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 16 / referenceHeight),
                    textfieldlabel("Gender*"),
                    SizedBox(height: screenHeight * 8 / referenceHeight),
                    Obx(
                      () => CommonDropdown(
                        value: authController.selectedGender.value.isEmpty
                            ? null
                            : authController.selectedGender.value,
                        hint: 'Select Your Gender',
                        items: const ['Male', 'Female', 'Other'],
                        onChanged: (val) {
                          authController.selectedGender.value = val!;
                        },
                      ),
                    ),
                    SizedBox(height: screenHeight * 16 / referenceHeight),
                    textfieldlabel("Phone Number*"),
                    SizedBox(height: screenHeight * 8 / referenceHeight),
                    Container(
                      height: screenHeight * 40 / referenceHeight,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: authController.phoneController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          fillColor: AppColors.white,
                          hintText: "Enter Your Phone Number",
                          hintStyle: AppTextStyles.bodySmallGrey,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 13,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 16 / referenceHeight),
                    textfieldlabel("Email Id"),
                    SizedBox(height: screenHeight * 8 / referenceHeight),
                    Container(
                      height: screenHeight * 40 / referenceHeight,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: authController.emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          fillColor: AppColors.white,
                          hintText: "Enter Your Email Id",
                          hintStyle: AppTextStyles.bodySmallGrey,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 16 / referenceHeight),
                    textfieldlabel("Language*"),
                    SizedBox(height: screenHeight * 8 / referenceHeight),

                    Obx(
                      () => CommonDropdown(
                        value: authController.selectedLanguage.value.isEmpty
                            ? null
                            : authController.selectedLanguage.value,
                        hint: 'Select Language',
                        items: const ['English', 'Hindi'],
                        onChanged: (val) {
                          authController.selectedLanguage.value = val!;
                        },
                      ),
                    ),
                    SizedBox(height: screenHeight * 8 / referenceHeight),
                    mediumtext(
                      text: "Choose The Language You Prefer To Use The App",
                      fontsize: 10,
                      color: AppColors.grey300,
                    ),

                    SizedBox(height: screenHeight * 24 / referenceHeight),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Obx(
                          () => Checkbox(
                            value: authController.isChecked.value,
                            onChanged: (value) {
                              authController.isChecked.value = value!;
                            },
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'By clicking, I accept the ',
                            style: TextStyle(
                              fontSize: 10,
                              color: AppColors.grey300,
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.w500,
                            ),
                            children: [
                              TextSpan(
                                text: 'Terms & Conditions ',
                                style: TextStyle(
                                  color: AppColors.primaryLight,
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: '& ',
                                style: TextStyle(
                                  color: AppColors.grey300,
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: TextStyle(
                                  color: AppColors.primaryLight,
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 40 / referenceHeight),
                    GestureDetector(
                      onTap: () => Get.toNamed('/home'),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 11,
                          horizontal: 112,
                        ),
                        height: screenHeight * 40 / referenceHeight,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Center(
                          child: Text("Register", style: AppTextStyles.button),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 16 / referenceHeight),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account ? ",
                          style: AppTextStyles.bodySmallGrey,
                        ),
                        // SizedBox(width: 6),
                        GestureDetector(
                          onTap: () => Get.toNamed('/login'),
                          child: Text(
                            'Log In',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryLight,
                              fontFamily: "Quicksand",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget textfieldlabel(String label) {
    // return Text("$label*", style: AppTextStyles.bodySmall);
    return mediumtext(text: label, fontsize: 12, color: AppColors.textPrimary);
  }
}
