// ignore_for_file: unused_local_variable, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:food_app/bottom_nav.dart';

class Dtmenu extends StatefulWidget {
  final DocumentReference selectItem;
  const Dtmenu({Key? key, required this.selectItem}) : super(key: key);
  @override
  State<Dtmenu> createState() => _DtmenumankaiState();
}

class _DtmenumankaiState extends State<Dtmenu> {


  late Stream<DocumentSnapshot> documentStream;

  String? get value => null;

  @override
  void initState() {
    documentStream = widget.selectItem.snapshots();
    super.initState();
  }

  Future<void> sendOrder() async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    var currentUser = auth.currentUser;
    DocumentSnapshot snapshot = await widget.selectItem.get();
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

  if (formKey.currentState!.validate()) {
  // Initialize the base price with the value from data["ราคา"]
  double basePrice = double.tryParse(data?["ราคา"]) ?? 0.0;

  // Add the price of 'พิเศษ' if it's selected
    if (more == 'พิเศษ') {
    basePrice += 10.0;
  }

  // Add the price if 'ไข่เจียว' or 'ไข่ดาว' is selected
  if (egg == 'ไข่เจียว' || egg == 'ไข่ดาว') {
    basePrice += 10.0;
  }
num numTotal = num.parse(total.text);
double totalPrice = basePrice * numTotal;
  // Create the datamenumankai map with the updated 'ราคา'
  Map<String, dynamic> datamenumankai = {
    'เมนู': data!['ชื่อเมนู'],
    'รายละเอียด': other,
    'อื่นๆ': more,
    // ignore: equal_keys_in_map
    'เพิ่มเติม': manyother.text,
    'ไข่': egg,
    'ราคา': basePrice.toStringAsFixed(2), // Format the price to 2 decimal places
   'จำนวน': numTotal,
   'รวม': totalPrice.toStringAsFixed(2),
  };

  // You can use the updated datamenumankai for further processing or send it as needed.

  if (currentUser != null) {
    CollectionReference userMainCollection =
        FirebaseFirestore.instance.collection("users");

    CollectionReference userOrderSubCollection =
        userMainCollection.doc(currentUser.email).collection('Orderuser');

    print('email :$currentUser.email');
    await userOrderSubCollection.doc(data['ชื่อเมนู']).set(datamenumankai);
  }
}

  }

  TextEditingController manyother = TextEditingController();
  TextEditingController total = TextEditingController(text: '1');

  // TextEditingController manyother = TextEditingController();
  final formKey = GlobalKey<FormState>();

  String other = '';
  String more = '';
  String egg = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('รายละเอียด', style: TextStyle(fontSize: 20)),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Text(
                      'เพิ่มเติม',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
              RadioListTile<String>(
                title: const Text(
                  'กินร้าน',
                  style: TextStyle(fontSize: 20),
                ),
                value: 'กินร้าน',
                groupValue: other,
                onChanged: (value) {
                  setState(() {
                    other = value!;
                  });
                },
              ),
              const Divider(
                height: 0,
              ),
              RadioListTile<String>(
                title: const Text('ใส่กล่อง', style: TextStyle(fontSize: 20)),
                value: 'ใส่กล่อง',
                groupValue: other,
                onChanged: (value) {
                  setState(() {
                    other = value!;
                  });
                },
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Text(
                      'อื่นๆ',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
              RadioListTile<String>(
                title: const Text('ธรรมดา', style: TextStyle(fontSize: 20)),
                value: 'ธรรมดา',
                groupValue: more,
                onChanged: (value) {
                  setState(() {
                    more = value!;
                  });
                },
              ),
              const Divider(
                height: 0,
              ),
              RadioListTile<String>(
                title: const Text('พิเศษ', style: TextStyle(fontSize: 20)),
                value: 'พิเศษ',
                groupValue: more,
                onChanged: (value) {
                  setState(() {
                    more = value!;
                  });
                },
              ),
              const Align(
                alignment: Alignment.topRight,
                child: Column(
                  children: [
                    Text(
                      '+10',
                      style: TextStyle(fontSize: 15),
                    )
                  ],
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Text(
                      'ไข่',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
              RadioListTile<String>(
                title: const Text('ไข่เจียว', style: TextStyle(fontSize: 20)),
                value: 'ไข่เจียว',
                groupValue: egg,
                onChanged: (value) {
                  setState(() {
                    egg = value!;
                  });
                },
              ),
              const Align(
                alignment: Alignment.topRight,
                child: Column(
                  children: [
                    Text(
                      '+10',
                      style: TextStyle(fontSize: 15),
                    )
                  ],
                ),
              ),
              const Divider(
                height: 0,
              ),
              RadioListTile<String>(
                title: const Text('ไข่ดาว', style: TextStyle(fontSize: 20)),
                value: 'ไข่ดาว',
                groupValue: egg,
                onChanged: (value) {
                  setState(() {
                    egg = value!;
                  });
                },
              ),
              const Align(
                alignment: Alignment.topRight,
                child: Column(
                  children: [
                    Text(
                      '+10',
                      style: TextStyle(fontSize: 15),
                    )
                  ],
                ),
              ),
              const Divider(
                height: 0,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Text(
                      'เพิ่มเติม:',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: manyother,
                decoration: const InputDecoration(
                  labelText: 'เช่นไม่ใส่ผัก',
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'จำนวน',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: total,
                keyboardType:
                    TextInputType.number, // กำหนดให้คีย์บอร์ดเป็นตัวเลข
                onChanged: (value) {
                  // เมื่อข้อมูลเปลี่ยนแปลงให้ทำอะไรก็ตามที่ต้องการ
                  // เช่นการแปลงค่าเป็นตัวเลข num
                  num totalValue = num.tryParse(value) ?? 0;
                  // ทำอะไรกับ totalValue ต่อไป
                },
              ),

              const SizedBox(
                height: 10,
              ),
              OutlinedButton(
                  onPressed: () {
                    sendOrder();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyNavigator()));
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_cart),
                      Text(
                        'เพิ่มลงตะกร้า',
                      ),
                    ],
                  ))
              // เพิ่ม RadioListTile อื่น ๆ ตามต้องการ
            ],
          ),
        ),
      ),
    );
  }
}
