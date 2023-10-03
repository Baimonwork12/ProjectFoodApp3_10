import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Listmenushop extends StatefulWidget {
  const Listmenushop({super.key});

  @override
  State<Listmenushop> createState() => _ListmenushopState();
}

class _ListmenushopState extends State<Listmenushop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายละเอียด'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc('testerappfood.user@gmail.com')
            .collection('Orderuser')
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
                    title: Wrap(
                      children: [
                        Text(
                          data['เมนู'],
                          style: TextStyle(fontSize: 20),
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text('เพิ่มเติม:'),
                                Text(
                                  data['เพิ่มเติม'],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(data['รายละเอียด']),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(data['อื่นๆ']),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(data['ไข่']),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text('จำนวน'),
                                Text(
        // แปลงจำนวนเป็น String
        data['จำนวน'].toString(),
      ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    onTap: () {});
              },
            );
          }
          ;

          return Text("ไม่มีข้อมูล");
        },
      ),
      floatingActionButton: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                // โค้ดที่คุณต้องการให้ทำงานเมื่อปุ่มถูกแตะ
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.purple, // สีพื้นหลัง
              ),
              child: const Text(
                'กำลังทำ',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white, // สีของข้อความ
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                // โค้ดที่คุณต้องการให้ทำงานเมื่อปุ่มถูกแตะ
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.red, // สีพื้นหลัง
              ),
              child: const Text(
                'ทำเสร็จแล้ว',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white, // สีของข้อความ
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                // โค้ดที่คุณต้องการให้ทำงานเมื่อปุ่มถูกแตะ
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.green, // สีพื้นหลัง
              ),
              child: const Text(
                'รับออเดอร์แล้ว',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white, // สีของข้อความ
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
