import 'package:flutter/material.dart';

class DetailRiwayatPage extends StatelessWidget {
  final String tanggalDiagnosis;
  final String nama;
  final String statusDiagnosis;
  final String penyakit;
  final String tanggalPenyakit;
  final List<String> langkahPenanganan;

  DetailRiwayatPage({
    required this.tanggalDiagnosis,
    required this.nama,
    required this.statusDiagnosis,
    required this.penyakit,
    required this.tanggalPenyakit,
    required this.langkahPenanganan,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Riwayat'),
        backgroundColor: Colors.blue[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Judul Hasil Diagnosa
            Text(
              'Hasil Diagnosa',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // Informasi Diagnosa
            _buildInfoRow('Tanggal Diagnosa:', tanggalDiagnosis),
            _buildInfoRow('Nama:', nama),
            _buildInfoRow('Status Diagnosa:', statusDiagnosis),
            SizedBox(height: 20),
            // Informasi Penyakit
            Text(
              'Penyakit: $penyakit',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(tanggalPenyakit, style: TextStyle(color: Colors.grey)),
            SizedBox(height: 10),
            // Langkah Penanganan
            Text(
              'Langkah Penanganan:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            ...langkahPenanganan.map((langkah) => Text('• $langkah')).toList(),
            Spacer(),
            // Tombol Selesai
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Aksi ketika tombol "Selesai" ditekan
                  Navigator.pop(context);
                },
                child: Text('Selesai'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue[900],
                  onPrimary: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontSize: 16),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
