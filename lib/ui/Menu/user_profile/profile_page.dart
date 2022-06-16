import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:viicsoft_inventory_app/component/colors.dart';
import 'package:viicsoft_inventory_app/component/style.dart';
import 'package:viicsoft_inventory_app/models/profile.dart';
import 'package:viicsoft_inventory_app/services/apis/user_api.dart';
import 'package:viicsoft_inventory_app/ui/Menu/user_profile/profile_details_page.dart';
import 'package:viicsoft_inventory_app/ui/authentication/loginsignup_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool status = false;
  UserAPI userAPI = UserAPI();

  Future refresh() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var screensize = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          color: Colors.white,
          height: screensize.height,
          width: screensize.width / 1.3,
          child: FutureBuilder<ProfileUser>(
              future: userAPI.fetchProfileUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    var result = snapshot.data!;
                    return RefreshIndicator(
                      onRefresh: refresh,
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 100, left: 15),
                            child: Row(
                              children: [
                                Container(
                                  height: 52,
                                  width: 52,
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: AppColor.buttonText),
                                    borderRadius: BorderRadius.circular(130),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(130),
                                    child: Image.network(
                                      result.avatarThumbnail,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(130),
                                          child: Image.asset(
                                            'assets/No_image.png',
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      result.fullName,
                                      style: style.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      result.email,
                                      style: style.copyWith(
                                          fontSize: 12,
                                          color: const Color(0xFF939AA3)),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: screensize.height * 0.06),
                          ListTile(
                            leading: Icon(Icons.person,
                                size: 24, color: AppColor.primaryColor),
                            title: Text(
                              'My Profile',
                              style: style.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const ProfileDetailPage(),
                                ),
                              );
                            },
                          ),
                          FutureBuilder<List<Groups>>(
                            future: UserAPI().fetchUserGroup(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasError) {
                                  return const Center();
                                } else {
                                  var userGroup = snapshot.data!;
                                  for (var i = 0; i < userGroup.length; i++) {
                                    return userGroup[i].id == '22'
                                        ? Column(
                                            children: [
                                              SizedBox(
                                                  height:
                                                      screensize.height * 0.01),
                                              const Divider(),
                                              SizedBox(
                                                  height:
                                                      screensize.height * 0.01),
                                              ListTile(
                                                leading: Icon(
                                                  Icons.add_circle_outline,
                                                  size: 24,
                                                  color: AppColor.primaryColor,
                                                ),
                                                title: Text(
                                                  'Create Event',
                                                  style: style.copyWith(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                onTap: () =>
                                                    Navigator.pushNamed(
                                                        context, '/addevent'),
                                              ),
                                            ],
                                          )
                                        : Container();
                                  }
                                }
                              }
                              return Container();
                            },
                          ),
                          SizedBox(height: screensize.height * 0.01),
                          const Divider(),
                          SizedBox(height: screensize.height * 0.01),
                          ListTile(
                            leading: Icon(
                              Icons.dark_mode_outlined,
                              size: 24,
                              color: AppColor.primaryColor,
                            ),
                            title: Text(
                              'Dark Mode',
                              style: style.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            trailing: Switch(
                              activeColor: AppColor.primaryColor,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.padded,
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
                            leading: Icon(
                              Icons.privacy_tip,
                              size: 24,
                              color: AppColor.primaryColor,
                            ),
                            title: Text(
                              'Privacy policy',
                              style: style.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            onTap: () {},
                          ),
                          SizedBox(height: screensize.height * 0.01),
                          const Divider(),
                          SizedBox(height: screensize.height * 0.06),
                          ListTile(
                            leading: Icon(
                              Icons.logout,
                              color: AppColor.red,
                              size: 24,
                            ),
                            title: Text(
                              'LogOut',
                              style: style.copyWith(
                                color: AppColor.red,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            onTap: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setBool('isLoggedIn', false);
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  PageRouteBuilder(pageBuilder:
                                      (BuildContext context,
                                          Animation animation,
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
                    return const Center();
                  }
                } else {
                  return const Center();
                }
              }),
        ),
        Stack(
          children: [
            Positioned(
              right: screensize.width * 0.185,
              top: screensize.height * 0.054,
              child: Container(
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: Center(
                  child: IconButton(
                    onPressed: (() => Navigator.pop(context)),
                    icon: const Icon(
                      Icons.close,
                      size: 26,
                    ),
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
