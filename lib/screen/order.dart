
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_app/screen/listorder.dart';


// ignore: camel_case_types
class order extends StatefulWidget {
  const order({super.key});

  @override
  State<order> createState() => _orderState();
}

class _orderState extends State<order> {
  

 
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(title: Text('รายการสั่ง'),backgroundColor: Colors.blue.shade300),
       body:StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc('testerappfood.user@gmail.com')
            .collection('status')
            
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
                      title: Text(data['สถานะ'], style: TextStyle(fontSize: 20)),
                     
                      onTap: (){
               Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Listorder( selectstatus: documents[index].reference,),
                    settings: RouteSettings(arguments: data),
                  ),
                );
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