import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../thems.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // backgroundColor: Colors.re,
      child: Column(
        children: [
          AppBar(
            backgroundColor: appbarColor,
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text("exit fromApp"),
            onTap: () {
              Navigator.of(context).pop();
              // Navigator.of(context).pushReplacementNamed('/');
              Provider.of<Auth>(context, listen: false)
                  .logOut(context); // add log out
            },
          ),
        ],
      ),
    );
  }
}
