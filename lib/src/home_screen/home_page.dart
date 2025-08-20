import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_app/core/di/di.dart';
import 'package:flutter_chat_app/src/chat_page/chat_page.dart';
import 'package:flutter_chat_app/src/home_screen/bloc/home_bloc.dart';
import 'package:flutter_chat_app/src/login_screen/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final bloc = getIt<HomeBloc>();

  void confirmLogout(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'Sign Out',
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: const Color(0xff2865DC),
          ),
        ),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              try {
                bloc.signOut(() {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                    (route) => false,
                  );
                });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xff2865DC),
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
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.person)),
                  title: Text(
                    user.displayName,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(user.email),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatPage(
                          receiverEmail: user.email,
                          receiverUid: user.uid,
                          senderUid: snapshot.currentUser?.uid ?? '',
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
              decoration: const BoxDecoration(color: Color(0xff2865DC)),
              child: Center(
                child: BlocBuilder<HomeBloc, HomeState>(
                  bloc: bloc,
                  builder: (context, state) {
                    return Text(
                      state.currentUser?.displayName ?? 'User',
                      style: const TextStyle(color: Colors.white, fontSize: 24),
                    );
                  },
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ListTile(
                  onTap: () {
                    confirmLogout(context);
                  },
                  title: const Text('Logout'),
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
