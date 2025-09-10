import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

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
    AnggotaScreen(), // Halaman untuk tab 'Anggota'
    KalkulatorScreen(), // Halaman untuk tab 'Kalkulator'
    GanjilGenapScreen(), // Halaman untuk tab 'Ganjil Genap'
    //
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Beri sedikit warna latar belakang
      appBar: AppBar(
        title: const Text('Halaman Utama'),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      // Body sekarang akan menampilkan halaman yang dipilih dari _widgetOptions
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        // PERBAIKAN: Padding ditambahkan kembali untuk efek melayang
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

// ===================================================================
// HALAMAN-HALAMAN TUJUAN
// ===================================================================

// PENINGKATAN: Membuat class untuk struktur data anggota yang lebih baik
class Member {
  final String name;
  final String nim;

  Member({required this.name, required this.nim});
}

/// Halaman untuk menampilkan daftar anggota
class AnggotaScreen extends StatelessWidget {
  const AnggotaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // PENINGKATAN: Menggunakan List dari object Member
    final List<Member> groupMembers = [
      Member(name: 'Nayla Ayu Rahmawati', nim: '124230015'),
      Member(name: 'Ardan Haryanto Putra', nim: '124230104'),
      Member(name: 'Muhammad Nobel Wurjayatma', nim: '124230114'),
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Anggota Kelompok:',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: groupMembers.length,
              itemBuilder: (context, index) {
                // Mengambil data member pada indeks saat ini
                final member = groupMembers[index];
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.deepPurple[100],
                      child: Text(
                        member.name[0], // Ambil huruf pertama dari nama
                        style: const TextStyle(color: Colors.deepPurple),
                      ),
                    ),
                    title: Text(
                      member.name, // Gunakan nama dari object
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    // PERBAIKAN: Hanya ada satu subtitle dan sekarang menampilkan NIM
                    subtitle: Text(member.nim), // Gunakan NIM dari object
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Halaman Placeholder untuk Kalkulator
class KalkulatorScreen extends StatelessWidget {
  const KalkulatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: KalkulatorForm(),
    );
    }
}

  class KalkulatorForm extends StatefulWidget {
    @override
    State<KalkulatorForm> createState() => _KalkulatorFormState();
  }

  class _KalkulatorFormState extends State<KalkulatorForm> {
    final TextEditingController _controller1 = TextEditingController();
    final TextEditingController _controller2 = TextEditingController();
    String _selectedOperator = '+';
    String _result = '';

    void _hitung() {
    double? num1 = double.tryParse(_controller1.text);
    double? num2 = double.tryParse(_controller2.text);

    if (num1 == null || num2 == null) {
      setState(() {
      _result = 'Input tidak valid';
      });
      return;
    }

    double hasil;
    switch (_selectedOperator) {
      case '+':
      hasil = num1 + num2;
      break;
      case '-':
      hasil = num1 - num2;
      break;
      case '×':
      hasil = num1 * num2;
      break;
      case '÷':
      if (num2 == 0) {
        setState(() {
        _result = 'Tidak bisa dibagi 0';
        });
        return;
      }
      hasil = num1 / num2;
      break;
      default:
      hasil = 0;
    }

    setState(() {
      _result = 'Hasil: $hasil';
    });
    }

    @override
    Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      const Text(
        'Kalkulator Sederhana',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 16),
      TextField(
        controller: _controller1,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
        labelText: 'Bilangan pertama',
        border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 12),
      TextField(
        controller: _controller2,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
        labelText: 'Bilangan kedua',
        border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 12),
      Row(
        children: [
        const Text('Operasi:'),
        const SizedBox(width: 16),
        DropdownButton<String>(
          value: _selectedOperator,
          items: const [
          DropdownMenuItem(value: '+', child: Text('+')),
          DropdownMenuItem(value: '-', child: Text('-')),
          DropdownMenuItem(value: '×', child: Text('×')),
          DropdownMenuItem(value: '÷', child: Text('÷')),
          ],
          onChanged: (value) {
          setState(() {
            _selectedOperator = value!;
          });
          },
        ),
        ],
      ),
      const SizedBox(height: 16),
      SizedBox(
        width: double.infinity,
        child: ElevatedButton(
        onPressed: _hitung,
        child: const Text('Hitung'),
        ),
      ),
      const SizedBox(height: 16),
      Text(
        _result,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      ],
    );
    }
  }


/// Halaman untuk menentukan Ganjil atau Genap
class GanjilGenapScreen extends StatefulWidget {
  const GanjilGenapScreen({super.key});

  @override
  State<GanjilGenapScreen> createState() => _GanjilGenapScreenState();
}

class _GanjilGenapScreenState extends State<GanjilGenapScreen> {
  final TextEditingController _controller = TextEditingController();
  String _result = '';

  void _tentukan() {
    final input = _controller.text.trim();
    final int? angka = int.tryParse(input);

    if (angka == null) {
      setState(() {
        _result = 'Input tidak valid';
      });
      return;
    }

    setState(() {
      if (angka % 2 == 0) {
        _result = 'Bilangan $angka adalah Genap';
      } else {
        _result = 'Bilangan $angka adalah Ganjil';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Penentu Ganjil atau Genap',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Masukkan angka',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _tentukan,
              child: const Text('Tentukan'),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            _result,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}