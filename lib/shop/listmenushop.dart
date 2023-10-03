import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Listmenushop extends StatefulWidget {
  final DocumentReference selectmenu;
  const Listmenushop({Key? key, required this.selectmenu}) : super(key: key);

  @override
  State<Listmenushop> createState() => _ListmenushopState();
}

class _ListmenushopState extends State<Listmenushop> {
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
          title: const Text('รายละเอียด'),
        ),
        body: StreamBuilder(
            stream: OrderCollection,
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
                              style: const TextStyle(fontSize: 20),
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    const Text('เพิ่มเติม'),
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
                                    const Text('จำนวน'),
                                    Text(
                                      // แปลงจำนวนเป็น String
                                      data['จำนวน'].toString(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text('ราคารวม'),
                                    Text(
                                      data['รวม'],
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
              return Text("ไม่มีข้อมูล");
            }));
  }
}
