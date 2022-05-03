import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:viicsoft_inventory_app/component/colors.dart';
import 'package:viicsoft_inventory_app/models/profile.dart';
import 'package:viicsoft_inventory_app/services/apis/user_api.dart';
import 'package:viicsoft_inventory_app/ui/Menu/user_profile/profile_details_page.dart';
import 'package:viicsoft_inventory_app/ui/authentication/loginsignupScreen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool status = false;
  UserAPI userAPI = UserAPI();

  final RefreshController _refresh = RefreshController(initialRefresh: false);
  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {});
    _refresh.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: FutureBuilder<ProfileUser>(
          future: userAPI.fetchProfileUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                var result = snapshot.data!;
                return SmartRefresher(
                  enablePullDown: true,
                  controller: _refresh,
                  onRefresh: _onRefresh,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      UserAccountsDrawerHeader(
                        accountName: Text(result.fullName),
                        accountEmail: Text(result.email),
                        currentAccountPicture: CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: result.avatarThumbnail.isEmpty
                              ? const AssetImage('assets/No_image.png')
                              : NetworkImage(result.avatarThumbnail)
                                  as ImageProvider,
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ProfileDetailPage(),
                            ),
                          );
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
                        leading: const Icon(Icons.add),
                        title: const Text('Add Category'),
                        onTap: () =>
                            Navigator.pushNamed(context, '/addCategory'),
                      ),
                      ListTile(
                        leading: const Icon(Icons.add),
                        title: const Text('Add Equipment'),
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
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              PageRouteBuilder(pageBuilder:
                                  (BuildContext context, Animation animation,
                                      Animation secondaryAnimation) {
                                return const SignupLogin();
                              }, transitionsBuilder: (BuildContext context,
                                  Animation<double> animation,
                                  Animation<double> secondaryAnimation,
                                  Widget child) {
                                return SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(1.0, 0.0),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: child,
                                );
                              }),
                              (Route route) => false);
                        },
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                  child:
                      CircularProgressIndicator(color: AppColor.gradientFirst),
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(color: AppColor.gradientFirst),
              );
            }
          }),
    );
  }
}
