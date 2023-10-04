import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_app/screen/listmenu.dart';

// ignore: camel_case_types
class cart extends StatefulWidget {
  const cart({super.key});

  @override
  State<cart> createState() => _cartState();
}

// ignore: camel_case_types
class _cartState extends State<cart> {
  



 

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ตะกร้า"),
      ),
      body: Stack(
        children: [
          StreamBuilder<QuerySnapshot>(
  stream: FirebaseFirestore.instance
      .collection('users')
      .doc('testerappfood.user@gmail.com')
      .collection('Orderuser')
      .snapshots(),
  builder: (context, snapshot){
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
    if (snapshot.hasData && snapshot.data != null) {
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
          if (data['เมนู'] != null) {
            return ListTile(
              title: Text(data['เมนู']),
              subtitle: Text(data['จำนวน'].toString()),
              trailing: IconButton(
                onPressed: () {
                  documents[index].reference.delete();
                },
                icon: Icon(Icons.delete),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Listviewmenu(
                      selectorder: documents[index].reference,
                    ),
                    settings: RouteSettings(arguments: data),
                  ),
                );
              },
            );
          } else {
            // กรณีข้อมูลเป็น null หรือไม่มีข้อมูลที่ต้องการ
            return Container();
          }
        },
      );
    }
    return const Text("ไม่มีข้อมูล");
  },
),
          Positioned(
            bottom: 10,
            right: 15,
            child: 
            Container( color: Colors.green.shade300,
              child: IconButton( 
                
                onPressed: () {
                  // sendUserDataToDB()
                },
                
                icon: const Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [ Text('สั่งซื้อ',style: TextStyle(fontSize: 25),),
                    Icon(Icons.shopping_cart),
                  ],
                ),
                
              ),
            ),
          ),
        ],
      ),
    );
  }
}