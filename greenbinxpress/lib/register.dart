import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final userController = TextEditingController();
  final passController = TextEditingController();
  final noController = TextEditingController();
  final alamatController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      var response = await http.post(
        Uri.parse('http://192.168.100.21:8080/auth/register'),
        body: {
          'username': userController.text,
          'password': passController.text,
          'no_hp': noController.text,
          'alamat': alamatController.text,
        },
      );
      if (response.statusCode == 201) {
        var data = json.decode(response.body);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Sukses'),
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
      } else {
        var data = json.decode(response.body);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Gagal'),
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
                      'Daftar Akun',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0XFF81C784),
                      ),
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
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                  child: TextFormField(
                    controller: noController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Masukkan No HP';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: "Masukkan No HP",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none),
                        fillColor:
                            Theme.of(context).primaryColor.withOpacity(0.1),
                        filled: true,
                        prefixIcon: Icon(Icons.phone)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                  child: TextFormField(
                    controller: alamatController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Masukkan Alamat';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: "Masukkan Alamat",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none),
                        fillColor:
                            Theme.of(context).primaryColor.withOpacity(0.1),
                        filled: true,
                        prefixIcon: Icon(Icons.home_filled)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                  child: ElevatedButton(
                    onPressed: _register,
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      backgroundColor: Color(0XFF81C784),
                      padding: const EdgeInsets.symmetric(vertical: 11),
                    ),
                    child: const SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Daftar",
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
      ),
    );
  }
}
