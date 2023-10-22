import 'package:flutter/material.dart';
import 'package:food_app/screen/loginuser.dart';
import 'package:food_app/shop/loginshop.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
          Text(
            'เลือกสถานะ',
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(
            height: 50,
          ),
          OutlinedButton(
              onPressed: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Loginuser()));
              },
              child: const Text(
                'ลูกค้า',
                style: TextStyle(fontSize: 35),
              )),
          const SizedBox(
            height: 20,
          ),
          OutlinedButton(
              onPressed: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Loginshop()));
              },
              child: const Text(
                ' ร้านค้า',
                style: TextStyle(fontSize: 35),
              ))
        ],
      ),
    ));
  }
}
