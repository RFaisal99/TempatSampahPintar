import 'package:flutter/material.dart';
import 'package:stb/presentation/splash_screen/splash_screen.dart';
import 'package:stb/presentation/home_screen/home_screen.dart';
import 'package:stb/presentation/sign_up_screen/sign_up_screen.dart';
import 'package:stb/presentation/login_screen/login_screen.dart';
import 'package:stb/presentation/forgot_password_screen/forgot_password_screen.dart';
import 'package:stb/presentation/catalog_screen/catalog_screen.dart';
import 'package:stb/presentation/trash_information_screen/trash_information_screen.dart';
import 'package:stb/presentation/data_sampah_screen/data_sampah_screen.dart';
import 'package:stb/presentation/data_pengambilan_sampah_screen/data_pengambilan_sampah_screen.dart';
import 'package:stb/presentation/setting_screen/setting_screen.dart';
import 'package:stb/presentation/main_screen/main_screen.dart';

class AppRoutes {
  static const String splashScreen = '/splash_screen';

  static const String homeScreen = '/home_screen';

  static const String signUpScreen = '/sign_up_screen';

  static const String loginScreen = '/login_screen';

  static const String forgotPasswordScreen = '/forgot_password_screen';

  static const String catalogScreen = '/catalog_screen';

  static const String trashInformationScreen = '/trash_information_screen';

  static const String dataSampahScreen = '/data_sampah_screen';

  static const String dataPengambilanSampahScreen =
      '/data_pengambilan_sampah_screen';

  static const String notificationScreen = '/notification_screen';

  static const String settingScreen = '/setting_screen';

  static const String mainScreen = '/main_screen';

  static Map<String, WidgetBuilder> routes = {
    splashScreen: (context) => SplashScreen(),
    homeScreen: (context) => HomeScreen(),
    signUpScreen: (context) => SignUpScreen(),
    loginScreen: (context) => LoginScreen(),
    forgotPasswordScreen: (context) => ForgotPasswordScreen(),
    catalogScreen: (context) => CatalogScreen(),
    trashInformationScreen: (context) => TrashInformationScreen(),
    dataSampahScreen: (context) => DataSampahScreen(),
    dataPengambilanSampahScreen: (context) => DataPengambilanSampahScreen(),
    settingScreen: (context) => SettingScreen(),
    mainScreen: (context) => MainScreen(key: GlobalKey(),),
  };
}
