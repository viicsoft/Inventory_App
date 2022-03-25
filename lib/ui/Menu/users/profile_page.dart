import 'package:flutter/material.dart';
import 'package:viicsoft_inventory_app/ui/store/store_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool status = false;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text('John due'),
            accountEmail: const Text('uche@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  'assets/musk.jpg',
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                image: AssetImage('assets/profile.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('My Profile'),
            onTap: () {
              Navigator.pushNamed(context, '/userdetails');
            },
          ),
           ListTile(
            leading: const Icon(Icons.group),
            title: const Text('All Users'),
            onTap: () {
              Navigator.pushNamed(context, '/UserList');
            },
          ),
          const Divider(),
           ListTile(
            leading: const Icon(Icons.storage_sharp),
            title: const Text('Store'),
            onTap: () => Navigator.pushNamed(context, '/store')
          ),
           ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Add New Category'),
             onTap: () => Navigator.pushNamed(context, '/addCategory'),
          ),
           ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Add New Item'),
            onTap: () => Navigator.pushNamed(context, '/addItem'),
          ),
         const Divider(),
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Add Event'),
            onTap: () => Navigator.pushNamed(context, '/addevent'),
          ),
         const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Dark Mode'),
            trailing: Switch(
                    activeColor: Colors.green,
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    value: status,
                    onChanged: (value) {
                      setState(
                        () {
                          status = value;
                        },
                      );
                    },
                  ),
            
          ),
          ListTile(
            leading: const Icon(Icons.policy),
            title: const Text('Privacy policy'),
            onTap: () {},
          ),
         const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('LogOut'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
