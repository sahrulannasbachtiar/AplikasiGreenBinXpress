import 'package:flutter/material.dart';
import 'package:greenbinxpress/berita/nav_beranda.dart';
import 'package:greenbinxpress/profil.dart';
import 'package:greenbinxpress/Api/setor_sampah.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final listPage = <Widget>[
      // ignore: prefer_const_constructors
      NavBeranda(),
      SetorSampah(),
      Profil(),
    ];

    // ignore: no_leading_underscores_for_local_identifiers
    final _bottomNavBarItems = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
      const BottomNavigationBarItem(
        icon: ImageIcon(
          AssetImage('assets/logo1.png'),
          size: 24.0,
        ),
        label: 'Setor Sampah',
      ),
      const BottomNavigationBarItem(
          icon: Icon(Icons.person_3_sharp), label: 'Profil'),
    ];

    // ignore: no_leading_underscores_for_local_identifiers
    final _bottomNavBar = BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: _bottomNavBarItems,
      currentIndex: _selectedIndex,
      selectedItemColor: Color(0XFF81C784),
      onTap: _onItemTapped,
    );

    return Scaffold(
      body: Center(
        child: listPage[_selectedIndex],
      ),
      bottomNavigationBar: _bottomNavBar,
    );
  }
}
