

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class Listviewmenu extends StatefulWidget {
  final DocumentReference selectorder;

  const Listviewmenu({super.key, required this.selectorder});

  @override
  State<Listviewmenu> createState() => _ListviewmenuState();
}

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
  };
  var currentUser = auth.currentUser;
  if (currentUser != null) {
    CollectionReference userMainCollection =
        FirebaseFirestore.instance.collection("Shop");

    // ignore: non_constant_identifier_names
    CollectionReference ShopOrderSubCollection =
        userMainCollection.doc('tbk1243@gmail.com').collection('Ordershop');

    print('email :$currentUser.email');
    // await userOrderSubCollection.doc(data['เมนู']).get();
    //แก้ไขเป็น
   await ShopOrderSubCollection.doc(datamenu['เมนู']).set(datamenu);

    // ลบข้อมูลในหน้า Cart
  const Scaffold(body: Text('ไม่มีข้อมูล'),);
  }

  // แสดงข้อความแจ้งเตือน
  // ignore: use_build_context_synchronously
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('ข้อมูลถูกบันทึกสำเร็จ'),
    ),
  );
}


// ประกาศตัวแปร userMainCollection
// CollectionReference userMainCollection =
//     FirebaseFirestore.instance.collection("order");

// Future<void> saveOrder() async {
//   // ประกาศตัวแปร data ก่อนการเรียกใช้ StreamBuilder
//   final data = await widget.selectorder.get();

//   // บันทึกข้อมูลลงใน Firebase
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   Map<String, dynamic> datamenu = {
//     'เมนู': data['เมนู'],
//     'รายละเอียด': data['รายละเอียด'],
//     'อื่นๆ': data['อื่นๆ'],
//     // ignore: equal_keys_in_map
//     'เพิ่มเติม': data['เพิ่มเติม'],
//     'ไข่': data['ไข่'],
//     'ราคา': data['ราคา'], // Format the price to 2 decimal places
//    'จำนวน': data['จำนวน'],
//    'รวม': data['รวม'],
//   };
//   var currentUser = auth.currentUser;
//   if (currentUser != null) {
//     // ประกาศตัวแปร ShopOrderSubCollection
//     CollectionReference ShopOrderSubCollection;

//     // เพิ่มเงื่อนไขเพื่อตรวจสอบประเภทเมนู
//     if (data['เมนู'] ==null) {
//       // บันทึกข้อมูลลงในเอกสาร `Ordershop` ของร้านข้าวมันไก่
//       ShopOrderSubCollection = userMainCollection.doc("ข้าวมันไก่").collection('Ordershop');
//     } else {
//       // บันทึกข้อมูลลงในเอกสาร `Ordershop` ของร้านอาหารตามสั่ง
//       ShopOrderSubCollection = userMainCollection.doc("อาหารตามสั่ง").collection('Ordershop');
//     }

//     // เปลี่ยน doc().collection('Ordershop') เป็น doc(datamenu['เมนู']).collection('Ordershop')
//     await ShopOrderSubCollection.doc(datamenu['เมนู']).set(datamenu);

//     //แสดงข้อมูล
//     print('ข้อมูลบันทึกสำเร็จ');
//   }
// }






  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("รายละเอียด"),backgroundColor: Colors.blue.shade300
      ),
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
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('เมนู: ${data['เมนู']}',style: const TextStyle(fontSize: 25),),
                    
                  ],
                ),
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
     bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            Container(
              color: Colors.red,
              child: TextButton(
                child: const Text('ลบ',style: TextStyle(fontSize: 30,color: Colors.white),),
                onPressed: () {
                  
                },
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
              child: TextButton(
                child: const Text('สั่งซื้อ',style: TextStyle(fontSize: 30,color: Colors.white)),
                onPressed: () {
                saveOrder();
                // ลบข้อมูลในหน้า Cart
               const Scaffold(body: Text('ไม่มีข้อมูล'),);
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
