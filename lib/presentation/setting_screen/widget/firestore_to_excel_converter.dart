import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

class FirestoreToExcelConverter {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> convertFirestoreToExcel(BuildContext context) async {
    final QuerySnapshot querySnapshot = await firestore.collection('database').get();
    final List<QueryDocumentSnapshot> documents = querySnapshot.docs;

    final Excel excel = Excel.createExcel();

    for (var document in documents) {
      final data = document.data() as Map<String, dynamic>;

      final sheet = excel[document.id]; // Gunakan ID dokumen sebagai nama sheet
      sheet.appendRow(['Plastik', 'Gelas', 'Kaleng', 'Reset']); // Hanya header kolom ini

      // Tambahkan nilai 'Pembuangan' di bawah kolom yang sesuai
      final plastikRows = addPembuanganRows(data['Plastik'], 'Plastik');
      final gelasRows = addPembuanganRows(data['Gelas'], 'Gelas');
      final kalengRows = addPembuanganRows(data['Kaleng'], 'Kaleng');
      final resetRows = addPembuanganRows(data['Reset'], 'Reset');

      // Menentukan jumlah baris maksimal dari semua kolom
      final maxRows = [
        plastikRows.length,
        gelasRows.length,
        kalengRows.length,
        resetRows.length,
      ].reduce((value, element) => value > element ? value : element);

      // Menambahkan baris ke sheet
      for (int i = 0; i < maxRows; i++) {
        sheet.appendRow([
          if (i < plastikRows.length) plastikRows[i] else '',
          if (i < gelasRows.length) gelasRows[i] else '',
          if (i < kalengRows.length) kalengRows[i] else '',
          if (i < resetRows.length) resetRows[i] else '',
        ]);
      }

      sheet.appendRow([]); // Tambahkan baris kosong sebagai pemisah antar data dokumen
    }

    final status = await Permission.storage.request();
    if (!status.isGranted) {
      print("Izin penyimpanan tidak diberikan, file tidak dapat disimpan.");
      return;
    }

    // Mengambil alamat direktori "Download" pada perangkat Android
    final Directory? downloadDirectory = Platform.isAndroid
        ? Directory('/storage/emulated/0/Download')
        : await getDownloadsDirectory();

    if (downloadDirectory != null) {
      final File file = File('${downloadDirectory.path}/Data_Sampah.xlsx');
      file.writeAsBytesSync(excel.encode()!);
      final snackBar = SnackBar(
        content: Text("Data sampah berhasil diunduh dan disimpan di ${file.path}"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar); // Pastikan Anda memiliki context yang sesuai
    } else {
      print("Tidak dapat menemukan direktori 'Download'. File tidak dapat disimpan.");
    }
  }

  List<String> addPembuanganRows(dynamic mapData, String columnName) {
    final rows = <String>[];

    if (mapData != null && mapData is Map<String, dynamic>) {
      mapData.forEach((namaAcak, innerMap) {
        if (innerMap != null && innerMap is Map<String, dynamic>) {
          final pembuangan = innerMap['pembuangan'];
          if (pembuangan != null) {
            rows.add(pembuangan);
          }
        }
      });
    }

    return rows;
  }
}
