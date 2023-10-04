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
                      trailing: IconButton(
  onPressed: () {
    // เรียกใช้ฟังก์ชัน editData()
    editData(documents[index].reference, data['แก้ไข']);
    // Navigator.push(context,MaterialPageRoute(builder: (context)=> EditDataPopup(documentReference: documentReference, data: data)))
  },
  icon: Icon(Icons.edit, size: 20, color: Colors.black),
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
  final DocumentReference documentReference;
  final Map<String, dynamic> data;

  const EditDataPopup({
    required this.documentReference,
    required this.data,
  });

  @override
  State<EditDataPopup> createState() => _EditDataPopupState();
}

class _EditDataPopupState extends State<EditDataPopup> {
  void editData(DocumentReference documentReference, Map<String, dynamic> data) async {
  // เรียกใช้ฟังก์ชัน editData()
  editData(widget.documentReference,{});

  // แสดงป๊อปอัปเพื่อแก้ไขข้อมูล
  showDialog(
    context: context,
    builder: (context) => EditDataPopup(
      documentReference: documentReference,
      data: data,
    ),
  );
}
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.data['ชื่อเมนู'];
    _priceController.text = widget.data['ราคา'].toString();
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
            // บันทึกข้อมูลใหม่ไปยัง Firestore
            editData(widget.documentReference, {
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