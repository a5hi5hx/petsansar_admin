// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
// import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './exports.dart';
// void main() {
//   runApp(const MyApp());
// }
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
debugShowCheckedModeBanner: false,
        home: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: Login(),
      home: Provider.of<UserProvider>(context).user.token.isEmpty
          ? Login()
          : HomePage(),
    );
  }
}
//https://brainy-fish-mittens.cyclic.app/
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  @override
  Widget build(BuildContext context) {
   return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      // routes: {
      //   // When navigating to the "/" route, build the FirstScreen widget.
      //   '/view': (context) => PetListScreen(),
      //   // When navigating to the "/second" route, build the SecondScreen widget.
      //   //'/second': (context) => const SecondScreen(),
      //   '/add': (context) => AddPets(),
      // },

      home: Provider.of<UserProvider>(context).user.token.isEmpty
          ? Login()
          : HomePage(),

     // home:Login(),
      // home: _isSync
      //     ? CircularProgressIndicator()
      //     : checkLogin
      //         ? SignUpScreen()
      //         : PetListScreen(),
    );
  }
}
