import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:viicsoft_inventory_app/component/colors.dart';
import 'package:viicsoft_inventory_app/models/profile.dart';
import 'package:viicsoft_inventory_app/services/apis/user_api.dart';

class ProfileDetailPage extends StatefulWidget {
  const ProfileDetailPage({Key? key}) : super(key: key);

  @override
  State<ProfileDetailPage> createState() => _ProfileDetailPageState();
}

class _ProfileDetailPageState extends State<ProfileDetailPage> {
  bool _isOnlineImage = true;
  bool _isObscure = true;
  bool _isObscureConfirmPassword = true;
  XFile? _profileimage;
  bool noImage = false;

  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmPasswordField = TextEditingController();
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  final picker = ImagePicker();
  UserAPI userAPI = UserAPI();

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(
        source: source, imageQuality: 50, maxHeight: 700, maxWidth: 650);

    if (pickedFile == null) {
      _isOnlineImage = true;
    } else {
      setState(() {
        _profileimage = pickedFile;
        _isOnlineImage = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<ProfileUser>(
          future: userAPI.fetchProfileUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                var result = snapshot.data!;
                final TextEditingController _newEmail =
                    TextEditingController(text: result.email);
                final TextEditingController _newName =
                    TextEditingController(text: result.fullName);
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                  child: Form(
                    key: globalFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => {Navigator.pop(context)},
                              icon: const Icon(Icons.arrow_back_ios),
                            ),
                            Expanded(child: Container()),
                            const Center(
                              child: Text(
                                'Edit Profile',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Expanded(flex: 2, child: Container()),
                          ],
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
                                        width: 90,
                                        height: 90,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          image: DecorationImage(
                                            image: _isOnlineImage
                                                ? NetworkImage(
                                                    result.avatarThumbnail)
                                                : FileImage(File(
                                                        _profileimage!.path))
                                                    as ImageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: InkWell(
                                          onTap: () {
                                            showDialog<String>(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                title: Text(
                                                  'Select Image',
                                                  style: TextStyle(
                                                    color: AppColor
                                                        .homePageSubtitle,
                                                  ),
                                                ),
                                                content: const Text(
                                                    'Select image from device gallery or use device camera'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      getImage(
                                                          ImageSource.camera);
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      'Camera',
                                                      style: TextStyle(
                                                        color: AppColor
                                                            .gradientFirst,
                                                      ),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      getImage(
                                                          ImageSource.gallery);
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      'Gallery',
                                                      style: TextStyle(
                                                        color: AppColor
                                                            .gradientFirst,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
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
                                  const SizedBox(height: 5),
                                  Center(
                                    child: Text(
                                      noImage ? 'No image selected !' : '',
                                      style: TextStyle(
                                          color: AppColor.gradientFirst),
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Text(
                                    result.fullName,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: AppColor.homePageTitle,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    result.email,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: AppColor.homePageTitle,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    controller: _newName,
                                    cursorColor: Colors.black54,
                                    decoration: InputDecoration(
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppColor.gradientFirst,
                                        ),
                                      ),
                                      icon: const Icon(
                                        Icons.person,
                                        color: Colors.grey,
                                      ),
                                      labelStyle: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                      labelText: 'Name*',
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  TextFormField(
                                    cursorColor: Colors.black54,
                                    controller: _newEmail,
                                    validator: (input) =>
                                        !(input?.contains('@') ?? false)
                                            ? "Put a valid Email Address"
                                            : null,
                                    decoration: InputDecoration(
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppColor.gradientFirst,
                                        ),
                                      ),
                                      icon: const Icon(
                                        Icons.email,
                                        color: Colors.grey,
                                      ),
                                      labelText: 'Email*',
                                      labelStyle: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  TextFormField(
                                    controller: _newPassword,
                                    obscureText: _isObscure,
                                    cursorColor: Colors.black54,
                                    validator: (value) {
                                      bool passValid =
                                          RegExp("^(?=.*[A-Z])(?=.*[a-z]).*")
                                              .hasMatch(value!);
                                      if (value.isEmpty || !passValid) {
                                        return 'Please enter Valid Pasword*';
                                      }
                                      if (value.length < 6) {
                                        return 'Pasword Must be more than 5 charater*';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppColor.gradientFirst,
                                        ),
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                            _isObscure
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: Colors.grey),
                                        onPressed: () {
                                          setState(() {
                                            _isObscure = !_isObscure;
                                          });
                                        },
                                      ),
                                      icon: const Icon(
                                        Icons.security,
                                        color: Colors.grey,
                                      ),
                                      hintText:
                                          'password must contain Upper case and lowercase',
                                      hintStyle: const TextStyle(
                                          fontSize: 12, color: Colors.red),
                                      labelText: 'Change Password*',
                                      labelStyle: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  TextFormField(
                                    obscureText: _isObscureConfirmPassword,
                                    controller: _confirmPasswordField,
                                    cursorColor: Colors.black54,
                                    decoration: InputDecoration(
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppColor.gradientFirst,
                                        ),
                                      ),
                                      suffixIcon: IconButton(
                                          icon: Icon(
                                              _isObscureConfirmPassword
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: Colors.grey),
                                          onPressed: () {
                                            setState(() {
                                              _isObscureConfirmPassword =
                                                  !_isObscureConfirmPassword;
                                            });
                                          }),
                                      icon: const Icon(
                                        Icons.security,
                                        color: Colors.grey,
                                      ),
                                      labelText: 'Confirm Pasword',
                                      labelStyle: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    validator: (value) {
                                      if (_newPassword.text !=
                                          _confirmPasswordField.text) {
                                        return 'Please Confirm Pasword*';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.width * 0.2),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      if (globalFormKey.currentState!
                                          .validate()) {
                                        if (_profileimage == null) {
                                          setState(() {
                                            noImage = true;
                                          });
                                        } else {
                                          noImage = false;
                                        }
                                        var res = await UserAPI()
                                            .updateUserProfile(
                                                _newEmail.text.trim(),
                                                _newPassword.text.trim(),
                                                result.id,
                                                _profileimage!,
                                                _newName.text.trim());
                                        if (res.statusCode == 200) {
                                          _newPassword.clear();
                                          _confirmPasswordField.clear();
                                          Navigator.pushNamed(context,
                                              '/profileChangeSuccessPage');
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              backgroundColor: Colors.red,
                                              content: Text(
                                                  "Not Saved Something went wrong !"),
                                            ),
                                          );
                                        }
                                      }
                                    },
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
                    ),
                  ),
                );
              } else {
                return Center(
                  child:
                      CircularProgressIndicator(color: AppColor.gradientFirst),
                );
              }
            }
            return Center(
              child: CircularProgressIndicator(color: AppColor.gradientFirst),
            );
          }),
    );
  }

  // userimage(bool saverImage, String url) {
  //   if (saverImage) {
  //     return Image.network(url);
  //   } else {
  //     return Image.file(File(_profileimage.path));
  //   }
  // }
}
