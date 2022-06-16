import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:viicsoft_inventory_app/component/button.dart';
import 'package:viicsoft_inventory_app/component/colors.dart';
import 'package:viicsoft_inventory_app/component/confirm_password.dart';
import 'package:viicsoft_inventory_app/component/profile_update.dart';
import 'package:viicsoft_inventory_app/component/style.dart';
import 'package:viicsoft_inventory_app/models/profile.dart';
import 'package:viicsoft_inventory_app/services/apis/user_api.dart';

class ProfileDetailPage extends StatefulWidget {
  const ProfileDetailPage({Key? key}) : super(key: key);

  @override
  State<ProfileDetailPage> createState() => _ProfileDetailPageState();
}

class _ProfileDetailPageState extends State<ProfileDetailPage> {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  final picker = ImagePicker();
  UserAPI userAPI = UserAPI();

  Future refresh() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.homePageColor,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        toolbarHeight: 75,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          children: [
            IconButton(
              onPressed: () => {Navigator.pop(context)},
              icon: Icon(
                Icons.arrow_back_ios,
                size: 25,
                color: AppColor.iconBlack,
              ),
            ),
            const SizedBox(width: 16),
            Center(
              child: Text('My Profile',
                  style: style.copyWith(fontWeight: FontWeight.bold)),
            ),
            Expanded(flex: 2, child: Container()),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: FutureBuilder<ProfileUser>(
            future: userAPI.fetchProfileUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  var result = snapshot.data!;

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Form(
                      key: globalFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ListView(
                              children: <Widget>[
                                Container(
                                  height: screenSize.height * 0.55,
                                  width: screenSize.width,
                                  decoration: BoxDecoration(
                                      color: AppColor.primaryColor,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 30),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 120,
                                          width: 120,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(130),
                                            border: Border.all(
                                                color: AppColor.white,
                                                width: 2),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(130),
                                            child: Image.network(
                                              result.avatarThumbnail,
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          130),
                                                  child: Image.asset(
                                                    'assets/No_image.png',
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        //
                                        SizedBox(
                                            height: screenSize.height * 0.015),
                                        Text(
                                          result.fullName,
                                          style: style.copyWith(
                                            fontSize: 22,
                                            color: AppColor.white,
                                          ),
                                        ),
                                        SizedBox(
                                            height: screenSize.height * 0.005),
                                        Text(
                                          result.email,
                                          style: style.copyWith(
                                            fontSize: 14,
                                            color: AppColor.darkGrey,
                                          ),
                                        ),

                                        SizedBox(
                                            height: screenSize.height * 0.03),
                                        FutureBuilder<List<Groups>>(
                                          future: UserAPI().fetchUserGroup(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.done) {
                                              if (snapshot.hasError) {
                                                return const Center();
                                              } else {
                                                var userGroup = snapshot.data!;
                                                for (var i = 0;
                                                    i < userGroup.length;
                                                    i++) {
                                                  return Container(
                                                    height: 25,
                                                    width: 85,
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xffEDF9F3),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        userGroup[i].id == '22'
                                                            ? 'SUPER USER'
                                                            : 'USER',
                                                        style: style.copyWith(
                                                            fontSize: 12,
                                                            color:
                                                                AppColor.green),
                                                      ),
                                                    ),
                                                  );
                                                }
                                              }
                                            }
                                            return const Center();
                                          },
                                        ),

                                        //
                                        SizedBox(
                                            height: screenSize.height * 0.03),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 50),
                                          child: Divider(
                                            color: AppColor.darkGrey,
                                          ),
                                        ),
                                        //
                                        SizedBox(
                                            height: screenSize.height * 0.03),

                                        InkWell(
                                          onTap: () {
                                            showModalBottomSheet(
                                              isScrollControlled: true,
                                              context: context,
                                              builder: (_) {
                                                return ProfileUpdateSheet(
                                                    profile: result);
                                              },
                                            );
                                          },
                                          child: Container(
                                            height: 57,
                                            width: 158,
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                  color: AppColor.white),
                                            ),
                                            child: Center(
                                                child: Text(
                                              'EDIT PROFILE',
                                              style: style.copyWith(
                                                fontSize: 12,
                                                color: AppColor.buttonText,
                                              ),
                                            )),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                //
                                SizedBox(height: screenSize.height * 0.03),
                                const Divider(),
                                SizedBox(height: screenSize.height * 0.02),
                                Text(
                                  'SETTINGS',
                                  style:
                                      style.copyWith(color: AppColor.darkGrey),
                                ),

                                //
                                SizedBox(height: screenSize.height * 0.03),
                                MainButton(
                                  borderColor: AppColor.lightGrey,
                                  text: 'Change Password',
                                  backgroundColor: AppColor.white,
                                  textColor: AppColor.primaryColor,
                                  onTap: () {
                                    showModalBottomSheet(
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (_) {
                                          return ConfirmPassswordSheet(
                                              profile: result);
                                        });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return const Center();
                }
              }
              return Center(
                child: CircularProgressIndicator(color: AppColor.darkGrey),
              );
            }),
      ),
    );
  }
}
