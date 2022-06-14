import 'package:flutter/material.dart';
import 'package:viicsoft_inventory_app/component/button.dart';
import 'package:viicsoft_inventory_app/component/colors.dart';
import 'package:viicsoft_inventory_app/component/mytextform.dart';
import 'package:viicsoft_inventory_app/component/style.dart';
import 'package:viicsoft_inventory_app/component/success_button_sheet.dart';
import 'package:viicsoft_inventory_app/models/profile.dart';
import 'package:viicsoft_inventory_app/services/apis/user_api.dart';

class ConfirmPassswordSheet extends StatefulWidget {
  final ProfileUser profile;
  const ConfirmPassswordSheet({Key? key, required this.profile})
      : super(key: key);

  @override
  State<ConfirmPassswordSheet> createState() => _ConfirmPassswordSheetState();
}

class _ConfirmPassswordSheetState extends State<ConfirmPassswordSheet> {
  final GlobalKey<FormState> _globalFormKey = GlobalKey<FormState>();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmPasswordField = TextEditingController();

  @override
  void dispose() {
    _newPassword.dispose();
    _confirmPasswordField.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _globalFormKey,
      child: Padding(
        padding: EdgeInsets.only(
            right: 20,
            left: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: FractionallySizedBox(
                widthFactor: 0.25,
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 12.0,
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
            Text(
              'New password',
              style: style.copyWith(
                  fontSize: 11,
                  color: AppColor.darkGrey,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            MyTextForm(
              controller: _newPassword,
              obscureText: false,
              labelText: 'Enter new password',
              validatior: (value) {
                bool passValid = RegExp(
                        "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z])(?=.*?[!@#\$&*~]).*")
                    .hasMatch(value!);
                if (value.isEmpty || !passValid) {
                  return 'Please enter Valid Pasword*';
                }
                return null;
              },
            ),
            const SizedBox(height: 8),
            //
            Text(
              'Confirm password',
              style: style.copyWith(
                  fontSize: 11,
                  color: AppColor.darkGrey,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            MyTextForm(
              controller: _confirmPasswordField,
              obscureText: false,
              labelText: 'Confirm password',
              validatior: (value) {
                if (_newPassword.text != _confirmPasswordField.text) {
                  return 'The passwords do not match, pls verify*';
                }
                return null;
              },
            ),

            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 30),
              child: MainButton(
                borderColor: Colors.transparent,
                text: 'DONE',
                backgroundColor: AppColor.primaryColor,
                textColor: AppColor.buttonText,
                onTap: () async {
                  if (_globalFormKey.currentState!.validate()) {
                    var res = await UserAPI().updateUserPassword(
                      widget.profile.email,
                      _newPassword.text,
                      widget.profile.fullName,
                      widget.profile.id,
                    );

                    if (res.statusCode == 200) {
                      successButtomSheet(
                        context: context,
                        buttonText: 'BACK TO MY PROFILE',
                        title: 'Password Changed\n    Successfully',
                        onTap: () => Navigator.pop(context),
                      );
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
