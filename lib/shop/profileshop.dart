import 'package:flutter/material.dart';
import 'package:food_app/screen/login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Profileshop extends StatefulWidget {
  const Profileshop({super.key});

  @override
  State<Profileshop> createState() => _ProfileshopState();
}

class _ProfileshopState extends State<Profileshop> {
  @override
  Widget build(BuildContext context) {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
  void signOutGoogle() async {
    await _googleSignIn.signOut();
    // ignore: avoid_print
    print("User Sign Out"); Navigator.push(context, MaterialPageRoute(builder: (context)=> MyWidget()));
  }
    
    return Scaffold(
      appBar: AppBar(
        title: Text('โปรไฟล์'),
    ),
    body: Center(
        child: OutlinedButton(onPressed: (){
          signOutGoogle();
        }, child: Text('log out')),
      ),
    );
  }
}