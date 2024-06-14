import 'package:flutter/material.dart';
import 'package:greenbinxpress/Api/sampah.dart';
import 'package:greenbinxpress/Api/detail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SampahCard extends StatefulWidget {
  final Sampah sampah;
  final Function(int) onKoinChanged;

  const SampahCard({
    Key? key,
    required this.sampah,
    required this.onKoinChanged,
  }) : super(key: key);

  @override
  _SampahCardState createState() => _SampahCardState();
}

class _SampahCardState extends State<SampahCard> {
  bool isSetor = false;

  @override
  void initState() {
    super.initState();
    _loadSetorStatus();
  }

  void _loadSetorStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isSetor = prefs.getBool('isSetor_${widget.sampah.idSampah}') ?? false;
    });
  }

  void _saveSetorStatus(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isSetor_${widget.sampah.idSampah}', value);
  }

  int calculateKoin() {
    double berat = double.tryParse(widget.sampah.beratSampah) ?? 0.0;
    switch (widget.sampah.jenisSampah.toLowerCase()) {
      case 'organik':
        return (3000 * berat).toInt();
      case 'anorganik':
        return (5000 * berat).toInt();
      case 'b3':
        return (2000 * berat).toInt();
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    int koin = calculateKoin();

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(sampah: widget.sampah),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.category, color: Colors.green),
                  const SizedBox(width: 10),
                  Text(
                    'Jenis Sampah: ${jenisSampahToString(widget.sampah.jenisSampah)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.delete_sweep_rounded, color: Colors.green),
                  const SizedBox(width: 10),
                  Text(
                    'Nama Sampah: ${widget.sampah.namaSampah}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.scale, color: Colors.green),
                  const SizedBox(width: 10),
                  Text(
                    'Berat: ${widget.sampah.beratSampah} kg',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.monetization_on, color: Colors.green),
                  const SizedBox(width: 10),
                  Text(
                    'Koin: ${koin}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SwitchListTile(
                title: const Text('Penyetoran Selesai'),
                value: isSetor,
                onChanged: (bool value) {
                  setState(() {
                    isSetor = value;
                    _saveSetorStatus(value);
                    widget.onKoinChanged(value ? koin : -koin);
                  });
                },
                secondary: Icon(
                  isSetor ? Icons.check_circle : Icons.check_circle_outline,
                  color: isSetor ? Colors.green : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String jenisSampahToString(String jenis) {
    switch (jenis) {
      case 'organik':
        return 'Organik';
      case 'anorganik':
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
