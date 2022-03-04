import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:provider/provider.dart';
import '../component/colors.dart';
import '../component/item_images.dart';
import 'Menu/users/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const ProfilePage(),
      appBar: AppBar(
        toolbarHeight: 80,
        iconTheme: const IconThemeData(
          color: Colors.black, 
        ),
        elevation: 0,
        backgroundColor: AppColor.homePageBackground,
        title: Text(
          'Dashboard',
          style: TextStyle(
            fontSize: 30,
            color: AppColor.homePageTitle,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      backgroundColor: AppColor.homePageBackground,
      body: Container(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 230,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColor.gradientFirst,
                      AppColor.gradientSecond.withOpacity(0.8)
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40),
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(2, 5),
                      blurRadius: 4,
                      color: AppColor.gradientSecond.withOpacity(0.2),
                    )
                  ]),
              child: Container(
                padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Inventory Summary',
                      style: TextStyle(
                          fontSize: 25,
                          color: AppColor.homePageContainerTextBig),
                    ),
                    const SizedBox(height: 25),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.all(5),
                          height: 25,
                          child: const Center(
                            child: Text("",
                              //'${Provider.of<InventoryData>(context).menu.length}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Total Equipments Recorded',
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColor.homePageContainerTextBig),
                        ),
                      ],
                    ),
                    const SizedBox(height: 23),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        equipmentCondition(qauntity: '10', condition: 'Fair'),
                        const SizedBox(
                            height: 50,
                            child: VerticalDivider(
                                color: Colors.white, thickness: 2)),
                        equipmentCondition(qauntity: '10', condition: 'Bad'),
                        const SizedBox(
                            height: 50,
                            child: VerticalDivider(
                                color: Colors.white, thickness: 2)),
                        equipmentCondition(
                            qauntity: '120000', condition: 'Good'),
                        
                      ],
                    ),
                    const SizedBox(height: 23),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.all(5),
                          height: 25,
                          child: const Center(
                            child: Text("",
                              //'${Provider.of<InventoryData>(context).menu.length}',
                              style:TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Equipments Available in Stock',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColor.homePageContainerTextBig,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Text(
                  'Activities',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: AppColor.homePageTitle,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              child: Column(
                children: [
                  homeactivities(context,
                      qauntity: '20',
                      title: 'Pending Return',
                      icon: Icons.pending, onpressed: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => PendingReturnPage()));
                  }),
                  const SizedBox(height: 15),
                  homeactivities(context,
                      qauntity: '20',
                      title: 'Collected',
                      icon: Icons.collections, onpressed: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => CollectionPage()));
                  }),
                  const SizedBox(height: 15),
                  homeactivities(context,
                      qauntity: '200',
                      title: 'Not Collected',
                      icon: Icons.not_interested, onpressed: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => NotCollectedPage()));
                  }),
                  const SizedBox(height: 15),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  equipmentCondition({String? qauntity, String? condition}) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(5),
          height: 25,
          child: Center(
            child: Text(
              qauntity!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.black,
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          condition!,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppColor.homePageContainerTextBig),
        ),
      ],
    );
  }

  homeactivities(BuildContext context,
      {String? qauntity,
      String? title,
      Function()? onpressed,
      IconData? icon}) {
    return SizedBox(
      height: 70,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 70,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [
                    AppColor.gradientSecond,
                    AppColor.gradientFirst,
                    Colors.white70,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4,
                    offset: const Offset(1, 1.5),
                    color: AppColor.gradientSecond.withOpacity(0.3),
                  )
                ]),
            child: Padding(
              padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(icon, size: 40, color: Colors.white),
                      Expanded(child: Container()),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            padding: const EdgeInsets.all(5),
                            height: 25,
                            child: Center(
                              child: Text(
                                qauntity!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            title!,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColor.homePageContainerTextBig,
                            ),
                          ),
                        ],
                      ),
                      Expanded(child: Container()),
                      IconButton(
                          onPressed: onpressed,
                          icon: const Icon(Icons.arrow_forward_ios, size: 25)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  final picker = ImagePicker();
  XFile? menuimage;

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    setState(() {
      menuimage = pickedFile;
    });
  }

  bottmsheet(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ItemImages(
              imageProvide: menuimage != null
                  ? FileImage(File(menuimage!.path))
                  : const AssetImage('assets/ex2.png') as ImageProvider,
              onpressedCamera: () {
                getImage(ImageSource.camera);
                Navigator.pop(context);
              },
              onpressedGallery: () {
                getImage(ImageSource.gallery);
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'menu name',
              ),
            ),
            const SizedBox(height: 50),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(primary: AppColor.gradientFirst),
                  onPressed: () {},
                  child: const Text(
                    'Create Menu',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
