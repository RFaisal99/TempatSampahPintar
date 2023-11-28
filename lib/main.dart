import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:stb/presentation/login_screen/user_role_provider.dart';
import 'package:stb/presentation/notification_fcm/notification_handler.dart';
import 'package:stb/theme/theme_helper.dart';
import 'package:stb/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Inisialisasi SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  final storedUserRole = prefs.getString('userRole') ?? '';

  final notificationHandler = NotificationHandler();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserRoleProvider()..setUserRole(storedUserRole)),
        Provider<NotificationHandler>.value(value: notificationHandler),
      ],
      child: MyApp(isLoggedIn: isLoggedIn),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  MyApp({required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      title: 'stb',
      debugShowCheckedModeBanner: false,
      initialRoute: isLoggedIn ? AppRoutes.mainScreen : AppRoutes.splashScreen,
      routes: AppRoutes.routes,
    );
  }
}
