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
    body:  Center(
        child: OutlinedButton(onPressed: (){
          signOutGoogle();
        }, child: Text('log out')),
      ),
//     body:  StreamBuilder<QuerySnapshot>(
//   stream: FirebaseFirestore.instance
//     .collection('users')
//     .doc('testerappfood.user@gmail.com')
//     .collection('Orderuser')
//     .snapshots(),
//   builder: (context, snapshot) {
//     if (snapshot.connectionState == ConnectionState.waiting) {
//       return const Center(
//         child: CircularProgressIndicator(),
//       );
//     }
//     if (snapshot.hasError) {
//       return const Center(
//         child: Text('Error fetching data'),
//       );
//     }
//     if (snapshot.hasData) {
//       final documents = snapshot.data!.docs;
//       if (documents.isEmpty) {
//         return const Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [Text('ยังไม่มีข้อมูล')],
//           ),
//         );
//       }
//       return ListView.builder(
//         itemCount: documents.length,
//         itemBuilder: (context, index) {
//           final data = documents[index];
//           // เพิ่มข้อมูล 'email', 'displayName', 'photoURL' จาก User
//           // final email = data['email'];
//           // final displayName = data['displayName'];
//           // final photoURL = data['photoURL'];

//           return ListTile(
//             title: Text(data['เมนู']),
//             subtitle: Text(data['จำนวน']),
//             trailing: Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Text(data['email']), // แสดง Email
//                 Text(data['displayName']), // แสดง Display Name
//                 // Image.network(photoURL), // แสดงรูปภาพจาก URL
//               ],
//             ),
//             onTap: () {
//               // โค้ดเมื่อตัวเมนูถูกแตะ
//             },
//           );
//         },
//       );
//     }
//     return Text("ไม่มีข้อมูล");
//   },
// )

   
    );
  }
}