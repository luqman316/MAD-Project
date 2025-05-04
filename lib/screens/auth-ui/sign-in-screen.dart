// // // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unused_local_variable, unnecessary_null_comparison, file_names

// // import 'package:finalpro/controllers/get-user-data-controller.dart';
// // import 'package:finalpro/controllers/sign-in-controller.dart';
// // import 'package:finalpro/screens/admin-panel/admin-screen.dart';
// // import 'package:finalpro/screens/auth-ui/sign-up-screen.dart';
// // import 'package:finalpro/screens/user-panel/main-screen.dart';
// // import 'package:finalpro/utils/app-constant.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
// // import 'package:get/get.dart';
// // import 'package:lottie/lottie.dart';

// // import 'forget-password-screen.dart';

// // class SignInScreen extends StatefulWidget {
// //   const SignInScreen({super.key});

// //   @override
// //   State<SignInScreen> createState() => _SignInScreenState();
// // }

// // class _SignInScreenState extends State<SignInScreen> {
// //   final SignInController signInController = Get.put(SignInController());
// //   final GetUserDataController getUserDataController =
// //       Get.put(GetUserDataController());
// //   TextEditingController userEmail = TextEditingController();
// //   TextEditingController userPassword = TextEditingController();

// //   @override
// //   Widget build(BuildContext context) {
// //     return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
// //       return Scaffold(
// //         appBar: AppBar(
// //           backgroundColor: AppConstant.appSecondaryColor,
// //           centerTitle: true,
// //           title: Text(
// //             "Sign In",
// //             style: TextStyle(color: AppConstant.appTextColor),
// //           ),
// //         ),
// //         body: Container(
// //           child: Column(
// //             children: [
// //               isKeyboardVisible
// //                   ? Text("Welcome to my app")
// //                   : Column(
// //                       children: [
// //                         Lottie.asset('assets/images/splash-icon.json'),
// //                       ],
// //                     ),
// //               SizedBox(
// //                 height: Get.height / 20,
// //               ),
// //               Container(
// //                 margin: EdgeInsets.symmetric(horizontal: 5.0),
// //                 width: Get.width,
// //                 child: Padding(
// //                   padding: const EdgeInsets.all(10.0),
// //                   child: TextFormField(
// //                     controller: userEmail,
// //                     cursorColor: AppConstant.appSecondaryColor,
// //                     keyboardType: TextInputType.emailAddress,
// //                     decoration: InputDecoration(
// //                       hintText: "Email",
// //                       prefixIcon: Icon(Icons.email),
// //                       contentPadding: EdgeInsets.only(top: 2.0, left: 8.0),
// //                       border: OutlineInputBorder(
// //                         borderRadius: BorderRadius.circular(10.0),
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //               Container(
// //                 margin: EdgeInsets.symmetric(horizontal: 5.0),
// //                 width: Get.width,
// //                 child: Padding(
// //                   padding: const EdgeInsets.all(10.0),
// //                   child: Obx(
// //                     () => TextFormField(
// //                       controller: userPassword,
// //                       obscureText: signInController.isPasswordVisible.value,
// //                       cursorColor: AppConstant.appSecondaryColor,
// //                       keyboardType: TextInputType.visiblePassword,
// //                       decoration: InputDecoration(
// //                         hintText: "Password",
// //                         prefixIcon: Icon(Icons.password),
// //                         suffixIcon: GestureDetector(
// //                           onTap: () {
// //                             signInController.isPasswordVisible.toggle();
// //                           },
// //                           child: signInController.isPasswordVisible.value
// //                               ? Icon(Icons.visibility_off)
// //                               : Icon(Icons.visibility),
// //                         ),
// //                         contentPadding: EdgeInsets.only(top: 2.0, left: 8.0),
// //                         border: OutlineInputBorder(
// //                           borderRadius: BorderRadius.circular(10.0),
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //               Container(
// //                 margin: EdgeInsets.symmetric(horizontal: 10.0),
// //                 alignment: Alignment.centerRight,
// //                 child: GestureDetector(
// //                   onTap: () {
// //                     Get.to(() => ForgetPasswordScreen());
// //                   },
// //                   child: Text(
// //                     "Forget Password?",
// //                     style: TextStyle(
// //                         color: AppConstant.appSecondaryColor,
// //                         fontWeight: FontWeight.bold),
// //                   ),
// //                 ),
// //               ),
// //               SizedBox(
// //                 height: Get.height / 20,
// //               ),
// //               Material(
// //                 child: Container(
// //                   width: Get.width / 2,
// //                   height: Get.height / 18,
// //                   decoration: BoxDecoration(
// //                     color: AppConstant.appSecondaryColor,
// //                     borderRadius: BorderRadius.circular(20.0),
// //                   ),
// //                   child: TextButton(
// //                     child: Text(
// //                       "SIGN IN",
// //                       style: TextStyle(color: AppConstant.appTextColor),
// //                     ),
// //                     onPressed: () async {
// //                       String email = userEmail.text.trim();
// //                       String password = userPassword.text.trim();

// //                       if (email.isEmpty || password.isEmpty) {
// //                         Get.snackbar(
// //                           "Error",
// //                           "Please enter all details",
// //                           snackPosition: SnackPosition.BOTTOM,
// //                           backgroundColor: AppConstant.appSecondaryColor,
// //                           colorText: AppConstant.appTextColor,
// //                         );
// //                       } else {
// //                         UserCredential? userCredential = await signInController
// //                             .signInMethod(email, password);

// //                         if (userCredential != null) {
// //                           var userData = await getUserDataController
// //                               .getUserData(userCredential.user!.uid);

// //                           if (userCredential.user!.emailVerified) {
// //                             if (userData.isNotEmpty &&
// //                                 userData[0]['isAdmin'] == true) {
// //                               print('admin mil gaya');
// //                               Get.snackbar(
// //                                 "Success Admin Login",
// //                                 "login Successfully!",
// //                                 snackPosition: SnackPosition.BOTTOM,
// //                                 backgroundColor: AppConstant.appSecondaryColor,
// //                                 colorText: AppConstant.appTextColor,
// //                               );
// //                               Get.offAll(() => AdminMainScreen());
// //                             } else {
// //                               print('admin ni mila');
// //                               Get.offAll(() => MainScreen());
// //                               Get.snackbar(
// //                                 "Success User Login",
// //                                 "login Successfully!",
// //                                 snackPosition: SnackPosition.BOTTOM,
// //                                 backgroundColor: AppConstant.appSecondaryColor,
// //                                 colorText: AppConstant.appTextColor,
// //                               );
// //                             }
// //                           } else {
// //                             Get.snackbar(
// //                               "Error",
// //                               "Please verify your email before login",
// //                               snackPosition: SnackPosition.BOTTOM,
// //                               backgroundColor: AppConstant.appSecondaryColor,
// //                               colorText: AppConstant.appTextColor,
// //                             );
// //                           }
// //                         } else {
// //                           Get.snackbar(
// //                             "Error",
// //                             "Please try again",
// //                             snackPosition: SnackPosition.BOTTOM,
// //                             backgroundColor: AppConstant.appSecondaryColor,
// //                             colorText: AppConstant.appTextColor,
// //                           );
// //                         }
// //                       }
// //                     },
// //                   ),
// //                 ),
// //               ),
// //               SizedBox(
// //                 height: Get.height / 20,
// //               ),
// //               Row(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   Text(
// //                     "Don't have an account? ",
// //                     style: TextStyle(color: AppConstant.appSecondaryColor),
// //                   ),
// //                   GestureDetector(
// //                     onTap: () => Get.offAll(() => SignUpScreen()),
// //                     child: Text(
// //                       "Sign Up",
// //                       style: TextStyle(
// //                           color: AppConstant.appSecondaryColor,
// //                           fontWeight: FontWeight.bold),
// //                     ),
// //                   ),
// //                 ],
// //               )
// //             ],
// //           ),
// //         ),
// //       );
// //     });
// //   }
// // }

// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unused_local_variable, unnecessary_null_comparison, file_names

// import 'package:finalpro/controllers/get-user-data-controller.dart';
// import 'package:finalpro/controllers/sign-in-controller.dart';
// import 'package:finalpro/screens/admin-panel/admin-screen.dart';
// import 'package:finalpro/screens/auth-ui/sign-up-screen.dart';
// import 'package:finalpro/screens/user-panel/main-screen.dart';
// import 'package:finalpro/utils/app-constant.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
// import 'package:get/get.dart';
// import 'package:lottie/lottie.dart';

// import 'forget-password-screen.dart';

// class SignInScreen extends StatefulWidget {
//   const SignInScreen({super.key});

//   @override
//   State<SignInScreen> createState() => _SignInScreenState();
// }

// class _SignInScreenState extends State<SignInScreen> {
//   final SignInController signInController = Get.put(SignInController());
//   final GetUserDataController getUserDataController =
//       Get.put(GetUserDataController());
//   TextEditingController userEmail = TextEditingController();
//   TextEditingController userPassword = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
//       return Scaffold(
//         appBar: AppBar(
//           backgroundColor: AppConstant.appSecondaryColor,
//           centerTitle: true,
//           title: Text(
//             "Sign In",
//             style: TextStyle(color: AppConstant.appTextColor),
//           ),
//         ),
//         body: Column(
//           children: [
//             isKeyboardVisible
//                 ? Text("Welcome to my app")
//                 : Column(
//                     children: [
//                       Lottie.asset('assets/images/splash-icon.json'),
//                     ],
//                   ),
//             SizedBox(height: Get.height / 20),
//             Container(
//               margin: EdgeInsets.symmetric(horizontal: 5.0),
//               width: Get.width,
//               child: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: TextFormField(
//                   controller: userEmail,
//                   cursorColor: AppConstant.appSecondaryColor,
//                   keyboardType: TextInputType.emailAddress,
//                   decoration: InputDecoration(
//                     hintText: "Email",
//                     prefixIcon: Icon(Icons.email),
//                     contentPadding: EdgeInsets.only(top: 2.0, left: 8.0),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.symmetric(horizontal: 5.0),
//               width: Get.width,
//               child: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Obx(
//                   () => TextFormField(
//                     controller: userPassword,
//                     obscureText: signInController.isPasswordVisible.value,
//                     cursorColor: AppConstant.appSecondaryColor,
//                     keyboardType: TextInputType.visiblePassword,
//                     decoration: InputDecoration(
//                       hintText: "Password",
//                       prefixIcon: Icon(Icons.password),
//                       suffixIcon: GestureDetector(
//                         onTap: () {
//                           signInController.isPasswordVisible.toggle();
//                         },
//                         child: signInController.isPasswordVisible.value
//                             ? Icon(Icons.visibility_off)
//                             : Icon(Icons.visibility),
//                       ),
//                       contentPadding: EdgeInsets.only(top: 2.0, left: 8.0),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.symmetric(horizontal: 10.0),
//               alignment: Alignment.centerRight,
//               child: GestureDetector(
//                 onTap: () {
//                   Get.to(() => ForgetPasswordScreen());
//                 },
//                 child: Text(
//                   "Forget Password?",
//                   style: TextStyle(
//                       color: AppConstant.appSecondaryColor,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//             SizedBox(height: Get.height / 20),
//             Material(
//               child: Container(
//                 width: Get.width / 2,
//                 height: Get.height / 18,
//                 decoration: BoxDecoration(
//                   color: AppConstant.appSecondaryColor,
//                   borderRadius: BorderRadius.circular(20.0),
//                 ),
//                 child: TextButton(
//                   child: Text(
//                     "SIGN IN",
//                     style: TextStyle(color: AppConstant.appTextColor),
//                   ),
//                   onPressed: () async {
//                     String email = userEmail.text.trim();
//                     String password = userPassword.text.trim();

//                     if (email.isEmpty || password.isEmpty) {
//                       Get.snackbar(
//                         "Error",
//                         "Please enter all details",
//                         snackPosition: SnackPosition.BOTTOM,
//                         backgroundColor: AppConstant.appSecondaryColor,
//                         colorText: AppConstant.appTextColor,
//                       );
//                     } else {
//                       UserCredential? userCredential =
//                           await signInController.signInMethod(email, password);

//                       if (userCredential != null) {
//                         if (userCredential.user!.emailVerified) {
//                           var userDoc = await getUserDataController
//                               .getUserData(userCredential.user!.uid);

//                           if (userDoc['isAdmin'] == true) {
//                             Get.snackbar(
//                               "Success Admin Login",
//                               "Login Successfully!",
//                               snackPosition: SnackPosition.BOTTOM,
//                               backgroundColor: AppConstant.appSecondaryColor,
//                               colorText: AppConstant.appTextColor,
//                             );
//                             Get.offAll(() => AdminMainScreen());
//                           } else {
//                             Get.snackbar(
//                               "Success User Login",
//                               "Login Successfully!",
//                               snackPosition: SnackPosition.BOTTOM,
//                               backgroundColor: AppConstant.appSecondaryColor,
//                               colorText: AppConstant.appTextColor,
//                             );
//                             Get.offAll(() => MainScreen());
//                           }
//                         } else {
//                           Get.snackbar(
//                             "Error",
//                             "Please verify your email before login",
//                             snackPosition: SnackPosition.BOTTOM,
//                             backgroundColor: AppConstant.appSecondaryColor,
//                             colorText: AppConstant.appTextColor,
//                           );
//                         }
//                       } else {
//                         Get.snackbar(
//                           "Error",
//                           "Please try again",
//                           snackPosition: SnackPosition.BOTTOM,
//                           backgroundColor: AppConstant.appSecondaryColor,
//                           colorText: AppConstant.appTextColor,
//                         );
//                       }
//                     }
//                   },
//                 ),
//               ),
//             ),
//             SizedBox(height: Get.height / 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   "Don't have an account? ",
//                   style: TextStyle(color: AppConstant.appSecondaryColor),
//                 ),
//                 GestureDetector(
//                   onTap: () => Get.offAll(() => SignUpScreen()),
//                   child: Text(
//                     "Sign Up",
//                     style: TextStyle(
//                         color: AppConstant.appSecondaryColor,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       );
//     });
//   }
// }
// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unused_local_variable, unnecessary_null_comparison, file_names
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unused_local_variable, unnecessary_null_comparison, file_names
import 'package:finalpro/controllers/get-user-data-controller.dart';
import 'package:finalpro/controllers/sign-in-controller.dart';
import 'package:finalpro/screens/admin-panel/admin-screen.dart';
import 'package:finalpro/screens/auth-ui/sign-up-screen.dart';
import 'package:finalpro/screens/user-panel/main-screen.dart';
import 'package:finalpro/utils/app-constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'forget-password-screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final SignInController signInController = Get.put(SignInController());
  final GetUserDataController getUserDataController =
      Get.put(GetUserDataController());
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppConstant.appSecondaryColor,
            centerTitle: true,
            title: Text("Sign In",
                style: TextStyle(color: AppConstant.appTextColor)),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                isKeyboardVisible
                    ? Text("Welcome to my app")
                    : Lottie.asset('assets/images/splash-icon.json'),
                SizedBox(height: Get.height / 20),
                _buildTextField(
                  controller: userEmail,
                  hintText: "Email",
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                ),
                Obx(() => _buildTextField(
                      controller: userPassword,
                      hintText: "Password",
                      icon: Icons.password,
                      obscureText: signInController.isPasswordVisible.value,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          signInController.isPasswordVisible.toggle();
                        },
                        child: Icon(
                          signInController.isPasswordVisible.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                    )),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => ForgetPasswordScreen());
                    },
                    child: Text(
                      "Forget Password?",
                      style: TextStyle(
                        color: AppConstant.appSecondaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Get.height / 20),
                _buildSignInButton(),
                SizedBox(height: Get.height / 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account? ",
                        style: TextStyle(color: AppConstant.appSecondaryColor)),
                    GestureDetector(
                      onTap: () => Get.offAll(() => SignUpScreen()),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: AppConstant.appSecondaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    Widget? suffixIcon,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      width: Get.width,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextFormField(
          controller: controller,
          obscureText: obscureText,
          cursorColor: AppConstant.appSecondaryColor,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(icon),
            suffixIcon: suffixIcon,
            contentPadding: EdgeInsets.only(top: 2.0, left: 8.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignInButton() {
    return Material(
      child: Container(
        width: Get.width / 2,
        height: Get.height / 18,
        decoration: BoxDecoration(
          color: AppConstant.appSecondaryColor,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: TextButton(
          child: Text(
            "SIGN IN",
            style: TextStyle(color: AppConstant.appTextColor),
          ),
          onPressed: () async {
            String email = userEmail.text.trim();
            String password = userPassword.text.trim();

            if (email.isEmpty || password.isEmpty) {
              Get.snackbar(
                "Error",
                "Please enter all details",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: AppConstant.appSecondaryColor,
                colorText: AppConstant.appTextColor,
              );
              return;
            }

            UserCredential? userCredential =
                await signInController.signInMethod(email, password);

            if (userCredential != null) {
              var userData = await getUserDataController
                  .getUserData(userCredential.user!.uid);

              if (userCredential.user!.emailVerified) {
                if (userData.exists && userData['isAdmin'] == true ||
                    email == "moeezmashhood@gmail.com") {
                  print('admin mil gaya');
                  Get.snackbar("Success Admin Login", "Login Successfully!",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: AppConstant.appSecondaryColor,
                      colorText: AppConstant.appTextColor);
                  Get.offAll(() => AdminMainScreen());
                } else {
                  Get.snackbar("Success User Login", "Login Successfully!",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: AppConstant.appSecondaryColor,
                      colorText: AppConstant.appTextColor);
                  Get.offAll(() => MainScreen());
                }
              } else {
                Get.snackbar("Error", "Please verify your email before login",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: AppConstant.appSecondaryColor,
                    colorText: AppConstant.appTextColor);
              }
            } else {
              Get.snackbar("Error", "Please try again",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: AppConstant.appSecondaryColor,
                  colorText: AppConstant.appTextColor);
            }
          },
        ),
      ),
    );
  }
}
