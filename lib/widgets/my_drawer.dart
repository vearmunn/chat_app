import 'package:chat_app/pages/setting_page.dart';
import 'package:flutter/material.dart';

import '../services/auth/auth_service.dart';
import '../themes/main_color.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: surface(context),
      child: Column(
        children: [
          DrawerHeader(
              child: Center(
                  child: Icon(
            Icons.chat,
            size: 40,
            color: primary(context),
          ))),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: ListTile(
              leading: const Icon(
                Icons.home,
              ),
              title: const Text(
                'H O M E',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: ListTile(
              leading: const Icon(
                Icons.settings,
              ),
              title: const Text(
                'S E T T I N G S',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const SettingPage()));
              },
            ),
          ),
          const Spacer(),
          ListTile(
            contentPadding: const EdgeInsets.only(left: 30.0, bottom: 10),
            leading: const Icon(
              Icons.logout,
            ),
            title: const Text(
              'L O G O U T',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () => AuthService().signOut(),
          ),
        ],
      ),
    );
  }
}
