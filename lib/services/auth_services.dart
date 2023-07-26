// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../exports.dart';
import 'package:dio/dio.dart';

class AuthService {
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    Dio dio = Dio();
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      final navigator = Navigator.of(context);
    
 final Map<String, dynamic> loginData = {
      'email': email,
      'userpassword': password,
    };
    try{
  dio.options.headers['Content-Type'] = 'application/json';
      Response response = await dio.post('${Constants.uri}/admin/login',
          data: loginData); 

if(response.data['success'] == true){
 SharedPreferences prefs = await SharedPreferences.getInstance();
prefs.setString('_id', response.data['_id']);
prefs.setString('email', response.data['email']);
userProvider.setUser(response.toString());
await prefs.setString('x-auth-token', response.data['token']);
 prefs.setString('phone', response.data['phoneNumber']);
prefs.setString('image', response.data['image']);
prefs.setString('name', response.data['name']);
       prefs.setBool('checklogin', true);

 navigator.pushReplacement(
            MaterialPageRoute(
              builder: (context) => AdminHome(),
            ),
          );
}
    }on DioException catch (e) {
 switch (e.response?.statusCode) {
        case 400:
          showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                    title: const Text("Error"),
                    content: Text(e.response?.data["msg"]),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          color: Colors.blue,
                          padding: const EdgeInsets.all(14),
                          child: const Text(
                            "OK",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ));
          break;
        case 500:
          showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                    title: const Text("Error"),
                    content: Text(e.response?.data["message"]),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          color: Colors.blue,
                          padding: const EdgeInsets.all(14),
                          child: const Text(
                            "OK",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ));
          break;
        default:
          showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                    title: const Text("Error"),
                    content: Text(e.toString()),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          color: Colors.blue,
                          padding: const EdgeInsets.all(14),
                          child: const Text(
                            "OK",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ));
      }
    }

  }
showSnackBar(BuildContext context, String text) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: AlertDialog(
          title: const Text('Message'),
          content: Text(text),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    },
  );
}

 void getUserData(
    BuildContext context,
  ) async {
          SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      String? token =  prefs.getString('x-auth-token');
      if (token == null || token == '') {
        prefs.setString('x-auth-token', '');
       prefs.setBool('checklogin', false);
      }
      Dio dio = Dio();
      dio.options.headers['Content-Type'] = 'application/json';
      dio.options.headers['x-auth-token'] = token;
      var tokenRes = await dio.get(
        '${Constants.uri}/admin/tokenValid',
      );
      var response = tokenRes.data['msg'];
      if (response == 'true') {
       prefs.setBool('checklogin', true);
        //Dio dio = Dio();
        dio.options.headers['Content-Type'] = 'application/json';
        dio.options.headers['x-auth-token'] = token;
        Response userRes = await dio.get(
          '${Constants.uri}/admin/user',
        );
        userProvider.setUser(userRes.toString());
       prefs.setBool('checklogin', true);
      }
    } catch (e) {
       prefs.setBool('checklogin', false);
      //showSnackBar(context, 'hr');
    }

  }

  void signOutuser(BuildContext context) async {
    final navigator = Navigator.of(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('x-auth-token', '');
    prefs.setBool('checklogin', false);

    navigator.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Login()),
        (route) => false);
  }

}