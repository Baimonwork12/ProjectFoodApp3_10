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
  
void editData(DocumentReference documentReference, Map<String, dynamic> data) async {
  // คุณสามารถแก้ไขข้อมูลที่ต้องการใน data ตรงนี้
  // เช่น data['ชื่อเมนู'] = 'เมนูที่แก้ไขแล้ว';
  //       data['ราคา'] = 100; // เปลี่ยนราคาเป็น 100
  // หลังจากแก้ไขข้อมูลเสร็จแล้ว ให้บันทึกข้อมูลใหม่ลงใน Firestore

  await documentReference.update(data);
  // หรือถ้าคุณต้องการใช้ `set` แทนการ `update` เพื่อแทนที่ข้อมูลทั้งหมด
  // await documentReference.set(data);
}


 

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
                      title: Text(data['เมนู']),
                      subtitle: Text(
        // แปลงจำนวนเป็น String
        data['จำนวน'].toString(),
      ),
       trailing: IconButton(
  onPressed: () {
    // เรียกใช้ฟังก์ชัน editData()
    editData(documents[index].reference, data['แก้ไข']);
  },
  icon: Icon(Icons.edit, size: 20, color: Colors.black),
),
      // trailing: IconButton(onPressed: (){
      //    documents[index].reference.delete();
      // }, icon: Icon(Icons.delete)),
      
                      onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=> Listviewmenu(
                  
                selectorder:  
                documents[index].reference,
                ) 
                // ,settings: RouteSettings(arguments: documents)
                ));
            }
                    );
                  },
                );
              }
              
              return const Text("ไม่มีข้อมูล");
          
        },),
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
