import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greenbinxpress/berita/berita.dart';
import 'package:greenbinxpress/berita/detail_berita.dart';
import 'package:greenbinxpress/notifikasi.dart';

class NavBeranda extends StatelessWidget {
  const NavBeranda({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Berita> beritaList = [
      Berita(
          judul:
              'GreenBinXpress Perkenalkan Fitur Baru untuk Edukasi Daur Ulang',
          konten:
              'Bojonegoro, 5 Juni 2024 - GreenBinXpress memperkenalkan fitur baru yang berfokus pada edukasi daur ulang. Fitur ini menyediakan informasi dan tutorial mengenai cara memilah sampah organik, anorganik, dan B3 dengan benar. Pengguna juga dapat mengikuti kuis interaktif untuk menguji pengetahuan mereka tentang daur ulang. Dengan adanya fitur ini, diharapkan masyarakat Bojonegoro dapat lebih sadar akan pentingnya daur ulang dalam menjaga lingkungan.'),
      Berita(
          judul:
              'Kolaborasi GreenBinXpress dengan Komunitas Lokal untuk Pengelolaan Sampah',
          konten:
              'Bojonegoro, 20 Juni 2024 - GreenBinXpress berkolaborasi dengan berbagai komunitas lokal untuk mengoptimalkan pengelolaan sampah di Bojonegoro. Melalui kolaborasi ini, komunitas-komunitas tersebut akan membantu dalam edukasi masyarakat, pengumpulan sampah, serta pengembangan program daur ulang. Dengan sinergi antara GreenBinXpress dan komunitas lokal, diharapkan pengelolaan sampah di Bojonegoro akan semakin efektif dan berkelanjutan.'),
      Berita(
          judul: 'Inovasi Terbaru dalam Pengelolaan Sampah di Kota Bojonegoro',
          konten:
              'Bojonegoro, 1 Juni 2024 - Pengelolaan sampah di Kota Bojonegoro telah mengalami kemajuan signifikan dengan diperkenalkannya berbagai inovasi terbaru yang bertujuan untuk meningkatkan efektivitas dan efisiensi dalam penanganan sampah. Pemerintah Kota Bojonegoro bekerja sama dengan beberapa organisasi lingkungan dan universitas lokal untuk menerapkan teknologi canggih serta metode pengelolaan sampah yang lebih ramah lingkungan.'),
      Berita(
          judul: 'Program Daur Ulang dan Edukasi Masyarakat',
          konten:
              'Selain teknologi, program daur ulang juga menjadi fokus utama dalam pengelolaan sampah di Bojonegoro. Pemerintah kota telah menyediakan fasilitas daur ulang di berbagai lokasi strategis, serta mengadakan kampanye edukasi untuk masyarakat mengenai pentingnya memilah sampah. Warga diajarkan cara memilah sampah organik, anorganik, dan B3 (Bahan Berbahaya dan Beracun), sehingga proses daur ulang dapat berjalan lebih lancar.'),
    ];

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0XFF81C784),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 50),
                ListTile(
                  leading: IconButton(
                    icon: const Icon(
                      Icons.notifications_active,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NotificationPage(),
                        ),
                      );
                    },
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  title: Text('GreenBinXpress',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: Colors.white)),
                  subtitle: Text('Setorkan Sampahmu disini!',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.white54)),
                  trailing: const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/profil.jpeg'),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          Container(
            color: Colors.green[300],
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 0),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                  )),
              child: Column(
                children: [
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    crossAxisSpacing: 30,
                    mainAxisSpacing: 40,
                    children: [
                      itemDashboard('Tentang Kami',
                          CupertinoIcons.question_circle, Colors.blue),
                      itemDashboard(
                          'Edukasi', CupertinoIcons.book, Colors.purple),
                      itemDashboard(
                          'Hubungi Kami', CupertinoIcons.phone, Colors.teal),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildBeritaSection(context, beritaList),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15)
        ],
      ),
    );
  }

  Widget itemDashboard(String title, IconData iconData, Color background) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
                offset: Offset(0, 3),
                color: Color(0XFF81C784),
                spreadRadius: 1,
                blurRadius: 5)
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: background,
                shape: BoxShape.circle,
              ),
              child: Icon(iconData, color: Colors.white)),
          const SizedBox(height: 8),
          Text(
            title.toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildBeritaSection(BuildContext context, List<Berita> beritaList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          child: Text(
            'Berita Terkini',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: Colors.green[300],
            ),
          ),
        ),
        ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 5),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: beritaList.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.white,
                  child: ListTile(
                    title: Text(
                      beritaList[index].judul,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      beritaList[index].konten,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black45,
                      ),
                    ),
                    trailing:
                        Icon(Icons.arrow_forward_ios, color: Colors.green),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailBerita(berita: beritaList[index]),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
              ],
            );
          },
        ),
      ],
    );
  }
}
