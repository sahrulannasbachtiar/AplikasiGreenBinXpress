import 'package:flutter/material.dart';
import 'package:greenbinxpress/Api/sampah.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:greenbinxpress/Api/sampah_card.dart';
import 'package:greenbinxpress/Api/sampah_edit.dart';
import 'package:greenbinxpress/Api/sampah_add.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetorSampah extends StatefulWidget {
  const SetorSampah({super.key});

  @override
  State<SetorSampah> createState() => _SetorSampahState();
}

class _SetorSampahState extends State<SetorSampah> {
  Future<List<Sampah>> fetchSampah() async {
    final response =
        await http.get(Uri.parse('http://192.168.100.21:8080/sampah'));

    if (response.statusCode == 200) {
      var getPostsData = json.decode(response.body) as List;
      var listSampah = getPostsData.map((i) => Sampah.fromJson(i)).toList();

      return listSampah;
    } else {
      throw Exception('Failed to load sampah');
    }
  }

  late Future<List<Sampah>> futureSampah;
  int totalKoin = 0;

  void navSampahAdd() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SampahAdd(data: '')),
    ).then((value) {
      if (value == 'refresh') {
        setState(() {
          futureSampah = fetchSampah();
        });
      }
    });
  }

  void navSampahEdit(String data) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SampahEdit(id: data)));
  }

  @override
  void initState() {
    super.initState();
    futureSampah = fetchSampah();
    _loadSaldoKoin();
  }

  // Fungsi untuk menyimpan saldo koin ke SharedPreferences
  Future<void> _saveSaldoKoin(int koin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('totalKoin', koin);
  }

  // Fungsi untuk memuat saldo koin dari SharedPreferences
  Future<void> _loadSaldoKoin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      totalKoin = prefs.getInt('totalKoin') ?? 0;
    });
  }

  void _updateSaldoKoin(int koin) {
    setState(() {
      totalKoin += koin;
    });
    _saveSaldoKoin(totalKoin);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        toolbarHeight: 40,
        backgroundColor: const Color(0XFF81C784),
        title: const Padding(
          padding: EdgeInsets.only(top: 5),
          child: Column(
            children: [
              Text(
                'Daftar Setoran Sampah',
                style: TextStyle(fontSize: 25),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 248, 249, 255),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                ),
              ),
              height: 25,
            ),
          ),
          Column(
            children: [
              _buildSaldoSection(),
              const SizedBox(height: 20),
            ],
          ),
          Expanded(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: FutureBuilder<List<Sampah>>(
                  future: futureSampah,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.separated(
                        itemBuilder: (context, index) {
                          var sampah = (snapshot.data as List<Sampah>)[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SampahCard(
                                sampah: Sampah(
                                  idSampah: sampah.idSampah,
                                  jenisSampah: sampah.jenisSampah,
                                  namaSampah: sampah.namaSampah,
                                  beratSampah: sampah.beratSampah,
                                  jenisAngkutan: sampah.jenisAngkutan,
                                  koin: '',
                                ),
                                onKoinChanged: _updateSaldoKoin,
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        itemCount: (snapshot.data as List<Sampah>).length,
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: navSampahAdd,
        tooltip: 'Add Sampah',
        child: const Icon(Icons.library_add),
        backgroundColor: Color(0XFF81C784),
        foregroundColor: Colors.white,
      ),
    );
  }

  Widget _buildSaldoSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 242, 243, 247),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Color(0XFF81C784),
            offset: Offset(0, 3),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Saldo Terkumpul',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Rp $totalKoin',
            // 'Rp 10',
            style: TextStyle(
              color: Colors.green[300],
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
