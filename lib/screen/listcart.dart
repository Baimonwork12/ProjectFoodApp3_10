import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Listcart extends StatefulWidget {
  const Listcart({super.key, required List<Map<String, dynamic>> dataList});

  @override
  State<Listcart> createState() => _ListcartState();
}

class _ListcartState extends State<Listcart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('')),
    );
  }
}
