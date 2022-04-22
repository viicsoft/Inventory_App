import 'package:flutter/material.dart';
import 'package:viicsoft_inventory_app/component/colors.dart';
import 'package:viicsoft_inventory_app/models/eventequipmentcheckout.dart';
import 'package:viicsoft_inventory_app/models/events.dart';
import 'package:viicsoft_inventory_app/services/apis/equipment_checkout_api.dart';
import 'package:viicsoft_inventory_app/services/apis/event_api.dart';

// ignore: must_be_immutable
class CheckOutEquipmentPage extends StatefulWidget {
  List<EventsEquipmentCheckout>? equipmentCheckout;
  CheckOutEquipmentPage({Key? key, required this.equipmentCheckout})
      : super(key: key);

  @override
  State<CheckOutEquipmentPage> createState() => _CheckOutEquipmentPageState();
}

class _CheckOutEquipmentPageState extends State<CheckOutEquipmentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      body: Container(
        padding: const EdgeInsets.only(top: 60),
        child: FutureBuilder<List<Event>>(
          future: EventAPI().fetchAllEvents(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColor.gradientFirst,
                  ),
                );
              } else {
                var event = snapshot.data!;
                return Column(
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
                        const Text(
                          'CheckOut Equipment',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.15),
                        Expanded(child: Container()),
                      ],
                    ),
                    Expanded(
                      child: FutureBuilder<List<EventsEquipmentCheckout>>(
                        future:
                            EquipmentCheckOutAPI().fetchAllEquipmentCheckOut(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return SizedBox(
                              child: Container(),
                            );
                          } else if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.data == null) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: AppColor.gradientFirst,
                                ),
                              );
                            } else {
                              var checkoutEquipments = snapshot.data!;
                              var eventId = List<String>.generate(
                                      checkoutEquipments.length,
                                      (i) => checkoutEquipments[i].eventId)
                                  .toList();
                              var events = event
                                  .where(
                                      (element) => eventId.contains(element.id))
                                  .toList();

                              return ListView.builder(
                                itemCount: events.length,
                                itemBuilder: (_, int index) {
                                  var result = checkoutEquipments
                                      .where((e) =>
                                          events[index].id.contains(e.eventId))
                                      .toList();
                                  return Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Card(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15.0),
                                        ),
                                      ),
                                      margin: const EdgeInsets.only(bottom: 5),
                                      elevation: 2,
                                      shadowColor: AppColor.gradientSecond,
                                      color: Colors.grey[50],
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  width: 70,
                                                  height: 60,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          events[index]
                                                              .eventImage),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 12),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Event:',
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: AppColor
                                                                    .homePageTitle,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          const SizedBox(
                                                              width: 10),
                                                          Text(
                                                            events[index]
                                                                .eventName,
                                                            overflow:
                                                                TextOverflow
                                                                    .clip,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Location:',
                                                          style: TextStyle(
                                                            color: AppColor
                                                                .homePageTitle,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 10),
                                                        Text(
                                                          events[index]
                                                              .eventLocation,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 5),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Expanded(child: Container()),
                                                Column(
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Text(
                                                          'Date:',
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              decoration:
                                                                  TextDecoration
                                                                      .underline,
                                                              color: AppColor
                                                                  .homePageTitle,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        const SizedBox(
                                                            height: 10),
                                                        Text(
                                                          '${checkoutEquipments[index].equipmentOutDatetime.day}-${checkoutEquipments[index].equipmentOutDatetime.month}-${checkoutEquipments[index].equipmentOutDatetime.year}',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 5),
                                                  ],
                                                )
                                              ],
                                            ),
                                            Divider(
                                              color: AppColor.homePageSubtitle,
                                              thickness: 0.5,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Equipment',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: AppColor
                                                          .homePageTitle,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                //const SizedBox(height: 5),
                                                SizedBox(
                                                  height: 180,
                                                  child: ListView.builder(
                                                    itemCount: result.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Container(
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 2,
                                                                right: 3),
                                                        child: Card(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          elevation: 3,
                                                          shadowColor: AppColor
                                                              .gradientSecond,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 3,
                                                                    left: 3),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      1.8,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(3),
                                                                    color: result[index]
                                                                                .isReturned ==
                                                                            '1'
                                                                        ? Colors
                                                                            .green
                                                                        : AppColor
                                                                            .homePageSubtitle,
                                                                  ),
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(2),
                                                                  height: 11,
                                                                  child: Center(
                                                                    child: Text(
                                                                      result[index]
                                                                          .equipment
                                                                          .category
                                                                          .name,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              6,
                                                                          color:
                                                                              AppColor.homePageContainerTextBig),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Container(
                                                                      width: 55,
                                                                      height:
                                                                          60,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                        image:
                                                                            DecorationImage(
                                                                          image: NetworkImage(result[index]
                                                                              .equipment
                                                                              .equipmentImage),
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                        width:
                                                                            15),
                                                                    Expanded(
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          SizedBox(
                                                                            width:
                                                                                MediaQuery.of(context).size.width,
                                                                            child:
                                                                                Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Row(
                                                                                  children: [
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.all(8.0),
                                                                                      child: Text(
                                                                                        result[index].equipment.equipmentName,
                                                                                        maxLines: 1,
                                                                                        style: TextStyle(color: AppColor.homePageTitle, fontSize: 12, fontWeight: FontWeight.w500),
                                                                                      ),
                                                                                    ),
                                                                                    Expanded(flex: 2, child: Container()),
                                                                                    Container(
                                                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: colorscondition(result[index].equipment.equipmentCondition)),
                                                                                      padding: const EdgeInsets.all(5),
                                                                                      height: 16,
                                                                                      child: Text(
                                                                                        result[index].equipment.equipmentCondition,
                                                                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 6, color: AppColor.homePageContainerTextBig),
                                                                                      ),
                                                                                    ),
                                                                                    Expanded(child: Container()),
                                                                                    IconButton(
                                                                                        onPressed: () async => await _confirmDialog(context, result[index].id, result[index].equipment.equipmentName),
                                                                                        icon: const Icon(
                                                                                          Icons.delete,
                                                                                          color: Colors.red,
                                                                                          size: 20,
                                                                                        )),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                              height: 5),
                                                                          SizedBox(
                                                                            width:
                                                                                MediaQuery.of(context).size.width,
                                                                            child:
                                                                                Text(
                                                                              'CHECKOUT DATE:   ${result[index].equipmentOutDatetime}',
                                                                              maxLines: 2,
                                                                              style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w500),
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
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
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
                );
              }
            }
            return Center(
              child: CircularProgressIndicator(color: AppColor.gradientFirst),
            );
          },
        ),
      ),
    );
  }

  Future _confirmDialog(
      BuildContext context, String equipmentId, String equipmentName) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Warning!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure want delete Equipment    $equipmentName ?'),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: AppColor.gradientFirst),
              child: const Text('Yes'),
              onPressed: () async {
                var res = await EquipmentCheckOutAPI()
                    .deleteEventEquipmentCheckout(equipmentId);
                if (res.statusCode == 200) {
                  setState(() {});
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.green,
                      content: Text(
                          "$equipmentName Equipment successfully deleted")));
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(" Operation failed ! Something went wrong"),
                    ),
                  );
                }
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: AppColor.gradientFirst),
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
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
