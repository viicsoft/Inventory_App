import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:viicsoft_inventory_app/component/colors.dart';
import 'package:viicsoft_inventory_app/component/textform.dart';
import 'package:viicsoft_inventory_app/models/users.dart';
import 'package:viicsoft_inventory_app/services/apis/user_api.dart';
//import 'package:inventory/handburger/reset_password_page.dart';

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({Key? key}) : super(key: key);

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  bool _isObscure = true;
  XFile? _profileimage;

  final picker = ImagePicker();

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    setState(() {
      _profileimage = pickedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: FutureBuilder<User>(
          future: UserAPI().profileUser(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return SizedBox(
                child: Container(
                  child: Text(snapshot.hasError.toString()),
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              final results = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        Column(
                          children: <Widget>[
                            Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    image: DecorationImage(
                                      image: _profileimage != null
                                          ? FileImage(File(_profileimage!.path))
                                          : NetworkImage(results.avatarThumbnail)
                                              as ImageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: InkWell(
                                    onTap: () => showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title: const Text('Select Image'),
                                        content: const Text(
                                            'Select image from device gallery or use device camera'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              getImage(ImageSource.camera);
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Camera'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              getImage(ImageSource.gallery);
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Gallery'),
                                          ),
                                        ],
                                      ),
                                    ),
                                    child: Container(
                                      height: 25,
                                      width: 25,
                                      decoration: BoxDecoration(
                                        color: AppColor.homePageTitle,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          width: 1.5,
                                          color: Colors.white,
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.edit,
                                        size: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Text(
                              results.fullName,
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColor.homePageTitle,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              results.email,
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColor.homePageTitle,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 20),
                            textform(
                                icon: Icons.person,
                                label: 'Full Name*',
                                initialValue: results.fullName),
                            const SizedBox(height: 10),
                            textform(
                                icon: Icons.person,
                                label: 'Username*',
                                initialValue: results.username),
                            const SizedBox(height: 10),
                            textform(
                                icon: Icons.email,
                                label: 'Email*',
                                initialValue: results.email),
                            const SizedBox(height: 10),
                            // textform(
                            //     obscureText: _isObscure,
                            //     suffixIcon: IconButton(
                            //       icon: Icon(_isObscure
                            //           ? Icons.visibility
                            //           : Icons.visibility_off),
                            //       onPressed: () {
                            //         setState(() {
                            //           _isObscure = !_isObscure;
                            //         });
                            //       },
                            //     ),
                            //     icon: Icons.security,
                            //     label: 'Password*',
                            //     initialValue: results.oauthProvider),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () => Navigator.pushNamed(
                                      context, '/resetpassword'),
                                  child: const Text('Change  Password  ?'),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              child: const Text('Save'),
                              style: ElevatedButton.styleFrom(
                                  primary: AppColor.gradientFirst),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              );
            }
            else {
              return Center(
                child: CircularProgressIndicator(color: AppColor.gradientFirst),
              );
            }
          },
          
        ),
      ),
    );
  }
}
