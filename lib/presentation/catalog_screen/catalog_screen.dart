import 'package:flutter/material.dart';
import 'package:stb/core/app_export.dart';
import '../trash_information_screen/trash_data.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(
                  horizontal: 27.h,
                  vertical: 26.v,
                ),
                decoration: AppDecoration.fillBackground.copyWith(
                  borderRadius: BorderRadiusStyle.customBorderBL40,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 87.h,
                      margin: EdgeInsets.only(
                        top: 3.v,
                        bottom: 191.v,
                      ),
                      child: Text(
                        "tempat sampah \npintar".toUpperCase(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: CustomTextStyles.labelMediumGray600,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 34.h,
                        top: 79.v,
                        bottom: 86.v,
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 5.v),
                          SizedBox(
                            width: 100.h,
                            child: Text(
                              "Pemilah \nSampah Minuman \nOtomatis",
                              maxLines: 3,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.labelLarge,
                            ),
                          ),

                        ],
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              SizedBox(height: 18.v),
              Text(
                "Katalog sampah".toUpperCase(),
                style: CustomTextStyles.headlineSmallBackground,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 20.h,
                  top: 16.v,
                  right: 31.h,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          navigateToTrashInfo(
                            context,
                            TrashData.botolPlastikTitle,
                            TrashData.botolPlastikDescription,
                            TrashData.botolPlastikImagePath,
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: 19.h),
                          child: Column(
                            children: [
                              CustomImageView(
                                imagePath: ImageConstant.imgPlastik,
                                height: 163.v,
                                width: 149.h,
                                radius: BorderRadius.circular(
                                  30.h,
                                ),
                              ),
                              SizedBox(height: 6.v),
                              Text(
                                "Botol Plastik",
                                style: theme.textTheme.titleSmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          navigateToTrashInfo(
                            context,
                            TrashData.botolGelasTitle,
                            TrashData.botolGelasDescription,
                            TrashData.botolGelasImagePath,
                          );
                        },
                      child: Padding(
                        padding: EdgeInsets.only(left: 19.h),
                        child: Column(
                          children: [
                            CustomImageView(
                              imagePath: ImageConstant.imgGelas,
                              height: 163.v,
                              width: 149.h,
                              radius: BorderRadius.circular(
                                30.h,
                              ),
                            ),
                            SizedBox(height: 6.v),
                            Text(
                              "Botol Gelas",
                              style: theme.textTheme.titleSmall,
                            ),
                          ],
                        ),
                      ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 23.v),
              GestureDetector(
                onTap: () {
                  navigateToTrashInfo(
                    context,
                    TrashData.botolKalengTitle,
                    TrashData.botolKalengDescription,
                    TrashData.botolKalengImagePath,
                  );
                },
                child: Column(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgKaleng,
                      height: 163.v,
                      width: 149.h,
                      radius: BorderRadius.circular(30.h),
                    ),
                    SizedBox(height: 8.v),
                    Text(
                      "Botol Kaleng",
                      style: theme.textTheme.titleSmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  navigateToTrashInfo(BuildContext context, String title, String description, String imagePath) {
    Navigator.pushNamed(context, AppRoutes.trashInformationScreen,
        arguments: {'title': title, 'description': description, 'imagePath': imagePath});
  }
}
