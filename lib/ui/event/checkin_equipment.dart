import 'package:flutter/material.dart';
import 'package:viicsoft_inventory_app/component/colors.dart';
import 'package:viicsoft_inventory_app/models/equipmentcheckin.dart';
import 'package:viicsoft_inventory_app/models/equipments.dart';
import 'package:viicsoft_inventory_app/services/apis/equipment_api.dart';
import 'package:viicsoft_inventory_app/services/apis/equipment_checkin_api.dart';

// ignore: must_be_immutable
class CheckInEquipmentPage extends StatefulWidget {
List<EquipmentCheckin>? equipmentCheckIn;
  CheckInEquipmentPage({Key? key, required this.equipmentCheckIn}) : super(key: key);

  @override
  State<CheckInEquipmentPage> createState() => _CheckInEquipmentPageState();
}

class _CheckInEquipmentPageState extends State<CheckInEquipmentPage> {
  //EquipmentCategory? selectedCategory;
  final EquipmentCheckInAPI _equipmentCheckinAPI = EquipmentCheckInAPI();
  final EquipmentAPI _equipmentAPI = EquipmentAPI();
  late Future<List<EquipmentElement>> _equipmentsList;
  late Future<List<EquipmentCheckin>> _equipmentCheckin;
  late Future equipmentFuture;
  int? selectedIndex;
  List selectedEquipment = [];

  @override
  void initState() {
    super.initState();
    _equipmentsList = _equipmentAPI.fetchAllEquipments();
    _equipmentCheckin = _equipmentCheckinAPI.fetchAllEquipmentCheckIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.homePageBackground,
      body:  Container(
                padding: const EdgeInsets.only(top: 60),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            size: 25,
                          ),
                        ),
                        Expanded(child: Container()),
                        Text(
                          'CheckIn Equipment',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: AppColor.homePageTitle,
                          ),
                        ),
                        const SizedBox(width: 50),
                        Expanded(child: Container()),
                      ],
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.15),
                    Expanded(
                      child: FutureBuilder<List<EquipmentElement>>(
                        future: _equipmentsList,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return SizedBox(
                              child: Container(),
                            );
                          } else if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.data == null) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else {
                              var checkIn = List<String>.generate(widget.equipmentCheckIn!.length, (i) => widget.equipmentCheckIn![i].equipmentId).toList();
                              final results = snapshot.data!;
                              var result = results.where((item) => checkIn.contains(item.id)).toList();
                              return ListView.builder(
                                itemCount: result.length,
                                itemBuilder: (_, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        right: 5, left: 5),
                                    child: Container(
                                      height: 95,
                                      padding: const EdgeInsets.only(
                                          bottom: 2, right: 3),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        elevation: 3,
                                        shadowColor: AppColor.gradientSecond,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            top: 3,
                                            left: 3,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width: 65,
                                                        height: 80,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          image:
                                                              DecorationImage(
                                                            image: NetworkImage(
                                                                result[index]
                                                                    .equipmentImage),
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(width: 15),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                result[index]
                                                                    .equipmentName,
                                                                maxLines: 1,
                                                                style: TextStyle(
                                                                    color: AppColor
                                                                        .homePageTitle,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                              const SizedBox(height: 5),
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                5),
                                                                        color: colorscondition(
                                                                            result[index].equipmentCondition)),
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(5),
                                                                    height: 17,
                                                                    child: Text(
                                                                      result[index]
                                                                          .equipmentCondition,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              8,
                                                                          color:
                                                                              AppColor.homePageContainerTextBig),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                      child:
                                                                          Container()),
                                                                  const Icon(Icons.check_circle, color: Colors.green),
                                                                                          const SizedBox(width: 5),
                                                                ],
                                                              ),
                                                              const SizedBox(height: 5),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Text(
                                                            result[index]
                                                                    .equipmentDescription!
                                                                    .isEmpty
                                                                ? 'No description'
                                                                : result[index]
                                                                    .equipmentDescription!,
                                                            maxLines: 2,
                                                            style: const TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                  
                                },
                                
                              );
                              
                            
                            }
                            
                          }
                          return Center(
                        child: CircularProgressIndicator(
                            color: AppColor.gradientFirst),
                      );
                        },
                      ),
                    )
                  ],
                ),
              )
          
          
          //}
          
    );
  }
  

  Color colorscondition(String conditionresult) {
    if (conditionresult == 'NEW') {
      return Colors.green;
    } else if (conditionresult == 'OLD') {
      return Colors.lime[900]!;
    } else if (conditionresult == 'FAIR') {
      return Colors.greenAccent;
    } else {
      return Colors.red;
    }
  }
}
