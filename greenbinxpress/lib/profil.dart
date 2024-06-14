import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';

class UserProfile {
  String name;
  String phoneNumber;
  String address;

  UserProfile({
    required this.name,
    required this.phoneNumber,
    required this.address,
  });
}

class Profil extends StatefulWidget {
  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;

  late UserProfile _userProfile;

  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();

    _loadProfile();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _loadProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString('username');
    String? phoneNumber = prefs.getString('no_hp');
    String? address = prefs.getString('alamat');

    setState(() {
      _userProfile = UserProfile(
        name: name ?? '',
        phoneNumber: phoneNumber ?? '',
        address: address ?? '',
      );
      _nameController.text = _userProfile.name;
      _phoneController.text = _userProfile.phoneNumber;
      _addressController.text = _userProfile.address;
    });
  }

  Future<void> _saveProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('Name', _nameController.text);
    await prefs.setString('PhoneNumber', _phoneController.text);
    await prefs.setString('Address', _addressController.text);
  }

  Future<void> _logout(BuildContext context) async {
    await _saveProfile();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await prefs.remove('no_hp');
    await prefs.remove('alamat');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Keluar'),
          content: const Text('Apakah Anda yakin ingin keluar?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
                _logout(context); // Panggil fungsi logout
              },
              child: const Text('Ya'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        toolbarHeight: 40,
        backgroundColor: const Color(0XFF81C784),
        title: const Text(
          'Profil',
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 5),
                  _buildProfileField(Icons.person, "Nama", _nameController),
                  _buildProfileField(Icons.phone, "Nomor HP", _phoneController),
                  _buildProfileField(Icons.home, "Alamat", _addressController),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _confirmLogout(context),
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      backgroundColor: const Color(0XFF81C784),
                      padding: const EdgeInsets.symmetric(vertical: 11),
                    ),
                    child: const SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Keluar",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileField(
      IconData icon, String title, TextEditingController controller) {
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: controller,
                      enabled: _isEditing,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Masukkan $title',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
