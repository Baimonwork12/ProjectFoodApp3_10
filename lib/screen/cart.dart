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

int orderNumber = 1;
int orderss = 0;

class _CartState extends State<Cart> {
  Future<void> placeOrder() async {
    // List dataArray = [];
    // List<List> dataArray2 = [];

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    QuerySnapshot querySnapshot = await firestore
        .collection('users')
        .doc(currentUserEmail)
        .collection('Orderuser')
        .get();

    querySnapshot.docs.forEach((doc) async {
      // dataArray.add(doc['จำนวน']);
      // dataArray.add(doc['ชื่อร้านค้า']);
      // dataArray.add(doc['รวม']);
      // dataArray.add(doc['ราคา']);
      // dataArray.add(doc['รายละเอียด']);
      // dataArray.add(doc['อื่นๆ']);
      // dataArray.add(doc['เพิ่มเติม']);
      // dataArray.add(doc['เมนู']);
      // dataArray.add(doc['ไข่']);
      // print(dataArray);
      // dataArray2.add(dataArray);
      // dataArray.clear();

      // dataArray.add(doc['เมนู']);
      Map<String, dynamic> data = {
        'เมนู': doc['เมนู'],
        'รายละเอียด': doc['รายละเอียด'],
        'อื่นๆ': doc['อื่นๆ'],
        'เพิ่มเติม': doc['เพิ่มเติม'],
        'ไข่': doc['ไข่'],
        'ราคา': doc['ราคา'], // Format the price to 2 decimal places
        'จำนวน': doc['จำนวน'],
        'รวม': doc['รวม'],
        'เลขออเดอร์': ((orderNumber++).toString()),
        'วันที่และเวลา':
            DateFormat('dd MMMM yyyy HH:mm').format(DateTime.now()) + ' น.',
        'ชื่อร้าน': doc['ชื่อร้านค้า'],
      };

      // ignore: avoid_single_cascade_in_expression_statements
      await FirebaseFirestore.instance
          .collection('Shop')
          .doc('tbk1243@gmail.com')
          .collection('Ordershop')
          .doc(((orderNumber).toString()))
          .set(data)
          .then((value) => {print('ส่งออเดอร์สำเร็จ')});
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('ข้อมูลถูกบันทึกสำเร็จ'),
      ),
    );
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
                      // bool isChecked = selectedOrders.contains(data['เมนู']);
                      return ListTile(
                        title: Text(data['เมนู'],
                            style: const TextStyle(fontSize: 20)),
                        subtitle: Text(data['จำนวน'].toString(),
                            style: const TextStyle(fontSize: 20)),
                        trailing: IconButton(
                            onPressed: () {
                              documents[index].reference.delete();
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
                        // Checkbox(
                        //   value: isChecked,
                        //   onChanged: (bool? value) {
                        //     setState(() {
                        //       if (value == true) {
                        //         selectedOrders.add(data['เมนู']);
                        //       } else {
                        //         selectedOrders.remove(data['เมนู']);
                        //       }
                        //     });
                        //   },
                        // ),
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
