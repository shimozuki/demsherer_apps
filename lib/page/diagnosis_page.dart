import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sistem_pakar/model/symptom_model.dart';
import 'dart:convert';

class DiagnosisPage extends StatefulWidget {
  @override
  _DiagnosisPageState createState() => _DiagnosisPageState();
}

class _DiagnosisPageState extends State<DiagnosisPage> {
  List<Symptom> symptoms = [];
  String? selectedSymptom;

  @override
  void initState() {
    super.initState();
    fetchSymptoms();
  }

  Future<void> fetchSymptoms() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/symptoms'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        symptoms = data
            .map((symptom) => Symptom(
                  id: symptom['id'].toString(),
                  description: symptom['description'],
                ))
            .toList();
      });
    } else {
      throw Exception('Failed to load symptoms');
    }
  }

  Future<void> submitDiagnosis() async {
    if (selectedSymptom == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Silakan pilih gejala')),
      );
      return;
    }

    final response = await http.post(
      Uri.parse(
          'https://lightsalmon-clam-342428.hostingersite.com/api/gejalas'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'symptom_id': selectedSymptom!,
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Diagnosis berhasil dikirim')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengirim diagnosis')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diagnosa'),
        backgroundColor: Colors.blue[900], // Ubah warna AppBar
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
                  return RadioListTile<String>(
                    title: Text(symptoms[index].description),
                    value: symptoms[index].id,
                    groupValue: selectedSymptom,
                    onChanged: (value) {
                      setState(() {
                        selectedSymptom = value;
                      });
                    },
                  );
                },
              ),
            ),
            Center(
              // Tempatkan tombol di tengah
              child: ElevatedButton(
                onPressed: submitDiagnosis,
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
