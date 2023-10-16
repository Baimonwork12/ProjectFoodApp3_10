import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:food_app/shop/listmenushop.dart';

class Ordershop extends StatefulWidget {
  const Ordershop({super.key});

  @override
  State<Ordershop> createState() => _OrdershopState();
}

class _OrdershopState extends State<Ordershop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('รายการสั่ง'),
            backgroundColor: Colors.deepPurple.shade300),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Shop')
              .doc('tbk1243@gmail.com')
              .collection('Ordershop')
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
            if (snapshot.hasData) {
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
                  return ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'เลขออเดอร์',
                            style: const TextStyle(fontSize: 20),
                          ),
                          Text(
                            data['เลขออเดอร์'],
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      subtitle: Text(
                          // แปลงจำนวนเป็น String
                          data['วันที่และเวลา'].toString(),
                          style: const TextStyle(fontSize: 20)),
                      trailing: IconButton(
                        onPressed: () {
                          documents[index].reference.delete();
                        },
                        icon: const Icon(
                          Icons.delete,
                          size: 25,
                          color: Colors.red,
                        ),
                        // เพิ่มข้อความหลังไอคอนลบ
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Listmenushop(
                                selectmenu: documents[index].reference,
                              ),
                            ));
                      });
                },
              );
            }
            return const Text("ไม่มีข้อมูล");
          },
        ));
  }
}
