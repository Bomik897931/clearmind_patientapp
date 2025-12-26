import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_app/core/constants/app_colors.dart';
// import 'package:patient_app/data/services/notification/send_notification.dart';

import '../../../core/constants/constant.dart';
import '../../../data/services/notification_service.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/textWidget.dart';
import '../../../widgets/text_box.dart';
import '../controllers/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.primary,
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Column(
          children: [
            SizedBox(height: height * .20),
            Stack(
              alignment: Alignment.topCenter,
              clipBehavior: Clip.none,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  height: height * .80,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 100),
                          TextField(
                            controller: authController.firstNameController,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              labelText: 'User Name',
                              hintText: 'Enter your name',
                              prefixIcon: const Icon(Icons.person_outlined),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          // textbox(
                          //     hinttext: "User Name",
                          //     icon: CupertinoIcons.person_circle),
                          const SizedBox(height: 25),
                          Obx(
                            () => TextField(
                              controller: authController.passwordController,
                              obscureText: authController.obscurePassword.value,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                hintText: 'Enter your password',
                                prefixIcon: const Icon(Icons.lock_outlined),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    authController.obscurePassword.value
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                  ),
                                  onPressed:
                                      authController.togglePasswordVisibility,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          // textbox(
                          //     hinttext: "Password",
                          //     icon: Icons.visibility_outlined),
                          const SizedBox(height: 5),
                          Align(
                            alignment: Alignment.topRight,
                            child: regulartext(
                              text: 'Forgot Password?',
                              fontsize: 12,
                              textAlign: TextAlign.end,
                            ),
                          ),
                          const SizedBox(height: 50),
                          primaryButton(
                            buttontext: "Log in",
                            ontap: () {
                              authController.login();
                              // Get.toNamed('/home');
                              // Get.to(() => const SelectCountryScreen());
                            },
                          ),
                          const SizedBox(height: 30),
                          // regulartext(text: "Or Continue With", fontsize: 12),
                          // const SizedBox(
                          //   height: 25,
                          // ),
                          const SizedBox(height: 16),

                          // Login Link
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'If you dont have an account? ',
                                style: TextStyle(color: AppColors.grey600),
                              ),
                              TextButton(
                                onPressed: () => Get.toNamed('/register'),
                                child: const Text('Register'),
                              ),
                            ],
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     IconButton(
                          //         onPressed: () {},
                          //         icon: SvgPicture.asset(google1)),
                          //     IconButton(
                          //         onPressed: () {},
                          //         icon: SvgPicture.asset(twitter1)),
                          //     IconButton(
                          //         onPressed: () {}, icon: SvgPicture.asset(fb1))
                          //   ],
                          // )
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: -50,
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primary, width: 5),
                      borderRadius: BorderRadius.circular(100),
                      color: AppColors.white,
                    ),
                    child: Center(
                      // child: Image.asset(
                      //   logo,
                      //   height: 50,
                      //   width: 50,
                      //   fit: BoxFit.fill,
                      // )
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    // return Scaffold(
    //   body: SafeArea(
    //     child: Center(
    //       child: SingleChildScrollView(
    //         padding: const EdgeInsets.all(24.0),
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           crossAxisAlignment: CrossAxisAlignment.stretch,
    //           children: [
    //             // Logo or Title
    //             Icon(
    //               Icons.video_call,
    //               size: 80,
    //               color: Theme.of(context).primaryColor,
    //             ),
    //             const SizedBox(height: 16),
    //             Text(
    //               'Welcome Back',
    //               style: Theme.of(context).textTheme.headlineMedium?.copyWith(
    //                 fontWeight: FontWeight.bold,
    //               ),
    //               textAlign: TextAlign.center,
    //             ),
    //             const SizedBox(height: 8),
    //             Text(
    //               'Sign in to continue',
    //               style: Theme.of(
    //                 context,
    //               ).textTheme.bodyLarge?.copyWith(color: AppColors.grey600),
    //               textAlign: TextAlign.center,
    //             ),
    //             const SizedBox(height: 48),
    //
    //             // Email Field
    //             TextField(
    //               controller: authController.emailController,
    //               keyboardType: TextInputType.emailAddress,
    //               decoration: InputDecoration(
    //                 labelText: 'Email',
    //                 hintText: 'Enter your email',
    //                 prefixIcon: const Icon(Icons.email_outlined),
    //                 border: OutlineInputBorder(
    //                   borderRadius: BorderRadius.circular(12),
    //                 ),
    //               ),
    //             ),
    //             const SizedBox(height: 16),
    //
    //             // Password Field
    //             Obx(
    //               () => TextField(
    //                 controller: authController.passwordController,
    //                 obscureText: authController.obscurePassword.value,
    //                 decoration: InputDecoration(
    //                   labelText: 'Password',
    //                   hintText: 'Enter your password',
    //                   prefixIcon: const Icon(Icons.lock_outlined),
    //                   suffixIcon: IconButton(
    //                     icon: Icon(
    //                       authController.obscurePassword.value
    //                           ? Icons.visibility_outlined
    //                           : Icons.visibility_off_outlined,
    //                     ),
    //                     onPressed: authController.togglePasswordVisibility,
    //                   ),
    //                   border: OutlineInputBorder(
    //                     borderRadius: BorderRadius.circular(12),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //             const SizedBox(height: 24),
    //
    //             // Login Button
    //             Obx(
    //               () => SizedBox(
    //                 height: 50,
    //                 child: ElevatedButton(
    //                   onPressed: authController.isLoading.value
    //                       ? null
    //                       : authController.login,
    //                   style: ElevatedButton.styleFrom(
    //                     shape: RoundedRectangleBorder(
    //                       borderRadius: BorderRadius.circular(12),
    //                     ),
    //                   ),
    //                   child: authController.isLoading.value
    //                       ? const CircularProgressIndicator(color: AppColors.white)
    //                       : const Text('Login', style: TextStyle(fontSize: 16)),
    //                 ),
    //               ),
    //             ),
    //             const SizedBox(height: 16),
    //
    //             // Register Link
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 Text(
    //                   "Don't have an account? ",
    //                   style: TextStyle(color: AppColors.grey600),
    //                 ),
    //                 TextButton(
    //                   onPressed: () => Get.toNamed('/register'),
    //                   child: const Text('Sign Up'),
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
