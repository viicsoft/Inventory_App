import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:viicsoft_inventory_app/component/colors.dart';
import 'package:viicsoft_inventory_app/models/category.dart';
import 'package:viicsoft_inventory_app/models/equipments.dart';
import 'package:viicsoft_inventory_app/models/eventequipment.dart';
import 'package:viicsoft_inventory_app/services/apis/category_api.dart';
import 'package:viicsoft_inventory_app/services/apis/equipment_api.dart';
import 'package:viicsoft_inventory_app/services/apis/equipment_checkin_api.dart';
import 'package:viicsoft_inventory_app/services/apis/equipment_checkout_api.dart';
import 'package:viicsoft_inventory_app/services/apis/event_api.dart';
import 'package:viicsoft_inventory_app/ui/event/add_eventequipmentpage.dart';
import 'package:viicsoft_inventory_app/ui/store/equipment_detail_page.dart';

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

  final EventAPI _eventAPI = EventAPI();
  final EquipmentAPI _equipmentApi = EquipmentAPI();
  final EquipmentCheckInAPI _equipmentCheckInAPI = EquipmentCheckInAPI();
  final EquipmentCheckOutAPI _equipmentCheckOutAPI = EquipmentCheckOutAPI();
  List scanedEquipment = [];

  @override
  void initState() {
    _equipment = _equipmentApi.fetchAllEquipments();
    _eventEquipment = _eventAPI.fetchAllEventsEquipment();
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

                return ListView.builder(itemBuilder: (context, index) {
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
                          height: 220,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image:
                                    NetworkImage(widget.eventDetail.eventImage),
                                fit: BoxFit.fill,
                              ),
                              color: AppColor.homePageContainerTextBig,
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(80),
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(80),
                                bottomRight: Radius.circular(10),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(2, 5),
                                  blurRadius: 4,
                                  color:
                                      AppColor.gradientSecond.withOpacity(0.2),
                                )
                              ]),
                          child: Container(
                            padding: const EdgeInsets.only(
                                top: 25, left: 40, right: 20, bottom: 25),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Event Name:    ${widget.eventDetail.eventName}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.homePageSubtitle),
                                ),
                                const SizedBox(height: 25),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Event Type:  ${widget.eventDetail.eventType}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: AppColor.homePageSubtitle,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Location:  ${widget.eventDetail.eventLocation}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: AppColor.homePageSubtitle,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Center(
                                          child: Text(
                                            'Date:',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: AppColor.homePageSubtitle,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          '${startingdate.day}-${startingdate.month}-${startingdate.year}',
                                          style: TextStyle(
                                              fontSize: 14,
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
                                              fontSize: 14,
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
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Equipments  Needed',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: AppColor.homePageTitle,
                              ),
                            ),
                          ],
                        ),
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
                                    .where((item) =>
                                        item.eventId == widget.eventDetail.id)
                                    .toList();
                                var result = results
                                    .where((item) =>
                                        item.id ==
                                        eventequipment[0].equipmentId)
                                    .toList();
                                return ListView.builder(
                                  itemBuilder: (context, index) {
                                    return ListView.builder(
                                      itemCount: result.length,
                                      itemBuilder: (_, int index) {
                                        return Container(
                                          height: 120,
                                          padding: const EdgeInsets.only(
                                              bottom: 5, right: 5),
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            elevation: 3,
                                            shadowColor: AppColor.gradientSecond,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                top: 5,
                                                left: 5,
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
                                                            width: 75,
                                                            height: 90,
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
                                                      const SizedBox(width: 10),
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
                                                                    maxLines: 2,
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .homePageTitle,
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500),
                                                                  ),
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
                                                                        height: 18,
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
                                                                      const SizedBox(
                                                                          width:
                                                                              10),
                                                                      InkWell(
                                                                        onTap:
                                                                            () async {
                                                                          if (scanedEquipment
                                                                              .contains(
                                                                                  result[index].id)) {
                                                                            await _checkIn(
                                                                                result[index].equipmentBarcode,
                                                                                result[index].id);
                                                                            setState(
                                                                                () {
                                                                              scanedEquipment
                                                                                  .remove(result[index].id);
                                                                            });
                                                                          } else if (!scanedEquipment
                                                                              .contains(
                                                                                  result[index].id)) {
                                                                            _checkOut(
                                                                                result[index].equipmentBarcode,
                                                                                result[index].id,
                                                                                widget.eventDetail.id);
                                                                            setState(
                                                                                () {
                                                                              scanedEquipment
                                                                                  .add(result[index].id);
                                                                            });
                                                                          } else {
                                                                            _confirmDialog(
                                                                                context);
                                                                          }
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(
                                                                                  5),
                                                                              color: scanedEquipment.contains(result[index].id)
                                                                                  ? AppColor.gradientFirst
                                                                                  : Colors.green),
                                                                          padding:
                                                                              const EdgeInsets.all(
                                                                                  5),
                                                                          height:
                                                                              18,
                                                                          child: scanedEquipment
                                                                                  .contains(result[index].id)
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
                                                                          child:
                                                                              Container()),
                                                                      TextButton(
                                                                        style: TextButton.styleFrom(
                                                                            primary:
                                                                                AppColor.gradientFirst),
                                                                        onPressed:
                                                                            () {},
                                                                        child: Icon(
                                                                            Icons
                                                                                .delete,
                                                                            color: AppColor
                                                                                .gradientFirst),
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
                                                                        .equipmentDescription!
                                                                        .isEmpty
                                                                    ? 'No description'
                                                                    : result[index]
                                                                        .equipmentDescription!,
                                                                maxLines: 2,
                                                                style: const TextStyle(
                                                                    fontSize: 14,
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
                                        );
                                      },
                                    );
                                  }
                                );
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
                });
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
