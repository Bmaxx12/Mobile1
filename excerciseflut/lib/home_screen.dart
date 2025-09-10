import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'styles.dart';

// Import halaman-halaman yang baru dibuat
import 'anggota.dart';
import 'kalkulator.dart';
import 'oddcheck.dart';
import 'totalangka.dart';

// Definisikan AppColors jika belum ada
class AppColors {
  static const Color darkGrey = Colors.black54;
}

// Halaman Utama yang akan mengatur navigasi
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // State untuk melacak indeks halaman yang aktif
  int _selectedIndex = 0;

  // Daftar widget/halaman yang akan ditampilkan sesuai dengan tab yang dipilih
  static const List<Widget> _widgetOptions = <Widget>[
    MemberScreen(), // Halaman untuk tab 'Anggota'
    CalculatorScreen(), // Halaman untuk tab 'Kalkulator'
    OddEvenScreen(),
    Totalangka(), // Halaman untuk tab 'Ganjil Genap'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('TUGAS PAM 1',style: TextStyles.title,),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: const BorderRadius.all(Radius.circular(25)),
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.1),
              )
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,
                gap: 8,
                activeColor: Colors.white,
                iconSize: 24,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: AppColors.darkGrey.withOpacity(0.5),
                color: Colors.white,
                tabs: const [
                  GButton(
                    icon: Icons.people,
                    text: 'Anggota',
                  ),
                  GButton(
                    icon: Icons.calculate,
                    text: 'Kalkulator',
                  ),
                  GButton(
                    icon: Icons.repeat,
                    text: 'Ganjil Genap',
                  ),
                  GButton(
                    icon: Icons.summarize,
                    text: 'Totalangka',
                  ),
                  
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}