import 'package:flutter/material.dart';
import '../catalog_screen/catalog_screen.dart';
import '../data_sampah_screen/data_sampah_screen.dart';
import '../data_pengambilan_sampah_screen/data_pengambilan_sampah_screen.dart';
import '../setting_screen/setting_screen.dart';


class MainScreen extends StatefulWidget {
  final int selectedIndex;

  MainScreen({required Key key, this.selectedIndex = 0}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState(selectedIndex);
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex;

  _MainScreenState(this._selectedIndex);

  final List<Widget> _screens = [
    CatalogScreen(key: UniqueKey()), // Menggunakan GlobalKey yang berbeda
    DataSampahScreen(key: UniqueKey()), // Menggunakan GlobalKey yang berbeda
    DataPengambilanSampahScreen(key: UniqueKey()), // Menggunakan GlobalKey yang berbeda
    SettingScreen(key: UniqueKey()), // Menggunakan GlobalKey yang berbeda
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Katalog',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Data Sampah',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Pengambilan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Pengaturan',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.brown,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
