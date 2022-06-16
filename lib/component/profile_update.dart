import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:viicsoft_inventory_app/component/button.dart';
import 'package:viicsoft_inventory_app/component/colors.dart';
import 'package:viicsoft_inventory_app/component/mytextform.dart';
import 'package:viicsoft_inventory_app/component/popover.dart';
import 'package:viicsoft_inventory_app/component/style.dart';
import 'package:viicsoft_inventory_app/component/success_button_sheet.dart';
import 'package:viicsoft_inventory_app/models/profile.dart';
import 'package:viicsoft_inventory_app/services/apis/user_api.dart';

class ProfileUpdateSheet extends StatefulWidget {
  final ProfileUser profile;
  const ProfileUpdateSheet({Key? key, required this.profile}) : super(key: key);

  @override
  State<ProfileUpdateSheet> createState() => _ProfileUpdateSheetState();
}

class _ProfileUpdateSheetState extends State<ProfileUpdateSheet> {
  final TextEditingController _newEmail = TextEditingController();
  final TextEditingController _newName = TextEditingController();
  final GlobalKey<FormState> _globalFormKey = GlobalKey<FormState>();

  final picker = ImagePicker();
  bool _isOnlineImage = true;
  XFile? _profileimage;
  bool noImage = false;

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
  void initState() {
    _newName.text = widget.profile.fullName;
    _newEmail.text = widget.profile.email;
    super.initState();
  }

  @override
  void dispose() {
    _newName.dispose();
    _newEmail.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _globalFormKey,
      child: Padding(
        padding: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //

            Center(
              child: FractionallySizedBox(
                widthFactor: 0.25,
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  child: Container(
                    height: 5.0,
                    decoration: BoxDecoration(
                      color: AppColor.darkGrey,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(2.5)),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),

            //

            Text(
              'Profile Picture',
              style: style.copyWith(
                  fontSize: 11,
                  color: AppColor.darkGrey,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Stack(
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(130),
                  ),
                  child: _isOnlineImage
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(130),
                          child: Image.network(
                            widget.profile.avatarThumbnail,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(130),
                                child: Image.asset(
                                  'assets/No_image.png',
                                ),
                              );
                            },
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(130),
                          child: Image.file(
                            File(_profileimage!.path),
                          ),
                        ),
                ),
                Positioned(
                  bottom: 28,
                  left: 12,
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Popover(
                            mainAxisSize: MainAxisSize.min,
                            child: Column(children: [
                              InkWell(
                                onTap: () {
                                  getImage(ImageSource.camera);
                                  Navigator.pop(context);
                                },
                                child: Row(
                                  children: [
                                    const Icon(Icons.camera_alt_outlined),
                                    const SizedBox(width: 10),
                                    Text('Take a Pictue', style: style)
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Divider(),
                              const SizedBox(height: 10),
                              InkWell(
                                onTap: () {
                                  getImage(ImageSource.gallery);
                                  Navigator.pop(context);
                                },
                                child: Row(
                                  children: [
                                    const Icon(Icons.photo_library),
                                    const SizedBox(width: 10),
                                    Text('Select from gallery', style: style)
                                  ],
                                ),
                              ),
                            ]),
                          );
                        },
                      );
                    },
                    child: Container(
                      height: 25,
                      width: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: AppColor.lightGrey),
                      ),
                      child: Center(
                          child: Text(
                        'EDIT',
                        style: style.copyWith(
                            fontSize: 14, color: AppColor.lightGrey),
                      )),
                    ),
                  ),
                )
              ],
            ),
            Text(
              noImage ? 'No image selected !' : '',
              style: style.copyWith(fontSize: 12, color: AppColor.red),
            ),
            //
            Text(
              'Full Name',
              style: style.copyWith(
                  fontSize: 11,
                  color: AppColor.darkGrey,
                  fontWeight: FontWeight.bold),
            ),
            MyTextForm(
                controller: _newName,
                labelText: widget.profile.fullName,
                obscureText: false,
                validatior: (input) =>
                    input!.isEmpty ? 'Enter your password' : null),
            //
            const SizedBox(height: 4),
            Text(
              'Email',
              style: style.copyWith(
                  fontSize: 11,
                  color: AppColor.darkGrey,
                  fontWeight: FontWeight.bold),
            ),
            MyTextForm(
              controller: _newEmail,
              labelText: widget.profile.email,
              obscureText: false,
              validatior: (input) => !(input?.contains('@') ?? false)
                  ? "Put a valid Email Address"
                  : null,
            ),
            //
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 30),
              child: MainButton(
                borderColor: Colors.transparent,
                text: 'UPDATE PROFILE',
                backgroundColor: AppColor.primaryColor,
                textColor: AppColor.buttonText,
                onTap: () async {
                  if (_globalFormKey.currentState!.validate()) {
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
                      _newEmail.text,
                      widget.profile.id,
                      _profileimage!,
                      _newName.text,
                    );
                    if (res.statusCode == 200) {
                      setState(() {});
                      successButtomSheet(
                          context: context,
                          buttonText: 'BACK TO MY PROFILE',
                          title: 'Profile Updated\n  Successfully',
                          onTap: () => {
                                Navigator.pop(context),
                              });
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
