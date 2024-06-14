import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> notifications = [
      'Sampah berhasil dijemput pada 10 Juni 2024',
      'Sampah berhasil dijemput pada 5 Juni 2024',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifikasi'),
        backgroundColor: const Color(0XFF81C784),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(notifications[index]),
            ),
          );
        },
      ),
    );
  }
}
