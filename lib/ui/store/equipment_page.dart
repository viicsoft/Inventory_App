import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viicsoft_inventory_app/component/colors.dart';
import 'package:viicsoft_inventory_app/models/category.dart';
import 'package:viicsoft_inventory_app/models/equipments.dart';
import 'package:viicsoft_inventory_app/services/apis/equipment_api.dart';
import 'package:viicsoft_inventory_app/ui/store/equipment_detail_page.dart';

// ignore: must_be_immutable
class EquipmentPage extends StatefulWidget {
  EquipmentCategory equipmentCategory;
  String categoryId;
  EquipmentPage(
      {Key? key,  required this.equipmentCategory, required this.categoryId})
      : super(key: key);

  @override
  State<EquipmentPage> createState() => _EquipmentPageState();
}

class _EquipmentPageState extends State<EquipmentPage> {
  final EquipmentAPI _equipmentAPI = EquipmentAPI();
  late final List<EquipmentElement> equipmentsList;
  late Future equipmentFuture;
  bool equipmentImage = true;

  @override
  void initState() {
    super.initState();
    equipmentFuture = _equipmentAPI.fetchAllEquipments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.homePageBackground,
      body: Container(
        padding: const EdgeInsets.only(top: 50),
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
                  widget.equipmentCategory.name,
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
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 150,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.equipmentCategory.image),
                      fit: BoxFit.fill,
                    ),
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(2, 5),
                        blurRadius: 4,
                        color: AppColor.gradientSecond.withOpacity(0.2),
                      )
                    ]),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<EquipmentElement>>(
                  future: _equipmentAPI.fetchAllEquipments(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return SizedBox(
                        child: Container(),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      final results = snapshot.data!;
                      var result = results.where((item) => widget.categoryId.contains(item.equipmentCategoryId)).toList();
                      return ListView.builder(
                        itemCount: result.length,
                        itemBuilder: (_, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 5, left: 5),
                            child: Container(
                              height: 105,
                              padding:
                                  const EdgeInsets.only(bottom: 3, right: 3),
                              child: InkWell(
                                onLongPress: () async{
                                 await _confirmDialog(context, result[index].id, result[index].equipmentName);
                                  setState(() {});
                                },
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 65,
                                                  height: 75,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                    image: DecorationImage(
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
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: MediaQuery.of(context)
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
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  color: colorscondition(
                                                                      result[index]
                                                                          .equipmentCondition)),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(5),
                                                              height: 17,
                                                              child: Text(
                                                                result[index]
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
                                                            TextButton(
                                                              style: TextButton
                                                                  .styleFrom(
                                                                      primary:
                                                                          AppColor
                                                                              .gradientFirst),
                                                              onPressed: () {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder: (context) => EquipmentDetailPage(
                                                                        equipmentElement:
                                                                            result[
                                                                                index],),
                                                                  ),
                                                                );
                                                              },
                                                              child: const Text(
                                                                  'View'),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: MediaQuery.of(context)
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
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                            color: AppColor.gradientFirst),
                      );
                    }
                  }),
            )
          ],
        ),
      ),
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
                Text('Are you sure want delete Equipment $equipmentName ?'),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: AppColor.gradientFirst),
              child: const Text('Yes'),
              onPressed: () async {
                var res = await EquipmentAPI().deleteEquipment(equipmentId);
                if (res.statusCode == 200) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.green,
                      content:
                          Text("$equipmentName Equipment successfully deleted")));
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
}
