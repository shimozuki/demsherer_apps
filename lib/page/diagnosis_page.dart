import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sistem_pakar/route/routes.dart';

void navigateToDetailRiwayat(BuildContext context) {
  final dummyData = {
    'tanggalDiagnosis': '04 February 2025',
    'nama': 'Jhon Doe',
    'statusDiagnosis': 'Selesai',
    'penyakit': 'Busuk Batang',
    'tanggalPenyakit': '06 Desember 2024',
    'langkahPenanganan': [
      'Tanam varietas tahan seperti Kalingga, Arjuna, dan Hibrida CL.',
      'Tanam Jagung pada Awal sampai akhir kemarau dan secara serempotan.',
      'Gunakan Fungisida sistemik secara semprotan.',
      'Tanam jagung secara serempotan pada awal sampai akhir musim kemarau.'
    ],
  };

  Navigator.pushNamed(
    context,
    Routes.detailRiwayat,
    arguments: dummyData, // Kirim data dummy sebagai argumen
  );
}

class Symptom {
  final String id;
  final String description;

  Symptom({required this.id, required this.description});
}

class DiagnosisPage extends StatefulWidget {
  @override
  _DiagnosisPageState createState() => _DiagnosisPageState();
}

class _DiagnosisPageState extends State<DiagnosisPage> {
  List<Symptom> symptoms = [];
  List<String> selectedSymptoms = [];

  @override
  void initState() {
    super.initState();
    fetchSymptoms();
  }

  Future<void> fetchSymptoms() async {
    final response = await http.get(Uri.parse(
        'https://lightsalmon-clam-342428.hostingersite.com/api/gejalas'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        symptoms = data
            .map((symptom) => Symptom(
                  id: symptom['id'].toString(),
                  description: symptom['nama_gejala'],
                ))
            .toList();
      });
    } else {
      throw Exception('Failed to load symptoms');
    }
  }

  void toggleSymptom(String id) {
    setState(() {
      if (selectedSymptoms.contains(id)) {
        selectedSymptoms.remove(id);
      } else {
        selectedSymptoms.add(id);
      }
    });
  }

  Future<void> submitDiagnosis() async {
    if (selectedSymptoms.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Silakan pilih gejala')),
      );
      return;
    }

    // Kirim data ke API sesuai kebutuhan
    // ...
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diagnosa'),
        backgroundColor: Colors.blue[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Silakan Pilih Gejala',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: symptoms.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text(symptoms[index].description),
                    value: selectedSymptoms.contains(symptoms[index].id),
                    onChanged: (bool? value) {
                      toggleSymptom(symptoms[index].id);
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, // Checkbox di sebelah kiri
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5), // Bentuk bulat
                    ),
                  );
                },
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  navigateToDetailRiwayat(context); // Panggil fungsi navigasi
                },
                child: Text('Submit'),
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
}
