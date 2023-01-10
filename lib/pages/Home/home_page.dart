// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_element, use_build_context_synchronously, unnecessary_import, unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ratetol/pages/History/history_page.dart';
import 'package:ratetol/pages/Login/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Images/uploadimage_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  _logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('login', false);
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: const Text('Home'),
      ),
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: ListView(
          // Importan: Remove any padding from the ListView
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
              ),
              accountName: Text(
                "Admin",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              accountEmail: null,
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
                leading: const Icon(Icons.exit_to_app),
                title: const Text('Exit'),
                onTap: _logOut),
          ],
        ),
      ),
      body: GridView.count(
        padding: EdgeInsets.all(25),
        crossAxisCount: 2,
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => History()));
              },
              splashColor: Colors.lightBlueAccent,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.history,
                      size: 70,
                      color: Colors.lightBlueAccent,
                    ),
                    Text(
                      'History',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UploadImage()));
              },
              splashColor: Colors.lightBlueAccent,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.add_a_photo,
                      size: 70,
                      color: Colors.lightBlueAccent,
                    ),
                    Text(
                      'Upload Image',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
