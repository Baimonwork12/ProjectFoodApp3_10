import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_app/screen/login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  
 
  @override
  Widget build(BuildContext context) {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
  void signOutGoogle() async {
    await _googleSignIn.signOut();
    // ignore: avoid_print
    print("User Sign Out"); Navigator.push(context, MaterialPageRoute(builder: (context)=> MyWidget()));
  }
    
    return Scaffold(
      appBar: AppBar(
        title: Text('โปรไฟล์'),
    ),
    // body:  Center(
    //     child: OutlinedButton(onPressed: (){
    //       signOutGoogle();
    //     }, child: Text('log out')),
    //   ),
   body:
    StreamBuilder<QuerySnapshot>(
  stream: FirebaseFirestore.instance.collection('users').snapshots(),
  builder: (context, snapshot) {
    if (!snapshot.hasData) {
      return const CircularProgressIndicator(); // แสดงตัวเครื่องโหลดข้อมูล
    }
    final List<DocumentSnapshot> documents = snapshot.data!.docs;
    return ListView.builder(
      itemCount: documents.length,
      itemBuilder: (context, index) {
        final data = documents[index].data() as Map<String, dynamic>;
    



        // เพิ่มข้อมูล 'email', 'displayName' จาก User
        final email = data['email'];
        final displayName = data['displayName'];
        final photoURL = data ['photoURL'];
        return ListTile(
       
          trailing: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(email),
              ), // แสดง Email
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(displayName),
              ), // แสดง Display Name
              Image.network(photoURL)
            ],
          ),
          onTap: () {
            // โค้ดเมื่อตัวเมนูถูกแตะ
          },
        );
      },
    );
  },
)




   
    );
  }
}