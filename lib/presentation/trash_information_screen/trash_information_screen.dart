import 'package:flutter/material.dart';
import 'package:stb/core/app_export.dart';
import 'package:stb/widgets/app_bar/appbar_image.dart';
import 'package:stb/widgets/app_bar/appbar_subtitle.dart';
import 'package:stb/widgets/app_bar/custom_app_bar.dart';

class TrashInformationScreen extends StatefulWidget {
  const TrashInformationScreen({Key? key}) : super(key: key);

  @override
  _TrashInformationScreenState createState() => _TrashInformationScreenState();
}

class _TrashInformationScreenState extends State<TrashInformationScreen> {
  String title = "";
  String description = "";
  String image = 'assets/sample_image.png';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments is Map<String, String>) {
      setState(() {
        title = arguments['title'] ?? "";
        description = arguments['description'] ?? "";
        image = arguments['imagePath'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            appBar: CustomAppBar(
                leadingWidth: 56.h,
                leading: AppbarImage(
                    svgPath: ImageConstant.imgArrowleft,
                    margin:
                        EdgeInsets.only(left: 30.h, top: 22.v, bottom: 14.v),
                    onTap: () {
                      onTapArrowleftone(context);
                    }),
                title: AppbarSubtitle(
                    text: "Informasi", margin: EdgeInsets.only(left: 50.h))),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 20.v),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 196.v,
                        width: 343.h,
                        margin: EdgeInsets.only(left: 7.h),
                        decoration: BoxDecoration(
                          color: appTheme.gray100,
                          borderRadius: BorderRadius.circular(8.h),
                        ),
                        child: Image.asset(image,),
                      ),
                      SizedBox(height: 32.v),
                      Text(title,
                          style: theme.textTheme.headlineSmall),
                      SizedBox(height: 2.v),
                      SizedBox(
                          width: 358.h,
                          child: Text(
                              description,
                              maxLines: 20,
                              overflow: TextOverflow.ellipsis,
                              style: CustomTextStyles
                                  .bodyMediumOpenSansOnPrimary)),
                      SizedBox(height: 5.v)
                    ]))));
  }

  /// Navigates back to the previous screen.
  ///
  /// This function takes a [BuildContext] object as a parameter, which is used
  /// to navigate back to the previous screen.
  onTapArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }
}
