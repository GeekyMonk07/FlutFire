import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoggedIn = false;
  late GoogleSignInAccount _userObj;
  GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("FlutFire")),
      body: Container(
        child: _isLoggedIn
            ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(_userObj.photoUrl.toString()),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _userObj.displayName.toString(),
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(_userObj.email),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "You are Signed in.",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black12),
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        _googleSignIn.signOut().then((value) {
                          setState(() {
                            _isLoggedIn = false;
                          });
                        }).catchError((e) {});
                      },
                      child: Text(
                        "Logout",
                        style: TextStyle(color: Colors.red),
                      ))
                ],
              )
            : Center(
                child: ElevatedButton(
                  child: Text("Login with Google"),
                  onPressed: () {
                    _googleSignIn.signIn().then((userData) {
                      setState(() {
                        _isLoggedIn = true;
                        _userObj = userData!;
                      });
                    }).catchError((e) {
                      print(e);
                    });
                  },
                ),
              ),
      ),
    );
  }
}
