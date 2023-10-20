import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/screen/listmenu.dart';
import 'package:intl/intl.dart';

class Cart extends StatefulWidget {
  final DocumentReference select;

  const Cart({Key? key, required this.select}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

int orderNumber = 100;

class _CartState extends State<Cart> {
  List<Map<String, dynamic>> dataList = [];
  List<String> selectedOrders = [];
  Future<void> placeOrder() async {
    for (var data in dataList) {
      if (selectedOrders.contains(data['เมนู'])) {
        Map<String, dynamic> datamenu = {
          'เมนู': data['เมนู'],
          'รายละเอียด': data['รายละเอียด'],
          'อื่นๆ': data['อื่นๆ'],
          'เพิ่มเติม': data['เพิ่มเติม'],
          'ไข่': data['ไข่'],
          'ราคา': data['ราคา'], // Format the price to 2 decimal places
          'จำนวน': data['จำนวน'],
          'รวม': data['รวม'],
          'เลขออเดอร์': ((orderNumber++).toString()).substring(1),
          'วันที่และเวลา':
              DateFormat('dd MMMM yyyy HH:mm').format(DateTime.now()) + ' น.',
          'ชื่อร้าน': data['ชื่อร้านค้า']
        };
        FirebaseFirestore.instance
            .collection('Shop')
            .doc('tbk1243@gmail.com')
            .collection('Ordershop')
            .add(datamenu)
            .then((value) {
          print("ส่งออเดอร์สำเร็จ");
        }).catchError((error) {
          print('Failed to place order: $error');
        });
      }
    }
  }

  final String currentUserEmail = FirebaseAuth.instance.currentUser!.email!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("ตะกร้า"), backgroundColor: Colors.blue.shade300),
      body: Stack(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(currentUserEmail)
                .collection('Orderuser')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Error fetching data'),
                );
              }
              if (snapshot.hasData && snapshot.data != null) {
                final documents = snapshot.data!.docs;
                if (documents.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text('ยังไม่มีข้อมูล')],
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    final data = documents[index];

                    if (data['เมนู'] != null) {
                      bool isChecked = selectedOrders.contains(data['เมนู']);
                      return ListTile(
                        title: Text(data['เมนู'],
                            style: const TextStyle(fontSize: 20)),
                        subtitle: Text(data['จำนวน'].toString(),
                            style: const TextStyle(fontSize: 20)),
                        trailing: Checkbox(
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              if (value == true) {
                                selectedOrders.add(data['เมนู']);
                              } else {
                                selectedOrders.remove(data['เมนู']);
                              }
                            });
                          },
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Listviewmenu(
                                selectorder: documents[index].reference,
                              ),
                              settings: RouteSettings(arguments: data),
                            ),
                          );
                        },
                      );
                    } else {
                      return Container();
                    }
                  },
                );
              }
              return const Text("ไม่มีข้อมูล");
            },
          ),
          Positioned(
            bottom: 10,
            right: 15,
            child: Container(
              color: Colors.green.shade300,
              child: IconButton(
                onPressed: () {
                  placeOrder();
                },
                icon: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'สั่งซื้อ',
                      style: TextStyle(fontSize: 25),
                    ),
                    Icon(Icons.shopping_cart),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
