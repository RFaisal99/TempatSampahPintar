import 'package:flutter/material.dart';
import 'package:stb/core/app_export.dart';
import 'package:stb/presentation/home_screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3), () {
      // Pindah ke tampilan berikutnya setelah 2 detik
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomeScreen(), // Gantilah dengan tampilan berikutnya
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: Container(
          width: mediaQueryData.size.width,
          height: mediaQueryData.size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                ImageConstant.imgSplash,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.only(top: 73.v),
            child: Column(
              children: [
                SizedBox(height: 5.v),
                SizedBox(
                  width: 200.h,
                  child: Text(
                    "TEMPAT SAMPAH\nPINTAR",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: CustomTextStyles.titleLargeExtraBold.copyWith(
                      height: 1.08,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
