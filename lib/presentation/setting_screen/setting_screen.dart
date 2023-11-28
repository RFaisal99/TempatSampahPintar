import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stb/core/app_export.dart';
import '../notification_fcm/notification_handler.dart';
import '../setting_screen//widget/firestore_to_excel_converter.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final converter = FirestoreToExcelConverter();
  late NotificationHandler notificationHandler; // Deklarasikan objek NotificationHandler

  @override
  void initState() {
    super.initState();
    notificationHandler = NotificationHandler(); // Inisialisasi NotificationHandler
  }

  Future<void> logoutUser() async {
    // Lakukan logout sesuai dengan implementasi autentikasi Anda
    FirebaseAuth.instance.signOut();

    // Hentikan notifikasi setelah logout
    notificationHandler.stopNotifications();

    // Perbarui status login ke `false` dalam SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);

    // Navigasi ke halaman login atau halaman lain yang sesuai
    // misalnya, menggunakan Navigator.pushReplacementNamed
    Navigator.pushReplacementNamed(context, AppRoutes.loginScreen);
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 24.h,
            vertical: 28.v,
          ),
          child: Column(
            children: [
              Text(
                "Pengaturan",
                style: theme.textTheme.displayMedium,
              ),
              SizedBox(height: 55.v),
              InkWell(
                onTap: () {
                  // Memanggil fungsi download data sampah
                  converter.convertFirestoreToExcel(context);
                },
                child: Ink(
                  decoration: AppDecoration.fillRed.copyWith(
                    borderRadius: BorderRadius.circular(10.0), // Ganti dengan radius yang sesuai
                  ),
                  child: Container(
                    child: Row(
                      children: [
                        SizedBox(
                          height: 58.0,
                          child: VerticalDivider(
                            width: 3.0,
                            thickness: 3.0,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 30.0,
                            top: 22.0,
                            bottom: 20.0,
                          ),
                          child: Text(
                            "Download Data Sampah",
                            style: theme.textTheme.labelMedium,
                          ),
                        ),
                        Spacer(),
                        CustomImageView(
                          svgPath: ImageConstant.imgArrowright,
                          height: 11.0,
                          width: 6.0,
                          margin: EdgeInsets.only(
                            top: 22.0,
                            right: 20.0,
                            bottom: 23.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 9.v),
              Container(
                decoration: AppDecoration.fillRed.copyWith(
                  borderRadius: BorderRadiusStyle.customBorderLR10,
                ),
                child: InkWell(
                  onTap: () {
                    logoutUser();
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        height: 58.v,
                        child: VerticalDivider(
                          width: 3.h,
                          thickness: 3.v,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 30.h,
                          top: 22.v,
                          bottom: 20.v,
                        ),
                        child: Text(
                          "Log Out",
                          style: theme.textTheme.labelMedium,
                        ),
                      ),
                      Spacer(),
                      CustomImageView(
                        svgPath: ImageConstant.imgArrowright,
                        height: 11.v,
                        width: 6.h,
                        margin: EdgeInsets.only(
                          top: 22.v,
                          right: 20.h,
                          bottom: 23.v,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5.v),
            ],
          ),
        ),
      ),
    );
  }
}
