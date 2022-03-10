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
      {Key? key, required this.categoryId, required this.equipmentCategory})
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
              padding: const EdgeInsets.only(left: 30, right: 30),
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
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
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
                      return ListView.builder(
                        itemCount: results.length,
                        itemBuilder: (_, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: Container(
                              height: 120,
                              padding:
                                  const EdgeInsets.only(bottom: 5, right: 5),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
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
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 75,
                                                height: 90,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                        results[index]
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
                                                        results[index]
                                                            .equipmentName,
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                            color: AppColor
                                                                .homePageTitle,
                                                            fontSize: 14,
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
                                                                    results[index]
                                                                        .equipmentCondition)),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5),
                                                            height: 18,
                                                            child: Text(
                                                              results[index]
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
                                                                          results[
                                                                              index],
                                                                      equipmentId:
                                                                          results[index]
                                                                              .id),
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
                                                    results[index]
                                                            .equipmentDescription!
                                                            .isEmpty
                                                        ? 'No description'
                                                        : results[index]
                                                            .equipmentDescription!,
                                                    maxLines: 2,
                                                    style: const TextStyle(
                                                        fontSize: 14,
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
}
