import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  bool _isButtonVisible = true; // เพิ่มตัวแปรสำหรับการตรวจสอบสถานะของปุ่ม
  bool _isButtonVisible1 = true;
  bool _isButtonVisible2 = true;
  bool _isButtonVisible3 = true;
  bool _isButtonVisible4 = true;
  bool _isButtonVisible5 = true;

  void sendstatus() async {
    String status = "ยกเลิกออเดอร์";
    final data = await widget.selectmenu.get();
    Map<String, dynamic> datamenu = {
      'เมนู': data['เมนู'],
      'เลขออเดอร์': data['เลขออเดอร์'],
      'รายละเอียด': data['รายละเอียด'],
      'อื่นๆ': data['อื่นๆ'],
      // ignore: equal_keys_in_map
      'เพิ่มเติม': data['เพิ่มเติม'],
      'ไข่': data['ไข่'],
      'ราคา': data['ราคา'], // Format the price to 2 decimal places
      'จำนวน': data['จำนวน'],
      'รวม': data['รวม'],
      'สถานะ': status,
      'วันที่และเวลา':
          DateFormat('dd MMMM yyyy HH:mm').format(DateTime.now()) + ' น.',
      'ชื่อร้านค้า': data['ชื่อร้าน']
    };

    // Add the document to the collection
    await collectionStatus.doc(data['เลขออเดอร์'].toString()).set(datamenu);
    // เพิ่ม SnackBar
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('ข้อมูลถูกบันทึกสำเร็จ'),
      ),
    );
  }

  void sendstatuszero() async {
    String statuszero = "รับออเดอร์";
    final data = await widget.selectmenu.get();
    Map<String, dynamic> datamenu = {
      'เมนู': data['เมนู'],
      'เลขออเดอร์': data['เลขออเดอร์'],
      'รายละเอียด': data['รายละเอียด'],
      'อื่นๆ': data['อื่นๆ'],
      // ignore: equal_keys_in_map
      'เพิ่มเติม': data['เพิ่มเติม'],
      'ไข่': data['ไข่'],
      'ราคา': data['ราคา'], // Format the price to 2 decimal places
      'จำนวน': data['จำนวน'],
      'รวม': data['รวม'],
      'สถานะ': statuszero,
      'วันที่และเวลา':
          DateFormat('dd MMMM yyyy HH:mm').format(DateTime.now()) + ' น.',
      'ชื่อร้านค้า': data['ชื่อร้าน']
    };

    // Add the document to the collection
    await collectionStatus.doc(data['เลขออเดอร์'].toString()).set(datamenu);
    // เพิ่ม SnackBar
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('ข้อมูลถูกบันทึกสำเร็จ'),
      ),
    );
  }

  void sendstatusone() async {
    String statusone = "กำลังทำ";
    final data = await widget.selectmenu.get();
    Map<String, dynamic> datamenu = {
      'เมนู': data['เมนู'],
      'เลขออเดอร์': data['เลขออเดอร์'],
      'รายละเอียด': data['รายละเอียด'],
      'อื่นๆ': data['อื่นๆ'],
      // ignore: equal_keys_in_map
      'เพิ่มเติม': data['เพิ่มเติม'],
      'ไข่': data['ไข่'],
      'ราคา': data['ราคา'], // Format the price to 2 decimal places
      'จำนวน': data['จำนวน'],
      'รวม': data['รวม'],
      'สถานะ': statusone,
      'วันที่และเวลา':
          DateFormat('dd MMMM yyyy HH:mm').format(DateTime.now()) + ' น.',
      'ชื่อร้านค้า': data['ชื่อร้าน']
    };

    // Add the document to the collection
    await collectionStatus.doc(data['เลขออเดอร์'].toString()).set(datamenu);
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
      'เลขออเดอร์': data['เลขออเดอร์'],
      'รายละเอียด': data['รายละเอียด'],
      'อื่นๆ': data['อื่นๆ'],
      // ignore: equal_keys_in_map
      'เพิ่มเติม': data['เพิ่มเติม'],
      'ไข่': data['ไข่'],
      'ราคา': data['ราคา'], // Format the price to 2 decimal places
      'จำนวน': data['จำนวน'],
      'รวม': data['รวม'],
      'สถานะ': statustwo,
      'วันที่และเวลา':
          DateFormat('dd MMMM yyyy HH:mm').format(DateTime.now()) + ' น.',
      'ชื่อร้านค้า': data['ชื่อร้าน']
    };

    // Add the document to the collection
    await collectionStatus.doc(data['เลขออเดอร์'].toString()).set(datamenu);
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
      'เลขออเดอร์': data['เลขออเดอร์'],
      'รายละเอียด': data['รายละเอียด'],
      'อื่นๆ': data['อื่นๆ'],
      // ignore: equal_keys_in_map
      'เพิ่มเติม': data['เพิ่มเติม'],
      'ไข่': data['ไข่'],
      'ราคา': data['ราคา'], // Format the price to 2 decimal places
      'จำนวน': data['จำนวน'],
      'รวม': data['รวม'],
      'สถานะ': statusthree,
      'วันที่และเวลา':
          DateFormat('dd MMMM yyyy HH:mm').format(DateTime.now()) + ' น.',
      'ชื่อร้านค้า': data['ชื่อร้าน']
    };

    // Add the document to the collection
    await collectionStatus.doc(data['เลขออเดอร์'].toString()).set(datamenu);
    // เพิ่ม SnackBar
    // ignore: use_build_context_synchronously
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
      'เลขออเดอร์': data['เลขออเดอร์'],
      'รายละเอียด': data['รายละเอียด'],
      'อื่นๆ': data['อื่นๆ'],
      // ignore: equal_keys_in_map
      'เพิ่มเติม': data['เพิ่มเติม'],
      'ไข่': data['ไข่'],
      'ราคา': data['ราคา'], // Format the price to 2 decimal places
      'จำนวน': data['จำนวน'],
      'รวม': data['รวม'],
      'สถานะ': statusfour,
      'วันที่และเวลา':
          DateFormat('dd MMMM yyyy HH:mm').format(DateTime.now()) + ' น.',
      'ชื่อร้านค้า': data['ชื่อร้าน']
    };

    // Add the document to the collection
    await collectionStatus.doc(data['เลขออเดอร์'].toString()).set(datamenu);
    // เพิ่ม SnackBar
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
                      'เลขออเดอร์: ${data['เลขออเดอร์']}',
                      style: const TextStyle(fontSize: 25),
                    ),
                  ],
                ),
                Text(
                  'เมนู: ${data['เมนู']}',
                  style: const TextStyle(fontSize: 25),
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
                      child: _isButtonVisible5
                          ? TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Color.fromARGB(255, 255, 0, 0),
                              ),
                              child: const Text(
                                'ยกเลิกออเดอร์',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                              onPressed: () {
                                sendstatus();

                                setState(() {
                                  _isButtonVisible5 =
                                      false; // เปลี่ยนค่าเพื่อทำให้ปุ่มหายไป
                                });
                              },
                            )
                          : Container(), // ถ้า _isButtonVisible เป็นเท็จ จะแสดง Container() ซึ่งไม่แสดงอะไรเลย
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: _isButtonVisible1
                          ? TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 241, 139, 80),
                              ),
                              child: const Text(
                                'รับออเดอร์',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                              onPressed: () {
                                sendstatuszero();
                                setState(() {
                                  _isButtonVisible1 =
                                      false; // เปลี่ยนค่าเพื่อทำให้ปุ่มหายไป
                                });
                              },
                            )
                          : Container(), // ถ้า _isButtonVisible เป็นเท็จ จะแสดง Container() ซึ่งไม่แสดงอะไรเลย
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: _isButtonVisible
                          ? TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 252, 110, 100),
                              ),
                              child: const Text(
                                'กำลังทำ',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                              onPressed: () {
                                sendstatusone();
                                setState(() {
                                  _isButtonVisible =
                                      false; // เปลี่ยนค่าเพื่อทำให้ปุ่มหายไป
                                });
                              },
                            )
                          : Container(), // ถ้า _isButtonVisible เป็นเท็จ จะแสดง Container() ซึ่งไม่แสดงอะไรเลย
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: _isButtonVisible2
                          ? TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 174, 236, 138),
                              ),
                              child: const Text(
                                'ทำเสร็จแล้ว',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                              onPressed: () {
                                sendstatustwo();
                                setState(() {
                                  _isButtonVisible2 =
                                      false; // เปลี่ยนค่าเพื่อทำให้ปุ่มหายไป
                                });
                              },
                            )
                          : Container(), // ถ้า _isButtonVisible เป็นเท็จ จะแสดง Container() ซึ่งไม่แสดงอะไรเลย
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: _isButtonVisible3
                          ? TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 73, 167, 230),
                              ),
                              child: const Text(
                                'แจ้งเตือนx2',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                              onPressed: () {
                                sendstatusthree();
                                setState(() {
                                  _isButtonVisible3 =
                                      false; // เปลี่ยนค่าเพื่อทำให้ปุ่มหายไป
                                });
                              },
                            )
                          : Container(), // ถ้า _isButtonVisible เป็นเท็จ จะแสดง Container() ซึ่งไม่แสดงอะไรเลย
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: _isButtonVisible4
                          ? TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 37, 241, 71),
                              ),
                              child: const Text(
                                'รับสินค้าเรียบร้อย',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                              onPressed: () {
                                sendstatusthree();
                                setState(() {
                                  _isButtonVisible4 =
                                      false; // เปลี่ยนค่าเพื่อทำให้ปุ่มหายไป
                                });
                              },
                            )
                          : Container(), // ถ้า _isButtonVisible เป็นเท็จ จะแสดง Container() ซึ่งไม่แสดงอะไรเลย
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
