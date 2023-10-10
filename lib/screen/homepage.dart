import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:food_app/screen/screentamsang.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  String? get menu => null;
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // List<Widget> screens = const [dttamsang(),kawkapao()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('หน้าหลัก'), backgroundColor: Colors.blue.shade300),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Shop').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator(); // แสดงตัวครื่องโหลดข้อมูล
          }
          final List<DocumentSnapshot> documents = snapshot.data!.docs;
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final data = documents[index].data() as Map<String, dynamic>;
              return ListTile(
                title: Text(
                  data['ชื่อร้านค้า'], style: TextStyle(fontSize: 20)
                ),
                subtitle: Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'เบอร์โทรศัพท์: ',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      data['เบอร์โทรศัพท์'],style: TextStyle(fontSize: 20),
                    ),
                    
                  ],
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => dttamsang(
                                menu: documents[index].reference,
                              ),
                          settings: RouteSettings(arguments: documents)));
                },
              );
            },
          );
        },
      ),
    );
  }
}
