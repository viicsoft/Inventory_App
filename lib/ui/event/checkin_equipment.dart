import 'package:flutter/material.dart';
import 'package:viicsoft_inventory_app/component/colors.dart';
import 'package:viicsoft_inventory_app/models/equipmentcheckin.dart';
import 'package:viicsoft_inventory_app/services/apis/equipment_checkin_api.dart';

// ignore: must_be_immutable
class CheckInEquipmentPage extends StatefulWidget {
  const CheckInEquipmentPage({Key? key}) : super(key: key);

  @override
  State<CheckInEquipmentPage> createState() => _CheckInEquipmentPageState();
}

class _CheckInEquipmentPageState extends State<CheckInEquipmentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.homePageBackground,
      body: Container(
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
              child: FutureBuilder<List<EquipmentsCheckin>>(
                future: EquipmentCheckInAPI().fetchAllEquipmentCheckIn(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppColor.gradientFirst,
                        ),
                      );
                    } else {
                      var result = snapshot.data!;
                      return ListView.builder(
                        itemCount: result.length,
                        itemBuilder: (_, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 5, left: 5),
                            child: InkWell(
                              onLongPress: () async => await _confirmDialog(
                                  context,
                                  result[index].id,
                                  result[index].equipment.equipmentName),
                              child: Container(
                                height: 98,
                                padding:
                                    const EdgeInsets.only(bottom: 2, right: 3),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
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
                                              children: [
                                                Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(3),
                                                        color: AppColor
                                                            .homePageSubtitle),
                                                    padding:
                                                        const EdgeInsets.all(2),
                                                    height: 14,
                                                    child: Center(
                                                      child: Text(
                                                        result[index]
                                                            .equipment
                                                            .category
                                                            .name,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 8,
                                                            color: AppColor
                                                                .homePageContainerTextBig),
                                                      ),
                                                    )),
                                                const SizedBox(height: 4),
                                                Container(
                                                  width: 60,
                                                  height: 65,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          result[index]
                                                              .equipment
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
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
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
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                              color: AppColor
                                                                  .homePageTitle,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        const SizedBox(
                                                            height: 5),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  color: colorscondition(result[
                                                                          index]
                                                                      .equipment
                                                                      .equipmentCondition)),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(5),
                                                              height: 17,
                                                              child: Text(
                                                                result[index]
                                                                    .equipment
                                                                    .equipmentCondition,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize: 8,
                                                                    color: AppColor
                                                                        .homePageContainerTextBig),
                                                              ),
                                                            ),
                                                            Expanded(
                                                                child:
                                                                    Container()),
                                                            Column(
                                                              children: [
                                                                Text(
                                                                  'CheckIn Date',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: AppColor
                                                                          .homePageSubtitle),
                                                                ),
                                                                const SizedBox(
                                                                    height: 5),
                                                                Text(
                                                                  '${result[index].equipmentInDatetime.day}-${result[index].equipmentInDatetime.month}-${result[index].equipmentInDatetime.year}',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: AppColor
                                                                          .gradientFirst),
                                                                )
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                                width: 10),
                                                          ],
                                                        ),
                                                      ],
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
            ),
          ],
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
                Text(
                    'Are you sure want to delete Equipment:  $equipmentName ?'),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: AppColor.gradientFirst),
              child: const Text('Yes'),
              onPressed: () async {
                var res = await EquipmentCheckInAPI()
                    .deleteEventEquipmentCheckIn(equipmentId);
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
