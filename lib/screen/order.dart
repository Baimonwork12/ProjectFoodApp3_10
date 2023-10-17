import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/screen/listorder.dart';

// ignore: camel_case_types
class order extends StatefulWidget {
  const order({super.key});

  @override
  State<order> createState() => _orderState();
}

// ignore: camel_case_types
class _orderState extends State<order> {
  final String currentUserEmail = FirebaseAuth.instance.currentUser!.email!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('รายการสั่ง'),
          backgroundColor: Colors.blue.shade300,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(currentUserEmail)
              .collection('status')
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
                        style: const TextStyle(fontSize: 20),
                      ),
                      title: Text(data['ชื่อร้านค้า'],
                          style: const TextStyle(fontSize: 20)),
                      subtitle: Text(
                        data['วันที่และเวลา'],
                        style: const TextStyle(fontSize: 15),
                      ),
                      trailing: Text(
                        data['สถานะ'],
                        style: const TextStyle(fontSize: 20),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Listorder(
                              selectstatus: documents[index].reference,
                            ),
                            settings: RouteSettings(arguments: data),
                          ),
                        );
                      });
                },
              );
            }
            return const Text("ไม่มีข้อมูล");
          },
        ));
  }
}
