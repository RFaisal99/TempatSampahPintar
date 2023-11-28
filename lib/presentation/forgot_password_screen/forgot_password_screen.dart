import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stb/core/app_export.dart';
import 'package:stb/widgets/custom_elevated_button.dart';
import 'package:stb/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String errorMessage = "";
  String successMessage = "";

  void resetPassword() async {
    if (_formKey.currentState!.validate()) {
      if (emailController.text.isEmpty) {
        errorMessage = "Email tidak boleh kosong. Harap isi email Anda.";
      } else {
        try {
          await FirebaseAuth.instance.sendPasswordResetEmail(
            email: emailController.text,
          );
          // Tautan pengaturan ulang kata sandi telah dikirimkan ke email pengguna
          // Anda dapat menambahkan logika lain di sini

          // Clear any previous error message
          errorMessage = "";
          successMessage = "Tautan pengaturan ulang kata sandi telah dikirimkan ke email Anda.";
          print(successMessage);
        } catch (e) {
          // Menangani kesalahan, seperti email tidak terdaftar
          errorMessage = "Terjadi kesalahan saat mengatur ulang kata sandi.";

          if (e is FirebaseAuthException) {
            if (e.code == 'user-not-found') {
              errorMessage = "Email tidak terdaftar.";
            } else if (e.code == 'invalid-email') {
              errorMessage = "Format email salah.";
            } else if (e.code == 'too-many-requests') {
              errorMessage = "Terlalu banyak percobaan reset password. Coba lagi nanti.";
            } else {
              // Handle other FirebaseAuthException errors here
            }
          }
        }
      }
    }
    // Update state to trigger a rebuild and display the error message
    setState(() {});
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
                          Text("Lupa Password",
                              style: CustomTextStyles.displaySmallOnPrimary),
                          SizedBox(height: 16.v),
                          CustomTextFormField(
                              controller: emailController,
                              hintText: "Email",
                              hideText: false,
                              textInputAction: TextInputAction.done,
                              textInputType: TextInputType.emailAddress),
                          Text(
                            errorMessage.isNotEmpty ? errorMessage : successMessage,
                            style: CustomTextStyles.titleSmallExtraBold,
                          ),
                          Spacer(),
                          CustomElevatedButton(
                            text: "Submit",
                            onTap: resetPassword, // Memanggil fungsi resetPassword
                          ),
                          SizedBox(height: 26.v),
                        ]))))));
  }

  /// Navigates back to the previous screen.
  ///
  /// This function takes a [BuildContext] object as a parameter, which is used
  /// to navigate back to the previous screen.
  onTapImgArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }
}
