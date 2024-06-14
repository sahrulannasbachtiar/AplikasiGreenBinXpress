import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class SampahEdit extends StatefulWidget {
  const SampahEdit({super.key, required this.id});

  final String id;

  @override
  State<SampahEdit> createState() => _SampahEditState();
}

class _SampahEditState extends State<SampahEdit> {
  late String idSampah;
  final apiUrl = "http://192.168.100.21:8080/sampah/edit/";
  TextEditingController namaSampahController = TextEditingController();
  TextEditingController beratSampahController = TextEditingController();
  String? selectedJenisSampah;
  final List<String> jenisSampahList = ['Organik', 'Anorganik', 'B3'];
  String? selectedJenisAngkutan;
  final List<String> jenisAngkutanList = [
    'Gerobak Sampah',
    'Motor Sampah',
    'Truk Sampah'
  ];

  @override
  void initState() {
    super.initState();
    idSampah = widget.id;
    fetchSampah(idSampah);
  }

  Future<void> fetchSampah(String data) async {
    final response =
        await http.get(Uri.parse('http://192.168.100.21:8080/sampah/$data'));

    if (response.statusCode == 200) {
      var getSampahData = json.decode(response.body);
      setState(() {
        selectedJenisSampah =
            jenisSampahList.contains(getSampahData['jenis_sampah'])
                ? getSampahData['jenis_sampah']
                : null;
        selectedJenisAngkutan =
            jenisAngkutanList.contains(getSampahData['jenis_angkutan'])
                ? getSampahData['jenis_angkutan']
                : null;
        namaSampahController.text = getSampahData['nama_sampah'];
        beratSampahController.text = getSampahData['berat_sampah'];
      });
    } else {
      throw Exception('Failed to load Sampah');
    }
  }

  Future<void> updateSampahRequest() async {
    var map = <String, dynamic>{};
    map['jenis_sampah'] = selectedJenisSampah!;
    map['nama_sampah'] = namaSampahController.text;
    map['berat_sampah'] = beratSampahController.text;
    map['jenis_angkutan'] = selectedJenisAngkutan!;
    var response = await http.post(Uri.parse(apiUrl + idSampah), body: map);

    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var getSampahData = json.decode(response.body);
      print('berhasil');
      print(getSampahData['messages']);
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Message'),
          content: Text(getSampahData['messages']['success']),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'refresh');
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      print('gagal');
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Message'),
          // content: const Text('Data sampah berhasil diubah'),
          content: const Text('Failed to create sampah!'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        toolbarHeight: 40,
        title: const Text(
          'Edit Sampah',
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
          children: <Widget>[
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
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 0),
              child: Column(
                children: <Widget>[
                  _buildDropdownField(Icons.category, 'Jenis Sampah',
                      jenisSampahList, selectedJenisSampah, (value) {
                    setState(() {
                      selectedJenisSampah = value;
                    });
                  }),
                  _buildTextField(Icons.delete_sweep_rounded, 'Nama Sampah',
                      namaSampahController, TextInputType.text),
                  _buildTextField(Icons.scale, 'Berat Sampah (kg)',
                      beratSampahController, TextInputType.number),
                  _buildDropdownField(Icons.local_shipping, 'Jenis Angkutan',
                      jenisAngkutanList, selectedJenisAngkutan, (value) {
                    setState(() {
                      selectedJenisAngkutan = value;
                    });
                  }),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: updateSampahRequest,
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
                        "Edit Sampah",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(IconData icon, String labelText,
      TextEditingController controller, TextInputType keyboardType) {
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
                  controller: controller,
                  decoration: InputDecoration(
                    labelText: labelText,
                    border: InputBorder.none,
                    hintText: 'Masukkan $labelText',
                  ),
                  keyboardType: keyboardType,
                  inputFormatters: keyboardType == TextInputType.number
                      ? <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ]
                      : null,
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

  Widget _buildDropdownField(IconData icon, String labelText,
      List<String> items, String? selectedValue, Function(String?) onChanged) {
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
                  value: selectedValue,
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
                  onChanged: onChanged,
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
