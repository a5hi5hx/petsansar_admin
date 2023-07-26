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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
bool _isSync = true;
  bool? checkLogin;
  final AuthService authService = AuthService();
  
  @override
  void initState()  {
    super.initState();
   // initPlatform();
    authService.getUserData(context);
      _loadValue();
    Timer(
        Duration(seconds: 5),() => setState(() {
              _isSync = false;
            }));
  }
  _loadValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      checkLogin = prefs.getBool('checklogin');
      
      _isSync = false;
    });
  }
  @override
  Widget build(BuildContext context) {
        bool checkLogin = Provider.of<UserProvider>(context).user.token.isEmpty;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _isSync ? Container(decoration: BoxDecoration(color: Colors.white),child: Center(child: CircularProgressIndicator( color: Colors.red,))) : checkLogin
          ? AdminHome()
          : Login(),
    );
  } 
}
//https://brainy-fish-mittens.cyclic.app/
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
  
//   @override
//   Widget build(BuildContext context) {
//    return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       navigatorKey: navigatorKey,
//       // routes: {
//       //   // When navigating to the "/" route, build the FirstScreen widget.
//       //   '/view': (context) => PetListScreen(),
//       //   // When navigating to the "/second" route, build the SecondScreen widget.
//       //   //'/second': (context) => const SecondScreen(),
//       //   '/add': (context) => AddPets(),
//       // },

//       home: Provider.of<UserProvider>(context).user.token.isEmpty
//           ? Login()
//           : HomePage(),

//      // home:Login(),
//       // home: _isSync
//       //     ? CircularProgressIndicator()
//       //     : checkLogin
//       //         ? SignUpScreen()
//       //         : PetListScreen(),
//     );
//   }
// }
