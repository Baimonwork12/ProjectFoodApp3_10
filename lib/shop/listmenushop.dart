import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class Listmenushop extends StatefulWidget {
  final DocumentReference selectmenu;

  Listmenushop({required this.selectmenu});

  @override
  State<Listmenushop> createState() => _ListmenushopState();
}

class _ListmenushopState extends State<Listmenushop> {
  CollectionReference collectionStatus = FirebaseFirestore.instance
      .collection("users")
      .doc('testerappfood.user@gmail.com')
      .collection("status");

  void sendstatusone() async {
    String statusone = "กำลังทำ";
    final data = await widget.selectmenu.get();
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
      'สถานะ': statusone,
    };

    // Add the document to the collection
    await collectionStatus.doc(statusone).set(datamenu);
    // เพิ่ม SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('ข้อมูลถูกบันทึกสำเร็จ'),
      ),
    );
  }

  void sendstatustwo() async {
    String statustwo = "ทำเสร็จแล้ว";
    final data = await widget.selectmenu.get();
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
      'สถานะ': statustwo,
    };

    // Add the document to the collection
    await collectionStatus.doc(statustwo).set(datamenu);
    // เพิ่ม SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('ข้อมูลถูกบันทึกสำเร็จ'),
      ),
    );
  }

  void sendstatusfour() async {
    String statusfour = "แจ้งเตือนครั้งที่2";
    final data = await widget.selectmenu.get();
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
      'สถานะ': statusfour,
    };

    // Add the document to the collection
    await collectionStatus.doc(statusfour).set(datamenu);
    // เพิ่ม SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('ข้อมูลถูกบันทึกสำเร็จ'),
      ),
    );
  }

  void sendstatusthree() async {
    String statusthree = "รับออเดอร์แล้ว";
    final data = await widget.selectmenu.get();
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
      'สถานะ': statusthree,
    };

    // Add the document to the collection
    await collectionStatus.doc(statusthree).set(datamenu);
    // เพิ่ม SnackBar
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('ข้อมูลถูกบันทึกสำเร็จ'),
      ),
    );
  }

  late Stream<QuerySnapshot> OrderCollection;
  @override
  void initState() {
    super.initState();
    OrderCollection = widget.selectmenu.collection('Orderuser').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("รายละเอียด"),
          backgroundColor: Colors.deepPurple.shade300),
      body: StreamBuilder<DocumentSnapshot>(
        stream: widget.selectmenu.snapshots(),
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
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                      child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 241, 87, 76)),
                        child: const Text(
                          'กำลังทำ',
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                        // เพิ่มโค้ดเพื่อเก็บข้อมูลลงใน firebase เมื่อกดปุ่ม
                        onPressed: () {
                          sendstatusone();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.yellow.shade300),
                          child: const Text(
                            'ทำเสร็จแล้ว',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                          onPressed: () {
                            sendstatustwo();
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.blue),
                          child: const Text(
                            'แจ้งเตือนครั้งที่2',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                          onPressed: () {
                            sendstatusfour();
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.green),
                          child: const Text(
                            'รับออเดอร์เรียบร้อย',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                          onPressed: () {
                            sendstatusthree();
                          }),
                    ),
                  ],
                )
              ],
            );
          }
          return const Text("ไม่มีข้อมูล");
        },
      ),
    );
  }
}
