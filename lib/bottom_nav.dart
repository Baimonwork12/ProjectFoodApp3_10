import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/screen/cart.dart';
import 'package:food_app/screen/homepage.dart';
import 'package:food_app/screen/order.dart';
import 'package:food_app/screen/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyNavigator extends StatefulWidget {
  const MyNavigator({super.key});

  @override
  State<MyNavigator> createState() => _MyNavigatorState();
}

class _MyNavigatorState extends State<MyNavigator> {
  int currentIndex = 0;

  late User? _user; // Declare _user as a non-const variable

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
  }

  onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  List<Widget> buildScreens() {
    return [
      const order(),
      const Homepage(),
      const cart(),
      Profile(dtprofile: FirebaseFirestore.instance.collection('users').doc(_user!.email)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final screens = buildScreens(); // Initialize screens in the build method
    return Scaffold(
      body: Center(
        child: screens.elementAt(currentIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue.shade300,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: onTap,
        currentIndex: currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'คำสั่งซื้อ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'หน้าหลัก',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'ตะกร้า',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_sharp),
            label: 'โปรไฟล์ผู้ใช้',
          ),
        ],
      ),
    );
  }
}
