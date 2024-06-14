import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'register.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userController = TextEditingController();
  final passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('username')) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    }
  }

  Future<void> _login() async {
    var response = await http.post(
      Uri.parse('http://192.168.100.21:8080/auth/login'),
      body: {
        'username': userController.text,
        'password': passController.text,
      },
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print('Response data: $data');
      if (data['message'] == 'Login successful') {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('username', data['user']['username']);
        await prefs.setString('no_hp', data['user']['no_hp']);
        await prefs.setString('alamat', data['user']['alamat']);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Login Gagal'),
              content: Text(data['message']),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content:
                Text('Masukkan username dan password yang sudah terdaftar!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void _togglePasswordView() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 50),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Positioned(
                  child: Center(
                    child: Text(
                      'Kelola Sampahmu disini!',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0XFF81C784),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                    width: 200,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Color(0XFF81C784),
                          offset: Offset(0, 3),
                          blurRadius: 5,
                          spreadRadius: 1,
                        ),
                      ],
                      color: Color(0xFFFFFFFF),
                    ),
                    child: Image.asset(
                      'assets/foto1.jpeg',
                      width: 200,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                  child: TextFormField(
                    controller: userController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Masukkan Username';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: "Masukkan Username",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none),
                        fillColor:
                            Theme.of(context).primaryColor.withOpacity(0.1),
                        filled: true,
                        prefixIcon: Icon(Icons.person)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                  child: TextFormField(
                    controller: passController,
                    decoration: InputDecoration(
                      hintText: "Masukkan Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none),
                      fillColor:
                          Theme.of(context).primaryColor.withOpacity(0.1),
                      filled: true,
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: _togglePasswordView,
                      ),
                    ),
                    obscureText: _obscureText,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Masukkan Password';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                  child: ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      backgroundColor: Color(0XFF81C784),
                      padding: EdgeInsets.symmetric(vertical: 11),
                    ),
                    child: const SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Masuk",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 10, 0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                      );
                    },
                    child: const Text(
                      'Belum punya akun? Daftar disini!',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
