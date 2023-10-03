import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/shop/bottom_shop.dart';

class Adddatashop extends StatefulWidget {
  const Adddatashop({super.key});

  @override
  State<Adddatashop> createState() => _AdddatashopState();
}

class _AdddatashopState extends State<Adddatashop> {
  TextEditingController nameshop = TextEditingController();
  TextEditingController Phone = TextEditingController();
  TextEditingController Address = TextEditingController();
  final formKey = GlobalKey<FormState>();

  CollectionReference collectionShop =
      FirebaseFirestore.instance.collection("Shop");

  sendUserDataToDB() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser;
//
    if (formKey.currentState!.validate()) {
      return collectionShop.doc(currentUser!.email).set({
        'ชื่อร้านค้า': nameshop.text,
        'เบอร์โทรศัพท์': Phone.text,
        'ที่อยู่': Address.text,
        'ชื่อแม่ค้า': currentUser.displayName,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('เพิ่มข้อมูลร้านค้า')),
        body: Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 20, 0, 0),
                  child: TextFormField(
                    controller: nameshop,
                    decoration: const InputDecoration(
                        labelText: 'ชื่อร้านค้า', hintText: 'ชื่อร้านค้า'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return ' กรุณากรอกชื่อร้านค้า';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: Phone,
                  decoration: const InputDecoration(
                      hintText: 'เบอร์โทรศัพท์', labelText: 'เบอร์โทรศัพท์'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return ' กรุณากรอกเบอร์โทรศัพท์';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: Address,
                  decoration: const InputDecoration(
                      labelText: 'ที่อยู่ร้านค้า', hintText: 'ที่อยู่ร้านค้า'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return ' กรุณากรอกที่อยู่ร้านค้าร้านค้า';
                    }
                    return null;
                  },
                ),
                OutlinedButton(
                    onPressed: () {
                      sendUserDataToDB();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyNavigator1()));
                    },
                    child: const Text('บันทึก'))
              ],
            )));
  }
}
