import 'package:flutter/material.dart';

// Class untuk struktur data anggota
class Member {
  final String name;
  final String nim;
  final String imagePath;

  Member({required this.name, required this.nim, required this.imagePath});
}

// Halaman untuk menampilkan daftar anggota
class MemberScreen extends StatelessWidget {
  const MemberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Daftar anggota dengan nama, NIM, dan path gambar
    final List<Member> groupMembers = [
      Member(
          name: 'Nayla Ayu',
          nim: '124230020',
          imagePath: 'assets/profile_pictures/nayla.jpg'),
      Member(
          name: 'Ardan Haryanto Putra',
          nim: '124230104',
          imagePath: 'assets/images/ardan.jpg'),
      Member(
          name: 'Muhammad Nobel Wurjayatma',
          nim: '124230114',
          imagePath: 'assets/profile_pictures/nobel.jpg'),
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Anggota Kelompok',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              itemCount: groupMembers.length,
              itemBuilder: (context, index) {
                final member = groupMembers[index];
                return Card(
                  elevation: 8, // Meningkatkan elevasi untuk efek bayangan yang lebih jelas
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Sudut yang lebih membulat
                  ),
                  margin: const EdgeInsets.only(bottom: 16), // Jarak antar card yang lebih besar
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(member.imagePath),
                          radius: 35, // Ukuran avatar yang lebih besar
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                member.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.deepPurple,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                member.nim,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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