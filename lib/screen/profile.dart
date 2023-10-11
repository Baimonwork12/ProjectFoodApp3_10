import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_app/screen/login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Profile extends StatefulWidget {
  final DocumentReference dtprofile;
  const Profile({Key? key, required this.dtprofile}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // ignore: non_constant_identifier_names
  late Stream<DocumentSnapshot> ProfileCollection;

  @override
  void initState() {
    super.initState();
    ProfileCollection = widget.dtprofile.snapshots();
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  void signOutGoogle() async {
    await _googleSignIn.signOut();
    // ignore: avoid_print
    print("User Sign Out");
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const MyWidget()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("โปรไฟล์"), backgroundColor: Colors.blue.shade300),
      body: StreamBuilder<DocumentSnapshot>(
        stream: widget.dtprofile.snapshots(),
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
                  height: 20,
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
                const SizedBox(height: 300), // add some space above the logout button
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
