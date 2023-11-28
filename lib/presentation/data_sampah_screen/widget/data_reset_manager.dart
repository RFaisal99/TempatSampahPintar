import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class DataResetManager {
  final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

  void updatePerformReset(String selectedNode) {
    databaseReference.child('Notification').update({
      'performReset': selectedNode,
    });
  }

  // Singleton pattern untuk menghindari pembuatan lebih dari satu instance
  static final DataResetManager _instance = DataResetManager._internal();

  factory DataResetManager() {
    return _instance;
  }

  DataResetManager._internal();
}
