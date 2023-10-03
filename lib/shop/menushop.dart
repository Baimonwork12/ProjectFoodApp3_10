import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_app/shop/adddata/add_datamenu.dart';

class MenuShop extends StatefulWidget {
  const MenuShop({super.key});

  @override
  State<MenuShop> createState() => _MenuShopState();
}

class _MenuShopState extends State<MenuShop> {
  late Stream<QuerySnapshot> menuCollection;
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('เมนูร้านค้า'),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Adddatamenu()));
                },
                icon: Icon(Icons.note_add))
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Shop')
              .doc('tbk1243@gmail.com')
              .collection('menu')
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
                      title: Text(data['ชื่อเมนู']),
                      // subtitle: Text(data['ราคา']),
                      onTap: () {
                        
                      });
                },
              );
            }
            return Text("ไม่มีข้อมูล");
          },
        ));
  }
}
