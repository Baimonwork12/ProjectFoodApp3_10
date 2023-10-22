import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:food_app/shop/menushop.dart';
import 'package:food_app/shop/ordershop.dart';
import 'package:food_app/shop/profileshop.dart';

class MyNavigator1 extends StatefulWidget {
  const MyNavigator1({super.key});

  @override
  State<MyNavigator1> createState() => _MyNavigatorState();
}

class _MyNavigatorState extends State<MyNavigator1> {
  int currentIndex = 0;
  // late User? _user; // Declare _user as a non-const variable
  final currrenUser = FirebaseAuth.instance.currentUser!;
  @override
  void initState() {
    super.initState();
  }

  onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  List<Widget> getScreens() {
    return [
      const Ordershop(),
      const MenuShop(),
      Profileshop(
          dtprofileshop: FirebaseFirestore.instance
              .collection('Shop')
              .doc(currrenUser.email))
    ];
  }

  @override
  Widget build(BuildContext context) {
    final screens = getScreens();
    return Scaffold(
        body: Center(
          child: screens.elementAt(currentIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.deepPurple.shade300,
          selectedItemColor: Colors.black, // สีของไอคอนแถบที่ถูกเลือก
          unselectedItemColor: Colors.grey, // สีของไอคอนแถบที่ไม่ถูกเลือก
          onTap: onTap,
          currentIndex: currentIndex,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment),
              label: 'ออเดอร์',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.auto_stories),
              label: 'เมนู',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_sharp),
              label: 'โปรไฟล์ผู้ใช้',
            ),
          ],
        ));
  }
}
