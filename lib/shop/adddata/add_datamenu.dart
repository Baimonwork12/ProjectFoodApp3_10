import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/shop/bottom_shop.dart';

class Adddatamenu extends StatefulWidget {
  const Adddatamenu({super.key});

  @override
  State<Adddatamenu> createState() => _AdddatamenuState();
}

class _AdddatamenuState extends State<Adddatamenu> {
  TextEditingController namemenu = TextEditingController();
  TextEditingController price = TextEditingController();
  
  final formKey = GlobalKey<FormState>();

  





Future<void> sendUserDataToDB() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser;

    if (formKey.currentState!.validate()) {
      Map<String, dynamic> menuData = {
        'ชื่อเมนู': namemenu.text,
        'ราคา': price.text, // Changed variable name to lowercase
        // Add other menu fields as needed
      };

      if (currentUser != null) {
        // Reference to the main collection associated with the user's UID
        CollectionReference userMainCollection =
            FirebaseFirestore.instance.collection('Shop');

        CollectionReference userMenuSubCollection =
            userMainCollection.doc('tbk1243@gmail.com').collection('menu');
            print('email :$currentUser.email');

        await userMenuSubCollection.doc(namemenu.text).set(menuData);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('เพิ่มเมนูร้านค้า')),
      body: Form(
        key: formKey,
        child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 20, 0, 0),
            child: TextFormField(controller: namemenu,
            decoration: const InputDecoration(
              labelText: 'ชื่อเมนู',
              hintText: 'ชื่อเมนู'
              
            ),validator: (value) {
              if(value == null || value.isEmpty){
                return ' กรุณากรอกชื่อเมนู';
              }return null;
            },),
          ),SizedBox(height: 10,),
          TextFormField(keyboardType: TextInputType.phone,
            controller: price,
            decoration: const InputDecoration(
              hintText: 'ราคา',
              labelText: 'ราคา'
            
            ),
            validator: (value) {
            if(value == null || value.isEmpty){
              return ' กรุณากรอกราคา';
            }return null;
          },
          ),SizedBox(height: 10,),
          
          OutlinedButton(onPressed: (){
             sendUserDataToDB();
            Navigator.push(context, MaterialPageRoute(builder: (context)=>(MyNavigator1())));
          }, child: const Text('บันทึก'))
        ],
      ))
      
    );
  }
}