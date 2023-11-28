import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:stb/core/app_export.dart';

class FirebaseJumlahBotol extends StatelessWidget {
  final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
  final String selectedNode;

  FirebaseJumlahBotol({required this.selectedNode});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DataSnapshot>(
      future: databaseReference.child(selectedNode).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            DataSnapshot data = snapshot.data!;
            Map? testData = data.value as Map<dynamic, dynamic>?;

            if (testData != null && testData.containsKey("jumlah_botol")) {
              Map<dynamic, dynamic> jumlahBotol = testData["jumlah_botol"] as Map<dynamic, dynamic>;

              // Ambil nilai Kondisi untuk masing-masing botol
              String kondisiPlastik = testData["Kondisi"]["Plastik"] ?? "Kosong";
              String kondisiKaleng = testData["Kondisi"]["Kaleng"] ?? "Kosong";
              String kondisiGelas = testData["Kondisi"]["Gelas"] ?? "Kosong";

              // Tentukan warna container berdasarkan nilai Kondisi
              Color colorPlastik = kondisiPlastik == "Penuh" ? Colors.red : appTheme.gray70001;
              Color colorKaleng = kondisiKaleng == "Penuh" ? Colors.red : appTheme.gray70001;
              Color colorGelas = kondisiGelas == "Penuh" ? Colors.red : appTheme.gray70001;

              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 20.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 70, // Set a fixed width
                            height: 53, // Set a fixed height
                            padding: EdgeInsets.symmetric(
                              horizontal: 23.h,
                              vertical: 10.v,
                            ),
                            decoration: AppDecoration.fillGray70001.copyWith(
                              borderRadius: BorderRadiusStyle.circleBorder37,
                              color: colorPlastik,
                            ),
                            child: Center(
                              child: Text(
                                jumlahBotol["Plastik"].toString() ?? "0",
                                style: CustomTextStyles.titleLargeExtraBold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 10.v,
                            ),
                            child: Text(
                              "Plastik".toUpperCase(),
                              style: CustomTextStyles.titleSmallExtraBold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 20.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 70, // Set a fixed width
                            height: 53, // Set a fixed height
                            padding: EdgeInsets.symmetric(
                              horizontal: 23.h,
                              vertical: 10.v,
                            ),
                            decoration: AppDecoration.fillGray70001.copyWith(
                              borderRadius: BorderRadiusStyle.circleBorder37,
                              color: colorKaleng,
                            ),
                            child: Center(
                              child: Text(
                                jumlahBotol["Kaleng"].toString() ?? "0",
                                style: CustomTextStyles.titleLargeExtraBold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 10.v,
                            ),
                            child: Text(
                              "Kaleng".toUpperCase(),
                              style: CustomTextStyles.titleSmallExtraBold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 20.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 70, // Set a fixed width
                            height: 53, // Set a fixed height
                            padding: EdgeInsets.symmetric(
                              horizontal: 23.h,
                              vertical: 10.v,
                            ),
                            decoration: AppDecoration.fillGray70001.copyWith(
                              borderRadius: BorderRadiusStyle.circleBorder37,
                              color: colorGelas,
                            ),
                            child: Center(
                              child: Text(
                                jumlahBotol["Gelas"].toString() ?? "0",
                                style: CustomTextStyles.titleLargeExtraBold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 10.v,
                            ),
                            child: Text(
                              "Gelas".toUpperCase(),
                              style: CustomTextStyles.titleSmallExtraBold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
          }

          return Center(
            child: Text(
              'Belum ada tempat sampah yang dipilih',
              style: CustomTextStyles.titleMediumInterBackground,
            ),
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
