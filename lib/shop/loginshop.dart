import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/shop/adddata/add_datashop.dart';
import 'package:food_app/shop/bottom_shop.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Loginshop extends StatefulWidget {
  const Loginshop({super.key});

  @override
  State<Loginshop> createState() => _LoginshopState();
}

class _LoginshopState extends State<Loginshop> {
  CollectionReference ShopCollection =
      FirebaseFirestore.instance.collection("Shop");
  Future<void> signInWithGoogleshop() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user != null) {
        final docSnapshot =
            await ShopCollection.doc(userCredential.user!.email).get();

        if (docSnapshot.exists) {
          // Document already exists, navigate to MyNavigator directly

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MyNavigator1(),
            ),
          );
        } else {
          // Document doesn't exist, navigate to InputDataForUser
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Adddatashop(),
            ),
          );
        }
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error signing in: $e');
    }
  }

// ฟังก์ชันตรวจสอบว่ามีบัญชีผู้ใช้ในฐานข้อมูลหรือไม่
  Future<bool> checkIfUserExistsInDatabase(String email) async {
    final firestore = FirebaseFirestore.instance;
    final userDoc = await firestore.collection('Shop').doc(email).get();
    return userDoc.exists;
  }

  Future<void> saveDataShop(User user) async {
    final firestore = FirebaseFirestore.instance;
    // หรือใช้ FirebaseDatabase เมื่อใช้ Firebase Realtime Database
    final userData = {
      'email': user.email,
      'displayName': user.displayName,
      'photoURL': user.photoURL,

      // เพิ่มข้อมูลอื่น ๆ ที่คุณต้องการเก็บได้ตามต้องการ
    };

    try {
      await firestore.collection('Shop').doc(user.displayName).set(userData);
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
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Image.asset('images/shop.png'),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
            child: OutlinedButton(
                onPressed: () async {
                  await signInWithGoogleshop();
                },
                child: const Text(
                  'Log in with Google ร้านค้า',
                  style: TextStyle(fontSize: 20),
                )),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    ));
  }
}
