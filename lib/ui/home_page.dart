import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:viicsoft_inventory_app/models/avialable_equipment.dart';
import 'package:viicsoft_inventory_app/models/equipment_not_avialable.dart';
import 'package:viicsoft_inventory_app/models/equipmentcheckin.dart';
import 'package:viicsoft_inventory_app/models/equipments.dart';
import 'package:viicsoft_inventory_app/models/eventequipmentcheckout.dart';
import 'package:viicsoft_inventory_app/services/apis/equipment_api.dart';
import 'package:viicsoft_inventory_app/services/apis/equipment_checkin_api.dart';
import 'package:viicsoft_inventory_app/services/apis/equipment_checkout_api.dart';
import 'package:viicsoft_inventory_app/ui/Menu/user_profile/profile_page.dart';
import 'package:viicsoft_inventory_app/ui/event/checkin_equipment.dart';
import 'package:viicsoft_inventory_app/ui/event/checkout_equipment.dart';
import 'package:viicsoft_inventory_app/ui/store/bad_equipment.dart';
import 'package:viicsoft_inventory_app/ui/store/equipment_not_avialable.dart';
import 'package:viicsoft_inventory_app/ui/store/fair_equipment.dart';
import 'package:viicsoft_inventory_app/ui/store/good_equipment.dart';
import '../component/colors.dart';
import '../component/item_images.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final EquipmentAPI _equipmentApi = EquipmentAPI();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {});
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    var screensize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        drawer: const ProfilePage(),
        appBar: AppBar(
          toolbarHeight: screensize.height * 0.082,
          iconTheme: const IconThemeData(color: Colors.black, size: 40),
          elevation: 0,
          backgroundColor: AppColor.homePageBackground,
          title: Text(
            'Dashboard',
            style: TextStyle(
              fontSize: 35,
              color: AppColor.homePageTitle,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        backgroundColor: AppColor.homePageBackground,
        body: FutureBuilder<List<EquipmentElement>>(
          future: EquipmentAPI().fetchAllEquipments(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: CircularProgressIndicator(color: AppColor.gradientFirst),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              final result = snapshot.data!;
              var fairResult = result
                  .where((item) => item.equipmentCondition == 'FAIR')
                  .toList();
              var badResult = result
                  .where((item) => item.equipmentCondition == 'BAD')
                  .toList();
              var newResult = result
                  .where((item) => item.equipmentCondition == 'NEW')
                  .toList();
              var oldResult = result
                  .where((item) => item.equipmentCondition == 'OLD')
                  .toList();
              var goodResult = newResult + oldResult;
              return SmartRefresher(
                enablePullDown: true,
                controller: _refreshController,
                onRefresh: _onRefresh,
                child: ListView(
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: screensize.height * 0.35,
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
                                    color: AppColor.gradientSecond
                                        .withOpacity(0.2),
                                  )
                                ]),
                            child: Container(
                              padding: const EdgeInsets.only(
                                  top: 15, left: 15, right: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Inventory Summary',
                                        style: TextStyle(
                                            fontSize: 30,
                                            color: AppColor
                                                .homePageContainerTextBig),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: screensize.height * 0.03,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                        ),
                                        padding: const EdgeInsets.all(5),
                                        height: 30,
                                        child: Center(
                                          child: Text(
                                            result.length.toString(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                      Text(
                                        'Total Equipments Recorded',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: AppColor
                                                .homePageContainerTextBig),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: screensize.width / 15),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                        onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    const FairEquipmentPage())),
                                        child: equipmentCondition(
                                            qauntity: fairResult.isEmpty
                                                ? '0'
                                                : '${fairResult.length}',
                                            condition: 'Fair'),
                                      ),
                                      const SizedBox(
                                          height: 50,
                                          child: VerticalDivider(
                                              color: Colors.white,
                                              thickness: 2)),
                                      InkWell(
                                        onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    const BadEquipmentPage())),
                                        child: equipmentCondition(
                                            qauntity: badResult.isEmpty
                                                ? '0'
                                                : '${badResult.length}',
                                            condition: 'Bad'),
                                      ),
                                      const SizedBox(
                                          height: 50,
                                          child: VerticalDivider(
                                              color: Colors.white,
                                              thickness: 2)),
                                      InkWell(
                                        onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    const GoodEquipmentPage())),
                                        child: equipmentCondition(
                                            qauntity: goodResult.isEmpty
                                                ? '0'
                                                : '${goodResult.length}',
                                            condition: 'Good'),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.width /
                                              16),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                        ),
                                        padding: const EdgeInsets.all(5),
                                        height: 30,
                                        child: Center(
                                          child: FutureBuilder<
                                                  List<EquipmentsAvailable>>(
                                              future: _equipmentApi
                                                  .fetchAvialableEquipments(),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.done) {
                                                  if (snapshot.hasData) {
                                                    var aviableEquipment =
                                                        snapshot.data!;
                                                    return Text(
                                                      aviableEquipment.length
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16,
                                                          color: Colors.black),
                                                    );
                                                  }
                                                }
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                          color: AppColor
                                                              .gradientFirst),
                                                );
                                              }),
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                      Text(
                                        'Equipments Available ',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color:
                                              AppColor.homePageContainerTextBig,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.width / 15),
                          Row(
                            children: [
                              Text(
                                'Activities',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.homePageTitle,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.width / 15),
                          SizedBox(
                            child: Column(
                              children: [
                                FutureBuilder<
                                    List<EquipmentsNotAvailableElement>>(
                                  future: _equipmentApi
                                      .fetchEquipmentsNotAvialable(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return homeactivities(
                                        context,
                                        qauntity:
                                            snapshot.data!.length.toString(),
                                        title: 'Equipment Not Avialable',
                                        icon: Icons.pending,
                                        onpressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const EquipmentNotAvialablePage(),
                                            ),
                                          );
                                        },
                                      );
                                    }
                                    return Center(
                                      child: CircularProgressIndicator(
                                          color: AppColor.gradientFirst),
                                    );
                                  },
                                ),
                                SizedBox(
                                    height:
                                        MediaQuery.of(context).size.width / 16),
                                FutureBuilder<List<EventsEquipmentCheckout>>(
                                  future: EquipmentCheckOutAPI()
                                      .fetchAllEquipmentCheckOut(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return homeactivities(
                                        context,
                                        qauntity:
                                            snapshot.data!.length.toString(),
                                        title: 'CheckOut Equipment',
                                        icon: Icons.collections,
                                        onpressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CheckOutEquipmentPage(
                                                equipmentCheckout:
                                                    snapshot.data,
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }
                                    return Center(
                                      child: CircularProgressIndicator(
                                          color: AppColor.gradientFirst),
                                    );
                                  },
                                ),
                                SizedBox(
                                    height:
                                        MediaQuery.of(context).size.width / 16),
                                FutureBuilder<List<EquipmentsCheckin>>(
                                  future: EquipmentCheckInAPI()
                                      .fetchAllEquipmentCheckIn(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return homeactivities(
                                        context,
                                        qauntity:
                                            snapshot.data!.length.toString(),
                                        title: 'CheckIn Equipment',
                                        icon: Icons.not_interested,
                                        onpressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const CheckInEquipmentPage(),
                                            ),
                                          );
                                        },
                                      );
                                    }
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: AppColor.gradientFirst,
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.width / 16,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(color: AppColor.gradientFirst),
              );
            }
          },
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
          height: 30,
          child: Center(
            child: Text(
              qauntity!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
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
            fontSize: 18,
            color: AppColor.homePageContainerTextBig,
          ),
        ),
      ],
    );
  }

  Widget homeactivities(BuildContext context,
      {String? qauntity,
      String? title,
      Function()? onpressed,
      IconData? icon}) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.08,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width / 5.5,
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
              padding: const EdgeInsets.only(top: 5, right: 10, left: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      //Icon(icon, size: 30, color: Colors.white),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.all(5),
                        height: 30,
                        child: Center(
                          child: Text(
                            qauntity!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Text(
                        title!,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColor.homePageContainerTextBig,
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      IconButton(
                        onPressed: onpressed,
                        icon: const Icon(Icons.arrow_forward_ios, size: 25),
                      ),
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
