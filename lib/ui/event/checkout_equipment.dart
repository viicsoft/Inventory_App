import 'package:flutter/material.dart';
import 'package:viicsoft_inventory_app/component/colors.dart';
import 'package:viicsoft_inventory_app/models/equipments.dart';
import 'package:viicsoft_inventory_app/models/eventequipmentcheckout.dart';
import 'package:viicsoft_inventory_app/models/events.dart';
import 'package:viicsoft_inventory_app/services/apis/equipment_api.dart';
import 'package:viicsoft_inventory_app/services/apis/event_api.dart';

// ignore: must_be_immutable
class CheckOutEquipmentPage extends StatefulWidget {
  List<EquipmentCheckout>? equipmentCheckout;
  CheckOutEquipmentPage({Key? key, required this.equipmentCheckout})
      : super(key: key);

  @override
  State<CheckOutEquipmentPage> createState() => _CheckOutEquipmentPageState();
}

class _CheckOutEquipmentPageState extends State<CheckOutEquipmentPage> {
  final EquipmentAPI _equipmentAPI = EquipmentAPI();
  late Future<List<EquipmentElement>> _equipmentsList;

  @override
  void initState() {
    super.initState();
    _equipmentsList = _equipmentAPI.fetchAllEquipments();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.gradientFirst,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                                  colors: [
                                    AppColor.gradientFirst,
                                    AppColor.gradientSecond.withOpacity(0.8)
                                  ],
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.centerRight,
                                ),
          ),
          padding: const EdgeInsets.only(top: 60),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon:  Icon(
                      Icons.arrow_back_ios_new,
                      size: 25,
                      color: AppColor.homePageContainerTextBig,
                    ),
                  ),
                  Expanded(child: Container()),
                  Text(
                    'CheckOut Equipment',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: AppColor.homePageContainerTextBig,
                    ),
                  ),
                  const SizedBox(width: 50),
                  Expanded(child: Container()),
                ],
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.15),
              Expanded(
                child: FutureBuilder<List<Event>>(
                  future: EventAPI().fetchAllEvents(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return SizedBox(
                        child: Container(),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      if (snapshot.data == null) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        var checkOutEquipment = List<String>.generate(widget.equipmentCheckout!.length,(i) => widget.equipmentCheckout![i].equipmentId) .toList();
                        var checkoutdate = List<DateTime>.generate(widget.equipmentCheckout!.length,(i) => widget.equipmentCheckout![i].equipmentOutDatetime).toList();
                        var eventid = List<String>.generate(widget.equipmentCheckout!.length,(i) => widget.equipmentCheckout![i].eventId).toList();
                        final eventResults = snapshot.data!;
                        var eventresult = eventResults.where((item) => eventid.contains(item.id)).toList();
                        return ListView.builder(
                          itemCount: eventresult.length,
                          itemBuilder: (_, int index) {
                            return Card(
                              margin: const EdgeInsets.only(bottom: 10),
                              elevation: 10,
                              shadowColor: AppColor.gradientFirst,
                              color: Colors.grey[200],
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  eventresult[index].eventImage),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Location:',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              eventresult[index].eventLocation,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(height: 5),
                                          ],
                                        ),
                                        Expanded(child: Container()),
                                        //Icon(Icons.cancel, color: Colors.red),
                                        Column(
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                  'Checkout Date:',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      decoration: TextDecoration
                                                          .underline,
                                                      color: AppColor
                                                          .homePageTitle,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                const SizedBox(height: 10),
                                                Text(
                                                  '${checkoutdate[index]}',
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 5),
                                            // const Icon(Icons.check_box,
                                            //     color: Colors.green),
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Text(
                                          'Event:',
                                          style: TextStyle(
                                              fontSize: 16,
                                              decoration:
                                                  TextDecoration.underline,
                                              color: AppColor.homePageTitle,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          eventresult[index].eventName,
                                          overflow: TextOverflow.clip,
                                          //maxLines: 1,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Divider(
                                      color: AppColor.gradientFirst,
                                      thickness: 0.5,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Equipment',
                                          style: TextStyle(
                                              fontSize: 16,
                                              decoration:
                                                  TextDecoration.underline,
                                              color: AppColor.homePageTitle,
                                              fontWeight: FontWeight.w600),
                                        ),
                                       const SizedBox(height: 10),
                                        SizedBox(
                                          height: 250,
                                          child: FutureBuilder<
                                                  List<EquipmentElement>>(
                                              future: _equipmentsList,
                                              builder: (context, snapshot) {
                                                if (snapshot
                                                        .connectionState ==
                                                    ConnectionState.done) {
                                                  if (snapshot.hasData) {
                                                    var equipmentResults = snapshot.data!; //eventresult
                                                     var checkoutequip = widget.equipmentCheckout!.where((item) => eventResults[index].id.contains(item.eventId)).toList();
                                                      //var results = widget.equipmentCheckout!.where((e) => eventResults.contains(e.eventId)).toList();                          
                                                  var    result = equipmentResults.where((e) => widget.equipmentCheckout![index].equipmentId.contains(e.id)).toList();

                                                    return ListView.builder(
                                                        itemCount:
                                                            result.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return  Container(
                                                            width: MediaQuery.of(context).size.width,
                                                              height: 95,
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          2,
                                                                      right:
                                                                          3),
                                                              child: Card(
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          10),
                                                                ),
                                                                elevation: 3,
                                                                shadowColor:
                                                                    AppColor
                                                                        .gradientSecond,
                                                                child:
                                                                    Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                    top: 3,
                                                                    left: 3,
                                                                  ),
                                                                  child:
                                                                      Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          Column(
                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                            children: [
                                                                              Container(
                                                                                width: 65,
                                                                                height: 80,
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(10),
                                                                                  image: DecorationImage(
                                                                                    image: NetworkImage(result[index].equipmentImage),
                                                                                    fit: BoxFit.cover,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          const SizedBox(width: 15),
                                                                          Expanded(
                                                                            child: Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                SizedBox(
                                                                                  width: MediaQuery.of(context).size.width,
                                                                                  child: Column(
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Text(
                                                                                        result[index].equipmentName,
                                                                                        maxLines: 1,
                                                                                        style: TextStyle(color: AppColor.homePageTitle, fontSize: 14, fontWeight: FontWeight.w500),
                                                                                      ),
                                                                                      const SizedBox(height: 5),
                                                                                      Row(
                                                                                        children: [
                                                                                          Container(
                                                                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: colorscondition(result[index].equipmentCondition)),
                                                                                            padding: const EdgeInsets.all(5),
                                                                                            height: 17,
                                                                                            child: Text(
                                                                                              result[index].equipmentCondition,
                                                                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8, color: AppColor.homePageContainerTextBig),
                                                                                            ),
                                                                                          ),
                                                                                           Expanded(child: Container()),
                                                                                          const Icon(Icons.cancel, color: Colors.red),
                                                                                          const SizedBox(width: 5),
                                                                                        ],
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                const SizedBox(height: 5),
                                                                                SizedBox(
                                                                                  width: MediaQuery.of(context).size.width,
                                                                                  child: Text(
                                                                                    result[index].equipmentDescription!.isEmpty ? 'No description' : result[index].equipmentDescription!,
                                                                                    maxLines: 2,
                                                                                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
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
                                                            
                                                          );
                                                        });
                                                  }
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                            color: AppColor
                                                                .gradientFirst),
                                                  );
                                                }
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                          color: AppColor
                                                              .gradientFirst),
                                                );
                                              }),
                                        )
                                        // Column(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.start,
                                        //   crossAxisAlignment:
                                        //       CrossAxisAlignment.start,
                                        //   children: [
                                        //     //for (var i = 0; i < items.length; ++i)
                                        //     ListTile(
                                        //       horizontalTitleGap: 10,
                                        //       minLeadingWidth: 30,
                                        //       contentPadding:
                                        //           const EdgeInsets.symmetric(
                                        //               horizontal: 20),
                                        //       title:
                                        //           Text(result[index].eventName),
                                        //       leading: Container(
                                        //         width: 25,
                                        //         height: 25,
                                        //         decoration: BoxDecoration(
                                        //           borderRadius:
                                        //               BorderRadius.circular(10),
                                        //           image: const DecorationImage(
                                        //             image: AssetImage(
                                        //                 'assets/squat1.jpg'),
                                        //             fit: BoxFit.cover,
                                        //           ),
                                        //         ),
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                        //}
                        //}
                        //);
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
        // }
        // );

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
