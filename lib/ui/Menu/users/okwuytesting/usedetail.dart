
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:viicsoft_inventory_app/component/colors.dart';

class UserDetailsScreen extends StatefulWidget {
  
  const UserDetailsScreen({Key? key}) : super(key: key);

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  XFile? _itemimage;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 50, left: 10, right: 30),
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    size: 25,
                    color: AppColor.gradientSecond,
                  ),
                ),
                Expanded(child: Container()),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    'User Details',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 22,
                    ),
                  ),
                ),
                Expanded(child: Container()),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 30, right: 30),
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        Column(
                          children: [
                            Container(
                              //margin: const EdgeInsets.only(right: 50, left: 50),
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                image: const DecorationImage(
                                  image: AssetImage('assets/musk.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 60),
                        Row(
                          children: [
                            Text(
                              'Name:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColor.gradientSecond
                              ),
                            ),
                            Expanded(child: Container()),
                             Text(
                              'chukwuemeka',
                              style: TextStyle(
                                color: AppColor.homePageSubtitle,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 40),
                        Row(
                          children: [
                            Text(
                              'User Name:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColor.gradientSecond
                              ),
                            ),
                            Expanded(child: Container()),
                            Text(
                              'emeka09',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColor.homePageSubtitle,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Row(
                          children: [
                            Text(
                              'Email:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColor.gradientSecond
                              ),
                            ),
                            Expanded(child: Container()),
                            Text(
                              'Emeka@gmail.com',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColor.homePageSubtitle,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Row(
                          children: [
                            Text(
                              'Role:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColor.gradientSecond,
                              ),
                            ),
                            Expanded(child: Container()),
                            Text(
                              'Admin',
                              style: TextStyle(
                                color: AppColor.homePageSubtitle,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 100),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: AppColor.gradientFirst),
                              onPressed: () {},
                              child: const Text(
                                'Edit',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}
