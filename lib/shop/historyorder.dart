import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/shop/listhistoryshop.dart';

class HistoryOrder extends StatefulWidget {
  const HistoryOrder({super.key});

  @override
  State<HistoryOrder> createState() => _HistoryOrderState();
}

class _HistoryOrderState extends State<HistoryOrder> {
  final String currentUserEmail = FirebaseAuth.instance.currentUser!.email!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('ประวัติ'),
            backgroundColor: Colors.deepPurple.shade300),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Shop')
              .doc(currentUserEmail)
              .collection('Historyshop')
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
                          const Text(
                            'เมนู',
                            style: TextStyle(fontSize: 20),
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
                                data['สถานะ'],
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 53, 224, 59)),
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
                              builder: (context) => ListHistory(
                                selectnumoreder: documents[index].reference,
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
