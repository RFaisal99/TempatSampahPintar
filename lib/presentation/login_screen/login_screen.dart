import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stb/core/app_export.dart';
import 'package:stb/presentation/login_screen/user_role_provider.dart';
import 'package:stb/widgets/custom_elevated_button.dart';
import 'package:stb/widgets/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stb/presentation/notification_fcm/notification_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

GlobalKey<_LoginScreenState> loginScreenKey = GlobalKey();
// ignore_for_file: must_be_immutable
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String errorMessage = '';

  bool isLoading = false;

  late NotificationHandler notificationHandler;

  void loginUser(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        // Periksa apakah login berhasil
        if (userCredential.user != null) {
          setState(() {
            isLoading = true; // Menampilkan tampilan loading
          });

          notificationHandler = NotificationHandler();
          notificationHandler.initializeNotifications('trash_notification');

          // Simpan status login ke shared preferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', true);

          // Subscribe to the FCM topic
          await subscribeToNotificationTopic();

          // Login berhasil
          // Ambil peran pengguna dari Firestore
          String userRole = await getUserRoleFromFirestore(userCredential.user!.uid);
          // Set peran pengguna menggunakan UserRoleProvider
          Provider.of<UserRoleProvider>(context, listen: false).setUserRole(userRole);
          // Navigasi ke halaman AppRoutes.mainScreen
          Navigator.pushReplacementNamed(context, AppRoutes.mainScreen);
        } else {
          // Handle password salah
          setState(() {
            errorMessage = 'Password salah';
          });
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          // Handle email tidak terdaftar
          setState(() {
            errorMessage = 'Email tidak terdaftar';
          });
        } else if (e.code == 'wrong-password') {
          // Handle password salah
          setState(() {
            errorMessage = 'Password salah';
          });
        } else if (e.code == 'invalid-email') {
          // Handle password salah
          setState(() {
            errorMessage = 'Format email salah';
          });
        } else {
          // Menangani kesalahan lainnya
          setState(() {
            errorMessage = 'Email atau password belum diisi.';
          });
        }
      }
    }
  }

  // Fungsi untuk mengambil peran pengguna dari Firestore
  Future<String> getUserRoleFromFirestore(String userId) async {
    String userRole = ''; // Inisialisasi peran pengguna

    // Lakukan permintaan Firestore untuk mengambil peran pengguna
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (snapshot.exists) {
      userRole = snapshot.get('role');
    }

    return userRole;
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            resizeToAvoidBottomInset: false,
            body: isLoading
                ? Center(
              child: CircularProgressIndicator(), // Tampilkan tampilan loading
            )
            : Container(
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
                          Text("Login",
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
                              obscureText: true,),
                          SizedBox(height: 10.v),
                          Text(
                            errorMessage, // Menampilkan pesan kesalahan
                            style: CustomTextStyles.titleSmallExtraBold,
                          ),
                          Spacer(),
                          CustomElevatedButton(
                            text: "Login",
                              onTap: () {
                                loginUser(context);
                              }
                          ),
                          SizedBox(height: 26.v),
                          GestureDetector(
                              onTap: () {
                                navigateToForgotPassowrd(context);
                              },
                              child: Text("Lupa password?",
                                  style: theme.textTheme.titleLarge)),
                          SizedBox(height: 26.v)
                        ]))))));
  }

  /// Navigates back to the previous screen.
  ///
  /// This function takes a [BuildContext] object as a parameter, which is used
  /// to navigate back to the previous screen.
  onTapImgArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the forgotPasswordScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the [Navigator] widget
  /// to push the named route for the forgotPasswordScreen.
  navigateToForgotPassowrd(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.forgotPasswordScreen);
  }

  // Function to subscribe to the FCM topic
  Future<void> subscribeToNotificationTopic() async {
    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      await messaging.subscribeToTopic('trash_notification');
      print('Subscribed to the FCM topic successfully');
    } catch (e) {
      print('Error subscribing to the FCM topic: $e');
    }
  }
}
