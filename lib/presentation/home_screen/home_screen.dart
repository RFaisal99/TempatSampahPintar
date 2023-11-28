import 'package:flutter/material.dart';
import 'package:stb/core/app_export.dart';
import 'package:stb/widgets/custom_elevated_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
                        image: AssetImage(ImageConstant.imgSplash),
                        fit: BoxFit.cover)),
                child: Container(
                    width: double.maxFinite,
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.h, vertical: 31.v),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 42.v),
                          Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                  width: 200.h,
                                  child: Text("TEMPAT SAMPAH\nPINTAR",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: CustomTextStyles
                                          .titleLargeExtraBold
                                          .copyWith(height: 1.08)))),
                          Spacer(),
                          CustomElevatedButton(
                              height: 70.v,
                              text: "SIGN UP".toUpperCase(),
                              margin: EdgeInsets.only(right: 15.h),
                              buttonStyle: CustomButtonStyles.fillPrimaryTL20,
                              buttonTextStyle:
                                  CustomTextStyles.titleSmallOnPrimary,
                              onTap: () {
                                navigateToSignUp(context);
                              })
                        ])))));
  }

  /// Navigates to the signUpScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the [Navigator] widget
  /// to push the named route for the signUpScreen.
  navigateToSignUp(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.signUpScreen);
  }
}
