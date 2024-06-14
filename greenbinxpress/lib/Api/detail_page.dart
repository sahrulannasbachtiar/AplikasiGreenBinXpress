import 'package:flutter/material.dart';
import 'package:greenbinxpress/Api/sampah.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:greenbinxpress/Api/sampah_edit.dart';

class DetailPage extends StatefulWidget {
  final Sampah sampah;

  DetailPage({required this.sampah});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Future<void> delSampah(String data) async {
    final response =
        await http.delete(Uri.parse('http://192.168.100.21:8080/sampah/$data'));

    if (response.statusCode == 200) {
      var getPostsData = json.decode(response.body);
      print(getPostsData);
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Message'),
          content: Text(getPostsData['messages']['success']),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'OK');
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => const AlertDialog(
          title: Text('Message'),
          content: Text("Failed to delete sampah!"),
          actions: <Widget>[
            TextButton(
              onPressed: null,
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void navSampahEdit(String data) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SampahEdit(id: data)));
  }

  int calculateKoin(String jenisSampah, String beratSampah) {
    double berat = double.tryParse(beratSampah) ?? 0.0;
    switch (jenisSampah.toLowerCase()) {
      case 'organik':
        return (3000 * berat).toInt();
      case 'anorganik':
        return (5000 * berat).toInt();
      case 'b3':
        return (7000 * berat).toInt();
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    String beratSampah = widget.sampah.beratSampah;
    String jenisSampah = widget.sampah.jenisSampah;
    int koin = calculateKoin(jenisSampah, beratSampah);

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        toolbarHeight: 40,
        backgroundColor: const Color(0XFF81C784),
        title: const Text(
          'Detail Sampah',
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
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
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 0),
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoRow(Icons.category, 'Jenis Sampah',
                            jenisSampahToString(widget.sampah.jenisSampah)),
                        SizedBox(height: 10),
                        _buildInfoRow(Icons.delete_sweep_rounded, 'Nama Sampah',
                            (widget.sampah.namaSampah)),
                        SizedBox(height: 10),
                        _buildInfoRow(
                            Icons.scale, 'Berat Sampah', '${beratSampah} kg'),
                        SizedBox(height: 10),
                        _buildInfoRow(Icons.local_shipping, 'Jenis Angkutan',
                            jenisAngkutanToString(widget.sampah.jenisAngkutan)),
                        SizedBox(height: 10),
                        _buildInfoRow(Icons.monetization_on, 'Koin', '${koin}'),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                navSampahEdit(widget.sampah.idSampah);
                              },
                              child: const Icon(Icons.edit, color: Colors.blue),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text('Message'),
                                    content: const Text(
                                        "Apakah yakin ingin menghapus?"),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context, 'Tidak');
                                        },
                                        child: const Text('Tidak'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context, 'Iya');
                                          delSampah(widget.sampah.idSampah);
                                        },
                                        child: const Text('Iya'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child:
                                  const Icon(Icons.delete, color: Colors.red),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.green, size: 23),
        SizedBox(width: 15),
        Text('$label: ',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Expanded(child: Text(value, style: TextStyle(fontSize: 18))),
      ],
    );
  }

  String jenisSampahToString(String jenis) {
    switch (jenis) {
      case 'Organik':
        return 'Organik';
      case 'Anorganik':
        return 'Anorganik';
      case 'B3':
        return 'B3';
      default:
        return jenis;
    }
  }

  String jenisAngkutanToString(String jenis) {
    switch (jenis) {
      case 'Gerobak Sampah':
        return 'Gerobak Sampah';
      case 'Motor Sampah':
        return 'Motor Sampah';
      case 'Truk Sampah':
        return 'Truk Sampah';
      default:
        return jenis;
    }
  }
}
