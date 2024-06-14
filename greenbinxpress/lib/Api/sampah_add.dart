import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SampahAdd extends StatefulWidget {
  const SampahAdd({super.key, required this.data});

  final String data;

  @override
  State<SampahAdd> createState() => _SampahAddState();
}

class _SampahAddState extends State<SampahAdd> {
  late String idSampah;
  final _formKey = GlobalKey<FormState>();
  final apiUrl = "http://192.168.100.21:8080/sampah/create";
  String? jenisSampah;
  String namaSampah = '';
  String? beratSampah;
  String jenisAngkutan = '';

  @override
  void initState() {
    super.initState();
    idSampah = widget.data;
  }

  Future<void> sendPostRequest() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final Map<String, dynamic> data = {
      'jenis_sampah': jenisSampah!,
      'nama_sampah': namaSampah,
      'berat_sampah': beratSampah!,
      'jenis_angkutan': jenisAngkutan,
    };
    var map = <String, dynamic>{};
    map['jenis_sampah'] = jenisSampah;
    // print(apiUrl);
    // print(data);
    // print(map);
    final response = await http.post(Uri.parse(apiUrl), body: data);
    // print(response.statusCode);
    if (response.statusCode == 201) {
      var getSampahData = json.decode(response.body);
      print(getSampahData);
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Message'),
          content: Text(getSampahData['messages']['success']),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'OK');
                navHomePage();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Message'),
          content: const Text("Failed to create sampah!"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'OK');
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void navHomePage() {
    Navigator.pop(context, 'refresh');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        toolbarHeight: 40,
        title: const Text(
          'Setorkan Sampah',
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: const Color(0XFF81C784),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, 'refresh');
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color(0XFF81C784),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                ),
              ),
              height: 25,
            ),
            Container(
              color: const Color(0XFF81C784),
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 248, 249, 255),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                  ),
                ),
                height: 25,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildDropdownField(Icons.category, 'Jenis Sampah',
                        ['Organik', 'Anorganik', 'B3']),
                    _buildTextField(Icons.delete_sweep_rounded, 'Nama Sampah',
                        (value) {
                      setState(() {
                        namaSampah = value;
                      });
                    }),
                    _buildTextField(Icons.scale, 'Berat Sampah (kg)', (value) {
                      setState(() {
                        beratSampah = value;
                      });
                    }, keyboardType: TextInputType.number),
                    _buildDropdownField(Icons.local_shipping, 'Jenis Angkutan',
                        ['Gerobak Sampah', 'Motor Sampah', 'Truk Sampah']),
                    const SizedBox(height: 30),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          await sendPostRequest();
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 12,
                          ),
                          backgroundColor: const Color(0XFF81C784),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const SizedBox(
                            child: Text(
                          "Setorkan",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      IconData icon, String labelText, Function(String) onChanged,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Icon(icon, color: Colors.green),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: labelText,
                    border: InputBorder.none,
                    hintText: 'Masukkan $labelText',
                  ),
                  keyboardType: keyboardType,
                  onChanged: onChanged,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan $labelText';
                    }
                    if (labelText == 'Berat Sampah (kg)' &&
                        double.tryParse(value) == null) {
                      return 'Masukkan nilai yang valid';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField(
      IconData icon, String labelText, List<String> items) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Icon(icon, color: Colors.green),
              const SizedBox(width: 10),
              Expanded(
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: labelText,
                    border: InputBorder.none,
                  ),
                  items: items
                      .map((item) => DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      if (labelText == 'Jenis Sampah') {
                        jenisSampah = value;
                      } else if (labelText == 'Jenis Angkutan') {
                        jenisAngkutan = value!;
                      }
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Pilih $labelText';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
