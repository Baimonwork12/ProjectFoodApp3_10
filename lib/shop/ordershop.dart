import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/shop/historyorder.dart';
import 'package:food_app/shop/listmenushop.dart';

class Ordershop extends StatefulWidget {
  const Ordershop({super.key});

  @override
  State<Ordershop> createState() => _OrdershopState();
}

class _OrdershopState extends State<Ordershop> {
  // Get the current user's email address
  final String currentUserEmail = FirebaseAuth.instance.currentUser!.email!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('รายการสั่ง'),
            actions: <Widget>[
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HistoryOrder()));
                  },
                  icon: const Icon(Icons.list_alt)),
            ],
            backgroundColor: Colors.deepPurple.shade300),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              // Reference the current user's orders collection
              .collection('Shop')
              .doc(currentUserEmail)
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
                      leading: Text(
                        '${data['เลขออเดอร์'].toString().padLeft(5, '0')}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'เมนู',
                            style: const TextStyle(fontSize: 20),
                          ),
                          Text(
                            data['เมนู'],
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        children: [
                          Text(
                            data['วันที่และเวลา'].toString(),
                            style: const TextStyle(fontSize: 20),
                          ),
                          // เพิ่มข้อความใน subtitle
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                ' (จำนวน : ${data['จำนวน']})',
                                style: const TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ],
                      ),
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
