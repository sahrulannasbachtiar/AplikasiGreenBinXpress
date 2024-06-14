import 'package:flutter/material.dart';
import 'package:greenbinxpress/berita/berita.dart';

class DetailBerita extends StatelessWidget {
  final Berita berita;

  DetailBerita({required this.berita});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          berita.judul,
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
        backgroundColor: Colors.green[300],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          // ignore: sort_child_properties_last
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                berita.judul,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[300],
                ),
              ),
              SizedBox(height: 10),
              Divider(color: Colors.green[300], thickness: 2),
              SizedBox(height: 10),
              Text(
                berita.konten,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          margin: EdgeInsets.all(20),
        ),
      ),
    );
  }
}
