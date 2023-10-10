import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_app/datamenu/dtmenu.dart';



class dttamsang extends StatefulWidget {
  final DocumentReference menu;
  const dttamsang({Key? key, required this.menu}) : super(key: key);
  @override
  State<dttamsang> createState() => _dttamsangState();
}

class _dttamsangState extends State<dttamsang> {
  late Stream<QuerySnapshot> menuCollection;
  @override
  void initState() {
    super.initState();
    menuCollection = widget.menu.collection('menu').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('เมนู'),backgroundColor: Colors.blue.shade300
        ),
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
                    final data =
                        documents[index];
                    return ListTile(
                      title: Text(data['ชื่อเมนู']),
                      subtitle: Text(data['ราคา']),
                      onTap: (){
                 Navigator.push(context, MaterialPageRoute(
                builder: (context)=>Dtmenu(selectItem: data.reference)));
            }
                    );
                  },
                );
              }
              return Text("ไม่มีข้อมูล");
            }));
  }
}
