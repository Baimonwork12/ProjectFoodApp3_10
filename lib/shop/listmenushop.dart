import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class Listmenushop extends StatefulWidget {
 final DocumentReference selectmenu;

  Listmenushop({required this.selectmenu});

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
        title: Text("รายละเอียด"),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: widget.selectmenu.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error fetching data'),
            );
          }
          if (snapshot.hasData) {
            final data = snapshot.data!.data() as Map<String, dynamic>;
            return Column(
              
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('เมนู: ${data['เมนู']}',style: TextStyle(fontSize: 25),),
                    
                  ],
                ),
                Text('รายละเอียด: ${data['รายละเอียด']}',style: TextStyle(fontSize: 20),),
                 Text('อื่นๆ: ${data['อื่นๆ']}',style: TextStyle(fontSize: 20),),
                Text('ไข่: ${data['ไข่']}',style: TextStyle(fontSize: 20)),
                Text('เพิ่มเติม: ${data['เพิ่มเติม']}',style: TextStyle(fontSize: 20)),
                Text('จำนวน: ${data['จำนวน']}',style: TextStyle(fontSize: 20)),
                Text('ราคา: ${data['รวม']}',style: TextStyle(fontSize: 20)),
                // ตรงนี้คุณสามารถแสดงข้อมูลเพิ่มเติมจากเมนูที่ผู้ใช้คลิกได้ตามความต้องการ
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                      child: TextButton(style: TextButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 241, 87, 76)
                      ),
                       child: Text('กำลังทำ',style: TextStyle(fontSize: 20,color: Colors.black),),
                       onPressed: (){
                      
                 
                  
                       }
                       ),
                      
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: TextButton(style: TextButton.styleFrom(
                        backgroundColor: Colors.yellow.shade300
                      ),child: Text('ทำเสร็จแล้ว',style: TextStyle(fontSize: 20,color: Colors.black),),
                      onPressed: (){
                       
                        
                      }
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: TextButton( style: TextButton.styleFrom(
                        backgroundColor: Colors.green
                      ),
                      child: 
                      Text('รับออเดอร์เรียบร้อย',style: TextStyle(fontSize: 20,color: Colors.black),),
                      onPressed: (){
                        
                      }
                      ),
                    ),
                  ],
                )
                                    
              ],
              
            );
            
          }
          return Text("ไม่มีข้อมูล");
        },
      ),
 



    );
  }
}
