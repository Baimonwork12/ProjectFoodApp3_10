import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/bottom_nav.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Loginuser extends StatefulWidget {
  const Loginuser({super.key});

  @override
  State<Loginuser> createState() => _LoginuserState();
}

class _LoginuserState extends State<Loginuser> {
  Future<UserCredential?> signInWithGoogleuser() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      // ไม่ได้ล็อกอินด้วย Google
      return null;
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    try {
      final UserCredential authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // เก็บข้อมูลผู้ใช้ลงใน Firebase
      final User user = authResult.user!;
      await saveUserDataToFirebase(user);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const MyNavigator()));

      return authResult;
    } catch (e) {
      return null;
    }
  }

  Future<void> saveUserDataToFirebase(User user) async {
    final firestore = FirebaseFirestore.instance;
    // หรือใช้ FirebaseDatabase เมื่อใช้ Firebase Realtime Database
    final userData = {
      'email': user.email,
      'displayName': user.displayName,
      'photoURL': user.photoURL,
      // เพิ่มข้อมูลอื่น ๆ ที่คุณต้องการเก็บได้ตามต้องการ
    };

    try {
      await firestore.collection('users').doc(user.email).set(userData);
      // ignore: empty_catches
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('images/logo.png'),
          ),
          OutlinedButton(
              onPressed: () async {
                await signInWithGoogleuser();
              },
              child: const Text(
                'Log in with Google ลูกค้า',
                style: TextStyle(fontSize: 20),
              )),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    ));
  }
}
