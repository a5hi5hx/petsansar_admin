// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _userName = "Loading...";
    String _email = "Loading...";
  String _phone = "Loading...";
  String _image = "Loading...";
  String token = "Loading...";
  String _id = "Loading...";


  @override
  void initState() {
    super.initState();
    _loadNameFromSharedPreferences();
  }

  Future<void> _loadNameFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('name') ?? "User Name Not Found";
      _email = prefs.getString('email') ?? "email Name Not Found";
      _phone = prefs.getString('phone') ?? "User Name Not Found";
      _image = prefs.getString('image') ?? "image Name Not Found";
      token = prefs.getString('x-auth-token') ?? "token Name Not Found";
      _id = prefs.getString('_id') ?? "Id Name Not Found";

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Name Page'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'Welcome, $_userName!',
              style: TextStyle(fontSize: 24),
            ),
             Text(
              'Welcome, $_email!',
              style: TextStyle(fontSize: 24),
            ),
             Text(
              'Welcome, $_phone!',
              style: TextStyle(fontSize: 24),
            ),
             Text(
              'Welcome, $token!',
              style: TextStyle(fontSize: 24),
            ),
             Text(
              'Welcome, $_id!',
              style: TextStyle(fontSize: 24),
            ),
             Image.network(_image, fit: BoxFit.contain,height: 200, width: 200,)
          ],
        ),
      ),
    );
  }
}
