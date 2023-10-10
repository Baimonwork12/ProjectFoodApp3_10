import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Listorder extends StatefulWidget {
  final DocumentReference selectstatus;

  const Listorder({super.key, required this.selectstatus});

  @override
  State<Listorder> createState() => _ListorderState();
}

class _ListorderState extends State<Listorder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("รายละเอียด"),backgroundColor: Colors.blue.shade300
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: widget.selectstatus.snapshots(),
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
            final data = snapshot.data!.data() as Map<String, dynamic>;
            return Column(
              
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('สถานะ: ${data['สถานะ']}',style: const TextStyle(fontSize: 25),),
                    
                    
                  ],
                ),
                Text('เมนู: ${data['เมนู']}',style: const TextStyle(fontSize: 25),),
                Text('รายละเอียด: ${data['รายละเอียด']}',style: const TextStyle(fontSize: 20),),
                 Text('อื่นๆ: ${data['อื่นๆ']}',style: const TextStyle(fontSize: 20),),
                Text('ไข่: ${data['ไข่']}',style: const TextStyle(fontSize: 20)),
                Text('เพิ่มเติม: ${data['เพิ่มเติม']}',style: const TextStyle(fontSize: 20)),
                Text('จำนวน: ${data['จำนวน']}',style: const TextStyle(fontSize: 20)),
                Text('ราคา: ${data['รวม']}',style: const TextStyle(fontSize: 20)),
                // ตรงนี้คุณสามารถแสดงข้อมูลเพิ่มเติมจากเมนูที่ผู้ใช้คลิกได้ตามความต้องการ
                
                                    
              ],
              
            );
          }
          return const Text("ไม่มีข้อมูล");
        },
      ),
      // ปุ่มข้อความ 2 อัน
    
    );
  }
}