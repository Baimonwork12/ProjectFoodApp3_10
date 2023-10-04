import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Listviewmenu extends StatefulWidget {
  final DocumentReference selectorder;

  Listviewmenu({required this.selectorder});

  @override
  State<Listviewmenu> createState() => _ListviewmenuState();
}

class _ListviewmenuState extends State<Listviewmenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("รายละเอียด"),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: widget.selectorder.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error fetching data'),
            );
          }
          if (snapshot.hasData) {
            final data = snapshot.data!.data() as Map<String, dynamic>;
            return Column(
              
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('เมนู: ${data['เมนู']}',style: TextStyle(fontSize: 25),),
                    
                  ],
                ),
                Text('รายละเอียด: ${data['รายละเอียด']}',style: TextStyle(fontSize: 20),),
                 Text('อื่นๆ: ${data['อื่นๆ']}',style: TextStyle(fontSize: 20),),
                Text('ไข่: ${data['ไข่']}',style: TextStyle(fontSize: 20)),
                Text('เพิ่มเติม: ${data['เพิ่มเติม']}',style: TextStyle(fontSize: 20)),
                Text('จำนวน: ${data['จำนวน']}',style: TextStyle(fontSize: 20)),
                Text('ราคา: ${data['รวม']}',style: TextStyle(fontSize: 20)),
                // ตรงนี้คุณสามารถแสดงข้อมูลเพิ่มเติมจากเมนูที่ผู้ใช้คลิกได้ตามความต้องการ
                
                                    
              ],
              
            );
          }
          return Text("ไม่มีข้อมูล");
        },
      ),
      // ปุ่มข้อความ 2 อัน
     bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            Container(
              color: Colors.red,
              child: TextButton(
                child: Text('ลบ',style: TextStyle(fontSize: 30,color: Colors.white),),
                onPressed: () {
                  // แสดงข้อความแจ้งก่อนลบเอกสาร
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('ลบเอกสาร'),
                        content: Text('คุณต้องการลบเอกสารนี้หรือไม่'),
                        actions: [
                          TextButton(
                            child: Text('ยกเลิก'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text('ลบ'),
                            onPressed: () {
                              // ลบเอกสารในตำแหน่ง index
                              documents[index].reference.delete();
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),

            
            // เพิ่ม Container ว่างเปล่าเพื่อเพิ่มระยะห่าง
            Container(
              width: 10,
              height: 10,
            ),
            
            Container(
              color: Colors.green,
              child: TextButton(
                child: Text('สั่งซื้อ',style: TextStyle(fontSize: 30,color: Colors.white)),
                onPressed: () {
                  
                },
              ),
            ),
          ],
        ),
      ),

    );
  }
}
