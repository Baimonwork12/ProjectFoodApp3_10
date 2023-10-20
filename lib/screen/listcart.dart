import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Listcart extends StatefulWidget {
  final DocumentReference listmenu;
  const Listcart({
    Key? key,
    required this.listmenu,
  }) : super(key: key);

  @override
  State<Listcart> createState() => _ListcartState();
}

class _ListcartState extends State<Listcart> {
  late Stream<QuerySnapshot> menuCollection;
  late String nameshop;

  @override
  void initState() {
    super.initState();
    menuCollection = widget.listmenu.collection('Orderuser').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('')),
        body: StreamBuilder(
            stream: menuCollection,
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
                        title: Text(data['ชื่อเมนู']),
                        subtitle: Row(
                          children: [
                            Text(data['ราคา']),
                          ],
                        ),
                        onTap: () {});
                  },
                );
              }
              // ignore: prefer_const_constructors
              return Text("ไม่มีข้อมูล");
            }));
  }
}
