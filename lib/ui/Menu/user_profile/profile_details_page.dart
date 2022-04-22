import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:viicsoft_inventory_app/component/colors.dart';
import 'package:viicsoft_inventory_app/models/profile.dart';
import 'package:viicsoft_inventory_app/services/apis/user_api.dart';

class ProfileDetailPage extends StatefulWidget {
  final ProfileUser userDetail;
  const ProfileDetailPage({Key? key, required this.userDetail})
      : super(key: key);

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

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(
        source: source, imageQuality: 50, maxHeight: 700, maxWidth: 650);

    setState(() {
      _profileimage = pickedFile;
      _isOnlineImage = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _newEmail =
        TextEditingController(text: widget.userDetail.email);
    final TextEditingController _newName =
        TextEditingController(text: widget.userDetail.fullName);
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Form(
            key: globalFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
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
                                  borderRadius: BorderRadius.circular(40),
                                  image: DecorationImage(
                                    image: _isOnlineImage
                                        ? NetworkImage(
                                            widget.userDetail.avatarThumbnail)
                                        : FileImage(File(_profileimage!.path))
                                            as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              // SizedBox(
                              //   height: 100,
                              //   width: 100,
                              //   child: CircleAvatar(
                              //     backgroundColor: Colors.white,
                              //     child: userimage(
                              //         _isOnlineImage, widget.userDetail.avatar),
                              //   ),
                              // ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: InkWell(
                                  onTap: () {
                                    showDialog<String>(
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
                          Center(
                            child: Text(
                              noImage ? 'No image selected !' : '',
                              style: TextStyle(color: AppColor.gradientFirst),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            widget.userDetail.fullName,
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColor.homePageTitle,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            widget.userDetail.email,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColor.homePageTitle,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _newName,
                            decoration: const InputDecoration(
                              icon: Icon(
                                Icons.person,
                                color: Colors.grey,
                              ),
                              labelText: 'Name*',
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _newEmail,
                            validator: (input) =>
                                !(input?.contains('@') ?? false)
                                    ? "Put a valid Email Address"
                                    : null,
                            decoration: const InputDecoration(
                              icon: Icon(
                                Icons.email,
                                color: Colors.grey,
                              ),
                              labelText: 'Email*',
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _newPassword,
                            obscureText: _isObscure,
                            validator: (input) => (input != null &&
                                    input.length < 6)
                                ? "Password should be more than 5 characters"
                                : null,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(_isObscure
                                    ? Icons.visibility
                                    : Icons.visibility_off),
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
                              labelText: 'Change Password*',
                            ),
                          ),
                          TextFormField(
                            obscureText: _isObscureConfirmPassword,
                            controller: _confirmPasswordField,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  icon: Icon(_isObscureConfirmPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off),
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
                      SizedBox(height: MediaQuery.of(context).size.width * 0.2),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              if (globalFormKey.currentState!.validate()) {
                                if (_profileimage == null) {
                                  setState(() {
                                    noImage = true;
                                  });
                                } else {
                                  setState(() {
                                    noImage = false;
                                  });
                                }
                                var res = await UserAPI().updateUserProfile(
                                    _newEmail.text.trim(),
                                    _newPassword.text.trim(),
                                    widget.userDetail.id,
                                    _profileimage!,
                                    _newName.text.trim());
                                if (res.statusCode == 200) {
                                  _newPassword.clear();
                                  _confirmPasswordField.clear();
                                  Navigator.pushNamed(
                                      context, '/profileChangeSuccessPage');
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
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
          )),
    );
  }

  userimage(bool saverImage, String url) {
    if (saverImage) {
      return Image.network(url);
    } else {
      return Image.file(File(_profileimage!.path));

      //FileImage(File(_profileimage!.path));
    }
  }
}
