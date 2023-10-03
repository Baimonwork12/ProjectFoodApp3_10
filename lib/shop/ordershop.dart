import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_app/shop/listmenushop.dart';


class Ordershop extends StatefulWidget {
  const Ordershop({super.key});

  @override
  State<Ordershop> createState() => _OrdershopState();
}

class _OrdershopState extends State<Ordershop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('รายการสั่ง')),
       body:StreamBuilder<QuerySnapshot>(
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
                    final data =
                        documents[index];
                    return ListTile(
                      title: Text(data['เมนู']),
                      subtitle: Text(
        // แปลงจำนวนเป็น String
        data['จำนวน'].toString(),
      ),
                      onTap: (){
              Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Listmenushop(),
                              ));
            }
                    );
                  },
                );
              }
              return Text("ไม่มีข้อมูล");
        },)
     
    );
  }
}