import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_app/screen/login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Profileshop extends StatefulWidget {
  final DocumentReference dtprofileshop;
  const Profileshop({Key? key, required this.dtprofileshop}) : super(key: key);

  @override
  State<Profileshop> createState() => _ProfileshopState();
}

class _ProfileshopState extends State<Profileshop> {
  // ignore: non_constant_identifier_names
  late Stream<DocumentSnapshot> ProfileshopCollection;

  @override
  void initState() {
    super.initState();
    ProfileshopCollection = widget.dtprofileshop.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    void signOutGoogle() async {
      await googleSignIn.signOut();
      // ignore: avoid_print, use_build_context_synchronously
      print("User Sign Out");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const MyWidget()));
    }

    return Scaffold(
      appBar: AppBar(
          title: const Text("โปรไฟล์"),
          backgroundColor: Colors.deepPurple.shade300),
      body: StreamBuilder<DocumentSnapshot>(
        stream: widget.dtprofileshop.snapshots(),
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
            final data = snapshot.data!.data() as Map<String, dynamic>;

            final email = data['email'];
            final displayName = data['displayName'];
            final photoURL = data['photoURL'];
            // ignore: non_constant_identifier_names
            final NameShop = data['ชื่อร้านค้า'];
            final Phone = data['เบอร์โทรศัพท์'];
            final Address = data['ที่อยู่'];

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: ClipOval(
                    child: Image.network(photoURL),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Row(
                    children: [
                      const Text(
                        'ชื่อร้านค้า:',
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        NameShop,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Row(
                    children: [
                      const Text(
                        'เบอร์โทรศัพท์:',
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        Phone,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // แสดง Email
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Row(
                    children: [
                      const Text(
                        'ชื่อ:',
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        displayName,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Row(
                    children: [
                      const Text(
                        'ที่อยู่:',
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        Address,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Row(
                    children: [
                      const Text(
                        'อีเมลล์:',
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        email,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                // แสดง Display Name
                const SizedBox(
                    height: 240), // add some space above the logout button
                Align(
                  alignment: Alignment.bottomCenter,
                  child: OutlinedButton(
                    onPressed: () {
                      signOutGoogle();
                    },
                    child: const Text(
                      'log out',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ),
              ],
            );
          }
          return const Text("ไม่มีข้อมูล");
        },
      ),
    );
  }
}
