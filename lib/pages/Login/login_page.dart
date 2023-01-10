// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, unused_import, avoid_unnecessary_containers, unused_element, prefer_interpolation_to_compose_strings, use_build_context_synchronously, unused_local_variable, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool hidePassword = true;
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool visible = false;
  String message = '';
  final String sUrl = "http://192.168.43.123:5000/login";
  _cekLogin() async {
    setState(() {
      visible = true;
    });
    final prefs = await SharedPreferences.getInstance();

    var res = await http.post(
        Uri.parse(
          sUrl,
        ),
        body: {
          'username': userNameController.text,
          'password': passwordController.text
        });
    if (res.statusCode == 200) {
      prefs.setBool('login', true);
      var response = json.decode(res.body);
      message = response['message'];
      setState(() {
        visible = false;
      });
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
      showSuccessMessage(message);
    } else {
      setState(() {
        visible = false;
        var response = json.decode(res.body);
        message = response['message'];
      });
      showErrorMessage(message);
    }
  }

  showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Container(
        decoration: const BoxDecoration(
          color: Colors.red,
        ),
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(
      content: Container(
        decoration: const BoxDecoration(
          color: Colors.green,
        ),
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 40,
                width: 40,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'RateTol',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Visibility(
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: visible,
                  child: Container(child: CircularProgressIndicator())),
              SizedBox(
                height: 10,
              ),
              // text_header
              Text(
                "PLEASE LOG IN!",
                style: TextStyle(
                    fontFamily: 'BebasNeue',
                    fontSize: 50,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 25,
              ),
              //username textfield
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: TextField(
                      controller: userNameController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.person),
                        hintText: 'Username',
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              //password textfield
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: TextField(
                      controller: passwordController,
                      obscureText: hidePassword,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                          color: Colors.lightBlueAccent,
                          icon: Icon(hidePassword
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                        hintText: 'Password',
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              // loginbutton
              Center(
                child: ElevatedButton(
                  child: Text(
                    'Log In',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'BebasNeue',
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: _cekLogin,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 80)),
                    textStyle: MaterialStateProperty.all(
                      TextStyle(fontSize: 25),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 25,
              ),
              //not member? register now
            ],
          ),
        ),
      ),
    );
  }
}
