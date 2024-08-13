import 'package:flutter/material.dart';
import 'package:gezi_rehberi/sayfalar/kesfet.dart';
import 'package:gezi_rehberi/sayfalar/rota.dart';
import 'package:gezi_rehberi/sayfalar/profil.dart';
import 'package:gezi_rehberi/sayfalar/rehber.dart';
import 'package:gezi_rehberi/renkler.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int aktifsayfa = 0;

  final List<Widget> sayfalar = [
    const Kesfet(),
    const Haritam(),
    const Rehber(),
    const Profil(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Image.asset('resimler/my_travel.png'),
        ),
        backgroundColor: yazirenk2,
        actions: [
          IconButton(
            icon: SizedBox(child: Icon(Icons.settings, color: yazirenk6)),
            onPressed: () {},
          ),
        ],
        title: const Center(
          child: Text(
            "MyTravel",
            style: TextStyle(
              fontFamily: 'ReemKufiun',
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        toolbarHeight: 65, // AppBar boyutu
      ),
      body: sayfalar[aktifsayfa],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              backgroundColor: Color(0xFFBF785E),
              icon: Icon(Icons.explore_outlined),
              label: "Keşfet"),
          BottomNavigationBarItem(
              backgroundColor: Color(0xFFBF785E),
              icon: Icon(Icons.map_rounded),
              label: "Rota"),
          BottomNavigationBarItem(
              backgroundColor: Color(0xFFBF785E),
              icon: Icon(Icons.location_on),
              label: "Rehber"),
          BottomNavigationBarItem(
              backgroundColor: Color(0xFFBF785E),
              icon: Icon(Icons.account_circle_outlined),
              label: "Profil"),
        ],
        currentIndex: aktifsayfa,
        //backgroundColor: yazirenk1,
        selectedItemColor: yazirenk6,
        unselectedItemColor: yazirenk6,
        onTap: (index) {
          setState(() {
            aktifsayfa = index;
          });
        },
      ),
    );
  }

  String _getAppBarTitle(int index) {
    switch (index) {
      case 0:
        return 'Anasayfa';
      case 1:
        return 'Haritam';
      case 2:
        return 'Rehber';
      case 3:
        return 'Profil';
      default:
        return 'Anasayfa';
    }
  }
}
