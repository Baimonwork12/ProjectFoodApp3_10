
import 'package:flutter/material.dart';
import 'package:food_app/screen/cart.dart';

import 'package:food_app/screen/homepage.dart';
import 'package:food_app/screen/order.dart';
import 'package:food_app/screen/profile.dart';

class MyNavigator extends StatefulWidget {
  const MyNavigator({super.key});

  @override
  State<MyNavigator> createState() => _MyNavigatorState();
}

class _MyNavigatorState extends State<MyNavigator> {
  int currentIndex = 0;
  onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  List<Widget> screens = const [order(), Homepage(), cart(), Profile()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: screens.elementAt(currentIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.deepPurple,
          selectedItemColor: Colors.black, // สีของไอคอนแถบที่ถูกเลือก
          unselectedItemColor: Colors.grey, // สีของไอคอนแถบที่ไม่ถูกเลือก
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
        ));
  }
}
