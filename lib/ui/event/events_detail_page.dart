import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:viicsoft_inventory_app/component/colors.dart';
import 'package:viicsoft_inventory_app/models/equipmentcheckin.dart';
import 'package:viicsoft_inventory_app/models/equipments.dart';
import 'package:viicsoft_inventory_app/models/eventequipment.dart';
import 'package:viicsoft_inventory_app/models/eventequipmentcheckout.dart';
import 'package:viicsoft_inventory_app/services/apis/equipment_api.dart';
import 'package:viicsoft_inventory_app/services/apis/equipment_checkin_api.dart';
import 'package:viicsoft_inventory_app/services/apis/equipment_checklist_api.dart';
import 'package:viicsoft_inventory_app/services/apis/equipment_checkout_api.dart';
import 'package:viicsoft_inventory_app/services/apis/event_api.dart';
import 'package:viicsoft_inventory_app/ui/event/add_eventequipmentpage.dart';
import 'package:viicsoft_inventory_app/ui/event/update_event.dart';

import '../../models/events.dart';

class EventsDetailPage extends StatefulWidget {
  final Event eventDetail;
  const EventsDetailPage({Key? key, required this.eventDetail})
      : super(key: key);

  @override
  State<EventsDetailPage> createState() => _EventsDetailPageState();
}

class _EventsDetailPageState extends State<EventsDetailPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Future<List<EquipmentElement>>? _equipment;
  Future<List<EventEquipmentChecklist>>? _eventEquipment;
  String _scanInBarcode = '';
  String _scanOutBarcode = '';

  final EventEquipmentChecklistAPI _eventEquipmentAPI =
      EventEquipmentChecklistAPI();
  final EquipmentAPI _equipmentApi = EquipmentAPI();
  final EquipmentCheckInAPI _equipmentCheckInAPI = EquipmentCheckInAPI();
  final EquipmentCheckOutAPI _equipmentCheckOutAPI = EquipmentCheckOutAPI();
  List scanedEquipment = [];

  @override
  void initState() {
    _equipment = _equipmentApi.fetchAllEquipments();
    _eventEquipment = _eventEquipmentAPI.fetchAllEquipmentCheckList();
    super.initState();
  }

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

  @override
  Widget build(BuildContext context) {
    var startingdate = DateTime.parse("${widget.eventDetail.checkOutDate}");
    var endingdate = DateTime.parse("${widget.eventDetail.checkInDate}");
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColor.homePageBackground,
      body: FutureBuilder<List<EventEquipmentChecklist>>(
          future: _eventEquipment,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data == null) {
                return Center(
                  child:
                      CircularProgressIndicator(color: AppColor.gradientFirst),
                );
              } else {
                var eventEquipmentResult = snapshot.data!;
                return Container(
                  padding: const EdgeInsets.only(top: 40, right: 10, left: 10),
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
                              Navigator.push(context, MaterialPageRoute(builder: (_) => UpdateEventPage(eventDetail: widget.eventDetail)));
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
                                            eventName:
                                                widget.eventDetail.eventName,
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
                                color: AppColor.gradientSecond.withOpacity(0.2),
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
                              bottomRight: Radius.circular(10)
                                ),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                                color:
                                                    AppColor.homePageSubtitle,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            '${startingdate.day}-${startingdate.month}-${startingdate.year}',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: AppColor.gradientFirst,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const SizedBox(width: 10),
                                          const Text(
                                            'To',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            '${endingdate.day}-${endingdate.month}-${endingdate.year}',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: AppColor.gradientFirst,
                                                fontWeight: FontWeight.w500),
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
                        child: FutureBuilder<List<EquipmentElement>>(
                          future: _equipment,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return SizedBox(
                                child: Container(),
                              );
                            } else if (snapshot.connectionState ==
                                ConnectionState.done) {
                              final results = snapshot.data!;
                              var eventequipment = eventEquipmentResult
                                  .where((item) => widget.eventDetail.id
                                      .contains(item.eventId))
                                  .toList();
                              var checklistequipmentid = List<String>.generate(
                                  eventEquipmentResult.length,
                                  (i) => eventEquipmentResult[i].equipmentId);
                              var result = results
                                  .where((item) =>
                                      checklistequipmentid.contains(item.id))
                                  .toList();

                              //var thirdList = checklistequipmentid.toSet().intersection(secondList.toSet()).toList();
                              //var    neweventresult = eventEquipmentResult.where((e) =>results.contains()).toList();

                              return ListView.builder(
                                itemCount: result.length,
                                itemBuilder: (_, int index) {
                                  return Container(
                                      height: 105,
                                      padding: const EdgeInsets.only(
                                          bottom: 3, right: 3),
                                      child:
                                          FutureBuilder<
                                                  List<EquipmentCheckout>>(
                                              future: EquipmentCheckOutAPI()
                                                  .fetchAllEquipmentCheckOut(),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.done) {
                                                  var checkoutequipment =
                                                      snapshot.data;
                                                  var checkOutequipmentid =
                                                      List<String>.generate(
                                                          checkoutequipment!
                                                              .length,
                                                          (i) =>
                                                              checkoutequipment[
                                                                      i]
                                                                  .equipmentId);
                                                  return Card(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
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
                                                                  Container(
                                                                    width: 65,
                                                                    height: 75,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      image:
                                                                          DecorationImage(
                                                                        image: NetworkImage(
                                                                            result[index].equipmentImage),
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                  width: 10),
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
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            result[index].equipmentName,
                                                                            maxLines:
                                                                                1,
                                                                            style: TextStyle(
                                                                                color: AppColor.homePageTitle,
                                                                                fontSize: 13,
                                                                                fontWeight: FontWeight.w600),
                                                                          ),
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
                                                                              InkWell(
                                                                                onTap: () async {
                                                                                  if (checkOutequipmentid.contains(result[index].id)) {
                                                                                    await _checkIn(result[index].equipmentBarcode, result[index].id);
                                                                                    // setState(
                                                                                    //     () {
                                                                                    //   scanedEquipment.remove(result[index].id);
                                                                                    // });
                                                                                  } else if (!checkOutequipmentid.contains(result[index].id)) {
                                                                                    _checkOut(result[index].equipmentBarcode, result[index].id, widget.eventDetail.id);
                                                                                    // setState(
                                                                                    //     () {
                                                                                    //   scanedEquipment.add(result[index].id);
                                                                                    // });
                                                                                  } else {
                                                                                    _confirmDialog(context);
                                                                                  }
                                                                                },
                                                                                child: Container(
                                                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: checkOutequipmentid.contains(result[index].id) ? Colors.red : Colors.green),
                                                                                  //checkcolors(checkinId: checkOutequipmentid.toString(), equipmentId: result[index].id)),
                                                                                  padding: const EdgeInsets.all(5),
                                                                                  height: 18,
                                                                                  child: checkOutequipmentid.contains(result[index].id)
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
                                                                              Expanded(child: Container()),
                                                                              TextButton(
                                                                                style: TextButton.styleFrom(primary: AppColor.gradientFirst),
                                                                                onPressed: () {},
                                                                                child: Icon(Icons.delete, color: AppColor.gradientFirst),
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
                                                                      child:
                                                                          Text(
                                                                        result[index].equipmentDescription!.isEmpty
                                                                            ? 'No description'
                                                                            : result[index].equipmentDescription!,
                                                                        maxLines:
                                                                            2,
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                12,
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
                                                  child:
                                                      CircularProgressIndicator(
                                                          color: AppColor
                                                              .gradientFirst),
                                                );
                                              }));
                                },
                              );
                              //});
                            } else {
                              return Center(
                                child: CircularProgressIndicator(
                                    color: AppColor.gradientFirst),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
            }

            return Center(
              child: CircularProgressIndicator(color: AppColor.gradientFirst),
            );
          }),
    );
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
      return await _equipmentCheckOutAPI.checkoutEquipments(
          eventId, equipmentId);
    }
  }

  _confirmDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Warning!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Invalid Barcode Or Equipment Does not Exist'),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: AppColor.gradientFirst),
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Color checkcolors({String? equipmentId, String? checkinId}) {
    if (equipmentId == checkinId) {
      return Colors.green;
    } else {
      return Colors.red;
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
