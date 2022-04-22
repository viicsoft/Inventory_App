import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:viicsoft_inventory_app/component/colors.dart';
import 'package:viicsoft_inventory_app/models/eventequipmentchecklist.dart';
import 'package:viicsoft_inventory_app/models/eventequipmentcheckout.dart';
import 'package:viicsoft_inventory_app/models/events.dart';
import 'package:viicsoft_inventory_app/services/apis/equipment_checkin_api.dart';
import 'package:viicsoft_inventory_app/services/apis/equipment_checklist_api.dart';
import 'package:viicsoft_inventory_app/services/apis/equipment_checkout_api.dart';
import 'package:viicsoft_inventory_app/ui/event/add_eventequipmentpage.dart';
import 'package:viicsoft_inventory_app/ui/event/update_event.dart';

class EventsDetailPage extends StatefulWidget {
  final Event eventDetail;
  const EventsDetailPage({Key? key, required this.eventDetail})
      : super(key: key);

  @override
  State<EventsDetailPage> createState() => _EventsDetailPageState();
}

class _EventsDetailPageState extends State<EventsDetailPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String _scanInBarcode = '';
  String _scanOutBarcode = '';

  final EquipmentCheckInAPI _equipmentCheckInAPI = EquipmentCheckInAPI();
  final EquipmentCheckOutAPI _equipmentCheckOutAPI = EquipmentCheckOutAPI();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List scanedEquipment = [];

  // @override
  // void initState() {
  //   //_equipment = _equipmentApi.fetchAllEquipments();
  //   _eventEquipment = _eventEquipmentAPI.fetchAllEquipmentCheckList();
  //   super.initState();
  // }

  Future scanInBarcode() async {
    String barcodescanIn;
    try {
      barcodescanIn = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
    } on PlatformException {
      barcodescanIn = 'Failed to get platform version.';
    }

    if (!mounted) return;
    setState(() {
      _scanInBarcode = barcodescanIn;
    });
  }

  Future scanOutBarcode() async {
    String barcodescanOut;
    try {
      barcodescanOut = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
    } on PlatformException {
      barcodescanOut = 'Failed to get platform version.';
    }

    if (!mounted) return;
    setState(() {
      _scanOutBarcode = barcodescanOut;
    });
  }

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {});
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    //var startingdate = DateTime.parse("${widget.eventDetail.checkOutDate}");
    //var endingdate = DateTime.parse("${widget.eventDetail.checkInDate}");
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: AppColor.homePageBackground,
        body: SmartRefresher(
          enablePullDown: true,
          //header: const WaterDropHeader(),
          controller: _refreshController,
          onRefresh: _onRefresh,
          child: FutureBuilder<List<EventEquipmentChecklist>>(
              future: EventEquipmentChecklistAPI().fetchAllEquipmentCheckList(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data == null) {
                    return Center(
                      child: CircularProgressIndicator(
                          color: AppColor.gradientFirst),
                    );
                  } else {
                    var results = snapshot.data!;
                    var result = results
                        .where((e) => widget.eventDetail.id.contains(e.eventId))
                        .toList();
                    return Container(
                      padding:
                          const EdgeInsets.only(top: 40, right: 10, left: 10),
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
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: AppColor.gradientFirst),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => UpdateEventPage(
                                        eventDetail: widget.eventDetail,
                                      ),
                                    ),
                                  );
                                },
                                child: const Text('Edit'),
                              ),
                              const SizedBox(width: 10),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: AppColor.homePageSubtitle),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => AddEventEquipmentPage(
                                                eventId: widget.eventDetail.id,
                                                eventName: widget
                                                    .eventDetail.eventName,
                                              )));

                                  scaffoldKey.currentState!;
                                },
                                child: const Text('Add Equipment'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 250,
                            decoration: BoxDecoration(
                                color: AppColor.homePageContainerTextBig,
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(80),
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(70),
                                  bottomRight: Radius.circular(10),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(2, 5),
                                    blurRadius: 4,
                                    color: AppColor.gradientSecond
                                        .withOpacity(0.2),
                                  )
                                ]),
                            child: Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 1,
                                  height: 125,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(80),
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          widget.eventDetail.eventImage),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 30, right: 10, bottom: 10),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Event Name:   ${widget.eventDetail.eventName}',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: AppColor.homePageSubtitle),
                                      ),
                                      const SizedBox(height: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Event Type:  ${widget.eventDetail.eventType}',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: AppColor.homePageSubtitle,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            'Location:  ${widget.eventDetail.eventLocation}',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: AppColor.homePageSubtitle,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Center(
                                                child: Text(
                                                  'Date:',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                    color: AppColor
                                                        .homePageSubtitle,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Text(
                                                '${widget.eventDetail.checkOutDate.day}-${widget.eventDetail.checkOutDate.month}-${widget.eventDetail.checkOutDate.year}',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color:
                                                        AppColor.gradientFirst,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              const SizedBox(width: 10),
                                              const Text(
                                                'To',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(width: 10),
                                              Text(
                                                '${widget.eventDetail.checkInDate.day}-${widget.eventDetail.checkInDate.month}-${widget.eventDetail.checkInDate.year}',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color:
                                                        AppColor.gradientFirst,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Equipments  Needed',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.homePageIcons,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Expanded(
                              child: ListView.builder(
                            itemCount: result.length,
                            itemBuilder: (_, int index) {
                              return Container(
                                  height: 99,
                                  padding: const EdgeInsets.only(
                                      bottom: 3, right: 3),
                                  child:
                                      FutureBuilder<
                                              List<EventsEquipmentCheckout>>(
                                          future: EquipmentCheckOutAPI()
                                              .fetchAllEquipmentCheckOut(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.done) {
                                              var checkoutequipment =
                                                  snapshot.data;
                                              var checkOutequipmentid =
                                                  List<String>.generate(
                                                      checkoutequipment!.length,
                                                      (i) =>
                                                          checkoutequipment[i]
                                                              .equipmentId);
                                              return Card(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                elevation: 3,
                                                shadowColor:
                                                    AppColor.gradientSecond,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 3,
                                                    left: 3,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Column(
                                                                children: [
                                                                  Container(
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(
                                                                              3),
                                                                          color: AppColor
                                                                              .homePageSubtitle),
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              2),
                                                                      height:
                                                                          14,
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          result[index]
                                                                              .equipment
                                                                              .category
                                                                              .name,
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 8,
                                                                              color: AppColor.homePageContainerTextBig),
                                                                        ),
                                                                      )),
                                                                  const SizedBox(
                                                                      height:
                                                                          3),
                                                                  Container(
                                                                    width: 60,
                                                                    height: 65,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
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
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                              width: 15),
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
                                                                            .equipment
                                                                            .equipmentName,
                                                                        maxLines:
                                                                            1,
                                                                        style: TextStyle(
                                                                            color: AppColor
                                                                                .homePageTitle,
                                                                            fontSize:
                                                                                13,
                                                                            fontWeight:
                                                                                FontWeight.w600),
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Container(
                                                                            decoration:
                                                                                BoxDecoration(borderRadius: BorderRadius.circular(5), color: colorscondition(result[index].equipment.equipmentCondition)),
                                                                            padding:
                                                                                const EdgeInsets.all(5),
                                                                            height:
                                                                                17,
                                                                            child:
                                                                                Text(
                                                                              result[index].equipment.equipmentCondition,
                                                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8, color: AppColor.homePageContainerTextBig),
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                              child: Container()),
                                                                          InkWell(
                                                                            onTap:
                                                                                () async {
                                                                              if (checkOutequipmentid.contains(result[index].equipmentId)) {
                                                                                await _checkIn(result[index].equipment.equipmentBarcode, result[index].equipmentId);
                                                                                setState(() {});
                                                                              } else {
                                                                                _checkOut(result[index].equipment.equipmentBarcode, result[index].equipmentId, widget.eventDetail.id);
                                                                                setState(() {});
                                                                              }
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(5),
                                                                                color: checkOutequipmentid.contains(result[index].equipmentId) ? Colors.red : Colors.green,
                                                                                //checkcolors(checkId: result[index].eventId, eventId: checkoutequipment[index].eventId)
                                                                              ),
                                                                              padding: const EdgeInsets.all(5),
                                                                              height: 18,
                                                                              child: checkOutequipmentid.contains(result[index].equipmentId)
                                                                                  ? Text(
                                                                                      'Scan to CheckIn',
                                                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8, color: AppColor.homePageContainerTextBig),
                                                                                    )
                                                                                  : Text(
                                                                                      'Scan to CheckOut',
                                                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8, color: AppColor.homePageContainerTextBig),
                                                                                    ),
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                              child: Container()),
                                                                          TextButton(
                                                                            style:
                                                                                TextButton.styleFrom(primary: AppColor.gradientFirst),
                                                                            onPressed:
                                                                                () async {
                                                                              await _confirmDialog(context, result[index].id, result[index].equipment.equipmentName);
                                                                            },
                                                                            child:
                                                                                Icon(Icons.delete, color: AppColor.gradientFirst),
                                                                          ),
                                                                        ],
                                                                      ),
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
                                                                            .equipment
                                                                            .equipmentName
                                                                            .isEmpty
                                                                        ? 'No description'
                                                                        : result[index]
                                                                            .equipment
                                                                            .equipmentName,
                                                                    maxLines: 2,
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                        fontWeight:
                                                                            FontWeight.w500),
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
                                              );
                                            }
                                            return Center(
                                              child: CircularProgressIndicator(
                                                  color:
                                                      AppColor.gradientFirst),
                                            );
                                          }));
                            },
                          )
                              //});
                              //     } else {
                              //       return Center(
                              //         child: CircularProgressIndicator(
                              //             color: AppColor.gradientFirst),
                              //       );
                              //     }
                              //   },
                              // ),
                              ),
                        ],
                      ),
                    );
                  }
                }

                return Center(
                  child:
                      CircularProgressIndicator(color: AppColor.gradientFirst),
                );
              }),
        ));
  }

  _checkIn(String? equipmentBarcode, String equipmentId) async {
    await scanInBarcode();
    if (equipmentBarcode == _scanInBarcode) {
      return await _equipmentCheckInAPI.checkinEquipments(equipmentId);
    }
  }

  _checkOut(
      String? equipmentBarcode, String equipmentId, String eventId) async {
    await scanInBarcode();
    if (equipmentBarcode == _scanInBarcode) {
      var res =
          await _equipmentCheckOutAPI.checkoutEquipments(eventId, equipmentId);
      return res;
    }
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
                Text('Are you sure want delete Category $equipmentName ?'),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: AppColor.gradientFirst),
              child: const Text('Yes'),
              onPressed: () async {
                var res = await EventEquipmentChecklistAPI()
                    .deleteEventEquipmentsChecklist(equipmentId);
                if (res.statusCode == 200) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.green,
                      content: Text(
                          "$equipmentName EquipmentsChecklist successfully deleted")));
                  Navigator.of(context).pop();
                  setState(() {});
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

  // var eventequipment = eventEquipmentResult
  //                                 .where((item) => widget.eventDetail.id
  //                                     .contains(item.eventId))
  //                                 .toList();
  //                             var checklistequipmentid = List<String>.generate(
  //                                 eventEquipmentResult.length,
  //                                 (i) => eventEquipmentResult[i].equipmentId);
  //                             var result = results
  //                                 .where((item) =>
  //                                     checklistequipmentid.contains(item.id))
  //                                 .toList();

  //var thirdList = checklistequipmentid.toSet().intersection(secondList.toSet()).toList();
  //var    neweventresult = eventEquipmentResult.where((e) =>results.contains()).toList();

  Color checkcolors({String? eventId, String? checkId}) {
    if (eventId == checkId) {
      return Colors.red;
    } else if (eventId != checkId) {
      return Colors.green;
    } else {
      return Colors.green;
    }
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
