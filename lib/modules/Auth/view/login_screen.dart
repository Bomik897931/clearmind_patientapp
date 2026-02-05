import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/constant.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/textWidget.dart';
import '../controllers/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final screenHeight = MediaQuery.of(context).size.height;
    const double referenceHeight = 800;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.extraPrimaryLight,
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SingleChildScrollView(
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
                                obscureText:
                                    authController.obscurePassword.value,
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
      ),

      // PRINCE

      // body: SafeArea(
      //   top: false,
      //   child: SingleChildScrollView(
      //     keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      //     // padding: EdgeInsets.only(bottom: mediaQuery.viewInsets.bottom),
      //     child: Column(
      //       children: [
      //         SizedBox(height: screenHeight * 24 / referenceHeight),
      //         Row(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             Image.asset(Assets.CMPng, height: 26, width: 48),
      //             SizedBox(width: 4),
      //             mediumtext(
      //               text: "CLARMINDS",
      //               fontsize: 18,
      //               color: AppColors.primary,
      //             ),
      //           ],
      //         ),
      //         SizedBox(height: screenHeight * 160 / referenceHeight),
      //         Image.asset(Assets.CMPng, height: 111, width: 204),
      //         SizedBox(height: screenHeight * 125 / referenceHeight),
      //         Container(
      //           height: screenHeight * 353 / referenceHeight,
      //           padding: EdgeInsets.only(
      //             bottom: 17,
      //             top: 24,
      //             left: 16,
      //             right: 15,
      //           ),
      //           decoration: BoxDecoration(
      //             color: AppColors.white,
      //             borderRadius: BorderRadius.only(
      //               topLeft: Radius.circular(28),
      //               topRight: Radius.circular(28),
      //             ),
      //           ),
      //           child: Column(
      //             children: [
      //               mediumtext(
      //                 text: "Sign In",
      //                 fontsize: 24,
      //                 color: AppColors.primaryLight,
      //               ),
      //               SizedBox(height: screenHeight * 24 / referenceHeight),
      //               Container(
      //                 height: screenHeight * 48 / referenceHeight,
      //                 child: TextField(
      //                   controller: authController.emailController,
      //                   keyboardType: TextInputType.emailAddress,
      //                   decoration: InputDecoration(
      //                     contentPadding: EdgeInsets.symmetric(
      //                       horizontal: 16,
      //                       vertical: 13,
      //                     ),
      //                     hintText: 'Phone Number',
      //                     hintStyle: AppTextStyles.bodySmallGrey,
      //                     border: OutlineInputBorder(
      //                       borderRadius: BorderRadius.circular(12),
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //               SizedBox(height: screenHeight * 16 / referenceHeight),
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.end,
      //                 children: [
      //                   Text(
      //                     "Don't have an account ?",
      //                     style: AppTextStyles.bodySmallGrey,
      //                   ),
      //                   SizedBox(width: 4),
      //                   GestureDetector(
      //                     onTap: () => Get.toNamed('/register'),
      //                     child: mediumtext(
      //                       text: "Register",
      //                       fontsize: 12,
      //                       color: AppColors.primaryLight,
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //               SizedBox(height: screenHeight * 40 / referenceHeight),
      //               GestureDetector(
      //                 onTap: () => Get.toNamed('/otpScreen'),
      //                 child: Container(
      //                   height: screenHeight * 40 / referenceHeight,
      //                   padding: EdgeInsets.symmetric(
      //                     vertical: 11,
      //                     horizontal: 112,
      //                   ),
      //                   decoration: BoxDecoration(
      //                     color: AppColors.primary,
      //                     borderRadius: BorderRadius.circular(24),
      //                   ),
      //                   child: Center(
      //                     child: Text("Sign In", style: AppTextStyles.button),
      //                   ),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
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
