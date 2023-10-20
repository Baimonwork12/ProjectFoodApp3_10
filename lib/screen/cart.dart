import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/screen/listmenu.dart';
import 'package:intl/intl.dart';

// ignore: camel_case_types
class cart extends StatefulWidget {
  final DocumentReference select;

  const cart({super.key, required this.select});

  @override
  State<cart> createState() => _cartState();
}

int orderNumber = 100;

// ignore: camel_case_types
class _cartState extends State<cart> {
  List<Map<String, dynamic>> dataList = [];
  Future<void> placeOrder(List<Map<String, dynamic>> dataList) async {
    for (var data in dataList) {
      Map<String, dynamic> datamenu = {
        'เมนู': data['เมนู'],
        'รายละเอียด': data['รายละเอียด'],
        'อื่นๆ': data['อื่นๆ'],
// ignore: equal_keys_in_map
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
// ดำเนินการหลังจากเพิ่มข้อมูลสำเร็จ
        print("ส่งออเดอร์สำเร็จ");
      }).catchError((error) {
// ดำเนินการหากเกิดข้อผิดพลาดในการเพิ่มข้อมูล
        print('Failed to place order: $error');
      });
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
                      return ListTile(
                        title: Text(data['เมนู'],
                            style: const TextStyle(fontSize: 20)),
                        subtitle: Text(data['จำนวน'].toString(),
                            style: const TextStyle(fontSize: 20)),
                        trailing: IconButton(
                          onPressed: () {
                            documents[index].reference.delete();
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
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
                      // กรณีข้อมูลเป็น null หรือไม่มีข้อมูลที่ต้องการ
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
                  placeOrder(dataList);
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
