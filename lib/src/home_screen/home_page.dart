import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_app/core/di/di.dart';
import 'package:flutter_chat_app/src/chat_page/chat_page.dart';
import 'package:flutter_chat_app/src/home_screen/bloc/home_bloc.dart';
import 'package:flutter_chat_app/src/login_screen/login_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final currentUser = FirebaseAuth.instance.currentUser;
  List<QueryDocumentSnapshot<Map<String, dynamic>>> searchResults = [];

  String? currentUserName;

  final bloc = getIt<HomeBloc>();



  // Logout with confirmation
  void confirmLogout() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              try {
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Failed to Sign Out')),
                );
              }
            },
            child: const Text('Log Out'),
          ),
        ],
      ),
    );
  }

  //get current user name
  Future<String?> getCurrentUserName() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    if (doc.exists && doc.data()!.containsKey('name')) {
      return doc['name'];
    }

    return null;
  }

  @override
  void initState() {
    super.initState();
    loadCurrentUserName();
  }

  void loadCurrentUserName() async {
    currentUserName = await getCurrentUserName();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        bloc: bloc,
        builder: (context, snapshot) {
          if (snapshot.userList.isEmpty) {
            return const Center(child: Text('No users found.'));
          }

          return ListView.builder(
            itemCount: snapshot.userList.length,
            itemBuilder: (context, index) {
              final user = snapshot.userList[index];
              if (user.uid == currentUser?.uid) {
                return const SizedBox.shrink();
              }
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: ListTile(
                  leading: CircleAvatar(child: Icon(Icons.person)),
                  title: Text(
                    user.displayName,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(user.email),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatPage(
                          receiverEmail: user.email,
                          receiverUid: user.uid,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.grey),
              child: Center(
                child: Text(
                  currentUserName ?? 'Loading...',
                  style: const TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ListTile(
                  onTap: confirmLogout,
                  title: const Text('L O G O U T'),
                  leading: const Icon(Icons.logout),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
