import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:stb/core/app_export.dart';

class FirebaseDataList extends StatelessWidget {
  final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
  final String selectedNode;

  FirebaseDataList({required this.selectedNode});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DataSnapshot>(
      future: databaseReference.child(selectedNode).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            DataSnapshot data = snapshot.data!;
            Map? testData = data.value as Map<dynamic, dynamic>?;

            List<Widget> dataWidgets = [];

            if (testData != null) {
              // Membuat daftar node yang ingin diambil
              List<String> nodesToRetrieve = ["Plastik", "Gelas", "Kaleng"];

              nodesToRetrieve.forEach((nodeName) {
                if (testData.containsKey(nodeName)) {
                  Map<dynamic, dynamic> nodeData = testData[nodeName] as Map<dynamic, dynamic>;
                  nodeData.forEach((key, value) {
                    if (value is Map && value.containsKey("pembuangan")) {
                      String pembuangan = value["pembuangan"];
                      dataWidgets.add(
                        ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(nodeName, textAlign: TextAlign.left, style: CustomTextStyles.titleLargeBackground),
                              Text(pembuangan, textAlign: TextAlign.right, style: CustomTextStyles.titleLargeBackground),
                            ],
                          ),
                        ),
                      );
                    }
                  });
                }
              });
            }


            return ListView(
              children: dataWidgets,
            );
          } else {
            return Center(
              child: Text('Data tidak ditemukan'), // Atur pesan sesuai kebutuhan
            );
          }
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class FirebaseService {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  Future<List<String>> getNodeList() async {
    try {
      DatabaseEvent event = await _database.once();
      if (event.snapshot != null) {
        Map<dynamic, dynamic>? data = event.snapshot!.value as Map?;
        if (data != null) {
          return data.keys.whereType<String>().toList();
        }
      }
    } catch (e) {
      print('Terjadi kesalahan: $e');
    }
    return [];
  }
}


