import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stb/core/app_export.dart';
import 'package:stb/widgets/custom_elevated_button.dart';
import 'package:stb/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String errorMessage = '';

  bool isLoading = false;

  void registerUser(String email, String password, String role, BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true; // Menampilkan tampilan loading
      });

      try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        // Simpan informasi peran pengguna dalam Firestore
        await FirebaseFirestore.instance.collection('users').doc(userCredential.user?.uid).set({
          'role': role,
        });

        // Reset pesan kesalahan jika registrasi berhasil
        setState(() {
          errorMessage = '';
        });

        // Navigasi hanya jika registrasi berhasil
        Navigator.pushReplacementNamed(context, AppRoutes.loginScreen);

      } catch (e) {
        // Menangani kesalahan registrasi dan mengatur pesan kesalahan sesuai dengan jenis kesalahan
        setState(() {
          isLoading = false; // Menghentikan tampilan loading
          if (e is FirebaseAuthException) {
            switch (e.code) {
              case 'email-already-in-use':
                errorMessage = 'Email sudah digunakan. Gunakan email lain.';
                break;
              case 'invalid-email':
                errorMessage = 'Email tidak valid. Harap periksa kembali.';
                break;
              case 'weak-password':
                errorMessage = 'Password terlalu lemah. Harap gunakan password yang lebih kuat.';
                break;
              default:
                errorMessage = 'Email atau password belum diisi.';
                break;
            }
          } else {
            errorMessage = 'Terjadi kesalahan selama registrasi.';
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            resizeToAvoidBottomInset: false,
            body: Container(
                width: mediaQueryData.size.width,
                height: mediaQueryData.size.height,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(ImageConstant.imgSplash),
                        fit: BoxFit.cover)),
                child: Form(
                    key: _formKey,
                    child: Container(
                        width: double.maxFinite,
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.h, vertical: 45.v),
                        child: Column(children: [
                          CustomImageView(
                              svgPath: ImageConstant.imgArrowleft,
                              height: 19.v,
                              width: 26.h,
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(left: 16.h),
                              onTap: () {
                                onTapImgArrowleftone(context);
                              }),
                          SizedBox(height: 33.v),
                          Text("Sign Up",
                              style: CustomTextStyles.displaySmallOnPrimary),
                          SizedBox(height: 16.v),
                          CustomTextFormField(
                              controller: emailController,
                              hintText: "Email",
                              hideText: false,
                              textInputType: TextInputType.emailAddress),
                          SizedBox(height: 16.v),
                          CustomTextFormField(
                              controller: passwordController,
                              hintText: "Password",
                              textInputAction: TextInputAction.done,
                              textInputType: TextInputType.visiblePassword,
                              obscureText: true),
                          SizedBox(height: 10.v),
                          Text(
                            errorMessage, // Menampilkan pesan kesalahan
                            style: CustomTextStyles.titleSmallExtraBold,
                          ),
                          Spacer(),
                          CustomElevatedButton(
                              text: isLoading ? "Loading..." : "Sign Up",
                              onTap: () {
                                registerUser(
                                  emailController.text,
                                  passwordController.text,
                                  "User",
                                  context,
                                );
                              }
                          ),
                          SizedBox(height: 18.v),
                          GestureDetector(
                              onTap: () {
                                navigateToLogin(context);
                              },
                              child: Text("Login",
                                  style: theme.textTheme.titleLarge)),
                          SizedBox(height: 18.v)
                        ]))))));
  }

  /// Navigates back to the previous screen.
  ///
  /// This function takes a [BuildContext] object as a parameter, which is used
  /// to navigate back to the previous screen.
  onTapImgArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the loginScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the [Navigator] widget
  /// to push the named route for the loginScreen.
  navigateToLogin(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.loginScreen);
  }
}
