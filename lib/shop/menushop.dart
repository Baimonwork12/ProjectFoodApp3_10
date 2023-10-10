import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_app/shop/adddata/add_datamenu.dart';

class MenuShop extends StatefulWidget {
  const MenuShop({super.key});

  @override
  State<MenuShop> createState() => _MenuShopState();
}

class _MenuShopState extends State<MenuShop> {
  void editData(DocumentReference documentReference, Map<String, dynamic> data) async {
  // คุณสามารถแก้ไขข้อมูลที่ต้องการใน data ตรงนี้
  // เช่น data['ชื่อเมนู'] = 'เมนูที่แก้ไขแล้ว';
  //       data['ราคา'] = 100; // เปลี่ยนราคาเป็น 100
  // หลังจากแก้ไขข้อมูลเสร็จแล้ว ให้บันทึกข้อมูลใหม่ลงใน Firestore

  await documentReference.update(data);
  // หรือถ้าคุณต้องการใช้ `set` แทนการ `update` เพื่อแทนที่ข้อมูลทั้งหมด
  // await documentReference.set(data);
}

  late Stream<QuerySnapshot> menuCollection;
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('เมนูร้านค้า'),backgroundColor: Colors.deepPurple.shade300,
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Adddatamenu()));
                },
                icon: const Icon(Icons.note_add)),
                
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
                itemCount: snapshot.data!.docs.length,
       itemBuilder: (context, index) {
                  final data = documents[index];
                  return ListTile(
                      title: Text(data['ชื่อเมนู'],style: TextStyle(fontSize: 20)),
                      // เพิ่ม icon ที่สอง
trailing: Stack(
  children: [
//     IconButton(
//       onPressed: () {
 
//   documents[index].reference.update({
//     'ชื่อเมนู':  data['ชื่อเมนู'],
//     'ราคา': data['ราคา'].toString(),
//   });
//   //     Navigator.push(context,
//   //                     MaterialPageRoute(builder: (context) =>
//   //                     EditDataPopup(editdatamenu: documents[index].reference, data: {},)));
// },

// //       onPressed: () {
// //   // ฟังก์ชันสำหรับ icon ที่สอง
// //   // documents[index].reference.delete();
// //   // เปลี่ยนเป็น
// //   documents[index].reference.update({
// //    'ชื่อเมนู': data['ชื่อเมนู'],
// //   });
// // },

// //       onPressed: () {
// //   // ฟังก์ชันสำหรับ icon ที่สอง
// //   // documents[index].reference.delete();
// //   // เปลี่ยนเป็น
// //   documents[index].reference.set({
// //     'ชื่อเมนู': data['ชื่อเมนู'],
// //     'ราคา': data['ราคา'].toString(),
// //   });
// // },

// //       onPressed: () {
// //         // ฟังก์ชันสำหรับ icon แรก
// //         // editData(documents[index].reference, data['แก้ไข']);
// //        // ฟังก์ชันสำหรับ icon แรก
// // editData(documents[index].reference, {
// //  'ชื่อเมนู': data['ชื่อเมนู'],
// //                       'ราคา': data['ราคา'].toString(),
// // });

// //         Navigator.push(context,
// //                       MaterialPageRoute(builder: (context) =>
// //                       EditDataPopup(editdatamenu: documents[index].reference, data: {},)));
// //       },
      
                  
                
//       icon: const Padding(
//         padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
//         child: Icon(Icons.edit, size: 20, color: Colors.black),
//       ),

//     ),
    // เปลี่ยน icon ที่สองเป็น icon สำหรับลบ
    IconButton(
      onPressed: () {
  // ฟังก์ชันสำหรับ icon ที่สอง
  // documents[index].reference.delete();
  // เปลี่ยนเป็น
        documents[index].reference.delete();

},

      // onPressed: () {
      //   // ฟังก์ชันสำหรับ icon ที่สอง
      //   documents[index].reference.delete();
      // },
      icon: const Padding(
        padding: EdgeInsets.fromLTRB(30, 0 , 0, 0),
        child: Icon(Icons.delete, size: 30, color: Colors.red),
      ),
    ),
  ],
),




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
class EditDataPopup extends StatefulWidget {
  final DocumentReference editdatamenu;
  final Map<String, dynamic> data;

  const EditDataPopup({
    required this.editdatamenu,
    required this.data,
  });

  @override
  State<EditDataPopup> createState() => _EditDataPopupState();
}
class _EditDataPopupState extends State<EditDataPopup> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.data['ชื่อเมนู'];
    _priceController.text = widget.data['ราคา'].toString();
  }

  // ฟังก์ชันสำหรับแก้ไขข้อมูลในเอกสาร
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
    return AlertDialog(
      title: Text('แก้ไขข้อมูล'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'ชื่อเมนู',
            ),
          ),
          TextField(
            controller: _priceController,
            decoration: InputDecoration(
              labelText: 'ราคา',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('ยกเลิก'),
        ),
        TextButton(
          onPressed: () {
            // อัปเดตข้อมูลในเอกสาร
            editData(widget.editdatamenu, {
              'ชื่อเมนู': _nameController.text,
              'ราคา': int.parse(_priceController.text),
            });
            Navigator.of(context).pop();
          },
          child: Text('บันทึก'),
        ),
      ],
    );
  }
}

