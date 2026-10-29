import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiProfilDanu());
}

class AplikasiProfilDanu extends StatelessWidget {
  const AplikasiProfilDanu({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tugas Aplikasi Profil',
      theme: ThemeData(
        // Punya lu biarin biru, punya Danu gw set Teal biar beda
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: HalamanProfilUtama(),
    );
  }
}

// REFACTOR: Memisahkan kerangka halaman dari MainApp
class HalamanProfilUtama extends StatelessWidget {
  HalamanProfilUtama({super.key});

  final String namaDosen = 'I Ketut Gunawan, S.Kom, M.T.I.';
  final String profesi = 'Senior Backend Engineer & Dosen';
  final List<String> riwayatKerja = [
    'Senior Backend Engineer - EDC Bank DKI',
    'Backend & System Architect - Secure Payment EDC',
    'Lead Developer - Aplikasi Sekurindo',
    'Backend Engineer - Pengembangan Sistem E-money', // Koma diperbaiki
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Mahasiswa'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const AvatarProfil(), // Extract Widget 1
            const SizedBox(height: 16),
            InfoProfil(nama: namaDosen, role: profesi), // Extract Widget 2
            const SizedBox(height: 24),
            
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Fitur edit belum aktif.')),
                );
              },
              icon: const Icon(Icons.edit),
              label: const Text('Edit Profil'),
            ),
            const SizedBox(height: 24),
            
            const WidgetStatistik(), // Extract Widget 3
            const SizedBox(height: 24),
            
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Pengalaman Kerja',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(),
            
            // BUG FIXED: Dibungkus Expanded biar tidak error layout
            Expanded(
              child: ListView.builder(
                itemCount: riwayatKerja.length,
                itemBuilder: (context, index) {
                  return KartuPengalaman(pengalaman: riwayatKerja[index]); // Extract Widget 4
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// REUSABLE COMPONENTS (EXTRACT WIDGETS)
// ==========================================

class AvatarProfil extends StatelessWidget {
  const AvatarProfil({super.key});
  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 50,
      backgroundColor: Colors.grey,
      child: Icon(Icons.person, size: 50, color: Colors.white),
    );
  }
}

class InfoProfil extends StatelessWidget {
  final String nama;
  final String role;
  const InfoProfil({super.key, required this.nama, required this.role});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          nama,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          role,
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class WidgetStatistik extends StatelessWidget {
  const WidgetStatistik({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.teal[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ItemStatistik(count: '15', label: 'Proyek'),
          SizedBox(width: 24), // BUG FIXED: Diganti width
          ItemStatistik(count: '1.2K', label: 'Followers'),
          SizedBox(width: 24), // BUG FIXED: Diganti width
          ItemStatistik(count: '42', label: 'Following'), // BUG FIXED: Int to String
        ],
      ),
    );
  }
}

class ItemStatistik extends StatelessWidget {
  final String count;
  final String label;
  const ItemStatistik({super.key, required this.count, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
      ],
    );
  }
}

class KartuPengalaman extends StatelessWidget {
  final String pengalaman;
  const KartuPengalaman({super.key, required this.pengalaman});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: const Icon(Icons.work, color: Colors.teal),
        title: Text(pengalaman),
      ),
    );
  }
}