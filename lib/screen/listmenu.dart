import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Listviewmenu extends StatefulWidget {
  final DocumentReference selectorder;

  const Listviewmenu({super.key, required this.selectorder});

  @override
  State<Listviewmenu> createState() => _ListviewmenuState();
}

int orderNumber = 100;

class _ListviewmenuState extends State<Listviewmenu> {
  Future<void> saveOrder() async {
    // ประกาศตัวแปร data ก่อนการเรียกใช้ StreamBuilder
    final data = await widget.selectorder.get();

    // บันทึกข้อมูลลงใน Firebase
    final FirebaseAuth auth = FirebaseAuth.instance;

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

    var currentUser = auth.currentUser;
    if (currentUser != null) {
      // ตรวจสอบเมนูที่สั่ง
      if (data['ชื่อร้านค้า'].contains('ข้าวมันไก่')) {
        // บันทึกข้อมูลไปยัง Ordershop อีเมลล์palmloveconan@gmail.com
        CollectionReference userMainCollection =
            FirebaseFirestore.instance.collection("Shop");

        CollectionReference ShopOrderSubCollection = userMainCollection
            .doc('palmdisaster2843@gmail.com')
            .collection('Ordershop');

        await ShopOrderSubCollection.doc(datamenu['เมนู']).set(datamenu);
      } else {
        // บันทึกข้อมูลไปยัง Ordershop อีเมลล์tbk1243@gmail.com
        CollectionReference userMainCollection =
            FirebaseFirestore.instance.collection("Shop");

        CollectionReference ShopOrderSubCollection =
            userMainCollection.doc('tbk1243@gmail.com').collection('Ordershop');

        await ShopOrderSubCollection.doc(datamenu['เมนู']).set(datamenu);
      }

      // ลบข้อมูลในหน้า Cart
      const Scaffold(
        body: Text('ไม่มีข้อมูล'),
      );
    }

    // แสดงข้อความแจ้งเตือน
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('ข้อมูลถูกบันทึกสำเร็จ'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("รายละเอียด"),
          backgroundColor: Colors.blue.shade300),
      body: StreamBuilder<DocumentSnapshot>(
        stream: widget.selectorder.snapshots(),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'เมนู: ${data['เมนู']}',
                      style: const TextStyle(fontSize: 25),
                    ),
                  ],
                ),
                Text(
                  'รายละเอียด: ${data['รายละเอียด']}',
                  style: const TextStyle(fontSize: 20),
                ),
                Text(
                  'อื่นๆ: ${data['อื่นๆ']}',
                  style: const TextStyle(fontSize: 20),
                ),
                Text('ไข่: ${data['ไข่']}',
                    style: const TextStyle(fontSize: 20)),
                Text('เพิ่มเติม: ${data['เพิ่มเติม']}',
                    style: const TextStyle(fontSize: 20)),
                Text('จำนวน: ${data['จำนวน']}',
                    style: const TextStyle(fontSize: 20)),
                Text('ราคา: ${data['รวม']}',
                    style: const TextStyle(fontSize: 20)),
                // ตรงนี้คุณสามารถแสดงข้อมูลเพิ่มเติมจากเมนูที่ผู้ใช้คลิกได้ตามความต้องการ
              ],
            );
          }
          return const Text("ไม่มีข้อมูล");
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
                child: const Text(
                  'ลบ',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                onPressed: () {},
              ),
            ),

            // เพิ่ม Container ว่างเปล่าเพื่อเพิ่มระยะห่าง
            // ignore: sized_box_for_whitespace
            Container(
              width: 10,
              height: 10,
            ),

            Container(
              color: Colors.green,
              child: // ปรับเปลี่ยนการทำงานของปุ่มสั่งซื้อ
                  TextButton(
                child: const Text('สั่งซื้อ ',
                    style: TextStyle(fontSize: 30, color: Colors.white)),
                onPressed: () {
                  saveOrder();
                  // ลบข้อมูลในหน้า Cart
                  const Scaffold(
                    body: Text('ไม่มีข้อมูล'),
                  );
                  // กลับสู่หน้าหลัก
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
