import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stb/core/app_export.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:stb/presentation/data_sampah_screen/widget/firebase_jumlah_botol.dart';
import '../data_sampah_screen/widget/firebase_data_list.dart';
import '../data_sampah_screen/widget/data_reset_manager.dart';
import '../login_screen/user_role_provider.dart';


class DataSampahScreen extends StatefulWidget {
  const DataSampahScreen({Key? key}) : super(key: key);

  @override
  _DataSampahScreenState createState() => _DataSampahScreenState();
}

class _DataSampahScreenState extends State<DataSampahScreen> {
  FirebaseService _firebaseService = FirebaseService();
  final databaseReference = FirebaseDatabase.instance.ref();
  String? selectedNode; // Tidak ada inisialisasi nilai default

  // Daftar node utama (akan diperbarui secara dinamis)
  List<String> mainNodes = ["Test1", "Test2"]; // Inisialisasi dengan node utama yang ada

  String? getSelectedNode() {
    return selectedNode;
  }

  void openDropdown() async {
    try {
      List<String> nodes = await _firebaseService.getNodeList();
      nodes.remove("Notification");
      setState(() {
        mainNodes = nodes;
      });
    } catch (e) {
      print('Terjadi kesalahan: $e');
    }
  }

  DataResetManager dataResetManager = DataResetManager();

  @override
  void initState() {
    super.initState();
    selectedNode = null; // Tidak ada inisialisasi node awal.
  }


  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 23.h,
            vertical: 26.v,
          ),
          child: Column(
            children: [
              Text(
                "Data Sampah",
                style: CustomTextStyles.displayMediumBackground,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 3.h,
                    top: 8.v,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: DropdownButton<String>(
                          value: selectedNode,
                          onChanged: (String? newValue) { // Mengubah tipe data parameter menjadi String?
                            setState(() {
                              selectedNode = newValue;
                            });
                          },
                          items: mainNodes.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                              ),
                            );
                          }).toList(),
                          underline: Container(),
                          style: CustomTextStyles.titleMediumInterBlack900,
                          selectedItemBuilder: (BuildContext context) {
                            return mainNodes.map<Widget>((String item) {
                              return Row(
                                children: [
                                  Text(
                                    item,
                                    style: CustomTextStyles.titleLargeBackground,
                                  ),
                                  Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.white, // Warna ikon panah dropdown
                                  ),
                                ],
                              );
                            }).toList();
                          },
                          onTap: openDropdown,
                          isExpanded: true, // Memastikan panah dropdown ada di sebelah kanan teks
                          //icon: Icon(null), // Menyembunyikan ikon panah dropdown bawaan
                          iconSize: 0, // Mengatur ukuran ikon panah dropdown
                          hint: Row(
                            children: [
                              Text('Tempat Sampah', style: CustomTextStyles.titleLargeBackground),
                              Icon(
                                Icons.arrow_drop_down, // Menggunakan ikon segitiga arah ke bawah
                                color: Colors.white, // Sesuaikan warna ikon
                              ),
                            ],
                          ),
                        ),
                      ),
                      Consumer<UserRoleProvider>(
                        builder: (context, userRoleProvider, child) {
                          if (userRoleProvider.userRole == 'Admin') { // Check user's role from userRoleProvider
                            return ElevatedButton(
                              onPressed: () {
                                dataResetManager.updatePerformReset(selectedNode!);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Data sampah berhasil direset'),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                                textStyle: CustomTextStyles.titleLargeBackground,
                              ),
                              child: Text('Reset'),
                            );
                          } else {
                            return SizedBox(); // If not an admin, return an empty SizedBox to hide the button
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 4.v),
              Container(
                height: 186.v,
                width: 343.h,
                decoration: BoxDecoration(
                  color: appTheme.gray100,
                  borderRadius: BorderRadius.circular(
                    8.h,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 27.h,
                  top: 24.v,
                  right: 31.h,
                ),
                child: FirebaseJumlahBotol(selectedNode: selectedNode ?? ''),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 9.h,
                    top: 25.v,
                  ),
                  child: Text(
                    "Botol Masuk",
                    style: CustomTextStyles.headlineSmallBackground,
                  ),
                ),
              ),
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.only(
                        left: 7.h,
                        top: 27.v,
                        right: 14.h,
                      ),

                    child: FirebaseDataList(selectedNode: selectedNode ?? ''),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}

