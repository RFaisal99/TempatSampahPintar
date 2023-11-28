import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:stb/core/app_export.dart';
import '../data_pengambilan_sampah_screen/widget/firebase_data_pengambilan.dart';

class DataPengambilanSampahScreen extends StatefulWidget {
  DataPengambilanSampahScreen({Key? key})
      : super(
          key: key,
        );

  @override
  _DataPengambilanSampahScreenState createState() => _DataPengambilanSampahScreenState();
}

class _DataPengambilanSampahScreenState extends State<DataPengambilanSampahScreen> {
  final databaseReference = FirebaseDatabase.instance.ref();
  FirebaseService _firebaseService = FirebaseService();
  String? selectedNode; // Tidak ada inisialisasi nilai default
  List<String> mainNodes = ["Test1", "Test2",]; // Inisialisasi dengan node utama yang ada

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

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 26.h,
            vertical: 25.v,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Pengambilan",
                  style: theme.textTheme.displayMedium,
                ),
              ),
              SizedBox(height: 9.v),
              Row(
                children: [
                  Expanded(
                    child: DropdownButton<String>(
                      value: selectedNode,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedNode = newValue;
                        });
                      },
                      items: mainNodes.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: CustomTextStyles.titleMediumInterBlack900,
                          ),
                        );
                      }).toList(),
                      underline: Container(),
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
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 1.h,
                  top: 5.v,
                ),
                child: Text(
                  "Riwayat Pengambilan",
                  style: CustomTextStyles.headlineSmallBackground,
                ),
              ),
              Expanded(
                child: Container(
                  width: double.maxFinite, // Adjust the width as needed
                  child: FirebaseDataPengambilan(selectedNode: selectedNode ?? ''),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

